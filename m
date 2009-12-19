From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: abort cleanly if the editor fails to launch
Date: Sat, 19 Dec 2009 21:57:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912192156030.4985@pacific.mpi-cbg.de>
References: <4B2CC133.9010704@gmail.com> <7v8wcy7kyc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1808364961-1261256236=:4985"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 21:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM6Hy-0007BB-OP
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 21:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbZLSUw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 15:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbZLSUw3
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 15:52:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:57026 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752775AbZLSUw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 15:52:28 -0500
Received: (qmail invoked by alias); 19 Dec 2009 20:52:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 19 Dec 2009 21:52:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zYexFpmQzVQI1/TgTkRQHOpcGt3X1HHjy3pF/iB
	126f++DEXwPK3s
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v8wcy7kyc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135502>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1808364961-1261256236=:4985
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 19 Dec 2009, Junio C Hamano wrote:

> Björn Gustavsson <bgustavsson@gmail.com> writes:
> 
> > If the user's configured editor is emacsclient, the editor
> > will fail to launch if emacs is not running and the git
> > command that tried to lanuch the editor will abort. For most
> > commands, all you have to do is to start emacs and repeat
> > the command.
> >
> > The "git rebase -i" command, however, aborts without cleaning
> > the "$GIT_DIR/rebase-merge" directory if it fails to launch the
> > editor, so you'll need to do "git rebase --abort" before
> > repeating the rebase command.
> >
> > Change "git rebase -i" to terminate using "die_abort" (instead of
> > with "die") if the initial launch of the editor fails.
> >
> > Signed-off-by: Björn Gustavsson <bgustavsson@gmail.com>
> 
> Two questions:
> 
>  - Is emacsclient the _only_ editor that can exit with non-zero status to
>    signal an error condition "the user invoked me to edit an existing
>    file, but I ended up not letting the user edit it"?

The non-existent editor also aborts with a non-zero status.

> An editor that can exit with non-zero status on demand could use this
> codepath to abort the rebase,

Removing all lines of the edit script will abort an interactive rebase.

Ciao,
Dscho

--8323328-1808364961-1261256236=:4985--
