From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Tue, 17 Jul 2007 22:27:55 +0200
Message-ID: <20070717202754.GB25037@cip.informatik.uni-erlangen.de>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <7vtzs3a0xg.fsf@assigned-by-dhcp.cox.net> <20070717101527.GB7774@cip.informatik.uni-erlangen.de> <7vlkdeang0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 22:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAteK-0000fQ-Op
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 22:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbXGQU14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 16:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756195AbXGQU14
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 16:27:56 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:36586 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755075AbXGQU1z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 16:27:55 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 17E353F42C; Tue, 17 Jul 2007 22:27:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vlkdeang0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52797>

Hello Junio,

> Ahhhh, by "testing", I meant "runnnig the testsuite shipped with
> the source".  Both of your patches were failing in somewhere in
> t2000 series of tests.

That was the last time, I am going to submit a patch _without_ running
the whole testsuite before. I hate it myself when other people don't do
the obvious tests and break something that worked before.

> I am thinking that this fix should go to 'maint' and merged to
> 'master', as it is a grave problem in at least one setup.

Thanks. For packages that I distribute, I fixed it of course by myself.
And to be precise I use git on Solaris a lot by myself but I don't work
as root so the bug never showed up before and as you can see by the
pastes that I provided to track down the bug I have

	if [ $UID -eq 0 ]; then
		export PS1="(${PROMPT_RED}\h${PROMPT_END}) [${PROMPT_BLUE}\w${PROMPT_END}] ";
		alias bk='echo DO *NOT* RUN BK AS ROOT'
		alias git='echo DO *NOT* RUN GIT AS ROOT'
		alias links='echo DO *NOT* RUN LINKS AS ROOT'
		alias elinks='echo DO *NOT* RUN ELINKS AS ROOT'
	...

in my distributed environment. But my coworker who I "show" git to work
a lot as root. A very bad habbit that is hard to get rid of. Btw. I
prepare to setup a automatic build script which I am going to let run
automatic on a daily basis so that I catch Solaris compile problems
early and report them to you.

	Thomas
