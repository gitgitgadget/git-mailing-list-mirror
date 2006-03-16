From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 14:53:43 +0100
Message-ID: <44196DE7.8010205@op5.se>
References: <20060314211022.GA12498@localhost.localdomain> <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org> <20060314224027.GB14733@localhost.localdomain> <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org> <7vek13ieap.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org> <7vlkvbffhz.fsf@assigned-by-dhcp.cox.net> <20060316075324.GA19650@pfit.vm.bytemark.co.uk> <7v64mebxsu.fsf@assigned-by-dhcp.cox.net> <slrne1inu0.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 14:54:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJsvJ-0008EG-GH
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 14:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWCPNxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 08:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWCPNxp
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 08:53:45 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:25052 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751121AbWCPNxo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 08:53:44 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 616E26BD21; Thu, 16 Mar 2006 14:53:43 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne1inu0.fr9.mdw@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17634>

Mark Wooding wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> 
> 
>>*1* BTW, I just noticed that git-sh-setup needs to be on user's
>>PATH, so we probably have to inline and duplicate the git_exec()
>>shell function definition at the beginning of each script after
>>all, when we make the initial ". git-sh-setup" inclusion to
>>honor GIT_EXEC_PATH without munging the user's PATH.
> 
> 
> . ${GIT_EXEC_PATH-'@@@GIT_EXEC_PATH@@@'}/git-sh-setup
> 
> isn't too grim, and shows how the git_exec shell function can be made
> somewhat terser.
> 

But it breaks the convenience when testing.

> By the way, am I the only person who /likes/ having all the git-*
> programs on his path?  It makes shell completion work fairly well
> without having to install strange completion scripts which get out of
> date for one thing.
> 

I like it too, but I don't use it unless I can't remember what the 
command was named (finger-training). It shouldn't be too difficult to 
make git.c write its own auto-generated bash-completion rules. If 
someone would care to teach me the syntax I'd gladly hack up a patch for 
it. This is a Good Thing, since it means it would also work for the 
internal commands, which bash's path-completion doesn't.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
