Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118032047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbdHASYf (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:24:35 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35099 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdHASYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:24:34 -0400
Received: by mail-lf0-f49.google.com with SMTP id t128so10576575lff.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ybBhaPOTvsn32aC3kSyWRmEuRaNiNmzq29zMJWhnIDM=;
        b=VlmHRTrHoVBBdy8WquWZ1/Yy5Gyi/ZkU5C+GcO+EU95orLY4YtXNAVATGSC/4VhiHs
         PkGJVs7MaADc8B3zs6cB6c1YFXJ8Z91Z8Avk28gqtA8/ImZVGVmEdmzABSRwJBIMDfnk
         seyf8Z4ckwZVORTnS18jTgG/2e817Hd6BzhI3VC3xx+YoNt9t73iMjK/6BIUsx5Y4avA
         nwHs7HGZ0H+49gaf2U0ITn070k8tm/abwdTA6jlIoJMjg7YAn8F8INGm4MctA9aXBjRx
         7nCz1FzbaeXGlMFOvHadK4X27fGU4+SaWklkq64UO9pECGiLEoqawH6cYJ0u52Yzi/IQ
         KHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ybBhaPOTvsn32aC3kSyWRmEuRaNiNmzq29zMJWhnIDM=;
        b=o+Hcdl97lGfC/TIRZZkbT7ezG3jyiITcmJEZUQXdyQvIKjcl/5Dk0x6A7McsNtqCdU
         IM5ojPTu565PmGCAdZ5pjGrTfW9lfYb9b6zmdDlLe3g5s1cLmDlpe2L7tGwh2XvnDv0Y
         tQeYZKhTEhqf1qUGLRj49zLnHh4HxIqU9ZDFR+fFSGNa19T0AB/52YZK76qfJjPZX/7S
         Vw56VAazCFNet40QcNCyi7Oew562/ZOn1XSMs3ce8+fFzr7pd/V0oTywT7FmkWJS1opA
         SpTE7sW5MaDepfrD3cVPwydFTGZUkVWhYruNIGzunA7cQ73irBlxPFbS3wVn1tgmckPK
         q25A==
X-Gm-Message-State: AIVw111nIiYJ2Lw3eE7hO5QXFkUUQztfzv/M5CgnGYaoUxLYAGAsLvBs
        nzXQH7iNi46/l/yv1WWz28le+KOCMw==
X-Received: by 10.46.9.202 with SMTP id 193mr8090707ljj.137.1501611872775;
 Tue, 01 Aug 2017 11:24:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.0.131 with HTTP; Tue, 1 Aug 2017 11:24:32 -0700 (PDT)
In-Reply-To: <20160625075433.4608-11-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com> <20160625075433.4608-11-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 Aug 2017 14:24:32 -0400
X-Google-Sender-Auth: UTOUZz0RXpricdUr9ZvJSvNkiW4
Message-ID: <CAPig+cSV9_6j6Nkptma3BewKW8QQcem7gwFCb42VBW4Xe0Vr2w@mail.gmail.com>
Subject: Re: [PATCH 10/10] worktree: add "remove" command
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 25, 2016 at 3:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -600,6 +601,81 @@ static int move_worktree(int ac, const char **av, co=
nst char *prefix)
> +static int remove_worktree(int ac, const char **av, const char *prefix)
> +{
> +       worktrees =3D get_worktrees();
> +       wt =3D find_worktree(worktrees, prefix, av[0]);
> +       if (!wt)
> +               die(_("'%s' is not a working directory"), av[0]);
> +       if (is_main_worktree(wt))
> +               die(_("'%s' is a main working directory"), av[0]);
> +       if ((reason =3D is_worktree_locked(wt))) {
> +               if (*reason)
> +                       die(_("already locked, reason: %s"), reason);
> +               die(_("already locked, no reason"));

"already locked" makes sense for 'worktree lock' command, but not
here. A simple "locked" would be clearer.

> +       }
> +       if (validate_worktree(wt, 0))
> +               return -1;

Leaking 'worktrees'. free_worktrees(...) recommended.

> +       strbuf_addstr(&sb, wt->path);
> +       if (remove_dir_recursively(&sb, 0)) {
> +               error_errno(_("failed to delete '%s'"), sb.buf);
> +               ret =3D -1;
> +       }
> +       strbuf_reset(&sb);
> +       strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
> +       if (remove_dir_recursively(&sb, 0)) {
> +               error_errno(_("failed to delete '%s'"), sb.buf);
> +               ret =3D -1;
> +       }
> +       strbuf_release(&sb);
> +       free_worktrees(worktrees);
> +       return ret;
> +}
> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> @@ -89,4 +89,30 @@ test_expect_success 'move main worktree' '
> +test_expect_success 'remove locked worktree' '
> +       git worktree lock destination &&
> +       test_must_fail git worktree remove destination &&
> +       git worktree unlock destination
> +'

'unlock' within test_when_finished(), perhaps?

> +test_expect_success 'remove worktree with dirty tracked file' '
> +       echo dirty >>destination/init.t &&
> +       test_must_fail git worktree remove destination
> +'
> +
> +test_expect_success 'remove worktree with untracked file' '
> +       git -C destination checkout init.t &&

Perhaps this reversion of 'init.t' belongs in the preceding test which
modified it (wrapped in test_when_finished())?

> +       : >destination/untracked &&
> +       test_must_fail git worktree remove destination
> +'
> +
> +test_expect_success 'force remove worktree with untracked file' '
> +       git worktree remove --force destination &&
> +       test_path_is_missing destination
> +'
