From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 17:04:02 -0400
Message-ID: <C4EC2200-59E0-4FBE-AA5F-4A05DAF4A427@silverinsanity.com>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com> <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com> <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com> <7vej97x78v.fsf@gitster.siamese.dyndns.org> <9b3e2dc20804151353p2622ab19i2a04f5da9a6417ca@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Russ Dill" <russ.dill@gmail.com>, git@vger.kernel.org
To: Stephen Sinclair <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 23:06:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlsKt-0005PE-Gj
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 23:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbYDOVEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965AbYDOVEL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 17:04:11 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48138 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbYDOVEK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 17:04:10 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 6DCCD1FFC257;
	Tue, 15 Apr 2008 21:04:06 +0000 (UTC)
In-Reply-To: <9b3e2dc20804151353p2622ab19i2a04f5da9a6417ca@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79631>


On Apr 15, 2008, at 4:53 PM, Stephen Sinclair wrote:

> On Tue, Apr 15, 2008 at 3:12 PM, Junio C Hamano <gitster@pobox.com>  
> wrote:
>>
>> Not complicated at all.  Put that description in-tree in a known  
>> location
>> (say, "help-branch") in-tree and your propagation problem is solved.
>>
>> And have a scriptlet in $HOME/bin/git-help-branch to grep from that  
>> file.
>
> Hm, I wasn't sure if an in-tree solution would be appropriate.
> It's possible, but I didn't really want this branch description to be
> something I have to deal with when merging..
> Ideally though this information _should_ be propagated through a
> clone, so something in-tree might make sense.
>
> When I posted I thought perhaps there was already a way to do this
> that I hadn't encountered.
> Perhaps there could be an in-tree file .gitbranch that is simply a
> name:description pair, "git-branch --info" (or whatever) could be made
> to know how to parse that file if it exists.
>
> However I was hoping that the branch description could be made when
> creating the branch, instead of having to associate it with an actual
> commit.

A random thought:

refs/info/heads/help is a pointer to a blob that is full of name- 
description pairs.  Instead of a full ref name it simply keeps the  
portion for a given subdirectory.  On a pull, you can add refs/info/ 
heads/help:refs/info/remote/origin/help.  Each subdirectory of refs  
gets it's own help blob.  You may need to deal with merging on pull,  
but it keeps the information separate from the commits and still pull/ 
pushable.

~~ Brian
