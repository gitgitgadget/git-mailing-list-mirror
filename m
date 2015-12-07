From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/2] format-patch: introduce option to suppress commit
 hashes
Date: Mon, 7 Dec 2015 03:30:20 +0000
Message-ID: <20151207033020.GA990758@vauxhall.crustytoothpaste.net>
References: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqh9jvnfbp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 04:30:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5mVU-0006eG-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 04:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428AbbLGDa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 22:30:28 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:32992 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755086AbbLGDa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2015 22:30:27 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8D26C2808C;
	Mon,  7 Dec 2015 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1449459025;
	bh=QuzIjaM0X7BchD0vKTznC2OokwaiCUtJFhXbjfVvf5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmN51zzDCmoLIiFd3to7k7wNj+vdmVPtwM8+x2QyYod2n0+3oURAnF9RnYRAJBrlP
	 GGOd8LpOwNx5LTDx3iwt962+oPVB5fDrfqEWYTEGCrZuFQmL07wtiZKRYIoC/1mETK
	 3H+7VpKAYai561C5O64iSq1pc2LbbzKJNavvn6TCrmKlM9ze5KwhpnzNz2JxUvfyzn
	 xPwrttD2mESWm51uclGXac9pbWSxeZc6gD7SrSz5jT2c8nj9pxlZNeYYu07DSpG7mj
	 GCk/edHD7Jq6xh1Y5s/h8Q9FVo91ZPvyitc9Af9ShB7wrvsgKSY+5xUvqA5KEBJRMS
	 GeCN5ksTkUIXcYOzKdmRIqrSBtdrV/LGrUb/8mkKvmRFmky6xlq4Sd04xfzUZ3Le7p
	 LzTPl5N3mA1gROsmByWnhixl/+8OmE6m+15mB7+SvooiQb04vVGpNgPAIfU5t4xG3H
	 FJZ41SOjEGlJ1+McTJMVs0DWrWDCG5is+/kd7QTW+6KVhi9vNFs
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <xmqqh9jvnfbp.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282074>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 06, 2015 at 06:49:14PM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > git format-patch is often used to create patches that are then stored in
> > version control or displayed with diff.  Having the commit hash in the
> > "From " line usually just creates diff noise in these cases, so this
> > series introduces --no-hash to set that to all zeros.
>=20
> I am somewhat negative on this change that deliberately loses
> information in a way that seems too specific to a single workflow.
>=20
> I understand that in that particular workflow, the patch stored as
> payload in a history needs only the diff part and the commit that
> the patch was taken from is deemed irrelevant.

Not exactly.  At $DAYJOB, we store pristine-tar files, the contents of
the tarball, and patches against the source in Git.  We do it because
RPM likes patches and doesn't know how to speak to Git, but many Debian
source packages are stored similarly.  Every source change results in a
rebase and reformat of all the patches.

> But the reason why that and only that piece of information is
> expendable, while author, subject and log message text are not is
> because...?  The answer to that question would very much be
> project's workflow dependant.  From that point of view, I'd say the
> users are much better off without the addition of this feature, but
> have a custom script in their workflow to remove parts that their
> project and workflow deems unnecessary.  Your project may deem the
> source commit object name unnecessary.  Another one may think the
> author date and name are, too.  Patch e-mail signature (i.e. what
> comes after a line with "-- ") by default depends on the version of
> Git that happened to have been used to prepare the patch, which may
> not be something you would want.

We do want to know who wrote the patch and the reason behind the patch,
and so pretty much all the information except for the actual hash of the
commit is useful to us.  The hash is not useful because we've just
rebased the commit on a temporary branch.  We do, of course, want
--no-signature, which already exists, as you pointed out.

The hash of the source file isn't generally as much of a problem,
because the patch tends to change, even incidentally (line numbers and
such), when the hash of the file changes.  It's also something that we
have in our history, whereas the temporary branch we rebased in is not.

> Stepping back a bit, why is the history from which the patches are
> taken from irrelevant in the first place?  Perhaps because you
> replayed these patches on top of the same base but did not preserve
> their timestamps?  If this user, i.e. the part of the workflow that
> commits generated patches to version control, finds the "irrelevant"
> change irritating, isn't it fair to expect other users, i.e. other
> parts of the same workflow, also find that unnecessary and
> irrelevant rebasing irritating?  It feels like I am seeing an
> entrance to an X-Y problem whose real solution is to stop doing the
> pointless rebases in the first place.

The history is irrelevant because it happens on a temporary branch which
is not pushed anywhere.  The patches are the canonical form.  As I said,
this workflow is not specific to us; it's also used by certain Debian
maintainers to handle their source packages.

The rebase is required because we're not sure if the patches all apply
to the updated source (e.g. we had Git 2.6.2 and are rebasing them on
2.6.3).  If patch 1 needed changes, but patch 2 did not, then patch 2
shows up in the diff even though we don't want it to.

> And if that rebase is not pointless, then I am not sure if it is a
> good thing to discard the information that records which incarnation
> of that constantly rebased source tree the patches were taken from.

I was looking through the Debian BTS for Git and I saw this feature
request and thought, "Gee, I've always wanted this functionality, but I
never thought to ask for it."  This frequent, throwaway rebasing is very
common in patch-based workflows.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWZP1MAAoJEL9TXYEfUvaLo+QP/1qUu3t9W/AuK2QbXVe8nflz
Uce3q0PGipi4zKtOl+qaW0zbNLw35+1wBGaYIxDHE39SosYVQ11Z9RnlagEan6Te
K/JXcXtxBNlvGCSt3srFal+ETJ7SVD1Iu5zc1Y9cDSst1UFQq39RMiKaG8I1M7GE
lbLONYMxtzzFvmnwVgv4Fc7SahMgpxVm8CDJjYYoLjavVjhUL4YrmRi4Z7ZCcU0e
L5jE87omMFarjrjqeuRp1W6CaDjD4xgzg/Q5Bg9mZKWkkAj424DnszU3NN2xNTKA
QDboVb7M2aCfNCw8PO/TK/XmqvIyNSruO8TLlm2bwfR5XwaK8cxHYxCcAcV/gy67
oLY6hmSRfa0Ck0Ruk52TkEO9n8us/rNe9HR3HfM3CS6uVhddRFrPBwR3VFOBUfwe
llmVkBioNGEYWKpVfYVGitQsA38HMkROhKt8NZD1EzK+FRNDEhehb2UGGTKfywYv
Oe8jVOTn1X0AVbpitfJVCgCRM8gumA6ONSpg5sHf3Qz2gPtAqYLwL/8wZmm5T6G5
rei4RsOwMhc1lvdPe749HCN4t+3lQ6COd8J7046vjMv/IJYnHTW2yoEF2XzymErt
UuxOJ2XPdzFIjjo545PjMIRwl7kLLe/GOPi9Sn8iDUmCwW9GQYmNBtPYW8O+Sbis
Bvrnu4BPV9S6oFdILuX6
=VxQH
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
