Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC9ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 08:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiIAIvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiIAIvn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 04:51:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E43BA170
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662022277;
        bh=CElpDwaKG04Aiug/dD/WoLVOeMWxsEpSPfmTakIdV54=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jSjKcjyF53xsdm7y//h/SZyDbw4Msk5JDyaCoavVIZIDAdK8HDLzIF8kKySNCr0Lc
         B2WgEyuAwlxFqrXMOHPIN+dLmzGvhxAOBlY1LU4UeaJZuhw6mxdT1ki+wc9ARTF365
         mFdmR/DuC/xHg7Ex9SUwVHsr0rJ7g4mIl0vAsdXc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1oRBcA2Get-006OXy; Thu, 01
 Sep 2022 10:51:17 +0200
Date:   Thu, 1 Sep 2022 10:51:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johasc@microsoft.com>
Subject: Re: [PATCH 4/8] scalar: implement the `help` subcommand
In-Reply-To: <46d0fddfe8fbc2c568cb5a3d14594276db2bc1a9.1661961746.git.gitgitgadget@gmail.com>
Message-ID: <5q412o8n-60so-52qn-883q-s3spo168o7r9@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <46d0fddfe8fbc2c568cb5a3d14594276db2bc1a9.1661961746.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4rfpgzFXQr7ny/sKkisjdMm2fn1D0uwVda1uamO2uMnvb+GfhSy
 lEZAqje2wuoRDqnePK527xG1oYb+Xla1Hfbvs9FkhwqwqfKpfCDksUJUG4enBPVSFCqCT+2
 eCg7sE4mKqZhbZ4DVDjzz1BHUVdacNua5NqpkJDVCDJdtyYeWL173SpaYaDPWwLPGK4BM70
 iZBACTbzcO4e7Fzlaz6AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z4cA6XaWjjY=:EJ+4Oy95x50JnTNAhxJjwJ
 dxsh9XwzcR5TqJM8PkWfAFstRRa85jTf5vjje+2g47LPc5ThWqBnYYpSzNYHBYHO7uL7dBX0o
 BSJ0jrTdKdGNoI2pOEU3ZcZesEx889Md5xzewMuTvU6zKYubhckANp8ok5KcXxOA2ZGuBuhhX
 X9IApyWYMN4Tdj0tS4Dr0K7v2p/iCIpNpMcrQgRHXwfIKMSMdBli/e0bwb4hDEkLzrxkbgFqq
 SbRMXeuo9ypF4Ewq1bmEAXQ8AiZieC3h9k54yyrdfND/N2KZzxsGmlWAMTSW6iUf3eZ6NnaVW
 qYx6Rc4UHOV4BbEmLC/HQy+swvDMUF3mT9bQ6SxSlLjvDPZ6bUMo6Lwn2S4lZkLS9jWApoyni
 ewe+d2p2o1gB9U0ldO+0MwTMhiXMNc4YUwFToocXU88Ic2cDY1G7tFY4/Uq40/TNKZGt70drh
 QNlWZBp1FAM2nnED1JSAsbeiyQV62gNNYcXrS2sAUFb4YFhsjZUFtsn3xEn+KkntSa9wwzZa7
 fuZ+9VvyxotHIY/brBMBUM/wn+xQBmyZFk2gJlozcRntMtCpV/ws4jdaxv0nu6Ao3Ft1kESqC
 38bQd4bpneIq89BK4m5K7l28h/QCLCKgqKrnZPKuHWtXk/2WgOVCTCrga0/ncd6k1P9uBxvqU
 sPnbYnMYZuv6fdORk1BvXOZXAV+/wwBarYgV4vg3w2qnu1d8UMdFO+apLE9mIvJJyIgBmBqE8
 ywqIHmM1zJejXGK2yDTfMauksei+F/W2fIRzOEBBoSIc8+QBQtZfVBnGJE4YXX7J755HpJroU
 6NPAbv87QzofbJ91QPyKwnywoMhbDut7pN0zw1VTClg+0jNw6p39Ps0qfxakd/eJfgJUZie+P
 P6ODZcPRDofwh2NYO2IT54NA297G3xjtllg8xlH+A2cLv0DSb8o0bqRTjG/qiIw7yi+NYzqpn
 sxuoEW2mG+K36pJ9qHkC70pJyWOPAXug7uE/q6HbOhFIpjeBnQOizMGR0aPKj44bCmNMKZRck
 nvffdtuzX3Qez+kfWU1RQYsPfJZ066u8FkVKq16atTFcMrnyHLwqHT0YvMp2NQfmDQesg8Ww9
 Z5SOdY6Ors9F9B3LqoLMIPhLFoDgg5eU6dG65ZLS1mKP8LFIoO1PbMfFQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Wed, 31 Aug 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johasc@microsoft.com>

I probably left that in by mistake. Could I bother you to change this (and
the corresponding Signed-off-by: footer) to use my usual email address?

Thank you,
Dscho

>
> It is merely handing off to `git help scalar`.
>
> Signed-off-by: Johannes Schindelin <johasc@microsoft.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  scalar.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/scalar.c b/scalar.c
> index 642d16124eb..675d7a6b0a9 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -819,6 +819,25 @@ static int cmd_delete(int argc, const char **argv)
>  	return res;
>  }
>
> +static int cmd_help(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END(),
> +	};
> +	const char * const usage[] =3D {
> +		N_("scalar help"),
> +		NULL
> +	};
> +
> +	argc =3D parse_options(argc, argv, NULL, options,
> +			     usage, 0);
> +
> +	if (argc !=3D 0)
> +		usage_with_options(usage, options);
> +
> +	return run_git("help", "scalar", NULL);
> +}
> +
>  static int cmd_version(int argc, const char **argv)
>  {
>  	int verbose =3D 0, build_options =3D 0;
> @@ -858,6 +877,7 @@ static struct {
>  	{ "run", cmd_run },
>  	{ "reconfigure", cmd_reconfigure },
>  	{ "delete", cmd_delete },
> +	{ "help", cmd_help },
>  	{ "version", cmd_version },
>  	{ "diagnose", cmd_diagnose },
>  	{ NULL, NULL},
> --
> gitgitgadget
>
>
