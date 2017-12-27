Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35951F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdL0Sf5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:35:57 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:46171 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdL0Sf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:35:56 -0500
Received: by mail-wr0-f169.google.com with SMTP id g17so28185300wrd.13
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 10:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WuEUh1fTwbxgVBbAPY8hyG+OL9P1kSDKaJYAa/iSLkg=;
        b=CIn/lgCnqekVsTkKSCe3Z/JQbDexl2PsciMG44yYGSnEmTHaVFkPDCSXtH3/aC81V1
         2JOkRHLJZerzPihIQnH/49JBSwNo39eLHZYqWv63XdzbszyNoy0gdVtEFS9c7BPyrzTu
         YqVo30k+BqnQ0DlSmOqnevg5ORDSgtzIK1Y61H7jj8fm/NmSI+AzQET47f7zznFOeHgY
         1ywiZufk48HGvtPDPgOPC56wSQ61Hl2U/nrUtIHy2QRkELtDroseiGXMwb68nHNflxpH
         vRrugM1qxqE3+sx88R5aIxT8iR6/51gXNeRf/8QkOCaTg4R/DNWBtUSd6GzF4BF7s+CN
         qQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WuEUh1fTwbxgVBbAPY8hyG+OL9P1kSDKaJYAa/iSLkg=;
        b=JxYzzYtBTNrO5TSioBrvwmxph8zlEzdFmMe6kr1Dtnpx1GZzErbkZ9A/1TP7Rnaj2T
         twu+Ek0xU/1hJfrZL3QIslNvm+ejFK2ADlAtHAOBCYbwnJLHy5c5Pqj8J7VD/nqowz/5
         5ilysSDImZrTbtS35j6PTNropETKNwgs3TmbL5COMw2nbV45C5Qnvf2gBQ+mNLMC2s3k
         eDt29Fc5zVvywEtgpD9R7NmH8ryNi59POuySoqd5RJRQPB1HGsDCmX45HGLGVH6gGnaE
         u69g4Pv9wIzbMkGBR8ZA/8KYMMw+wC4EkSAT9vJ0IDUi8j/4SFunzv4pbfNewovBLw2w
         mL1A==
X-Gm-Message-State: AKGB3mIJxcoJK+/m4qT2B2FVOo5uumzXIrWm+heNfk06LgPpmQRru1hI
        Q6Cie5yn0QTVcwiMLPTXA+k=
X-Google-Smtp-Source: ACJfBou3Y3WXcd0ZU2AoWwA4p4lyomS9yONWiYQNb+e52ZLxDhWuinnBYDHJr8YYmTOLbuBvNNiCyw==
X-Received: by 10.223.199.70 with SMTP id b6mr17910366wrh.223.1514399755447;
        Wed, 27 Dec 2017 10:35:55 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5682.dip0.t-ipconnect.de. [93.219.86.130])
        by smtp.gmail.com with ESMTPSA id g84sm9831336wmf.26.2017.12.27.10.35.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 10:35:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/4] travis-ci: fine tune the use of 'set -x' in 'ci/*' scripts
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171227163603.13313-2-szeder.dev@gmail.com>
Date:   Wed, 27 Dec 2017 19:35:55 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <757B917B-1F47-487B-989B-C31BD6F43C61@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com> <20171227163603.13313-1-szeder.dev@gmail.com> <20171227163603.13313-2-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Dec 2017, at 17:36, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> The change in commit 4f2636667 (travis-ci: use 'set -x' in 'ci/*'
> scripts for extra tracing output, 2017-12-12) left a couple of rough
> edges:
>=20
>  - 'ci/run-linux32-build.sh' is executed in a Docker container and
>    therefore doesn't source 'ci/lib-travisci.sh', which would enable
>    tracing executed commands.  Enable 'set -x' in this script, too.
>=20
>  - 'ci/print-test-failures.sh' iterates over all the files containing
>    the exit codes of all the execued test scripts.  Since there are
s/execued/executed/

>    over 800 such files, the loop produces way too much noise with
>    tracing executed commands enabled, so disable 'set -x' for this
>    script.
>=20
>  - 'ci/run-windows-build.sh' busily waits in a loop for the result of
>    the Windows build, producing too much noise with tracing executed
>    commands enabled as well.  Disable 'set -x' for the duration of
>    that loop.
>=20
> igned-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> ci/lib-travisci.sh        | 4 +++-
> ci/print-test-failures.sh | 3 +++
> ci/run-linux32-build.sh   | 2 ++
> ci/run-windows-build.sh   | 5 +++++
> 4 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 331d3eb3a..348fe3c3c 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -22,7 +22,9 @@ skip_branch_tip_with_tag () {
> }
>=20
> # Set 'exit on error' for all CI scripts to let the caller know that
> -# something went wrong
> +# something went wrong.
> +# Set tracing executed commands, primarily setting environment =
variables
> +# and installing dependencies.

Maybe:

  # something went wrong. Enable tracing to ease debugging on TravisCI.

I would move the "primarily setting environment ..." either to the
top of the file or to the respective section below.


But this is a minor nit. The rest of the patch looks very good.

Thanks,
Lars
=20

> set -ex
>=20
> skip_branch_tip_with_tag
> diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> index 8c8973cbf..97cc05901 100755
> --- a/ci/print-test-failures.sh
> +++ b/ci/print-test-failures.sh
> @@ -5,6 +5,9 @@
>=20
> . ${0%/*}/lib-travisci.sh
>=20
> +# Tracing executed commands would produce too much noise in the loop =
below.
> +set +x
> +
> for TEST_EXIT in t/test-results/*.exit
> do
> 	if [ "$(cat "$TEST_EXIT")" !=3D "0" ]
> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> index e30fb2cdd..a8518eddf 100755
> --- a/ci/run-linux32-build.sh
> +++ b/ci/run-linux32-build.sh
> @@ -6,6 +6,8 @@
> #   run-linux32-build.sh [host-user-id]
> #
>=20
> +set -x
> +
> # Update packages to the latest available versions
> linux32 --32bit i386 sh -c '
>     apt update >/dev/null &&
> diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
> index 8757b3a97..86999268a 100755
> --- a/ci/run-windows-build.sh
> +++ b/ci/run-windows-build.sh
> @@ -69,6 +69,10 @@ esac
>=20
> echo "Visual Studio Team Services Build #${BUILD_ID}"
>=20
> +# Tracing execued commands would produce too much noise in the =
waiting
> +# loop below.
> +set +x
> +
> # Wait until build job finished
> STATUS=3D
> RESULT=3D
> @@ -90,6 +94,7 @@ done
> # Print log
> echo ""
> echo ""
> +set -x
> gfwci "action=3Dlog&buildId=3D$BUILD_ID" | cut -c 30-
>=20
> # Set exit code for TravisCI
> --=20
> 2.15.1.500.g54ea76cc4
>=20

