Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F47C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1D361205
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbhKIQTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:19:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:42533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239499AbhKIQTe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 11:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636474598;
        bh=K8FJpsg4VMCi7uSd7ojAGtLx6m0s+5Qf5wII/YBqIso=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gNQ6j9I96Z/skf0sYqolUjz+fdIXly8QZJLchrdx6FgTvWsC9oqnqmC+WYZuNYqPY
         BoKAu3JJ+/Fpdfapein4MJHABNNJdLsW4+nOMtRb4m4roO/gX4MxjPT8L7tWfViLHr
         Nx87szxpZ9fbm7pLDT6XqKfVH1hy+yUTRzNOSwdw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.201.164] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzyya-1mXjm41CFC-00wzHE; Tue, 09
 Nov 2021 17:16:38 +0100
Date:   Tue, 9 Nov 2021 17:16:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anders Kaseorg <andersk@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v4 2/4] receive-pack: Clean dead code from
 update_worktree()
In-Reply-To: <20211109030028.2196416-2-andersk@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2111091711450.54@tvgsbejvaqbjf.bet>
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu> <20211109030028.2196416-1-andersk@mit.edu> <20211109030028.2196416-2-andersk@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1553000182-1636474598=:54"
X-Provags-ID: V03:K1:IpN0KpNJTYOJseDKeh7z37TDgMSSXjECb+XvE1zl05zH18jDr2E
 7pQj+4wkytqZ8AdHTOPkbXB2NmH47vU+44x00Jwy4roQ3rQS9l6MFUNznKogar5fBpU8zib
 asg61ug7JC4X4hdX6Rxbgf5PmKsf3JdFYKXuLJtsoMXv9IdB+JrO+llsfM6ykaThlYpUpFK
 D2guQCSgpakHI8jB2tQXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:92qf7FvSKfw=:FQ26LPhq1+kqcZai6ej6m6
 55fmv5jxd1WkSqc+4p1jOF0iwQIkYcO2yv0kNTvCIrg+7GTeFRUSH3mx99RBi4e+DNohHUHMo
 5JRU98NFMeWK/Udo/AACCKYSbOhbeuzTQLU9If6+Dn8EjeAn78AbZwZU/6YG/i/kY5hCY3NXL
 iHTlP4IQxKBJPhO4R15AXhzD+nxuWy9h+qTLH467yT6DHeF97l8KTRfBMqdFOezRPafH2qzJ0
 x/0XMFIaW13jSXj/pjOVCIZ5Nk7bQIVSSEEIb0fN5zyw60++r0YQX5eYa8yHGOeemDTOYXNlS
 VfJdl/VwKEAPIedMGu/VQE50MJxpz7zmM1XG6VIXKigSw/l7Fy9oE5LnX9Tf808L/VgZlFVTS
 V1UT7QAZkrWLAusWMPW28wTxEfpxdUtUpHw59Gd8RIofhpa1ir0YgalnY2I7MFzODiDhzA+yx
 cdIAVpPW6PKyl/ljyxb49p1BHMscjIdCXC3gQRdPbxF5ln8D3mmzmLHXjaXScgExkmNaF6TFA
 2EK/HQd3AtA8KT3X318v/RABSrJVZnKt8yFburcbSTVpLtyuJzKAHZ+UM77ZQdFpxIbh2j0KK
 eZk8298cISTkgtxTD8C779wyw5eMyH3qcXUpISOflAGwhsI1zZy7rn4vhXfOTDeyTa6OKC0LD
 S449wAjI5XZVsKT7ccmBMgmmy9R5eCk2j/le0u1SkTNE/gc3Oqn1+yxpThxhy0D7yzvVsZRcE
 J+Q48+2AX8mlF1J6vNvsTIBRQA1cQD9tzhWBRxbiskd5lXyKQwiQXGcS73yTwTPFrawmhFPMj
 qnbZP5MpZ6u9G//nauOMaLp77b9UrbjffK3KcFdVR2Z3ynpyFO3UJSLSmOqy88T9LJcp6PhXv
 rP7jgCiHRBlILit1vGzmukx2L79uoE3TDVhTfqMjOHI79r4atUt7cr8SsufO1PvnO9y0+G6Od
 r6nmcVYBXmgDuW3rJfvZ+X5tv+JijQf4RwEfWK88C9KXYgA1eoKq0+4DtcK3zyMUWJT5vDjuY
 EIlg+AHbFkBPyMBRYB1vll8vm+eTaJSaBzAujX8je6QmMxUZWR4pC4SgNpcC0XuWftjuOTz7s
 5EQE1aGhNfwplE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1553000182-1636474598=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Anders,

looks good, just one suggestion, see inlined.

On Mon, 8 Nov 2021, Anders Kaseorg wrote:

> update_worktree() can only be called with a non-NULL worktree parameter,
> because that=E2=80=99s the only case where we set do_update_worktree =3D=
 1.
> worktree->path is always initialized to non-NULL.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  builtin/receive-pack.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 49b846d960..cf575280fc 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1449,29 +1449,19 @@ static const char *push_to_checkout(unsigned cha=
r *hash,
>
>  static const char *update_worktree(unsigned char *sha1, const struct wo=
rktree *worktree)
>  {
> -	const char *retval, *work_tree, *git_dir =3D NULL;
> +	const char *retval, *git_dir;
>  	struct strvec env =3D STRVEC_INIT;
>
> -	if (worktree && worktree->path)
> -		work_tree =3D worktree->path;
> -	else if (git_work_tree_cfg)
> -		work_tree =3D git_work_tree_cfg;
> -	else
> -		work_tree =3D "..";

We might want to make sure that `worktree` and `worktree->path` are
non-`NULL`, and otherwise call a `BUG()`.

> -
>  	if (is_bare_repository())

Okay, I lied, I have two suggestions. Shouldn't this be turned into
`worktree->is_bare`?

Of course, `find_shared_symref()` will currently not return any worktree
with non-zero `is_bare`...

>  		return "denyCurrentBranch =3D updateInstead needs a worktree";
> -	if (worktree)
> -		git_dir =3D get_worktree_git_dir(worktree);
> -	if (!git_dir)
> -		git_dir =3D get_git_dir();
> +	git_dir =3D get_worktree_git_dir(worktree);
>
>  	strvec_pushf(&env, "GIT_DIR=3D%s", absolute_path(git_dir));
>
>  	if (!hook_exists(push_to_checkout_hook))
> -		retval =3D push_to_deploy(sha1, &env, work_tree);
> +		retval =3D push_to_deploy(sha1, &env, worktree->path);
>  	else
> -		retval =3D push_to_checkout(sha1, &env, work_tree);
> +		retval =3D push_to_checkout(sha1, &env, worktree->path);
>
>  	strvec_clear(&env);
>  	return retval;
> @@ -1579,7 +1569,7 @@ static const char *update(struct command *cmd, str=
uct shallow_info *si)
>  	}
>
>  	if (do_update_worktree) {
> -		ret =3D update_worktree(new_oid->hash, find_shared_symref("HEAD", nam=
e));
> +		ret =3D update_worktree(new_oid->hash, worktree);

Makes sense. If `worktree` is `NULL`, `do_update_worktree` won't ever be
set, and if `worktree` is not `NULL`, even before we remove that
`is_bare_repository()` ternary, it is set to `find_shared_symref("HEAD",
name)` (and `name` is not changed in the `update()` function).

Thanks,
Dscho

>  		if (ret)
>  			return ret;
>  	}
> --
> 2.33.1
>
>

--8323328-1553000182-1636474598=:54--
