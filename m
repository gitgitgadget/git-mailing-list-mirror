From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Re: git pull fails
Date: Tue, 28 Mar 2006 16:00:11 +0100
Message-ID: <200603281700.17233.astralstorm@o2.pl>
References: <20060328162831.af1bd4c0.tihirvon@gmail.com> <20060328141140.GC3113@linux-mips.org> <20060328173827.3d64d91e.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2008450.MXpIZsGnfp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>
X-From: git-owner@vger.kernel.org Tue Mar 28 17:04:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOFk0-0002a6-39
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 17:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWC1PEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 10:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWC1PEN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 10:04:13 -0500
Received: from mx2.go2.pl ([193.17.41.42]:37564 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1750778AbWC1PEM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 10:04:12 -0500
Received: from zen.localdomain (host-81-190-201-167.gorzow.mm.pl [81.190.201.167])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id DEC1F748072;
	Tue, 28 Mar 2006 17:04:04 +0200 (CEST)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FOFgV-0001Il-Da; Tue, 28 Mar 2006 17:00:39 +0200
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <20060328173827.3d64d91e.tihirvon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18124>

--nextPart2008450.MXpIZsGnfp
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 28 March 2006 16:38, Timo Hirvonen wrote yet:
> Thanks, but forcing everyone to edit their git/remotes/origin file
> is not very nice solution.  I think git-fetch should update refs for the
> other non-'broken' branches and leave "pu" and "next" refs untouched.

How do you know a non-broken branch from something weird?
All git knows is that the history is non-linear. You can do at least three=
=20
things:
=2D discard older history
=2D merge older history with newer
=2D add another branch

Or instead provide a more useful error message, like what is attached.
(I hope kmail doesn't mangle the tabs.)

diff --git a/git-fetch.sh b/git-fetch.sh
index 0346d4a..88df7f4 100755
=2D-- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -172,13 +172,15 @@ fast_forward_local () {
 		;;
 	    esac || {
 		echo >&2 "* $1: does not fast forward to $3;"
+		echo >&2 "  If the branch is known to roll back often,"
+		echo >&2 "  add + before the branch name in $GIT_DIR/$1."
 		case ",$force,$single_force," in
 		*,t,*)
=2D			echo >&2 "  forcing update."
+			echo >&2 "  Forcing update."
 			git-update-ref "$1" "$2" "$local"
 			;;
 		*)
=2D			echo >&2 "  not updating."
+			echo >&2 "  Not updating."
 			;;
 		esac
 	    }

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart2008450.MXpIZsGnfp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEKU+BlUMEU9HxC6IRAni/AKCZUYZ63EH+SwQVhQZ8Ixa4mHgFIwCfXclh
zdZX4o2Ri9xlcdLger0zLYs=
=ByuT
-----END PGP SIGNATURE-----

--nextPart2008450.MXpIZsGnfp--
