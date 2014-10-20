From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] t1304: Set LOGNAME even if USER is unset or null
Date: Mon, 20 Oct 2014 08:28:09 -0700
Message-ID: <20141020152809.GR17200@odin.tremily.us>
References: <12975d1f2b5b1cd4cc6052b829bf4814300a7ffd.1413581788.git.wking@tremily.us>
 <xmqqegu3r7y7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sf3MmCJcUNNLokcm"
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 17:28:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgEsZ-00043f-H8
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 17:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbaJTP2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 11:28:11 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:55299 "EHLO
	resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751331AbaJTP2K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 11:28:10 -0400
Received: from resomta-po-19v.sys.comcast.net ([96.114.154.243])
	by resqmta-po-11v.sys.comcast.net with comcast
	id 5TU01p00D5FMDhs01TUA2w; Mon, 20 Oct 2014 15:28:10 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by resomta-po-19v.sys.comcast.net with comcast
	id 5TU91p00J152l3L01TU9xk; Mon, 20 Oct 2014 15:28:10 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 506B3142EA31; Mon, 20 Oct 2014 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1413818889; bh=GD0mAqzcBJYCaEOSP6QpJtm570/vK0FLYFvSS5nLfvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IbRD6czGMhEtuYn6oNHBhXk/Rb1Nv/6Vz56WPFb0OAHj1HZ+Of0f45i3b5PbxZ4M6
	 Pn2u24o+7TiR0/nYvLl3Cp1OxYHLKUwCaqoA+Zh+uO7WzWpRWy8x0ameO5ZO3U7M7S
	 vLgzRL9N+HORA6z6ZVPbpmRSykGOTUt/54gk5VbM=
Content-Disposition: inline
In-Reply-To: <xmqqegu3r7y7.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1413818890;
	bh=2DTZVKPu2mHlFy1PH3br//FbXzwfLmqkeZHK7hI5myc=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=IFiQVw2/TqL3GnGaBaU7Bo8QfkGKjjUokhbVcRao3wHyYqrrxX0jYa4rhq1LdH6py
	 TOAFuZS3rvUPKTf37DEqeyaekfnfoQoK+FwoaQrsApud0kiGlHNVlwG4ZHfsNuf/8q
	 m36euzemCd8PswNyppiDL/tBxznZ33I4SsKu6O8KnXM3m4N7VHmwiHLCyFTuS0L2X1
	 iuNcEYNyLE//CCAxyWlzjArIBneWVF8qpRS9cwvZOwQ/1K9OjTDPPbuN0aCRVywO7L
	 Q+d6pR4JjRuAnjDC6MWIuRqoEs+hKBhdIomBEbGqYydMDDHLDS9ZW1P9dL2G+4S7Vl
	 jHmd8Xjtx9wiQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Sf3MmCJcUNNLokcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2014 at 03:49:36PM -0700, Junio C Hamano wrote:
> I'll queue this as-is, but it makes me wonder if we want to do this
> without if/then/fi, e.g.
>=20
> 	: ${LOGNAME:=3D${USER:-$(id -u -n)}

I'm fine with that too.

> Spelling everything out with if/then/fi is obviously at the other
> extreme, i.e.

And I'm fine with this ;).

> More importantly, what if none of the alternatives work?  I
> personally feel it is OK to punt and declare test_done early,
> instead of giving false positive breakages like you saw without this
> patch.

I can put this into a v2 if you like.  Which conditional syntax do you
prefer?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--Sf3MmCJcUNNLokcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJURSoIAAoJEG8/JgBt8ol8WZoQAN85zMKZYs/gjA7u2lfMv3os
PGcJs09IgW2d89qgzSAIlfEwPYe/n7mU62AifeKRU3pyY9PXBrxVyecTWIAkiNYp
WU+GkeGo0Gi1Nb6wWzFKAeP9spgvcCQl9eCHXi+r5CN14lJv3FXA78FzkO+CnElS
72pSHWM3bF90m7aauaKD2LXc/+sks1fdYLtE17lGCjU5jzTFAdcht1SLVdARoM0h
CziEAlYiyIZJ0XcUTqbt9yftNyl7lvqdG/T1TVd0LIf3FC5DeFJD84Nr07XZ4mQZ
PWab2MAat1jiD+7Qk0Zc/xe8ludTvFbJ4vdp9KOd6ZN1A/ERCk/G3m6uyoTCgqBt
KCRnG2se4Ljsjpwl3JGW+tct5k3PCdHJVN6kXMtNU2nntp3ltNWImefKoJXj/Db9
RRR1kyGrQ3wvheJQZWzpr4s617pBVbmk1dPt/ZgWcBSswAFjKVvuJIRY81UWfYQ/
9/8CYgMTlT45Fkcxb0s1mSTIxAyVhFCczE4MjThn1rHy/fPmZsgB7IbmWwsnjyK1
iJm/zC9ptm6Rfro/IE+NwCpnXxQXxiD9bK8s2/FooO3PT00YfPBjkvt9jIjohUoJ
JDf6PcxcOU04fUEoCRiY+crmM4ySdrHx/abeXgu2B075hhPA2iOFLEtE+RbzE8Kq
smsoXTaSVRK3DFJQERlk
=jWWf
-----END PGP SIGNATURE-----

--Sf3MmCJcUNNLokcm--
