Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18116C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBE120809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="e9bJ5DMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbgKJPI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:08:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:53737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbgKJPI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 10:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605020898;
        bh=29Ovomsj8VlFzjC0mTNgYIqOuC9lfy2VN+8c6+f5YYY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e9bJ5DMux+ydM26gc/IryjcXlGJEw69/1afyUww5ky2HQMbRRSWh9T2kj7GIY/Kk+
         czynjsaeQgzKXM4UWUoI4qHBczcCAHM/PYmpwie6wr5F4BYI/8MEu7r5Oa0nHF9FIu
         Xb+tFkY+jKw5NFmtR+yxhWcP7ncuZUGncezrt+8c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1k7rP91xi5-00e1xM; Tue, 10
 Nov 2020 16:08:18 +0100
Date:   Tue, 10 Nov 2020 16:08:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Peter Kaestle <peter.kaestle@nokia.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC 2/2] Revert "submodule.c: fetch in submodules git directory
 instead of in worktree"
In-Reply-To: <1604910829-49109-3-git-send-email-peter.kaestle@nokia.com>
Message-ID: <nycvar.QRO.7.76.6.2011101607250.18437@tvgsbejvaqbjf.bet>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com> <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com> <1604910829-49109-3-git-send-email-peter.kaestle@nokia.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2UIaVc7hPrLm1OoaLKJWlLtgvTuRZoU1c5FT6ZNghM4iJ31Kkhh
 rYUvwrO0wSD2Gl3xKlvkRBgPQDnHRiTF/0O57MenAoyU+1p+WU2lYd8VQ/lPtrbKDTnEC7l
 RGfsY2sRZYNuI+WXBGHvTMXa14d+Owxs1JhCaQDu0yuRXWZ0w/mYdOzkUdZBjNad52J3Wfs
 31O5HWDZdqpDbTrk151Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hOLU6kbjdkw=:+J9YuScYIgklQYsJx0nngx
 nmLNV/E41C7kFO4pMC1LDq+UDY9dOeRodTw9/EKxrZzJr/z4WsJ07T+2NbpGOIIXgcPUGTtCd
 ChgaUjEWoi7OnmJ5moSN6+2QwP2UEwwKWTMINtMLoPeid/Nvts1V/BqSHNYPofXR3nGLQ/0tm
 d71eBaJbqgiKBL+rHaOvMMdcBc1m0u8Mvnp9S2VSVX3IvX5TAOUniDYE7OnRm+eL4Of11djvt
 QBGFHJ3oFLyrbFf3pBN5Fr/Jlye8m2U8xxtVxIAA1RuEClU9FAt0/06pyc3/VIUSfKsl+F3iV
 yLQMQapZUBHAxQDG6CIT93k44wqb6mTSE1jYrsKa0V7D0usOCEXUGDU/XiEn1PJkuNT7zodga
 OyqX9Vpr67XP9UXtR9teTe3G+n56LBE/Ge2R9JGuC2UkMdIPpvXVr10jnbWLLGjAn/fa7OC93
 d8LSB/j228qdNjZAMAjNKxgZvSOMUIfdvovDboZStNy5ELQc5XxsuTnH5rulPDmBHFllgY0Q3
 NfCk35XrRpZo7WSnbmQ1Bxn/zmiddJEM9UvxQZkny/5ALGo+Hi6iRFpDc5bQ2a4YoaSkFFxad
 0PIm+MFwK1PaSNqGrr4oHZwBFbOhFH0WcXO1lwZHxrx/hM3U5KZcikF7pa4U3/4qCHQNoge4T
 qQndMtBlvhZtMhJXK8BIQ5vz3fwRpXqyysqn6Vh1k3yX17eh22kHHSkWbSGgmTGu9al2vAIqh
 IS/GPpnzPl1B5Ybb1wYma+QKxAT72VwtNnv1e9dX7mLEKMrEQMFHlQ9/JEhi78mSV1tOt8f62
 yNc8pw7+9ho7W74fMPxkJuCGsuE3x5NrIloaOz4LqS1ckimgNP4UO0TQX2WojS/4tSyvAJ/Mg
 In8C1QOY+qC3ck7Oa9eFoKxen4F5S3V1nXoykROig=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

On Mon, 9 Nov 2020, Peter Kaestle wrote:

> This reverts commit a62387b3fc9f5aeeb04a2db278121d33a9caafa7 and sets
> the "fetching a superproject containing an uninitialized sub/sub
> project" testcase to expect success.

Just like the cover letter, this commit message might be technically
correct, but leaves me (and probably every future reader) wondering _why_
you would want this change.

Maybe this can be improved?

Ciao,
Dscho

>
> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
> ---
>  submodule.c                 | 14 ++++----------
>  t/t5526-fetch-submodules.sh |  2 +-
>  2 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index b3bb59f..eef5204e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -499,12 +499,6 @@ void prepare_submodule_repo_env(struct strvec *out)
>  		     DEFAULT_GIT_DIR_ENVIRONMENT);
>  }
>
> -static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
> -{
> -	prepare_submodule_repo_env_no_git_dir(out);
> -	strvec_pushf(out, "%s=3D.", GIT_DIR_ENVIRONMENT);
> -}
> -
>  /*
>   * Initialize a repository struct for a submodule based on the provided=
 'path'.
>   *
> @@ -1455,8 +1449,8 @@ static int get_next_submodule(struct child_process=
 *cp,
>  		if (task->repo) {
>  			struct strbuf submodule_prefix =3D STRBUF_INIT;
>  			child_process_init(cp);
> -			cp->dir =3D task->repo->gitdir;
> -			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> +			cp->dir =3D task->repo->worktree;
> +			prepare_submodule_repo_env(&cp->env_array);
>  			cp->git_cmd =3D 1;
>  			if (!spf->quiet)
>  				strbuf_addf(err, _("Fetching submodule %s%s\n"),
> @@ -1505,9 +1499,9 @@ static int get_next_submodule(struct child_process=
 *cp,
>  			    spf->prefix, task->sub->path);
>
>  		child_process_init(cp);
> -		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> +		prepare_submodule_repo_env(&cp->env_array);
>  		cp->git_cmd =3D 1;
> -		cp->dir =3D task->repo->gitdir;
> +		cp->dir =3D task->repo->worktree;
>
>  		strvec_init(&cp->args);
>  		strvec_pushv(&cp->args, spf->args.v);
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 9fbd481..236e26a 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -729,7 +729,7 @@ add_commit_push()
>  	git -C "$dir" push
>  }
>
> -test_expect_failure 'fetching a superproject containing an uninitialize=
d sub/sub project' '
> +test_expect_success 'fetching a superproject containing an uninitialize=
d sub/sub project' '
>  	# does not depend on any previous test setups
>
>  	for repo in outer middle inner
> --
> 2.6.2
>
>
