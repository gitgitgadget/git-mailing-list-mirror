Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF55ECAAD5
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiIAJn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiIAJnh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:43:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8043C27DF6
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662025411;
        bh=WILVkP3t4LF54DdF7XPQAQibO0R1XKzFfk/fbIBm8RU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QVUvRN4h42qL7jw+upxQTsf14gfkezS2zhzLCE/3K6GwIexArYXxU8aQL+yZ+Ex10
         somcB0zXhhsuWhts8ItoOzu6Xhpe4Kfl8S5GVv/c7JYeQHrTyTDmjsw6FV3RcIShOX
         XVBPKoZXg5HZJa1hgQUuxswmCHJ+OMmhmUbjfOrU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1p9I5k2d0h-00oWid; Thu, 01
 Sep 2022 11:43:31 +0200
Date:   Thu, 1 Sep 2022 11:43:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 7/8] t/perf: add 'GIT_PERF_USE_SCALAR' run option
In-Reply-To: <96e08a95265ea66839b439ce8abc50b34395aaa3.1661961746.git.gitgitgadget@gmail.com>
Message-ID: <60p9nos4-n576-qqq2-p8n9-969sro247141@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <96e08a95265ea66839b439ce8abc50b34395aaa3.1661961746.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+6gJHfMHAgaN1vkvmZo8Sf0RrjIhNKolRA/TZ335mkM0ve1+xlP
 AxzI57ZhQ8AV3xonnb7Wkpk9Q3LNoigFXTROCwtjQZGRW+QEzlTDP6ZQmTpbUKVlYS/stly
 ckT5W8oBTaTGI6TtD9WRw40ASfx9PnYs5o4Gf+cWhaqa5c2R5Dt+BdTd39KdU6vMDYfZpSg
 tre2VJHwsLopLUOA3DB0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eZff+XEQqgg=:bygLCQtZZCwM+bh5m5CZfz
 7kx7/w1nWZ6AP7kuo+w3kd+60plump7OYMWI2k+DcBiy9JKj+JJ8XUgg8UwZCTW2Jrye3T2Eg
 thPyb7seekZfRGjU3TpbER2mCp10FNYoOBk974SVCPu2y6SgUSfVhBdQY2iT2oiDKymMpYhIR
 68RyqsGm9+Ek/0T4hBB/it8YWMxV7sKLLNWLaChTUVZJGqhPro5rtmFXPxuorLDJ5Z+icCocn
 2DhjpTdFp2HHKH7xCUhr7C8a8Xzy+gyEpOg3xvcQIeLNiTSqt/U5QXJBWKpxTzOZmluwtf4V2
 LwdpW3Bta8XnASOtp4oXxlXzloOuuo6nGZMIWAQMRW1nj0OQ3QEeNAO+mbo2/wPnk2K5w9FZW
 LpOsJ4sSS2sR4kP4eBU/poBL3yjbqY7aSKwBFtqMdAwSn31vJvOSXCncNKcadI+o+l3SUqs7Y
 OurXjD8b2gv8HZ4TTqEiYqHJJNQSR8nD8OZe12kyqTE4yrw99dUxV9+proIUQDJyWxIgcTULR
 1w/VUvr4r1W9/j7bZD319D3ak1yFpKC6/MqfTBuvOM6TaRJDPOqU+ZLkfbtpK+OS+Be4yXq/t
 50ir5fnnr7oEsl84RoYtXfXAMIqeqNRNPQT1SSXw8oaxCWC21S06LX9uZG/185SyO1aVBLbuM
 q2gK3K5xofr6F3JSr54//2dB10PdLBHOq0HLNX32Qw7CktlA9vO+LzzedSwx+W7JeYVFxwXrh
 iGLdtG8bnYRbgA+qiWTjB1uQ1yhEseQ39BqKS18TxN66gQlXTanELU96qk76CjFYuBIgYh8R+
 k6hUvpYdVmAzRykD+C22QSVbHmmB6V3jNzRqlODF9MFLPGfpa0J85kAM1ajmpsOEbH54DHfzq
 ifu4x35FsuwQw0d1vWNNUR6xMXD8G0Nnz1GrSOpgEMq9KWS7efC19r6Uz18Hvl/ZpxICXsLlF
 0mGxSqmkOSmdzxQk42MXrgVk4G64JNJ9YExeOTN8EdICPlZEUI7q2CvtEbS3j4i5WfDwsk3QS
 gQY03xqBxD71jIYGyPtINCfDsOtntVxmQhR01cWjf5pCZxtHhj7CFSp+695wERKoZkry+CFHm
 ne1EvGxir85GvsE3H8XF4u5QtfmsAqvSKS8w8Z4VBhcoJjSw+0JLRTzcNUhsgan41ELyoH897
 GGr6vqMNKhESuuev1nCLVHWsU/
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Add a 'GIT_PERF_USE_SCALAR' environment variable (and corresponding perf
> config 'useScalar') to register a repository created with any of:
>
> * test_perf_fresh_repo
> * test_perf_default_repo
> * test_perf_large_repo
>
> as a Scalar enlistment. This is intended to allow a developer to test th=
e
> impact of Scalar on already-defined performance scenarios.

Great idea!

> [...]
> @@ -130,7 +137,11 @@ test_perf_fresh_repo () {
>  	"$MODERN_GIT" init -q "$repo" &&
>  	(
>  		cd "$repo" &&
> -		test_perf_do_repo_symlink_config_
> +		test_perf_do_repo_symlink_config_ &&
> +		if test_bool_env "$GIT_PERF_USE_SCALAR" false
> +		then
> +			"$MODERN_SCALAR" register

Do we need to unregister anything here? My guess is that no, the "global"
config we're using in tests is "$TRASH_DIRECTORY/.gitconfig", and the side
effect of scheduling the maintenance task won't matter in practice. But I
might have missed something and we may want to have an explicit
`unregister` step.

What's your take on this?

Ciao,
Dscho

> +		fi
>  	)
>  }
