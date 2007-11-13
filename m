From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Tue, 13 Nov 2007 22:32:11 +0100
Message-ID: <200711132232.11730.johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at> <200711132110.29136.johannes.sixt@telecom.at> <7vlk91svgf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 22:32:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3N4-0000rb-HX
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759935AbXKMVcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759425AbXKMVcP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:32:15 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:43972 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759210AbXKMVcP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:32:15 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 3AA5433C03;
	Tue, 13 Nov 2007 22:32:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5B66959083;
	Tue, 13 Nov 2007 22:32:12 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vlk91svgf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64873>

On Tuesday 13 November 2007 22:10, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > On Tuesday 13 November 2007 21:04, Johannes Sixt wrote:
> >> [PATCH 09/11] Allow a relative builtin template directory.
> >> [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access
> >> 	of ETC_GITCONFIG.
> >> [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
> >>
> >> These need probably some discussion. They avoid that $(prefix) is
> >> hardcoded and so allows that an arbitrary installation directory.
> >
> > ... and so allow that the compiled binaries are installed in any
> > directory that the user chooses.
>
> If you can do that without breaking the tests (specifically, the
> test script should pick up the version of git you just built,
> not from /usr/bin nor /usr/local/stow/git/bin) that would be
> great.

Sorry, I don't understand your statement. Do you see any tests breaking?

These changes are only about where git-init looks up the templates and where 
the system configuration is looked for. They change git's behavior only if 
config.mak contains relative paths like this:

sysconfdir = ../etc
template_dir = ../share/git-core

It has nothing to do with where the test suite looks for the executables.

-- Hannes
