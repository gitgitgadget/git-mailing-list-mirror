From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el: what is format-spec?
Date: Sun, 06 Dec 2009 19:43:29 +0100
Message-ID: <87d42s3pv2.fsf@lysator.liu.se>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	<87ljhi3cao.fsf@osv.gnss.ru> <87fx7q4p6h.fsf@lysator.liu.se>
	<87einafojx.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 19:43:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHM5F-000339-N2
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 19:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbZLFSne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 13:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbZLFSnd
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 13:43:33 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:50340 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757010AbZLFSnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 13:43:32 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E629F4006B;
	Sun,  6 Dec 2009 19:42:32 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id D9CF34006F; Sun,  6 Dec 2009 19:42:32 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 8FE6F4006B;
	Sun,  6 Dec 2009 19:42:32 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id C38DB608C9; Sun,  6 Dec 2009 19:43:29 +0100 (CET)
In-Reply-To: <87einafojx.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
	04 Dec 2009 23:54:10 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134686>

Sergei Organov <osv@javad.com> writes:

> Then there should be (require 'format-spec) in git-blame.el, right? D=
ue
> to:

Of course. I must have missed that since I already had it loaded.

> Now, I've evaluated (require 'format-spec) in my Emacs 22 (yes, 22, n=
ot
> 23), and now git-blame almost works there. The problem I see is that =
it
> doesn't output anything in the echo area. It color-codes the buffer, =
it
> does show correct pop-up when mouse is over a region, but it doesn't
> print anything in the echo area when I move cursor through the region=
s.
> Any idea how to debug/fix this?

Well, it appears I removed the output to the echo area. I didn't think
it worked very well, and the new output format mostly replaces it by
showing the hash.

There are also technical reasons for removing it (it couldn't be
implemented very cleanly).

It would of course be possible to restore the old way, but I think it
would be good to ask ourselves what we really would like to see? Some
ideas:

* A keybinding to show the commit introducing the current line,
  including diff and all.

* A keybinding to show the commit message in the echo areia.

* The old "log --oneline in echo area when point moves in to a new
  region" behavior.

* The old behvaior with a delay.

* Inline display of even more information. For just the current region?

* A constantly updating separate window

--=20
David K=C3=A5gedal
