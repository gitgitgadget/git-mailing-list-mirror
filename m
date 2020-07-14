Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D44C433E1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 12:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8ED22447
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 12:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hx3OM/Qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGNMVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:21:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:37733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgGNMVd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 08:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594729291;
        bh=FdpFX7FHHZGfQdA2Yh/LFkzOm5qCsookldBhdzBp8mM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hx3OM/Qk3vAgamcWwc8iqiojheXxRD3dF2e0E2NnIcDaTZTBFP+KkfQQrXRyE6nVU
         lp2v5A7BLYO+BE9wu5UMKj0sTUEMQX9OJI5YyS5uBli/sY6p7/P5xxMj3FrP+deLLE
         TJ8Htkt8iV+ulzWAJJ4RFqqBI2rhko83rBvPP+TQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([89.1.215.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1jxomG1R2x-007WbP; Tue, 14
 Jul 2020 14:21:31 +0200
Date:   Tue, 14 Jul 2020 14:21:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: warn about un-enabled extensions
In-Reply-To: <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com> <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iqd5Ca5xkCIRjATsBdJytTjBMHmwmtApfeDk+L4hy3iYJzkep8y
 9/qhnaq6otRElD6Lbd3zmg2J4nxvpfCeXzF08A/LSdMi4PoUzI/GxeuGUz6damVhSuzwzEt
 2ZodfhX+GQl5OU+b3uXqt11Pa5Mo+h8dHhPcj99zi2K8j/X7HFJvhQUXuY5GbcjvTm8XsQ/
 2U2byotGgyxDInidbjwqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V9G1po1eMYw=:mBcta771QowzxF16J6UeuC
 fVp0g2zw9Rzd8jhGQoK7UwciI8nhBgka72GCWHFKNM+MADqe6ux0XDs7gFWfKl4rBMJhLv9Zd
 cd0aZTXpNZ8Yc11xYA43urqrSNk+WextAfXeRJxM+KcgJHtHw/pxgPqr1En6yGUnLCLuST2pX
 N6ZaQQWK622M9p28I3CfPAg1Z7HOEdQag9lEuLspQioWqzy824Hdw56koOSByx6OIJ1dHdlrL
 de/IbRJ8KCpAMx64nmY/uHXai2piRtLDxFoidQfinXtcPHKiwMs0jiljcFd2mY9qcVQPLc4OH
 1BIWJDhjeC+ZzaZIP7lr1o+53fYTaoAvqG+GkU5wMz68MburnByfM4zUqp5o9DceQrNb4e1PF
 SM3mlLaufJsQZxVvlfFLkZSmaggyY9f+7gL2NN9fOJ6D6h9uFMwAg01g7YuJp6N9H04MOOq3E
 Hr8pjTN01kSYMbTHmpic409lSPuKo2YBAI4T83cVYhq9RYsX/mMAkiMbbmFUzLQpw0YzavM2K
 Q/H2lKwOOTKOj1PxY9tJPvDxB0vBm6ELDQlCe06284kEtC6Kp55Hl78ykH10Vo4fpGUzCkiUa
 lREJ+5zFSd7vTQ8D9Of9Ov1X4nYtRkHo08Bebuzt73f8Ot9Zy22rGtG/o+goCKkR32TiHmU23
 wZWaUyrZa37DeWW4INvmrTSFeGRP6SMs6FvhmDEE14gUEFrj4HJR8DJqif6nW5iWWsr8XP2qj
 Gaj5sgd/66bJ036OCDicBZCH7Y6vlWjTFC6QEluqhu0HIH1I2xzkrwLN3e/FPcXrmX01nuO9y
 bLBneKi5UfUGNlexqWLz5G/efkCdYCvmsVeVnLcRM5DQBESE0WFtDG/IQ27yeax4pl5zk15At
 kNmQW+3PQZIiovBsThTFn/91l1Z7Glj9HGTXc0oTlLWnpKjbEaEos4swr+WYjFjRW7v9fKjQH
 GbGZfUJ/+JRwJLM1QJBQjxWAsNOEIzYCrANxFlIxJ9HYH4A2KDIFkGjvqtOgtPhNR1WioUJTs
 ZYuJse6lm8f06FCy1rzkzWYyFJRsdel2UKtZEissEOJU6avRtS6chjfe4uaLG5GpJAiqixBfM
 FS2HRTX/EYe52RlIeup2W7GBYxyyarCCeFrM49WeJEQsibXJM1Mlk2oseI67i6dOenPJbT9U/
 65Iwcdkqp2Hlt0TVPUVQrin+adTGWdlcBGEI1EJ0OL41geEUANZSvndU8Vy+autfsSKr9WuAZ
 iLvciCB0SdCDiBoK0bWzX82Neok1S3+29poqM/Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 13 Jul 2020, Derrick Stolee wrote:

> On 7/13/2020 5:55 PM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When any `extensions.*` setting is configured, we newly ignore it unle=
ss
> > `core.repositoryFormatVersion` is set to a positive value.
> >
> > This might be quite surprising, e.g. when calling `git config --worktr=
ee
> > [...]` elicits a warning that it requires
> > `extensions.worktreeConfig =3D true` when that setting _is_ configured
> > (but ignored because `core.repositoryFormatVersion` is unset).
> >
> > Let's warn about this situation specifically, especially because there
> > might be already setups out there that configured a sparse worktree
> > using Git v2.27.0 (which does set `extensions.worktreeConfig` but not
> > `core.repositoryFormatVersion`) and users might want to work in those
> > setups with Git v2.28.0, too.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     Warn when extensions.* is ignored
> >
> >     I did actually run into this today. One of my pipelines is configu=
red to
> >     clone a bare repository, then set up a sparse secondary worktree. =
This
> >     used to work, but all of a sudden, the git config --worktree
> >     core.sparseCheckout true call failed because I'm now using v2.28.0=
-rc0.
>
> I tried your situation with Junio's patch from earlier [1] [2].
>
> [1] https://lore.kernel.org/git/pull.674.git.1594668051847.gitgitgadget@=
gmail.com/
> [2] https://lore.kernel.org/git/xmqqpn8zmao1.fsf_-_@gitster.c.googlers.c=
om/
>
> The issue here is that Junio's silent fix for sparse-checkout doesn't
> work here for "git config --worktree". However, I think that Johannes
> is making the same over-compensating warning message pattern as I was.
> That is, this warning happens for all extensions that are enabled when
> core.repositoryFormatVersion is less than 1.
>
> To attempt to summarize Junio's opinion, we should keep our situation
> isolated to this worktree config extension. Your patch does agree with
> the others in that we don't revert the behavior of failing to set the
> config, but I think in this instance we can specify the warning more
> carefully.

Okay.

> If you don't mind, I was already going to squash Junio's commit into
> mine (almost completely replacing mine) but I could add a small
> commit on top that provides the following improvement to the error
> message:

I don't mind at all. I'd just like to know that v2.28.0 avoids confusing
users in the same was as v2.28.0-rc0 confused me.

Thanks,
Dscho

>
> diff --git a/builtin/config.c b/builtin/config.c
> index 5e39f618854..b5de7982a93 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -678,8 +678,9 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
>                 else if (worktrees[0] && worktrees[1])
>                         die(_("--worktree cannot be used with multiple "
>                               "working trees unless the config\n"
> -                             "extension worktreeConfig is enabled. "
> -                             "Please read \"CONFIGURATION FILE\"\n"
> +                             "extension worktreeConfig is enabled "
> +                             "and core.repositoryFormatVersion is at le=
ast\n"
> +                             "1. Please read \"CONFIGURATION FILE\""
>                               "section in \"git help worktree\" for deta=
ils"));
>                 else
>                         given_config_source.file =3D git_pathdup("config=
");
>
> Thanks,
> -Stolee
>
>
