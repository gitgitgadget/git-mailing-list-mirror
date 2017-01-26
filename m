Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281BA1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbdAZSMG (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:12:06 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:33185 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbdAZSME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:12:04 -0500
Received: by mail-it0-f52.google.com with SMTP id d9so4554894itc.0
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=06/EQytxbBIY4LLyG/uY41jTK42hoCSsEmLSySdCm7U=;
        b=FT/YNCdqDfFp/0fOzTYj3mOgmp22sizN9kLtuTp3+W81In8xUjS4V/Sg9qALRoWSC0
         h1QX5KwPop0hbjOd+HV2TzypMFxJrJDm/7k+n3dEEr1AJYkCQDWjh72T/BXti2H8FBkY
         sN4N83cADcUIXvqmixuztxBe21mHE893Qo+NvGb5lvf6J0d1JWIDrKQ3/aXCr88DW1od
         t1z2vd0o6FZ91K1+YkATWYTw7Bk6xKwha1yOE/GIIuzny5jIYG0m9d1Ut+7tupn+7pmp
         3+at8mbJqSetl9cvAZcpRfRDEC3fhIYAIGdORgFdA19RwBeQzzxVh5DgXldx1GCXg8ju
         HxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=06/EQytxbBIY4LLyG/uY41jTK42hoCSsEmLSySdCm7U=;
        b=RUcT5C2zoHCWqxLe1gW7D+gAkhwnh71Zz/zJgbpzzKYAA2vU8RH45ME9qMkOV5qfDt
         0psj4dYZ1lvL6pHeCroCf11y6AHCooOcUAVj5754VfVAoJenyHzgh1DI6TLYdbX+xFC7
         6LBhG5e0Njg/1AKo4bOY+uLmU2bX0fUU0AyQIDD7aKovAxHCrhtwWmzISZi11ZXx7VbI
         OGGf93Zwn5XqcL8B566QAXDKEkrJZAg5i8J52oUYfLIG/qmrJUiEpLoWCdQrornqkr14
         tjpFWwsVZ+6DBajsbQcKmh7HqHllg4PR/NBmLsoOADE7IJKCp3f1GBjaKFbxO1IjsSPr
         pNvg==
X-Gm-Message-State: AIkVDXJi8lERtIVU6PiiCdL7UP/ika1rvGPNBn0Qtbi6e2E/X6Bl8o/dVXlUnhoRqcCsffLT5aI4+cuMP+VToFJu
X-Received: by 10.36.169.12 with SMTP id r12mr3967495ite.69.1485453722763;
 Thu, 26 Jan 2017 10:02:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 26 Jan 2017 10:02:02 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701261708370.3469@virtualbox>
References: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de>
 <cover.1485446899.git.johannes.schindelin@gmx.de> <alpine.DEB.2.20.1701261708370.3469@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Jan 2017 10:02:02 -0800
Message-ID: <CAGZ79kYLFJYPQu5KSv3hG+_eavO9BHkxHjpVOEs63Nn6Hu1gTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] status: be prepared for not-yet-started
 interactive rebase
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 8:08 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Some developers might want to call `git status` in a working
> directory where they just started an interactive rebase, but the
> edit script is still opened in the editor.
>
> Let's show a meaningful message in such cases.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t7512-status-help.sh | 19 +++++++++++++++++++
>  wt-status.c            | 14 ++++++++++----
>  2 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 5c3db656df..458608cc1e 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -944,4 +944,23 @@ EOF
>         test_i18ncmp expected actual
>  '
>
> +test_expect_success 'status: handle not-yet-started rebase -i gracefully' '
> +       ONTO=$(git rev-parse --short HEAD^) &&
> +       COMMIT=$(git rev-parse --short HEAD) &&
> +       EDITOR="git status --untracked-files=no >actual" git rebase -i HEAD^ &&
> +       cat >expected <<EOF &&
> +On branch several_commits
> +No commands done.
> +Next command to do (1 remaining command):
> +   pick $COMMIT four_commit
> +  (use "git rebase --edit-todo" to view and edit)
> +You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
> +  (use "git commit --amend" to amend the current commit)
> +  (use "git rebase --continue" once you are satisfied with your changes)
> +
> +nothing to commit (use -u to show untracked files)
> +EOF
> +       test_i18ncmp expected actual
> +'
> +
>  test_done
> diff --git a/wt-status.c b/wt-status.c
> index a715e71906..4dff0b3e21 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1135,14 +1135,17 @@ static void abbrev_sha1_in_line(struct strbuf *line)
>         strbuf_list_free(split);
>  }
>
> -static void read_rebase_todolist(const char *fname, struct string_list *lines)
> +static int read_rebase_todolist(const char *fname, struct string_list *lines)
>  {
>         struct strbuf line = STRBUF_INIT;
>         FILE *f = fopen(git_path("%s", fname), "r");
>
> -       if (!f)
> +       if (!f) {
> +               if (errno == ENOENT)
> +                       return -1;
>                 die_errno("Could not open file %s for reading",
>                           git_path("%s", fname));

While at it, fix the translation with die_errno(_(..),..) ?
(The errno message is translated already by the system,
which make untranslated die_errno things awkward for the users.)

Otherwise the patch looks good to me
