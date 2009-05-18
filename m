From: "David H. Lynch J.r" <ml@dlasys.net>
Subject: Re: git svn rebase problem
Date: Mon, 18 May 2009 10:06:22 -0400
Message-ID: <4A116B5E.70206@dlasys.net>
Reply-To: dhlii@dlasys.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 16:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M63ad-0002vu-0v
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 16:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbZEROM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 10:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbZEROMz
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 10:12:55 -0400
Received: from outbound-mail-309.bluehost.com ([67.222.54.2]:41345 "HELO
	outbound-mail-309.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751720AbZEROMy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 10:12:54 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2009 10:12:54 EDT
Received: (qmail 25081 invoked by uid 0); 18 May 2009 14:06:16 -0000
Received: from unknown (HELO host200.hostmonster.com) (74.220.207.200)
  by outboundproxy6.bluehost.com with SMTP; 18 May 2009 14:06:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dlasys.net;
	h=Received:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-Identified-User;
	b=igZ4MmYgtZQGHhYQOZVcoD3PMEHJR76z48o406UXC9jHUVypvhN+LS4sFVtYfkzDFQ3Rt6v5LR1cbeeAzo6tmqg0wotIzRS4MsLAhnlAb2Ow8Cd5vHlsqDK9h3aw1Xu6;
Received: from 72.25.32.200.dynamic.dejazzd.com ([72.25.32.200] helo=[206.223.20.150])
	by host200.hostmonster.com with esmtpa (Exim 4.69)
	(envelope-from <ml@dlasys.net>)
	id 1M63Tr-0002P2-PJ
	for git@vger.kernel.org; Mon, 18 May 2009 08:06:15 -0600
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
X-Identified-User: {2173:host200.hostmonster.com:dlasysne:dlasys.net} {sentby:smtp auth 72.25.32.200 authed with dhlii+dlasys.net}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119442>

>2009/5/16 Avery Pennarun <apenwarr@xxxxxxxxx>:
>>/ On Fri, May 15, 2009 at 5:21 PM, David H. Lynch J.r <ml@xxxxxxxxxx> wrote:/
>>/> A few days ago I did an/
>>/> git svn rebase/
>>/>/
>>/> The rebase took a while and after it completed reported/
>>/> fatal: bad object HEAD/
>
>We had this come up about once a week when using http as the
>transport.  After switching most people over to ssh the problems
>disappeared.  We never managed to find out why.

	I am using an ssh link

>/> git status reports/
>/> root@hp-dhlii:/usr/src/pico/git# git status/
>/> # Not currently on any branch./
>/> fatal: bad object HEAD/
>/>/
>/> and git fsck reports/
>/> root@hp-dhlii:/usr/src/pico/git# git fsck/
>/> dangling blob eb3afb4aa3aaf0003bac601a5db4fd76aafa2a87/
>/> dangling commit 5c496db25007c17c325f294bb8324097c9bc407d/
>/>/
>/> How can I recover without downloading the entire repository again which/
>/> could take days?/
>
>/ I don't know how this would happen; it would be great if you could/
>/ find reproduction steps and send them in, or if you had the complete/
>/ git rebase log, some of which probably explains the problem.
Aparently I can reproduce this. I have a git repository that is about a year old.
I have made a local copy of it, and tried to run git svn update on it.
After downloading tons of commits it fails in the same way.

if there a way to do a step by step git svn rebase - somethng vaguely like git bisect - some way to zero in on the commit that is screwing things up ?

Or some way to get a log from the rebase AFTER the repository has become trashed

/>
>/ You can probably recover your pre-rebased repository using 'git/
>/ reflog'.

git reflog replies
fatal error bad HEAD
  
> Look through the reflog to find the commit you want, then do/
>/ something like/
>
>/    git checkout whatever-the-commit-id-was-that-you-got-from-git-reflog/
>
>/ and then optionally/
>
>/    git checkout -b master/
>
>/ Good luck./
>
>/ Avery/
>/ --/
>/ To unsubscribe from this list: send the line "unsubscribe git" in/
>/ the body of a message to majordomo@xxxxxxxxxxxxxxx/
>/ More majordomo info at  http://vger.kernel.org/majordomo-info.html/
>
--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@xxxxxxxxxxxxxxx
More majordomo info at  http://vger.kernel.org/majordomo-info.html
