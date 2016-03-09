From: Barry Warsaw <barry@python.org>
Subject: Re: GIT_CEILING_DIRECTORY
Date: Wed, 9 Mar 2016 12:57:04 -0500
Organization: Damn Crazy Followers of the Horn
Message-ID: <20160309125704.162be49c@subdivisions.wooz.org>
References: <20160309110242.04d8d480@anarchist.wooz.org>
	<xmqqshzzimpo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VqpUzpTkf01x+Ks/o..7wrh"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 18:57:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiMR-0002n1-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933705AbcCIR5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:57:15 -0500
Received: from mail.wooz.org ([216.15.33.194]:54092 "EHLO mail.wooz.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933490AbcCIR5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:57:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.wooz.org (Postfix) with ESMTP id 356F5140497;
	Wed,  9 Mar 2016 12:57:07 -0500 (EST)
Received: from mail.wooz.org ([127.0.0.1])
	by localhost (carnies.wooz.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hl2y4m9fKB49; Wed,  9 Mar 2016 12:57:07 -0500 (EST)
Received: from subdivisions.wooz.org (subdivisions.wooz.org [192.168.11.47])
	by mail.wooz.org (Postfix) with ESMTPSA id 0C38B140496;
	Wed,  9 Mar 2016 12:57:07 -0500 (EST)
In-Reply-To: <xmqqshzzimpo.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.13.1 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288539>

--Sig_/VqpUzpTkf01x+Ks/o..7wrh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mar 09, 2016, at 09:29 AM, Junio C Hamano wrote:

>Let me understand the use case.  You have $HOME/.git that governs
>everything under $HOME, but there are parts of $HOME/, such as
>$HOME/projects/*, that will never be controled by $HOME/.git?

Correct.

>Two obvious reactions are:
>
> - hopefully $HOME/.gitignore covers these non-git parts by having
>   entries like '/projects/'; this should not affect the behaviour
>   of CEILING though.

Correct.  In this case, $HOME/.gitignore has `projects` so `git status`
etc. in $HOME does the right thing.

> - typing "git status" inside $HOME/projects/ does not make much
>   sense in the first place.

True, and normally I wouldn't do this explicitly, but it comes up because I
have a bash prompt that shows me the status of the current directory
($GIT_PS_*) so even when I just cd to ~/projects I see status for $HOME.

>I _think_ the "are we in a Git-managed working tree and if so, then
>where is the .git directory?" discovery works like this:
[...]

>So setting $HOME/projects as one of the elements in the CEILING list
>would not stop us going up if you are actually at $HOME/projects,
>but we would stop if you started from $HOME/projects/python.

And indeed, that works great.

>This somehow sounds a bit inconsistent to me, but I say "a bit
>inconsistent" because "Why do we give different answer to 'is
>$HOME/projects/python governed by $HOME/.git?' depending on where we
>start the discovery process?" is a non-argument (i.e. that is not
>the question CEILING is answering).
>
>I have a feeling that we must have done that for a reason.  It may
>be interesting to see what breaks in t1504 if the above logic is
>updated to stop when you start at a CEILING (unlike the current code
>where it stops only when you start below a CEILING).

That would be interesting; it seems like it would solve my use case.

Cheers,
-Barry

--Sig_/VqpUzpTkf01x+Ks/o..7wrh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4GPxAAoJEBJutWOnSwa/NqgQAK1uv6tGxiCVU1diV06LOg7d
EAPVZg5I0k1rCYsyNHs7/M4GYwG09mm+c3oMbTAsLjs69DIkD7vbuyaBmI/zJyOy
q3wJCPnzApd2s0nTbDlwhUYS3tvdoO6cAmFmKw11QQwyppEFoFBknOt6lHeCF2TL
S9mR8UumdcIondEV2Cc394G/Wm6xlonIkhHbMPAcZsb2UW6z4MD4BVJUrnfHczF4
cgvbEEM09EsnjPyBDvyc9At3PSonvPFVosj0QdODXE1UM8l+3rpRzCBWFYzoPCpj
nMqaHQtXIjDggtrfL5GamZXL68r2fd1eSaL2a2EhEARd6ynUOuRONUHqQWQ43aZS
DrZ2ZL7Hlst4cu1fkjqOQ9Fb9YuuCx6T/fWPtBR1vmlqV4UwfqaEQYrXyP2D7M53
xFR9OykAfv2k7TLFiG9j3IUr6rwSbfh4SpMvr6oaSEOf5Ba4+5mBa3Z6xsFf5658
Jn8nYQ/mnnMVzCCu8aCwgSR7GZruwfPALRdjOJ/9XPJhH5Xjzzz10fTQgKdINLmO
7XXPgZkH9athBXuI2qM4W8Btwo1+loXgUEpmiJsU8szvp+dJrupYk7zZMwLPl0YU
hIqdZ3g8opTbd2bEOPV9FLlxMe9KiST1abXydYhtBV117cFcBA7hmRMM2lRBwGZO
BVw3AOwa2FcOIBFYYPvf
=38Tu
-----END PGP SIGNATURE-----

--Sig_/VqpUzpTkf01x+Ks/o..7wrh--
