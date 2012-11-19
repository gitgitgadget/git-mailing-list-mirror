From: Felipe Balbi <balbi@ti.com>
Subject: Failure to extra stable@vger.kernel.org addresses
Date: Mon, 19 Nov 2012 11:57:47 +0200
Message-ID: <20121119095747.GA13552@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 11:04:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaODO-00038s-0w
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 11:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab2KSKEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 05:04:15 -0500
Received: from bear.ext.ti.com ([192.94.94.41]:51541 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab2KSKEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 05:04:14 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id qAJA4EYq017189
	for <git@vger.kernel.org>; Mon, 19 Nov 2012 04:04:14 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qAJA4Etx016451
	for <git@vger.kernel.org>; Mon, 19 Nov 2012 04:04:14 -0600
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dfle72.ent.ti.com
 (128.247.5.109) with Microsoft SMTP Server id 14.1.323.3; Mon, 19 Nov 2012
 04:04:13 -0600
Received: from localhost (h68-4.vpn.ti.com [172.24.68.4])	by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id qAJA4CvK024579;	Mon, 19 Nov
 2012 04:04:13 -0600
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210042>

--ALfTUftag+2gvp1h
Content-Type: multipart/mixed; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi guys,

for whatever reason my git has started acting up with
stable@vger.kernel.org addresses. It doesn't manage to extract a valid
adress from the string:

 Cc: <stable@vger.kernel.org> # v3.4 v3.5 v3.6

Removing the comment at the end of the line makes things work again. I
do remember, however, seeing this working since few weeks back I sent a
mail to stable (in fact the same one I'm using to test), so this could
be related to some perl updates, who knows ?!?

Anyway, here's output of git-send-email:

> $ git send-email --to linux-usb@vger.kernel.org ../linux/0001-usb-dwc3-ga=
dget-fix-endpoint-always-busy-bug.diff --dry-run
> ../linux/0001-usb-dwc3-gadget-fix-endpoint-always-busy-bug.diff
> (mbox) Adding cc: Felipe Balbi <balbi@ti.com> from line 'From: Felipe Bal=
bi <balbi@ti.com>'
> (body) Adding cc: <stable@vger.kernel.org> #v3.4 v3.5 v3.6 from line 'Cc:=
 <stable@vger.kernel.org> #v3.4 v3.5 v3.6'
> (body) Adding cc: Felipe Balbi <balbi@ti.com> from line 'Signed-off-by: F=
elipe Balbi <balbi@ti.com>'
> Use of uninitialized value $cc in string eq at /usr/libexec/git-core/git-=
send-email line 997.
> Use of uninitialized value $cc in quotemeta at /usr/libexec/git-core/git-=
send-email line 997.
> W: unable to extract a valid address from: <stable@vger.kernel.org> #v3.4=
 v3.5 v3.6
> W: unable to extract a valid address from: <stable@vger.kernel.org> #v3.4=
 v3.5 v3.6
> Dry-OK. Log says:
> Sendmail: /usr/bin/msmtp -i linux-usb@vger.kernel.org balbi@ti.com
> From: Felipe Balbi <balbi@ti.com>
> To: linux-usb@vger.kernel.org
> Cc: Felipe Balbi <balbi@ti.com>
> Subject: [PATCH] usb: dwc3: gadget: fix 'endpoint always busy' bug
> Date: Mon, 19 Nov 2012 11:54:16 +0200
> Message-Id: <1353318856-14987-1-git-send-email-balbi@ti.com>
> X-Mailer: git-send-email 1.8.0
>=20
> Result: OK

$ perl --version

This is perl 5, version 14, subversion 2 (v5.14.2) built for x86_64-linux-g=
nu-thread-multi
(with 72 registered patches, see perl -V for more detail)

Copyright 1987-2011, Larry Wall

Perl may be copied only under the terms of either the Artistic License or t=
he
GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on
this system using "man perl" or "perldoc perl".  If you have access to the
Internet, point your browser at http://www.perl.org/, the Perl Home Page.

And attached you can find the patch file which I'm using

--=20
balbi

--oLBj+sq0vYjzfsbl
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-usb-dwc3-gadget-fix-endpoint-always-busy-bug.diff"
Content-Transfer-Encoding: quoted-printable

=46rom 041d81f493d90c940ec41f0ec98bc7c4f2fba431 Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <balbi@ti.com>
Date: Thu, 4 Oct 2012 11:58:00 +0300
Subject: [PATCH] usb: dwc3: gadget: fix 'endpoint always busy' bug

If a USB transfer has already been started, meaning
we have already issued StartTransfer command to that
particular endpoint, DWC3_EP_BUSY flag has also
already been set.

When we try to cancel this transfer which is already
in controller's cache, we will not receive XferComplete
event and we must clear DWC3_EP_BUSY in order to allow
subsequent requests to be properly started.

The best place to clear that flag is right after issuing
DWC3_DEPCMD_ENDTRANSFER.

Cc: <stable@vger.kernel.org> #v3.4 v3.5 v3.6
Reported-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c9e729a..7b7dedd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1904,7 +1904,7 @@ static void dwc3_stop_active_transfer(struct dwc3 *dw=
c, u32 epnum)
 	ret =3D dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
 	WARN_ON_ONCE(ret);
 	dep->resource_index =3D 0;
-
+	dep->flags &=3D ~DWC3_EP_BUSY;
 	udelay(100);
 }
=20
--=20
1.8.0


--oLBj+sq0vYjzfsbl--

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqgKbAAoJEIaOsuA1yqRENncP/33tpYSIL2PqiTQ80ZJvRmgp
wS0PFyGv4F0tpPCzi2E6xkLFWPV9Sdlw5ZkNWK97ioEKnW2V4bHq1dU7eqdc4S9T
8biJyZHgq+lH2tjIZaz/3mmAsbygVN4HWwOapX4ROmIVkgm3i6L0reo/3D2X0t0l
EmTNNGvaJRquK+7m7Kwc9VMN9p364W2u/EG3OqCglrI+0QaSy9HTA3317H8JbYCp
iPqCzb0oEmAz0M1XU7lvK8m36uRMz+Eynon2vRWX1Dcbdxct+GJLhl9zE2F6Z/1r
fXvKx33osGenNW2JK1iblkA9WpA4PxY/inzMKJX96V66jcFdmTNyoyzeIoda+P1B
1yfMyzIJvmbL2ZEREKvqLytryv5fNeVcnDBET2EsnIiQC3akUaNjZkAEjvPkk95U
83Q07gQlpSdyapDwBow3Txo0BdCMu48Eefte9AsgqpZSB2jsDa2M8W1nygrXQoAY
xOigy7jTXmjgV0wTyNALCEbrvJPNF6TWVbII8fWVkoO4XLrhUK91c1EP4ZSizB7f
4PpUm6z2EGdaYX4qNrBvLN3ZiMW+/mLQ+NCaQPlFhTj0g8UPVzaPahGxDzRSCFOT
2KCrt0n5xlyNnbtEokjKEAANOaQbYjE3aPDZyQj6oBOFP/yV+qb/D5u32H9dy3s1
m/tWdGlrtwCp8uobjQCL
=77+9
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
