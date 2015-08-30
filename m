From: Neil Brown <neil@brown.name>
Subject: git bisect replay produces wrong result
Date: Sun, 30 Aug 2015 06:38:54 +0200
Message-ID: <8737z15r1d.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 06:39:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVuOv-0001sB-9A
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 06:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbbH3EjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 00:39:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:47223 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbbH3EjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 00:39:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8EE13AC4B
	for <git@vger.kernel.org>; Sun, 30 Aug 2015 04:39:00 +0000 (UTC)
User-Agent: Notmuch/0.20.2 (http://notmuchmail.org) Emacs/24.5.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276801>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,
 the following git-bisect log - applied to a recent linux-kernel tree
 produced different end results when I use "git bisect replay"
 and when I just run it as a shell script.

$ git bisect replay /tmp/log=20
We are not bisecting.
Bisecting: a merge base must be tested
[2decb2682f80759f631c8332f9a2a34a02150a03] Merge git://git.kernel.org/pub/s=
cm/linux/kernel/git/davem/net


$ bash /tmp/log
....
Bisecting: 2 revisions left to test after this (roughly 1 step)
[57127645d79d2e83e801f141f7d03f64accf28aa] s390/zcrypt: Introduce new SHA-5=
12 based Pseudo Random Generator.

Is "git bisect replay" doing the wrong thing, or am I confused?

I tested on 2.5.0, and the current HEAD.

Thanks,
NeilBrown

git bisect start
# bad: [5ebe6afaf0057ac3eaeb98defd5456894b446d22] Linux 4.1-rc2
git bisect bad 5ebe6afaf0057ac3eaeb98defd5456894b446d22
# good: [39a8804455fb23f09157341d3ba7db6d7ae6ee76] Linux 4.0
git bisect good 39a8804455fb23f09157341d3ba7db6d7ae6ee76
# good: [6c373ca89399c5a3f7ef210ad8f63dc3437da345] Merge git://git.kernel.o=
rg/pub/scm/linux/kernel/git/davem/net-next
git bisect good 6c373ca89399c5a3f7ef210ad8f63dc3437da345
# good: [2c33ce009ca2389dbf0535d0672214d09738e35e] Merge Linus master into =
drm-next
git bisect good 2c33ce009ca2389dbf0535d0672214d09738e35e
# good: [7d2b6ef19cf0f98cef17aa5185de3631a618710a] Merge tag 'armsoc-driver=
s' of  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 7d2b6ef19cf0f98cef17aa5185de3631a618710a
# good: [836ee4874e201a5907f9658fb2bf3527dd952d30] Merge tag 'arm64-upstrea=
m' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good 836ee4874e201a5907f9658fb2bf3527dd952d30
# good: [78d425677217b655ed36c492a070b5002832fc73] Merge tag 'platform-driv=
ers-x86-v4.1-1' of git://git.infradead.org/users/dvhart/linux-platform-driv=
ers-x86
git bisect good 78d425677217b655ed36c492a070b5002832fc73
# good: [39376ccb1968ba9f83e2a880a8bf02ad5dea44e1] Merge git://git.kernel.o=
rg/pub/scm/linux/kernel/git/pablo/nf
git bisect good 39376ccb1968ba9f83e2a880a8bf02ad5dea44e1
# bad: [64887b6882de36069c18ef2d9623484d6db7cd3a] Merge branch 'for-linus-4=
.1' of git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs
git bisect bad 64887b6882de36069c18ef2d9623484d6db7cd3a
# bad: [9dbbe3cfc3c208643cf0e81c8f660f43e1b4b2e8] Merge tag 'for-linus' of =
git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad 9dbbe3cfc3c208643cf0e81c8f660f43e1b4b2e8
# bad: [dcca8de0aa597f14e31a1b38690626c9f6745fd5] Merge tag 'usb-4.1-rc2' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect bad dcca8de0aa597f14e31a1b38690626c9f6745fd5
# bad: [3d99e3fe13d473ac4578c37f477a59b829530764] Merge branch 'stable' of =
git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile
git bisect bad 3d99e3fe13d473ac4578c37f477a59b829530764
# good: [b7d14f3a92223c3f5e52e9f20c74cb96dc130e87] s390/mm: correct transfe=
r of dirty & young bits in __pmd_to_pte
git bisect good b7d14f3a92223c3f5e52e9f20c74cb96dc130e87

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV4ojeAAoJEDnsnt1WYoG5VSMP/iRvC6tpsvNiP1AYt8ajMqqv
EchitXOWYu1GLEurrJCF2Fj4JpQ8b1wOFykMDjvRvyBDq1wGVK1p7+VjOCt1nlza
Wb76euc4EERC42et9o0t0r9XthSFLUMowkBP0/GVTfnB+hC98ZH1ajq4QIBUMbAW
eYpdvuX3+BSTazOktAQYZ5YjqduQWmapLPjlThIxOGH6BV/CvNykPwxkM/QlZrGC
7ZXAcCyMb/yxmEYv4wx4ziymCYJKxi82Yh3NlYvM4XEvk0kCKAmzDv5L594gfNfI
5DKYh1areFjovgPXt2DgcM93gVjCCRz62DHRMzQuF8xLgdfPJ277kIkYti8X5TC2
495OW16nAEdq1Jgj0yToc/JQMfr69jsUoSKwLieGGylHDRIGN+H5xcifqg0cfDG6
MCFTNRMp1V5CHUnenxv+GKJqhfJaW+z50FEryppjHthC4FgpDIDlx4oK6ayNuazJ
u3dDxEmXzkEJXb7Jh+QaJn67g2crQUtq9Y4y4S4DlzNvoWWzIJxZ3tVxzqMrKPZL
IirNnupDrzEz1xmka2dpUAnUF1cfvCLleFpDUkLlSqQGDQa01AQAORL1aIksOjHW
gqpLP5/FnOt+z/OKJxWprshT9K+EqY5ipSu83tkPj2AoqRQoD3xWxahcDknSO00p
sxbdlUtcprjRALU14UWD
=ZC2S
-----END PGP SIGNATURE-----
--=-=-=--
