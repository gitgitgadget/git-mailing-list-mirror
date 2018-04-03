Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DFA61F404
	for <e@80x24.org>; Tue,  3 Apr 2018 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbeDCW01 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 18:26:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33252 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754200AbeDCW0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 18:26:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id z73so20174388wrb.0
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=thlgCcNttqP8tDmYysapF70Regn6PZRiffbm+5AAr7s=;
        b=rsGjnKc/R7MHmV50Cz6fu0z8Pa5qdih7UjyiaJmRF/e8qLeNW7Qi5aAIELng1eN1od
         g6CsOx5Rk7WCuavFa62LPmQna4wa7cCfJS2xQDbpAeumqpycTE0xBiU/5ZhdYbTpZy6e
         EPwP7Q4M9ajw+5l2OvMSoly1cwMhOQ+8tbvHAWtc8nfehppmNLXthxJeO3GCfgf1d+MZ
         IHteUR6uajZ9fpGSg4Y5DvUZe4oiyJ2WEswu1s7US2t/wBIdeU3VK/NjwnzFH7nEoNdZ
         Ov3sq+Z5M8yWMWCPAazG3xvNZml5CPr41umzs02l1hRECJDnczfuuL8uvz2NUiiWWrlp
         YqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=thlgCcNttqP8tDmYysapF70Regn6PZRiffbm+5AAr7s=;
        b=c1E9lsOi62hoXt+xvBXtG/prIvNZMjiCRkt5eVHhLZTvpSD6URGOXCz/e5f3+X1TTa
         cVwgEg2MPo4vncN9rk47L488ji+74JFFJpDll+PqjxTRAWVyIXH7UNhbKa2q0H16FBDL
         Kv08dAyGytOBLEXPG9G5v/rSYx1G/eMLgK9xeBVabhKtQ9u7Mj6G958XOMxESjgdeDqL
         QMPI/I3uJGKoSE4WJmtSeTM2O12+LcRX0647YtS1heiMH5OGPymD6xt8j2q9xIZV4snd
         wpa18vgK62g4DC9ihyqLJ38o5X4nCrWMkMuUHGXgjSv58ExGtdwlgWM7IxhjvFe1WjWN
         c0lA==
X-Gm-Message-State: AElRT7Gc28nRX/c22Z2L2K2bbqqcnrd440dz0ZkWQLUw08z9Syulran6
        vHhj/j7OkawTE7vXfiERXo80GuGoKAD6iafc1YtUHboE
X-Google-Smtp-Source: AIpwx4/3efNG/pZ2DIwIZ60w1z7bBYjbFmFifalR6nfoY0QlxkOMs5SIJu+uA39H2coMjky70NkYY+5/P2BIbAbau9c=
X-Received: by 10.223.219.144 with SMTP id u16mr10954511wri.13.1522794379952;
 Tue, 03 Apr 2018 15:26:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.208.210 with HTTP; Tue, 3 Apr 2018 15:26:19 -0700 (PDT)
In-Reply-To: <20180403222053.23132-2-eddy.petrisor@codeaurora.org>
References: <CAK0XTWdpKnMbXs5sq2qsERxQO20sQW6YwL=2kfBHmSwHMmunBg@mail.gmail.com>
 <20180403222053.23132-1-eddy.petrisor@codeaurora.org> <20180403222053.23132-2-eddy.petrisor@codeaurora.org>
From:   =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Date:   Wed, 4 Apr 2018 01:26:19 +0300
Message-ID: <CAK0XTWf=ubDK-4=FknLSFObZrShg=7UDgR5c6iNSjrwiDngayA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] t7406: add test for non-default branch in submodule
To:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Notes:
    I am aware this test is not probably the best one and maybe I
should have first one test that does a one level non-default, before
trying a test with 2 levels of submodules, but I wanted to express the
goal of the patch.

    Currently the test fails, so I am obviously missing something.
Help would be appreciated.


2018-04-04 1:20 GMT+03:00 Eddy Petri=C8=99or <eddy.petrisor@codeaurora.org>=
:
> From: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
>
> If a submodule uses a non-default branch and the branch info is versioned=
, on
> submodule update --recursive --init the correct branch should be checked =
out.
>
> Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
> ---
>  t/t7406-submodule-update.sh | 54 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 6f083c4d6..7b65f1dd1 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -259,6 +259,60 @@ test_expect_success 'submodule update --remote shoul=
d fetch upstream changes wit
>         )
>  '
>
> +test_expect_success 'submodule update --remote --recursive --init should=
 fetch module branch from .gitmodules' '
> +       git clone . super5 &&
> +       git clone super5 submodl2b2 &&
> +       git clone super5 submodl1b1 &&
> +       cd submodl2b2 &&
> +       echo linel2b2 > l2b2 &&
> +       git checkout -b b2 &&
> +       git add l2b2 &&
> +       test_tick &&
> +       git commit -m "commit on b2 branch in l2" &&
> +       git rev-parse --verify HEAD >../expectl2 &&
> +       git checkout master &&
> +       cd ../submodl1b1 &&
> +       git checkout -b b1 &&
> +       echo linel1b1 > l1b1 &&
> +       git add l1b1 &&
> +       test_tick &&
> +       git commit -m "commit on b1 branch in l1" &&
> +       git submodule add ../submodl2b2 submodl2b2 &&
> +       git config -f .gitmodules submodule."submodl2b2".branch b2 &&
> +       git add .gitmodules &&
> +       test_tick &&
> +       git commit -m "add l2 module with branch b2 in l1 module in branc=
h b1" &&
> +       git submodule init submodl2b2 &&
> +       git rev-parse --verify HEAD >../expectl1 &&
> +       git checkout master &&
> +       cd ../super5 &&
> +       echo super_with_2_chained_modules > super5 &&
> +       git add super5 &&
> +       test_tick &&
> +       git commit -m "commit on default branch in super5" &&
> +       git submodule add ../submodl1b1 submodl1b1 &&
> +       git config -f .gitmodules submodule."submodl1b1".branch b1 &&
> +       git add .gitmodules &&
> +       test_tick &&
> +       git commit -m "add l1 module with branch b1 in super5" &&
> +       git submodule init submodl1b1 &&
> +       git clone super5 super &&
> +       (
> +               cd super &&
> +               git submodule update --recursive --init
> +       ) &&
> +       (
> +               cd submodl1b1 &&
> +               git rev-parse --verify HEAD >../../actuall1 &&
> +               test_cmp ../../expectl1 ../../actuall1
> +       ) &&
> +       (
> +               cd submodl2b2 &&
> +               git rev-parse --verify HEAD >../../../actuall2 &&
> +               test_cmp ../../../expectl2 ../../../actuall2
> +       )
> +'
> +
>  test_expect_success 'local config should override .gitmodules branch' '
>         (cd submodule &&
>          git checkout test-branch &&
> --
> 2.16.2
>



--=20
Eddy Petri=C8=99or
