From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: GIT Hooks and security
Date: Sat, 26 Oct 2013 11:39:48 +0200
Message-ID: <20131026093948.GA17645@domone.podge>
References: <CA+nXgrUZk=_wtQ2yQnxwCZ3Mazdz=ZH2FJV+V92PVa0a4+A1hQ@mail.gmail.com>
 <xmqqwql1hub6.fsf@gitster.dls.corp.google.com>
 <CA+nXgrUcpfya+rTPzfRafzJbK1khNqtz-HsaKeGfdA86AepKEg@mail.gmail.com>
 <CAGyf7-HCEQy2hUnc6UvABDrwYatoUEiPnpXo-e9_8wtbhvN0mw@mail.gmail.com>
 <CA+nXgrWBue1A9KBXaRwRPi7qFNsrz8CnoyLrdhbALeo=7xborQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Olivier Revollat <revollat@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 11:40:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va0Lf-0005EX-CZ
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 11:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229Ab3JZJjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 05:39:54 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:37917 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3JZJjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 05:39:54 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 4BF6A68E93;
	Sat, 26 Oct 2013 11:39:49 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id 18BFC5F96A; Sat, 26 Oct 2013 11:39:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CA+nXgrWBue1A9KBXaRwRPi7qFNsrz8CnoyLrdhbALeo=7xborQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236747>

> 2013/10/26 Bryan Turner <bturner@atlassian.com>:
> > No, the .git/hooks directory in your clone is created from your local
> > templates, installed with your Git distribution, not the remote hooks.
> > On Linux distributions, these templates are often in someplace like
> > /usr/share/git-core/templates (for normal packages), and on Windows
> > with msysgit they are in share\git-core\templates under your
> > installation directory. If you look in this directory you will see a
> > hooks directory containing the sample hooks.
> >
> > Hooks from a remote repository are never cloned. As far as I'm aware,
> > nothing from the .git directory (aside from refs and packs, of course)
> > is cloned, including configuration. Your .git directory after a clone
> > is completely new, assembled from scratch. There's nothing in the Git
> > wire protocol (currently) for moving other data like configuration or
> > hooks, and this sort of malicious code injection is one of the reasons
> > I've seen discussed on the list for why that's the case.
> >
> > Hope this helps,
> > Bryan Turner
> >
> >
> > On 26 October 2013 09:25, Olivier Revollat <revollat@gmail.com> wrote:
> >>
> >> But when someone do a "clone" he don't have .git/hooks directory
> >> downloaded to his local computer ? I thought so ...
> >>
> >> 2013/10/26 Junio C Hamano <gitster@pobox.com>:
> >> > Olivier Revollat <revollat@gmail.com> writes:
> >> >
> >> >> I was wondering : What if I had a "malicious" GIT repository who can
> >> >> "inject" code  via git hooks mechanism : someone clone my repo and
> >> >> some malicious code is executed when a certain GIT hook is triggered
> >> >> (for example on commit ("prepare-commit-msg' hook))
> >> >
> >> > In that somebody else's clone, you will not have _your_ malicious
> >> > hook installed, unless that cloner explicitly does something stupid,
> >> > like copying that malicious hook.
> >>
Also copying hooks is relatively low risk, real hackers hide exploits in
1MB configure scripts.
