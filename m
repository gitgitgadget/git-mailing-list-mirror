Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DDBA1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937910AbdLRSQI (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:16:08 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43498 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933036AbdLRSQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:16:04 -0500
Received: by mail-wr0-f195.google.com with SMTP id w68so2705523wrc.10
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 10:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xj90grL9TxyOU9zF8Q28uYZai6aUm6Xa+Y5GW6Knscs=;
        b=n/O/U3w/guxtVxxIiUpfoYK4GaOFExONfll4NY+/FzdD03zSP7UA2pUNPPOVUpeaeO
         m3PEODNfqc7d00eLzpc5s9+M+xGM8J9eEY2P6yRNRAaurWIimZbEgcgKGQN57ILZZyW4
         +GkPKYjpjG752BlCuzp54C7aeXXazvwhahJfSZOruygGLWaNfrHOI80EfgYvLY9b9jIP
         fyL3dW5NGD0InD3HJXcD+Tse+Wquqxme8R1pmJQv4ER4y++20z55N5o68JOSHH81PYNq
         ydzAUe7illrbiXsZTZlYP4/I101ZZM5e8ILcDqp+85mhU4OXlTJCcSQf3Ye/t7/vJPGq
         jW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xj90grL9TxyOU9zF8Q28uYZai6aUm6Xa+Y5GW6Knscs=;
        b=YA224fOLadgOfYJtnxPOyQIDpacItptjMN56CnzyP8tKU52urI7ezw31974Eswwgh3
         IDPV89rpTqiWPYYKC8mudT7XzMm/BWY6uAmXCGVUlimbUEL5rUjexIcGOYO5J8XCEpXX
         BBmkDQoHwEHZLALUcXTI2t4h98R8eabDzwWFS8l9S2OUgS7xvHqLUqt92Ny8XcVP3Fej
         /hz1haKp3xeVHpr98j4YqwI4A+ThhxytTDsknnSK4JmeBDLj74xCO5VzIp0lKWyjYo3d
         JFdvBsZKT+2lYEUjiBF/Rd7i88feUDh2q7hVVZ2CKhB2D60QL0kxsFvYhEzPFD9VFQPn
         HAXQ==
X-Gm-Message-State: AKGB3mJ4PLcjwWdW2nSbrflFsT2UFH8oS3Bd+A2U4DvYH7rTgQyRcMea
        uwtDEcORCf8Q22tQVfUzTPo=
X-Google-Smtp-Source: ACJfBos4ScweCHHVKVfNq+oVxT6n30ohixwak7Xwr6I5CwB7tQNXTd/lPLIC6GMce8CIHmPkifPj1A==
X-Received: by 10.223.159.15 with SMTP id l15mr942483wrf.155.1513620963125;
        Mon, 18 Dec 2017 10:16:03 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e16sm2758501wra.0.2017.12.18.10.16.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 10:16:02 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171217225122.28941-4-t.gummerer@gmail.com>
Date:   Mon, 18 Dec 2017 19:16:01 +0100
Cc:     Git List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA6C93AD-B24D-43A2-8AAA-DE98A4C9E719@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com> <20171217225122.28941-1-t.gummerer@gmail.com> <20171217225122.28941-4-t.gummerer@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Dec 2017, at 23:51, Thomas Gummerer <t.gummerer@gmail.com> =
wrote:
>=20
> Split index mode only has a few dedicated tests, but as the index is
> involved in nearly every git operation, this doesn't quite cover all =
the
> ways repositories with split index can break.  To use split index mode
> throughout the test suite a GIT_TEST_SPLIT_INDEX environment variable
> can be set, which makes git split the index at random and thus
> excercises the functionality much more thoroughly.
>=20
> As this is not turned on by default, it is not executed nearly as =
often
> as the test suite is run, so occationally breakages slip through.  Try
> to counteract that by running the test suite with GIT_TEST_SPLIT_INDEX
> mode turned on on travis.
>=20
> To avoid using too many cycles on travis only run split index mode in
> the linux-gcc and the linux 32-bit gcc targets.

I am surprised to see the split index mode test for the linux 32-bit
target. Is it likely that a split index bug appears only on 32-bit?=20
Wouldn't the linux-gcc target be sufficient to save resources/time?


>  The Linux builds were
> chosen over the Mac OS builds because they tend to be much faster to
> complete.
>=20
> The linux gcc build was chosen over the linux clang build because the
> linux clang build is the fastest build, so it can serve as an early
> indicator if something is broken and we want to avoid spending the =
extra
> cycles of running the test suite twice for that.
>=20
> Helped-by: Lars Schneider <larsxschneider@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> ci/run-linux32-build.sh | 1 +
> ci/run-tests.sh         | 4 ++++
> 2 files changed, 5 insertions(+)
>=20
> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> index e30fb2cddc..f173c9cf2a 100755
> --- a/ci/run-linux32-build.sh
> +++ b/ci/run-linux32-build.sh
> @@ -27,4 +27,5 @@ linux32 --32bit i386 su -m -l $CI_USER -c '
>     cd /usr/src/git &&
>     make --jobs=3D2 &&
>     make --quiet test
> +    GIT_TEST_SPLIT_INDEX=3DYesPlease make --quiet test
> '
> diff --git a/ci/run-tests.sh b/ci/run-tests.sh
> index f0c743de94..c7aee5b9ff 100755
> --- a/ci/run-tests.sh
> +++ b/ci/run-tests.sh
> @@ -8,3 +8,7 @@
> mkdir -p $HOME/travis-cache
> ln -s $HOME/travis-cache/.prove t/.prove
> make --quiet test
> +if test "$jobname" =3D "linux-gcc"
> +then
> +	GIT_TEST_SPLIT_INDEX=3DYesPlease make --quiet test
> +fi

For now I think that looks good. Maybe we could define additional test=20=

configurations with an environment variable. That could be an array =
variable
defined in the lib-travis.ci "case" statement:
=
https://github.com/git/git/blob/1229713f78cd2883798e95f33c19c81b523413fd/c=
i/lib-travisci.sh#L42-L65


- Lars=
