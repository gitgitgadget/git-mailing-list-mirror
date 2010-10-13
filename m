From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v2] hash binary sha1 into patch id
Date: Wed, 13 Oct 2010 23:10:11 +0200
Message-ID: <20101013211011.GA2558@localhost>
References: <20100813094027.GA20906@localhost>
 <20100813200031.GD2003@burratino>
 <20100813212331.GA24127@localhost>
 <20100813213726.GB2516@burratino>
 <20100813215801.GA24534@localhost>
 <20100815072043.GA368@localhost>
 <1284095850.1728.5.camel@n900.home.ru>
 <20100910081626.GA30507@localhost>
 <1286956002591-5629905.post@n2.nabble.com>
 <1286961452235-5630164.post@n2.nabble.com>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P68aK-0003x0-51
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab0JMVJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:09:57 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51680 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0JMVJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:09:56 -0400
Received: by ewy20 with SMTP id 20so2654924ewy.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Yzb8KmlcTrHVxLDYzbUM9rWKUu0NUOnOkaYsIhkd8VA=;
        b=JQC4jtdwfDak3Shn0N12+M5h9HmUmMjoD5u83z7+9HUv0WRBgBEcw7/TgTk43gj6gj
         sFslTLL5eoIYzo0Qdq37kvCquXqHLEEz1N45mc6iDfwBoXFmjiCNaxuwB5BCd7Tm6+3B
         3/AKprco4BsihdFHVfHFE1IrmqvrFmkzQILdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=oozDux7GrmsmRf8oKre23VrqQmOOFmCzsM/ptJTJkPbXb9KJa8JCwbAafOK1Ds7M4V
         5UlnbJHONy0lNk5zUzSqZbJ3Br6E0FRcxgSnHOBn4akNKAxXwbEe+lbYpBFVtOjLaP36
         nVuKte6Xs7gclt33VSKlgufp4RqnsvsCsQ88k=
Received: by 10.14.119.7 with SMTP id m7mr5777367eeh.43.1287004194822;
        Wed, 13 Oct 2010 14:09:54 -0700 (PDT)
Received: from darc.lan (p549A679C.dip.t-dialin.net [84.154.103.156])
        by mx.google.com with ESMTPS id x54sm5573546eeh.17.2010.10.13.14.09.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 14:09:53 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P68aR-0000nA-EY; Wed, 13 Oct 2010 23:10:11 +0200
Content-Disposition: inline
In-Reply-To: <1286961452235-5630164.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158976>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marat,

On Wed, Oct 13, 2010 at 02:17:32AM -0700, Marat Radchenko wrote:
>=20
> Does diff_get_patch_id (in diff.c) really need to set xecfg.flags =3D
> XDL_EMIT_FUNCNAMES? Removing that makes git-rev-list (called by rebase) 2x
> faster here. Not sure about consequences though.

Yes, this has already been fixed in ad14b450 (do not search
functions for patch ID), which is currently in git.git's pu branch.
Function name search performance has also been improved for some
obscure cases in c099789b (diff: avoid repeated scanning while
looking for funcname).

Thanks anyways. If you notice anything else, please let us know.

I had a look at your gprof results, but I cannot make much sense of
it. I do not understand why git rev-list would even do any diffs.
For me, rev-list spends more than 50% in libz.  Can you give more
details on the kind of repository you have (binaries, memory size,
history size, any special attributes or options?), which git
version you are using, and which options you are passing to
rev-list?

Clemens

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMtiAzAAoJELKdZexG8uqMxNgH/RmwFUqLX4ZHMfCTJM1WwQrn
j3RuAu+2gp8j1W/dZhI752prOStoi/kPm15jymmuA49pGI7BOkZcAzkvStTv7sjW
y7Ts+e6EaCRzSTNVYLqwgDxPnL2MQHBMV4gPt8XINGQ8b5eQs2J3eclot4X6bMEM
g/lR+NjGkqAWlTwOOAqJ1+bQnWY8CuusBrMcjjABT+Jh0M9Jj4fT7//Ew3RGtLrR
1FaBzQySOweCx1IfK0WkBwSfWQG1iJQSgJLnTFe3HgwjqRiMVGJafesWGKqVTi8U
z6dOEpMoCe7E7R8/vb44ahVlX+gd56N2KXvQMiC0KzDAhrUvT6OBRFuqPNvtajM=
=6gFK
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
