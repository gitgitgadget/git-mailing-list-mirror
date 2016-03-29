From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] worktree: add: introduce --checkout option
Date: Tue, 29 Mar 2016 15:20:47 -0400
Message-ID: <CAPig+cRimDGFDk7A2p2rKpJ2GR27_R=BJdpyPK4xeyDU1TruWQ@mail.gmail.com>
References: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
	<01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ray Zhang <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:20:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzCA-0008K4-D5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbcC2TUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:20:49 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35875 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbcC2TUt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:20:49 -0400
Received: by mail-vk0-f68.google.com with SMTP id z68so3580005vkg.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Y/uxkUTgYU37sg7lkYaRle3cGVthvlfQymjqB7kknlI=;
        b=po1h3FpJdWtlX3vPFwZgWYhaGT/n7NKND/l6ep/VhKeCFoxOGxcHprAIEXKBH+F1Hf
         hhexr/R60B9+k3PBPtXRIJTUi22XCHjGdhjHBAUwk2VoL3RR/Zd6p8H1b34lLyKyScxh
         Mmj2NY1J4vB05P/QR3W6QaV7FXY5TUma2Z/e9wgAUVMFnPsjhASxCrCvpF0GWLrjUMG4
         GMqpVql5Pf92PeEgvri1XG+wgnaGG0IqqBfda7qowdto0NT7vNGevrZUKQkSU/Eq2uCF
         ADCnEzfmouEx4PbvzniAhBouSr517CV8Y/j3JdOajwhBPysf/q+ZkixmB4D6FnkZKJFZ
         eIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Y/uxkUTgYU37sg7lkYaRle3cGVthvlfQymjqB7kknlI=;
        b=Ngmkf7glGcu/EV+eaQ4px8Brh1stUkgo/1uea7gHPa4R+k5oMf6awvWYB86I66CuN+
         54If5KetQtxm8EXH5cRSnS4EVUWHvH0BUT8mok2b5JWc3GMN/7vex6G1QCldMBAZ44hh
         i8nnQ9I6YRZVR1q1IzXwQ0dZ7jzMAEEorFPy2heJ2FelQuXbi5IV19lvouXRtqgPy9l8
         zzT/8Hho2GpqFvM3BHDdWtZMnuTudKtcAj9BG+ePhxReMomhScMkn6a4Rg3w6hSJD52t
         u2afpuy/QFzrBOuFWT49ed/i9oeho/GmsFeGCZJnZW3GybH9Rt3nlJhEY3AvW+CwX++z
         bgow==
X-Gm-Message-State: AD7BkJJioU/QWuAhKcKatso66d5HG3Yfk/wHvEWtUc/mVpVvM7uhlN6/BTi7YLNeV4eW/xVdwORWoXS4/azikA==
X-Received: by 10.31.21.4 with SMTP id 4mr2469935vkv.151.1459279248037; Tue,
 29 Mar 2016 12:20:48 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 12:20:47 -0700 (PDT)
In-Reply-To: <01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: AdKWgxz2WUR65Evp1qejj6Lyw_Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290167>

On Tue, Mar 29, 2016 at 6:11 AM, Ray Zhang <zhanglei002@gmail.com> wrote:
> By adding this option which defaults to true, we can use the
> corresponding --no-checkout to make some customizations before
> the checkout, like sparse checkout, etc.
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
> ---
> Changes since last version of this patch[v4]:
>         t/t2025-worktree-add.sh: use test -e to test file existence.
>         builtin/worktree.c: refactor the code a little bit.

Thanks, this version is still:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

A couple comments below...

> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -284,18 +285,22 @@ static int add_worktree(const char *path, const char *refname,
>         if (ret)
>                 goto done;
>
> -       cp.argv = NULL;
> -       argv_array_clear(&cp.args);
> -       argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> -       cp.env = child_env.argv;
> -       ret = run_command(&cp);
> -       if (!ret) {
> -               is_junk = 0;
> -               free(junk_work_tree);
> -               free(junk_git_dir);
> -               junk_work_tree = NULL;
> -               junk_git_dir = NULL;
> +       if (opts->checkout) {
> +               cp.argv = NULL;
> +               argv_array_clear(&cp.args);
> +               argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +               cp.env = child_env.argv;
> +               ret = run_command(&cp);
> +               if (ret)
> +                       goto done;
>         }
> +
> +       is_junk = 0;
> +       free(junk_work_tree);
> +       free(junk_git_dir);
> +       junk_work_tree = NULL;
> +       junk_git_dir = NULL;

Doing the goto-dance and outdenting the "freeing" code as suggested as
a possible improvement by [1] probably should have been done as a
separate preparatory patch since the result in this patch is fairly
noisy and more difficult to review. However, it's probably not worth
the patch churn to do so now.

>  done:
>         strbuf_reset(&sb);
>         strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> +test_expect_success '"add" worktree with --no-checkout' '
> +       git worktree add --no-checkout -b swamp swamp &&
> +       ! test -e swamp/init.t &&

I realize that this was suggested by [2], however, a more modern way
to state this would be:

    test_path_is_missing swamp/init.t &&

but, as also mentioned in [2], it's probably not worth the patch churn
to change it now.

> +       git -C swamp reset --hard &&
> +       test_cmp init.t swamp/init.t
> +'
> +
> +test_expect_success '"add" worktree with --checkout' '
> +       git worktree add --checkout -b swmap2 swamp2 &&
> +       test_cmp init.t swamp2/init.t
> +'
> +
>  test_done

[1]: http://git.661346.n2.nabble.com/PATCH-add-option-n-no-checkout-to-git-worktree-add-tp7651385p7651884.html

[2]: http://article.gmane.org/gmane.comp.version-control.git/290050
