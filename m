From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] commit: add a commit.verbose config variable
Date: Thu, 10 Mar 2016 18:01:44 -0500
Message-ID: <CAPig+cT+dmD2Nxw7z+x0Q2z_aJQFMwRwnb=dn1uH-_Nt9tnk4Q@mail.gmail.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 00:01:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae9aY-0002ww-CU
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 00:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbcCJXBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 18:01:46 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34046 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444AbcCJXBp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 18:01:45 -0500
Received: by mail-vk0-f65.google.com with SMTP id e6so7818503vkh.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 15:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=7TLiYZmcBMSVWD5IjmZGeBfZkC3Agb41gYr1RJ4X9RI=;
        b=oK03jNxJF+p+t9E5JDiCgW+m0uAMPG/gc9w7TAfJmFalikSPltqNjzaO3YMGRE0nk5
         RNwke3h5yS7JgGxQbQsSiJ/okN1sCoIApb3txO4a9NNYonMgmuf2K0qTq/Y5VFaJfFJx
         psB/8okK+YQU1wFkI1OhGPWxUcHw9i4FjqErKMYWOY/AupyJPFhfJImq8mtOZN2BBnwm
         jkMbJIFf2i/47NPw5ONsQtlnBotdDd7UIoytBJZ1jZJ4mTozY8TYYGW/Ap5A/jmofoXq
         a5uHF31CYmgiPOKTDNY0VpYtsTmHjwGenDcvl0+Jx5pKbwllQ2DCyG11Bu1F62HKVE9V
         Z3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7TLiYZmcBMSVWD5IjmZGeBfZkC3Agb41gYr1RJ4X9RI=;
        b=Q9vPBd4ah/my9eCVoK0bAnZA8Uswnur/n5q3uXlFGsv0iaVWCBXNbNE3mlg3SMzSc8
         WHrNRHkxUpBE8wMGxSXbXideMQIxUJbJmvjIKphmhGueNudY5uSZbsHpft1TPGiEKLKF
         7V9TUfugOcv03Ue60YE9QZelQ9+fqenact3E3FtdusSRjxxWm3sMQNgMwPHk0mvvC1J/
         YgBmxvnad1Y1jhu5JBRZxUonVAcuI8BXyo3KH/4bFnKuoMbULUnc1pPnbgGNqJK7bI9j
         RxbHb4LnTaOqqUkkHXUnOdZSe/geIypPXooE6q5SBqMADti4QRELoAZVPMkbdZsyNtn6
         ogZQ==
X-Gm-Message-State: AD7BkJKXZISOvHhlfUKk39ZLU8KQlR4o22I62fkfCn4zGoCNtNZQMbQ+ZVFdHy2OoIiysYJvUvJgh8dhuCovWA==
X-Received: by 10.31.21.4 with SMTP id 4mr6306024vkv.151.1457650904359; Thu,
 10 Mar 2016 15:01:44 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 10 Mar 2016 15:01:44 -0800 (PST)
In-Reply-To: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: ePENhO985-KnjFGcNaJqC2RoYF4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288658>

On Thu, Mar 10, 2016 at 5:12 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Since many people always run the command with this option, it would be
> preferrable to specify it in the configuration file instead of passing
> the option with `git commit` again and again.

Perhaps drop the unsubstantiated "many people always" and just say:

    Add commit.verbose configuration variable as a convenience
    for those who always prefer --verbose.

or something.

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---

As a convenience to reviewers, please use this area below the "---"
line to provide links and explain what changed since the previous
round rather than doing so in a separate email.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> @@ -290,7 +290,8 @@ configuration variable documented in linkgit:git-config[1].
>         what changes the commit has.
>         Note that this diff output doesn't have its
>         lines prefixed with '#'. This diff will not be a part
> -       of the commit message.
> +       of the commit message. To activate this option permanently, the
> +       configuration variable `commit.verbose` can be set to true.

The "permanently" bit sounds scary. A more concise way to state this might be:

    See the `commit.verbose` configuration variable in
    linkgit:git-config[1].

which doesn't bother spelling out what the intelligent reader should
infer from the reference.

> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -1505,6 +1505,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>                 sign_commit = git_config_bool(k, v) ? "" : NULL;
>                 return 0;
>         }
> +       if (!strcmp(k, "commit.verbose")){

Style: space before {

> +               verbose = git_config_bool(k, v);
> +               return 0;
> +       }
>
>         status = git_gpg_config(k, v, NULL);
>         if (status)
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> @@ -96,4 +96,52 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
>         test_i18ngrep "Aborting commit due to empty commit message." err
>  '
>
> +test_expect_success 'commit with commit.verbose true and no arguments' '

"no arguments" doesn't convey much; how about "--verbose omitted" or
something? Ditto for the titles of other tests.

> +       echo content >file &&
> +       git add file &&
> +       test_config commit.verbose true &&
> +       (
> +               GIT_EDITOR=cat &&
> +               export GIT_EDITOR &&
> +               test_must_fail git commit >output
> +       ) &&
> +       test_i18ngrep "diff --git" output
> +'

Making git-commit fail unconditionally with "aborting due to empty
commit message" is a rather sneaky way to perform this test. I would
have expected to see these new tests re-use the existing machinery
provided by this script (the check-for-diff "editor") rather than
inventing an entirely new and unintuitive mechanism. Doing so would
also reduce the size of each new test.

More below...

> +test_expect_success 'commit with commit.verbose true and --no-verbose' '
> +       echo content >file &&
> +       git add file &&
> +       test_config commit.verbose true &&
> +       (
> +               GIT_EDITOR=cat &&
> +               export GIT_EDITOR &&
> +               test_must_fail git commit --no-verbose >output
> +       ) &&
> +       ! test_i18ngrep "diff --git" output
> +'
> +
> +test_expect_success 'commit with commit.verbose false and -v' '
> +       echo content >file &&
> +       git add file &&
> +       test_config commit.verbose false &&
> +       (
> +               GIT_EDITOR=cat &&
> +               export GIT_EDITOR &&
> +               test_must_fail git commit -v >output
> +       ) &&
> +       test_i18ngrep "diff --git" output
> +'
> +
> +test_expect_success 'commit with commit.verbose false no arguments' '
> +       echo content >file &&
> +       git add file &&
> +       test_config commit.verbose false &&
> +       (
> +               GIT_EDITOR=cat &&
> +               export GIT_EDITOR &&
> +               test_must_fail git commit >output
> +       ) &&
> +       ! test_i18ngrep "diff --git" output
> +'

Some additional tests[1][2] are probably warranted.

[1]: http://article.gmane.org/gmane.comp.version-control.git/288648
[2]: http://article.gmane.org/gmane.comp.version-control.git/288657

> +
>  test_done
