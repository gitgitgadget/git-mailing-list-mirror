From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting GIT_EXIT_OK to GIT_EXIT_CODE
Date: Sat, 10 Oct 2009 08:53:00 -0400
Message-ID: <1255178966-sup-5813@ntdws12.chass.utoronto.ca>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil> <20091010120121.GA16336@localhost> <m2eipbphbr.fsf@igel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1255179183-555824-1386-4671-30-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
Cc: GIT List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Oct 10 14:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwbTw-0005zC-ME
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 14:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760976AbZJJMxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 08:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754677AbZJJMxn
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 08:53:43 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:33058 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZJJMxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 08:53:42 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:46903 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1MwbRY-0005bL-G1; Sat, 10 Oct 2009 08:53:04 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1MwbRY-0006Y1-Df; Sat, 10 Oct 2009 08:53:04 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n9ACr3i7025169;
	Sat, 10 Oct 2009 08:53:03 -0400
In-reply-to: <m2eipbphbr.fsf@igel.home>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129882>


--=-1255179183-555824-1386-4671-30-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Andreas Schwab's message of Sat Oct 10 08:24:40 -0400 2009:

> According to the autoconf docs this bug is also present in the Solaris
> /bin/sh (and autoconf generated scripts use some elaborated workaround).

Solaris' /bin/sh shouldn't be used for anything but forking a decent
shell, imo.  It was brought to my attention recently that the test
suite for mercurial on solaris was failing the git tests.  The
mercurial folks initially thought this was a git on solaris bug.

After looking into it, I discovered that ^ is still treated[1] as a
pipe symbol[2] in some cases.  So, test suite programs run under
/bin/sh on solaris with commands like `git reset --hard HEAD^` were
misbehaving due to the shell setting up a pipeline under the right
circumstances.

-Ben

[1] http://cvs.opensolaris.org/source/xref/onnv/onnv-gate/usr/src/cmd/sh/cmd.c
    line 184

[2] This dates back to the Thomson shell:
    http://en.wikipedia.org/wiki/Thompson_shell
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1255179183-555824-1386-4671-30-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFK0IOv8vuMHY6J9tIRAjXLAJ0azcSz9Nc0ZYgmRPpkJiS/JuN85wCgt5hC
PGeBn7afiU6dnZf+CqAhkRI=
=yd+p
-----END PGP SIGNATURE-----

--=-1255179183-555824-1386-4671-30-=--
