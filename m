Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76542021E
	for <e@80x24.org>; Sun,  6 Nov 2016 14:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbcKFOzC (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 09:55:02 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35138 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbcKFOzA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 09:55:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so1290985wme.2
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 06:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fvNn6M0Tn5mXAaz4fLh21OHazLBZxpTuWsC17cgMyng=;
        b=rMLQzWJM3wqEp6x1Qe+urfUSEoR6cJiLXbWlREFUxGqx/STkmpYlA212nLSZSHWpcg
         oTNZ8Wry4nvt0W5FjiwkJnJGqcBjcHQsuZKHWQweUsKpt+HOoE1H6nJGXXeH6NKo7gRy
         L3DvGXPtM5SxkS2zDnBozAegDRcgdj429VhourGV0Z/nbLrcGW8RqPQt5DB96N5yBE8k
         ThV2qCQp0lyKdq9sqy9AohpTKdn9A7IkhUjYeCqmDk5vXwTXfMBzJfhtXAIaPcohV/LW
         Wj2U5XfTK/uM3N3RuyFGCX4y/+eAKPXszG99sKYsIoxKun49T1j9K9l+Q/ta+k2pILF/
         baWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fvNn6M0Tn5mXAaz4fLh21OHazLBZxpTuWsC17cgMyng=;
        b=kO/WJMNm7n+ivojd4CHoKwxa7pjcWrRHwa85fnweDL5GnoXYNbinyJ4ibS8+KeKjwt
         8tcaH/8BfFNHEqR/CjJrZXL1Awj456hHyHNqj3+Tq+GrrBJZN4uklEYdyhEbTlExamUA
         lcCMoF5EiTUa7Vxi3HK0SgGQ/8/yHPcj9/M0dDyEYC9eBwbQRGxazgeO1FRzwkVVKvrM
         K2t/5tE7H0n5VHUrYNPY1UEjg8dqX2gyTZL1oxh3WodPESIqMGbctcljTp29rA3M0GYC
         RPNL5e/zfKpz4qtw5B41xl8COznVRsiM9cXV/9HCRQrx3sXRfw0Z9IRR7uovLgq/PMFJ
         h+Hg==
X-Gm-Message-State: ABUngvd4Uyc5wg8FmMHYktoG+qAdHDHlCYwvf/jfl73kp0D5aM3mzPJ234pa/OAjSOIt8Q==
X-Received: by 10.28.214.73 with SMTP id n70mr5843967wmg.6.1478444099498;
        Sun, 06 Nov 2016 06:54:59 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id b184sm8057657wma.0.2016.11.06.06.54.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 06:54:58 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 4/4] t0021: fix filehandle usage on older perl
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161102182301.hezruhtuhra6uoft@sigill.intra.peff.net>
Date:   Sun, 6 Nov 2016 15:55:06 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        Martin-Louis Bright <mlbright@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <36375B98-2706-4A07-96F7-75D89B5FFD60@gmail.com>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net> <20161102182301.hezruhtuhra6uoft@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Nov 2016, at 19:23, Jeff King <peff@peff.net> wrote:
>=20
> The rot13-filter.pl script calls methods on implicitly
> defined filehandles (STDOUT, and the result of an open()
> call).  Prior to perl 5.13, these methods are not
> automatically loaded, and perl will complain with:
>=20
>  Can't locate object method "flush" via package "IO::Handle"
>=20
> Let's explicitly load IO::File (which inherits from
> IO::Handle). That's more than we need for just "flush", but
> matches what perl has done since:
>=20
>  =
http://perl5.git.perl.org/perl.git/commit/15e6cdd91beb4cefae4b65e855d68cf6=
4766965d
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I see J6t solved this a week ago using "FileHandle". These days that =
is
> basically a compatibility synonym for IO::File. I think both should be
> available pretty much everywhere, so I went with IO::File for the
> reasons above. But if that doesn't work for some reason, switching to
> "use FileHandle" should be OK, too.
>=20
> I don't have an old enough perl easily available to test it either =
way.
>=20
> t/t0021/rot13-filter.pl | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> index e3ea58e1e..4d5697ee5 100644
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl
> @@ -21,6 +21,7 @@
>=20
> use strict;
> use warnings;
> +use IO::File;
>=20
> my $MAX_PACKET_CONTENT_SIZE =3D 65516;
> my @capabilities            =3D @ARGV;
> --=20
> 2.11.0.rc0.258.gf434c15

Looks good to me (and works flawlessly on newer macOS).

Thanks,
Lars=
