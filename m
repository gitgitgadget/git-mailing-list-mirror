Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7451F576
	for <e@80x24.org>; Fri,  2 Feb 2018 11:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeBBLrQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 06:47:16 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45821 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBBLrO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 06:47:14 -0500
Received: by mail-qt0-f196.google.com with SMTP id x27so30460315qtm.12
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 03:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pH/4L8AVcsX6lc+ISIXkYKu9TYRYgo6WY7CVkRR+FVM=;
        b=aaKmKsQl4xICqZW1wzr6kqX6E+AWNLDPkxLkwKmUGKCdKT3ROOd9H8xzCYIFG3m/rt
         b7CNgsG0ZUgf0C7MjIyxUwy05cIKNvsSNgZhrLbhBVjSN4u1m8hFY9C7he+HPbDSKxkn
         nKnermbeVv3zzDjqmXhCXgnDdeGLWrjjl29bXcEOFg/nRh+7i3D1TzMZWo45qLuY63Rw
         gGPfTXG0wJOZ/HyfsbIabgHAT6oKcH4kmwbDuDjCMycM/5Va+gBhIkaY9apkWc/YJqDb
         poQSUASSMojl6V78Ybjg71ZACeUmljg7yklnUw71mpl+epmwL9uC+e4coeFmA6dDIJBd
         XvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pH/4L8AVcsX6lc+ISIXkYKu9TYRYgo6WY7CVkRR+FVM=;
        b=p/gSvhjUcZw4BCF3TsGcPEIzr+9kne/Jd1+8vVMxtwNaNV9GQycJuuoDE4uzHN/bvI
         TfezZujwzwY/9RMoOO8goeVLJz739ASMmMtkeewn0TG3v9h4JrqC92QxxmQaY8QGmr0j
         Sauc9KVp50wnDPetI28dfYlnjp6Q2C96dqf5cRWuV1BCpOx3WJ+RSlvQkmFVHpnF99aw
         cuGuJvNNaC+d9qz05pneQxCCydKRpQF8ulEIw+KNwrEfBgNXGWJpKWaqWSQMXPMT2KBC
         SyFMqy2SwKyJvP925MDRDbOZ2NJv61+n8P6z603s0JkSswOq0CwLiGlzdd8hzIwesy2K
         qnlg==
X-Gm-Message-State: AKwxytfy+VmYExgcX+o8enZC81J1oq7iP8jWD1D0eDWuGsvpf08icYXl
        mu3GYl7aHTmawH7mGham8N2ifhV+SOTW3vT1CD6Dbg==
X-Google-Smtp-Source: AH8x2268a2G20FIo5bd34+YPJWahQGn8Xejt1f+t56P5X9196hKgpi3PGH+xdqqAWyIrX8SRPu3uhYPa/SEXAtkL4EA=
X-Received: by 10.200.15.218 with SMTP id f26mr64549041qtk.237.1517572033584;
 Fri, 02 Feb 2018 03:47:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 03:47:13 -0800 (PST)
