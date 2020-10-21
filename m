Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5253DC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3264241A4
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506633AbgJUWWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:22:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54300 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506629AbgJUWWF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Oct 2020 18:22:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E02D46042C;
        Wed, 21 Oct 2020 22:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1603318924;
        bh=utZ1Y2rj+7og/VHdBgddxa4o2GCuWxheyrH7wFGPOS8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tlJAldtA9Rz8CqM4d81YPzIcIJQOwdfKLFE5/186ftssPHwo1P9Uy3mPfq7+PNiEJ
         /W8G7+44qSojSvol+dQhh9O7gJTfsebHK1U9h8ODqDLupZphJgM3T4zD1qFer0sozz
         yIXFnxbqbFYhMbAsktTuALlB6Pz0EIz1L/ibQpz63A4G6L+y2U5KH3Ak4eA6+o1LLU
         4slZ8gcIDZAl4fHArKS3F1gOb0/OWj5mUUCMAuNRq+lLy+RN9IR5xUN9FPhb9P96V0
         05i8Xqc+MbWR47na66r615ZX7JSMaH5CJnwy+x4402bim9S6RIMcfV2t38nZUn+fHQ
         4rEAqFujvCOAxV4uv+8PZlj89UXNxuZZWJE1J3i8SwgNqfelPKBAd5tn3BNf5YRtxz
         2KeDqJNoyCi/a4AjQVYBHF29B0LyPzVdGyzsUEwW18cKvt+2J+dECjslBy4bcJ8I68
         TcpeV+8HyAC6eDwZqJ8ioa9nmdhu0X9t7iaBP2rZfqWEWltkpwL
Date:   Wed, 21 Oct 2020 22:21:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Nikos Chantziaras <realnc@gmail.com>,
        git@vger.kernel.org
Subject: Re: git svn log: Use of uninitialized value $sha1_short
Message-ID: <20201021222158.GJ490427@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nikos Chantziaras <realnc@gmail.com>, git@vger.kernel.org
References: <rmpve5$q2s$1@ciao.gmane.io>
 <20201021202642.GA60606@coredump.intra.peff.net>
 <xmqqwnzj5mq5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline
In-Reply-To: <xmqqwnzj5mq5.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-21 at 20:48:50, Junio C Hamano wrote:
> Looks that way.  '$::' as opposed to plain '$' threw the replacement
> off the track?
>=20
>  perl/Git/SVN/Log.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git i/perl/Git/SVN/Log.pm w/perl/Git/SVN/Log.pm
> index 3858fcf27d..9c819188ea 100644
> --- i/perl/Git/SVN/Log.pm
> +++ w/perl/Git/SVN/Log.pm
> @@ -298,7 +298,7 @@ sub cmd_show_log {
>  			get_author_info($c, $1, $2, $3);
>  		} elsif (/^${esc_color}(?:tree|parent|committer) /o) {
>  			# ignore
> -		} elsif (/^${esc_color}:\d{6} \d{6} $::sha1_short/o) {
> +		} elsif (/^${esc_color}:\d{6} \d{6} $::oid_short/o) {
>  			push @{$c->{raw}}, $_;
>  		} elsif (/^${esc_color}[ACRMDT]\t/) {
>  			# we could add $SVN->{svn_path} here, but that requires

Yeah, this is correct.  I'll try to get a format patch written up
tonight with this if nobody gets to it before me.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX5C0hgAKCRB8DEliiIei
ge/AAP9M3kNyJrIHNwjg8hVmcA7urzjpfcuzYrqc+XiDkVAOgAEA9Yiyv7/Vb6/X
RMhnux1pK5+Pr5tOFiSC9Y1jfY3U0QI=
=tckR
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
