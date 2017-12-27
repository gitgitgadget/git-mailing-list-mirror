Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1421F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbdL0SwU (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:52:20 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38480 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdL0SwT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:52:19 -0500
Received: by mail-wm0-f43.google.com with SMTP id 64so40553925wme.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 10:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IR600vLxL2rv4TeytOuGeYAX72HDaOpbSYwBdoDTfeU=;
        b=rvVAOEYpifGOBBL5wAqY2VNujOcd7q3erR3K1rBVbo39ZYH1L7MquKkmHf6fbO2ApE
         kJFiAJHcaWsHJa53eV4AQh+V25+vBdvmVNeemx8e08Rj6iHbIx3qGP6aQl34/1W5JwOf
         0kMHw7Ld9GryFLcw5S8EczRuZ+0b8HedSDOk+jP+//roKb2hBZ837EIOp5svv/21hLiw
         s26NSIbjE7TbpqqiOafEQOkU3zFAWLTWD1GOFgcVcHwvVOWIOX+PU1cdbgrdiKQuIb+v
         hOKkR8uLgrS/DgqW2baNBnUAaUYkZplguHrNKRqzKtPd4msS4BXflKL6GUssk1kjw2xm
         TD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IR600vLxL2rv4TeytOuGeYAX72HDaOpbSYwBdoDTfeU=;
        b=RmpIOd1nYkiAtB2V+phxoOHzemwHWUZ9XqLFjj1AgU6ajCz+clFAsCg/cNul9MoD+G
         /mLlj/Sm4vyG1WZ+q4uG9PfJ03XQI6Z7FaPb2PNk86lDGBlwEeIVlndN5rG3/ccfd4Kl
         VSCzBlKEDrHsQfxEjeD8EXTBEEM8evdRmPs26eNv1Sohe+3jhYDURc1YUhvRqNShQLnU
         vffyGsg55mZN/ups6Rf/GNRVOFc6Ot2yPC5AP7GPNBfEOgx+E2qZIgrRRlNEVQVUOUzw
         kMPN3/Z3PZbOzAOGCtzagcbeYZe6apo+AvRJEC/QkryzQuXcHV119zgDzASEU/XDvZNt
         DhUA==
X-Gm-Message-State: AKGB3mKmOTDJHdPTqGQQ3JYexzCG7qoQkq9K65O/HFq+hQnjg2eifzDK
        /izhPcPCyPL3w3LtuFM3EyQ=
X-Google-Smtp-Source: ACJfBovO3yFi1elJP9CpxdVokZKGE4DBBaE0VXIa63IQemkBdxfAzNhFTkk6ym5FsKXxHCsQIIRH8g==
X-Received: by 10.28.152.85 with SMTP id a82mr15206872wme.16.1514400738381;
        Wed, 27 Dec 2017 10:52:18 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5682.dip0.t-ipconnect.de. [93.219.86.130])
        by smtp.gmail.com with ESMTPSA id a16sm40332631wrc.7.2017.12.27.10.52.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 10:52:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 4/4] travis-ci: only print test failures if there are test results available
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171227163603.13313-5-szeder.dev@gmail.com>
Date:   Wed, 27 Dec 2017 19:52:18 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <53B4EF08-4511-4668-B7F4-7BC593550E5F@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com> <20171227163603.13313-1-szeder.dev@gmail.com> <20171227163603.13313-5-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Dec 2017, at 17:36, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> When a build job running the test suite fails, our
> 'ci/print-test-failures.sh' script scans all 't/test-results/*.exit'
> files to find failed tests and prints their verbose output.  However,
> if a build job were to fail before it ever gets to run the test suite,
> then there will be no files to match the above pattern and the shell
> will take the pattern literally, resulting in errors like this in the
> trace log:
>=20
>  cat: t/test-results/*.exit: No such file or directory
>  =
------------------------------------------------------------------------
>  t/test-results/*.out...
>  =
------------------------------------------------------------------------
>  cat: t/test-results/*.out: No such file or directory
>=20
> Check upfront and proceed only if there are any such files present.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> ci/print-test-failures.sh | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> index 97cc05901..4f261ddc0 100755
> --- a/ci/print-test-failures.sh
> +++ b/ci/print-test-failures.sh
> @@ -8,6 +8,12 @@
> # Tracing executed commands would produce too much noise in the loop =
below.
> set +x
>=20
> +if ! ls t/test-results/*.exit >/dev/null 2>/dev/null
> +then
> +	echo "Build job failed before the tests could have been run"
> +	exit
> +fi
> +

Look good to me!

Minor nit: I am not 100% sure about the grammar but I am no native =
speaker
and can't really tell.


Thanks,
Lars



> for TEST_EXIT in t/test-results/*.exit
> do
> 	if [ "$(cat "$TEST_EXIT")" !=3D "0" ]
> --=20
> 2.15.1.500.g54ea76cc4
>=20

