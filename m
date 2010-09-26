From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3 v2] use cache for function names in hunk headers
Date: Sun, 26 Sep 2010 22:43:18 +0200
Message-ID: <20100926204318.GA19588@localhost>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at>
 <20100923070439.GA29764@localhost>
 <4C9F7450.9060208@lsrfire.ath.cx>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 26 22:47:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozy8P-0003Oh-Mr
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 22:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab0IZUmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 16:42:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58437 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab0IZUmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 16:42:53 -0400
Received: by bwz11 with SMTP id 11so2917191bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=C8lnonN+8FmG41z4VNNROLWHRB7tpSpDHGzlPJkhfFs=;
        b=jhX3BoXTIotMAPykFkAWHu9/C0ezcYmpxWInZV6ldwuUr6DKxjBIMU76hqiXO4Ynck
         k32sk7Bez5dSK/kOBHMqTDlrgJ1uTTjYAG0rOplMOxDFhLy9SMc85tfh6hgjHdUy7CBI
         DqcCduPOWkqXSc64CUExmO+P8gQh45/AYzSK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=uS2lK0FG1gPiOFmn09Yao9jI5TnfLSSkKZG0l7XL3+pEZdQI64NQDwWZR4SNz2KKu/
         LTLTlXjF6szzGyn807y4n2AKuX5TeUfbKC0tSOLNqOiTmFqwbKtgopmhMf0WhiDgLCXL
         i+fenItmeskoR+vtgapsNnMp9kMDuyGLaQxp4=
Received: by 10.204.113.20 with SMTP id y20mr4427589bkp.170.1285533771889;
        Sun, 26 Sep 2010 13:42:51 -0700 (PDT)
Received: from darc.lan (p549A39F2.dip.t-dialin.net [84.154.57.242])
        by mx.google.com with ESMTPS id v7sm969651bkx.16.2010.09.26.13.42.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 13:42:50 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Ozy46-00058g-P1; Sun, 26 Sep 2010 22:43:18 +0200
Content-Disposition: inline
In-Reply-To: <4C9F7450.9060208@lsrfire.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157258>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 26, 2010 at 06:26:56PM +0200, Ren=E9 Scharfe wrote:
>=20
> Is xf needed?  Does xdl_emit_diff() handle multiple files in one go?

Right now it does not.

> If you inline xdl_find_func() the struct isn't needed anymore.
[...]
>
> How about something like this?

Yes, that's better. Thanks.

> -	/*
> -	 * Be quite stupid about this for now.  Find a line in the old file
> -	 * before the start of the hunk (and context) which starts with a
> -	 * plausible character.
> -	 */
>
> It also removes an outdated comment.

Actually, in the default case, the comment is still correct and
helpful IMO.

> The inlining part should probably split out in its own patch..

I am not sure what you mean here. Do you want to add the parameter
funclineprev to the function and remove the function in the next
page, or do you want to refactor the below into an inline function?

Clemens

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMn7BmAAoJELKdZexG8uqMz78H/1PVeQhSVLGNuMVx2zoNuUkj
lVdySYdWcBhhRFTz3nAU+2UN8dBo0UGoJgu7d0PT9RlKcDktzQP+qxbwCaF8W43D
mvMl1psBiUb/13RYoZIVe1BPNLyhszmX2UylCNRvaafrZayUXBRH1FxAvzng1TU5
mOpoqknRBjBVOlPhxMKRv4qZpM7fYiX25zINRPWMkJVSdl2jaPrTAcaSO/q2YgfU
UyXhwyet89Y5Cw7bgL/fBFpRWwaWD6bW1XnPL2ssJkxo9BKXCxp03WLMqf6wRW6Q
k2MSQfYte7nEYAWErJzBezMtSwRmNmkV+NCO7d7OEml078KP0DkAh5OOZEIajrQ=
=y2PN
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
