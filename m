From: Andreas Ericsson <ae@op5.se>
Subject: Re: disable branch modification
Date: Tue, 04 Aug 2009 15:36:43 +0200
Message-ID: <4A78396B.70004@op5.se>
References: <24550469.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ishaaq Chandy <ishaaq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 15:36:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYKCI-0002yV-Fy
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 15:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbZHDNgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 09:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755538AbZHDNgs
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 09:36:48 -0400
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33849 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755537AbZHDNgs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 09:36:48 -0400
Received: from source ([209.85.219.209]) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSng5bsbSNM/NpQyKFdfBEJU4hiaRzrLG@postini.com; Tue, 04 Aug 2009 06:36:49 PDT
Received: by mail-ew0-f209.google.com with SMTP id 5so6824361ewy.15
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 06:36:46 -0700 (PDT)
Received: by 10.210.91.7 with SMTP id o7mr6698812ebb.25.1249393005842;
        Tue, 04 Aug 2009 06:36:45 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 10sm2333607eyd.32.2009.08.04.06.36.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 06:36:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <24550469.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124788>

Ishaaq Chandy wrote:
> Hi all,
> I've got a remote git repository that I want multiple users to be able to
> push to. This is all set up fine and working beautifully. The only thing is,
> I want to be able to lock down the branches on this remote repo, once set up
> users should not be able to:
> 
> 1. Create new branches on it
> 2. Delete existing branches from it
> 3. push non-fast-forward commits to it.
> 
> I think I'll need to write a pre-receive hook for this, but before I embark
> on this, any helpful pointers would be appreciated.
> 

I did this once so that users could only push to branches in a namespace
beginning with their username, so the user "hgb" could only write to
"hgb/master" and never to "master" directly (for example). This provides
maximum freedom to the users while making sure they never muck about with
any "official" branches.

The script to accomplish this is, alas, lost.

Denying non-fast-forwards even if --force is in effect is a config option
these days, I think.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
