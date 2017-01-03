Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9691E1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 17:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759822AbdACR7B (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 12:59:01 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33117 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753143AbdACR67 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 12:58:59 -0500
Received: by mail-qk0-f173.google.com with SMTP id t184so383060546qkd.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5JlysuYnIvr6IbOHvVVTQime3re9FWGRaHanlJdOLhE=;
        b=A+2evc+fayMCThB3Oy4SsXErLIHu6YGQ4kzcZ2cJpain3epXuKKGbBY3itS5NJJ63I
         oFlH9Yc4u9IB7tq4wMEKLlEPou8TwQkIOOvmgLWE9EYL05I+dSRQQ0dLzUYtFHJsif1E
         0J+9i3VMUJ6GWiHO3ncPLlGS0p8SSDtll05TJPrYG8Aqa8t+AStbMIJvRjtTMUTJ3yiJ
         udtBtSUXaSllwSVyT9U3haXZ+uU6epmXrgZXjsOK/sifDnNYNEW0i6DlxyiNIjaoQVCl
         SoTFHszIUdOZWUguDb8YMEyN9LAbZeUa9iGH6aTZuubMSo5U+Ooq6grMXhk5fyaNEd6R
         URkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5JlysuYnIvr6IbOHvVVTQime3re9FWGRaHanlJdOLhE=;
        b=r823Av4dor2O6jw7eSPXNFcKLtbN+YSe4NLfGynFFMSOxQCAeZ/MxyuhVG4lJYdzQR
         UJTPzLKe0bZwnM9EDI/YEbShybJ3AinUSxKQyj9YyqM3lM18VX7WTmeraA7CRxGrj1VD
         bcYk0wm7Lq/Vv3auyWoeFStV9JRghr0smsEjwuMqy/jPOn2YOjH5F6vL7OIAUxv2GIW9
         OkIMNVoEPTddyT81QoxelpJeobjLq32L4p9qqyWUYnv0ASy1HbGOad1Abh/bsbP1NK/y
         wwUKMXZkGDxLRP9LaPbZy6jx4+8TZn4jYYoN8kmzzUfVZboSzymlPPrIUTfuFrxs7L87
         1sQw==
X-Gm-Message-State: AIkVDXI3WUr2FORgA3CuKqhpl151+Drs1SH8O7DX7KkkgrjAREJNU31xPlXobQSEz7GgMqY0E8z0e6BsexNxRwjv
X-Received: by 10.55.221.5 with SMTP id n5mr58872684qki.58.1483466320599; Tue,
 03 Jan 2017 09:58:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 3 Jan 2017 09:58:40 -0800 (PST)
In-Reply-To: <20170102184536.10488-2-pranit.bauva@gmail.com>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
 <20170102184536.10488-1-pranit.bauva@gmail.com> <20170102184536.10488-2-pranit.bauva@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Jan 2017 09:58:40 -0800
Message-ID: <CAGZ79kZRFLzD7wcAnFvke9vBxxTAgE7=Ud7F_O95EfkWqz=LJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t9813: avoid using pipes
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, luke@diamond.org,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 2, 2017 at 10:45 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> The exit code of the upstream in a pipe is ignored thus we should avoid
> using it.

for commands under test, i.e. git things. Other parts can be piped if that makes
the test easier. Though I guess that can be guessed by the reader as well,
as you only convert git commands on upstream pipes.

> By writing out the output of the git command to a file, we can
> test the exit codes of both the commands.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

Thanks for taking ownership of this issue as well. :)

> ---
>  t/t9813-git-p4-preserve-users.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
> index 798bf2b67..9d7550ff3 100755
> --- a/t/t9813-git-p4-preserve-users.sh
> +++ b/t/t9813-git-p4-preserve-users.sh
> @@ -118,12 +118,12 @@ test_expect_success 'not preserving user with mixed authorship' '
>                 make_change_by_user usernamefile3 Derek derek@example.com &&
>                 P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
>                 export P4EDITOR P4USER P4PASSWD &&
> -               git p4 commit |\
> -               grep "git author derek@example.com does not match" &&
> +               git p4 commit >actual 2>&1 &&

Why do we need to pipe 2>&1 here?
Originally the piping only fed the stdout to grep, so this patch changes the
test? Maybe

    2>actual.err &&
    test_must_be_empty actual.err

instead?

Thanks,
Stefan
