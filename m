From: Carl Mercier <cmercier@websense.com>
Subject: Re: bug in git-p4?
Date: Fri, 8 May 2009 14:02:26 -0400
Message-ID: <B82F1DD2-282A-4E3A-ABAE-53F1D0386B25@websense.com>
References: <F98DA2FE6F6C464C860149518BD861CC3B3C13440A@SSDEXCH2.websense.com> <1a6be5fa0905080443h5c696f8es55ea5acf3b3025cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 20:21:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2UhL-0001JV-Ur
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 20:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763575AbZEHSUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 14:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763551AbZEHSUL
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 14:20:11 -0400
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:57963 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763568AbZEHSUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 14:20:08 -0400
Received: from rly25g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly25g.srv.mailcontrol.com (MailControl) with ESMTP id n48IK5rt027636
	for <git@vger.kernel.org>; Fri, 8 May 2009 19:20:08 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly25g.srv.mailcontrol.com (MailControl) id n48IJGCt017977
	for <git@vger.kernel.org>; Fri, 8 May 2009 19:19:16 +0100
Received: from ssdexch4a.websense.com ([204.15.64.171])
	by rly25g-eth0.srv.mailcontrol.com (envelope-sender <cmercier@websense.com>) (MIMEDefang) with ESMTP id n48IJ5MO016266; Fri, 08 May 2009 19:19:16 +0100 (BST)
Received: from jzhaoisa632.bjtestsupport.techsupport.com (10.64.163.3) by
 ssdexch4a.websense.com (10.64.80.130) with Microsoft SMTP Server (TLS) id
 8.1.358.0; Fri, 8 May 2009 11:19:15 -0700
In-Reply-To: <1a6be5fa0905080443h5c696f8es55ea5acf3b3025cb@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
X-Scanned-By: MailControl A-06-00-00 (www.mailcontrol.com) on 10.71.1.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118623>

Thank you.

What I'm trying to accomplish is a little bit different. We've been  
using Git with a remote server for so long, we don't want to give that  
up. (and we also can't for some reasons).  So what I was hoping to do  
was simply keep working with out remote Git server as normal, and then  
have another server pull from Git and submit to P4.

We have many Git repos we'd like to store into P4 subdirectories.  For  
example:

website.git -> //SecTech/website
api.git -> //SecTech/api

I just can't seem to get this to work because git-p4 seems to expect a  
brand new Git repo to work properly.

What would be the correct way to accomplish this?

Carl Mercier
Director of software development
Defensio.com, a Websense service



On 8-May-09, at 7:43 AM, Tor Arvid Lund wrote:

> On Mon, May 4, 2009 at 9:20 PM, Mercier, Carl  
> <cmercier@************> wrote:
>> Hello all,
>>
>> I've been trying to use git-p4 without much success.  My setup is  
>> very simple:
>>
>> - 1 existing Git repo (with data)
>> - 1 existing P4 depot (with an empty subdirectory)
>> - We commit and push to Git and our company requires all the code  
>> to be stored in P4 (in the p4 empty subdir).
>>
>> Here's what I did:
>>
>> cd /root/p4-repo/SecTech
>> git clone /home/git/repositories/web website
>> cd website
>> git-p4 sync //SecTech/website
>> git branch --track p4-master p4/master
>> git checkout p4-master
>> git merge master
>> git-p4 submit
>
> Hi. What I try to do at my job, is to consider the P4 depot to be the
> "master" depot, since I consider it the "weaker" of the two VCSs. I
> have not had much success doing git merges and then trying to sync
> with P4. I instead use rebasing a lot. So what I would do in your
> situation is something like:
>
> ...
> git-p4 sync //SecTech/website
> git rebase p4/master
> git-p4 submit
>
> So.. my normal flow of work is:
>
> code
> commit
> code
> commit
> git p4 sync
> git rebase p4/master
> git p4 commit
>
> Don't know if this is something that might work for you, though...
>
> -Tor Arvid-



 Protected by Websense Hosted Email Security -- www.websense.com 