In-Reply-To: <20180124095357.19645-7-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-7-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 06:47:13 -0500
X-Google-Sender-Auth: AQqC-12ZFiDucAdQcx9l8rBWcWw
Message-ID: <CAPig+cQvVreeggOj52bVLS6R0ZCar_yfUcyLbN3-nLG81eOQaA@mail.gmail.com>
Subject: Re: [PATCH 6/7] worktree remove: new command
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 4:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This command allows to delete a worktree. Like 'move' you cannot
> remove the main worktree, or one with submodules inside [1].
> [...]
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -688,6 +689,132 @@ static int move_worktree(int ac, const char **av, c=
onst char *prefix)
> +static void check_clean_worktree(struct worktree *wt,
> +                                const char *original_path)
> +{
> +       [...]
> +       validate_no_submodules(wt);

It's slightly strange seeing worktree validation in a function
checking whether the worktree is clean since submodule validation
isn't an issue of cleanliness. I'd have expected the caller to invoke
it instead:

    int remove_worktree(...) {
        ...
        if (!force) {
            validate_no_submodules(wt);
            check_clean_worktree(wt, av[0]);
        }
        ...
    }

On the other hand, I could imagine it being called here as appropriate
if submodule validation eventually also checks submodule cleanliness
as hinted by the commit message.

> +       argv_array_pushf(&child_env, "%s=3D%s/.git",
> +                        GIT_DIR_ENVIRONMENT, wt->path);
> +       argv_array_pushf(&child_env, "%s=3D%s",
> +                        GIT_WORK_TREE_ENVIRONMENT, wt->path);
> +       memset(&cp, 0, sizeof(cp));
> +       argv_array_pushl(&cp.args, "status",
> +                        "--porcelain", "--ignore-submodules=3Dnone",
> +                        NULL);
> +       cp.env =3D child_env.argv;
> +       cp.git_cmd =3D 1;
> +       cp.dir =3D wt->path;
> +       cp.out =3D -1;
> +       ret =3D start_command(&cp);
> +       if (ret)
> +               die_errno(_("failed to run git-status on '%s'"),
> +                         original_path);

Minor: I think there was some effort recently to remove "git-foo"
style mentions from documentation and error messages. Perhaps this
could be "failed to run 'git status' on '%s'". Ditto below.

> +       ret =3D xread(cp.out, buf, sizeof(buf));
> +       if (ret)
> +               die(_("'%s' is dirty, use --force to delete it"),
> +                   original_path);
> +       close(cp.out);
> +       ret =3D finish_command(&cp);
> +       if (ret)
> +               die_errno(_("failed to run git-status on '%s', code %d"),
> +                         original_path, ret);
> +}
> +
> +static int delete_git_work_tree(struct worktree *wt)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       int ret =3D 0;
> +
> +       strbuf_addstr(&sb, wt->path);
> +       if (remove_dir_recursively(&sb, 0)) {
> +               error_errno(_("failed to delete '%s'"), sb.buf);
> +               ret =3D -1;
> +       }
> +       strbuf_release(&sb);
> +
> +       return ret;
> +}

Style nit: In the very similar delete_git_dir(), just below, there is
no blank line before 'return'.

> +
> +static int delete_git_dir(struct worktree *wt)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       int ret =3D 0;
> +
> +       strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
> +       if (remove_dir_recursively(&sb, 0)) {
> +               error_errno(_("failed to delete '%s'"), sb.buf);
> +               ret =3D -1;
> +       }
> +       strbuf_release(&sb);
> +       return ret;
> +}
> +
> +static int remove_worktree(int ac, const char **av, const char *prefix)
> +{
> +       [...]
> +       if (reason) {
> +               if (*reason)
> +                       die(_("cannot remove a locked working tree, lock =
reason: %s"),
> +                           reason);
> +               die(_("cannot remove a locked working tree"));
> +       }
> +       if (validate_worktree(wt, &errmsg))
> +               die(_("validation failed, cannot remove working tree:\n%s=
"),
> +                   errmsg.buf);

Minor: Same concern as in 3/7 about the multi-line error message
making scripted handling of error message collection more difficult.

> +       strbuf_release(&errmsg);
> +
> +       if (!force)
> +               check_clean_worktree(wt, av[0]);
> +
> +       ret |=3D delete_git_work_tree(wt);
> +       /*
> +        * continue on even if ret is non-zero, there's no going back
> +        * from here.
> +        */
> +       ret |=3D delete_git_dir(wt);
> +
> +       free_worktrees(worktrees);
> +       return ret;
> +}
> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> @@ -90,4 +90,30 @@ test_expect_success 'move main worktree' '
> +test_expect_success 'remove locked worktree' '
> +       git worktree lock destination &&
> +       test_must_fail git worktree remove destination &&
> +       git worktree unlock destination
> +'

Perhaps place 'unlock' in test_when_finished()[1].

> +test_expect_success 'remove worktree with dirty tracked file' '
> +       echo dirty >>destination/init.t &&
> +       test_must_fail git worktree remove destination
> +'
> +
> +test_expect_success 'remove worktree with untracked file' '
> +       git -C destination checkout init.t &&

Reversion of 'init.t' probably belongs in the preceding test which
modified it, wrapped in test_when_finished()[1].

> +       : >destination/untracked &&
> +       test_must_fail git worktree remove destination
> +'

[1]: https://public-inbox.org/git/CAPig+cSV9_6j6Nkptma3BewKW8QQcem7gwFCb42V=
BW4Xe0Vr2w@mail.gmail.com/
