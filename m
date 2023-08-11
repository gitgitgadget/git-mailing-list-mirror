Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE042C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjHKRnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjHKRnp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:43:45 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004810D
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:43:44 -0700 (PDT)
Date:   Fri, 11 Aug 2023 17:43:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1691775821; x=1692035021;
        bh=MhLWY8qGyH6m4oCUbU7tzNRpgM63LEQANBuSZKkoc4c=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CpnWxE7uRkpF4401EdJ8mQ2ZiXI9euTpvDLF/b5lx1ySGN2rE0Ue+sgAK6j3djLx/
         1wEbTa1xYJvXNWyZgzsYPbxIsBbNBcL6QVKr6kW5TLaKsVgR6RJFWq9PVAR1211HC4
         Ut5PngwmXGw0fvagKDjh4V9dSz6xinfdwyjx5NooUa5gjQuBCFJrz2ZWyuuEJBx9mJ
         9Ds4z6SLglpxv870l6Hlxbgt9s4tGpP/Dbh1Triodu7WGOFwMYoVTuDjfuM2QuiX6F
         XkUJVJLTmm9hE6jTkcaRsvZ9LKp5gZxZBJR1viZWCU1yaqD+U158dMVj2aS/NsXcYj
         7U9gKGsf99dsw==
To:     Teng Long <dyroneteng@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, phillip.wood123@gmail.com, rjusto@gmail.com,
        rsbecker@nexbridge.com, sunshine@sunshineco.com
Subject: Re: RESEND [PATCH v10 7/8] worktree add: extend DWIM to infer --orphan
Message-ID: <6gxybfz4vu5onk6m7aqg2xuvlyipyp4dywujgjverfbeliw7pc@u4f5czxfl26s>
In-Reply-To: <20230809064724.13032-1-tenglong.tl@alibaba-inc.com>
References: <20230517214711.12467-8-jacobabel@nullpo.dev> <20230809064724.13032-1-tenglong.tl@alibaba-inc.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/09 02:47PM, Teng Long wrote:
>=20
> > [...]
>=20
> s/overide/override?
>=20
>  builtin/worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 4cd01842..10db70b7 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -696,7 +696,7 @@ static int can_use_remote_refs(const struct add_opts =
*opts)
>                 return 1;
>         } else if (!opts->force && remote_get(NULL)) {
>                 die(_("No local or remote refs exist despite at least one=
 remote\n"
> -                     "present, stopping; use 'add -f' to overide or fetc=
h a remote first"));
> +                     "present, stopping; use 'add -f' to override or fet=
ch a remote first"));
>         }
>         return 0;
>  }
>=20
> ---
>=20
> I found it when working at l10n round of 2.42.0, maybe it's not late to f=
ix
> this typo=EF=BC=9A
>=20
> Thanks.

Ah yep. That's on me. I'll put together a patch of the above and send it
out, cc-ing you before the end of the day today.

