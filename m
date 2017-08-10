Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A79208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdHJUD7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:03:59 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:38332 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbdHJUD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:03:58 -0400
Received: by mail-lf0-f48.google.com with SMTP id y15so8053282lfd.5
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rh+95wEkUJeFJ/ohYT3N5lX4CVb3I/Ekf1qdPA8WPwk=;
        b=FODBku7Ms+murgQMKiF0clbgVsst/AGLPlZ7nC0zTfVg3XaWbOsL6JbWiBZAGU0385
         CQUeQBGYENSWJ9woqiIJ3fiwztEcm712kWbMGGZwfJlOzEdiVy1UuBLa5lkDuVOY3gKQ
         WyVIvVUPwjGdyzuaDS9shYXaZt/tCGEEJcE/E+TgrgurR8WVP/oNblAGf176L53o7HYD
         4AN7eqneOo9o4Q2JXJlHU75NbYutr0og93uN7RhcZiKpuwq9RmzCvdnOptsbYmKT5H6j
         f1zPZE0cKgAViaMhDeuX/1aGUOjfYaAxv5wZgkEylRLmf77zH0ro8hSckTZh0teTlcTl
         XUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rh+95wEkUJeFJ/ohYT3N5lX4CVb3I/Ekf1qdPA8WPwk=;
        b=NePkKW+FgLgAAicpEtwI0oKRcp4j9VkqFA4C+icA0IKiG4A15JPF236Cu4fVwMs67T
         bxmytGArgS2R6QeeukD3KyvN/iKa//3910fvzCmRpBg2oIssYFpbDJSz7nPyHM9LJVVJ
         DXwX+4HAsbLRIwOJ0XWgXIojCI8VrYY0giBrf1Xt9VQIvXQqKS/MWQfqpKp7LKQYl6Wv
         6LMytvxVfzJg8ECDmn6jYzIcDH78fJxkKcHxBLlZfL+d0zNpA8TsuPVfQENBkYEzpqZG
         JTTpXiWS9SKfF7K6ZRFA5h7jr10DjlXMqySUY14F3KyTnuyLM3+XOCNgQ0fUq/bK973Z
         XVmw==
X-Gm-Message-State: AHYfb5iqWpIZUWiQzuElQlB42NBNo34fWosIh+oqu86XO9b9zdYUquyt
        P2FtNNaM7QXABqhGX4PWLK5EBIGqeueC
X-Received: by 10.46.5.141 with SMTP id 135mr4639241ljf.95.1502395436151; Thu,
 10 Aug 2017 13:03:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 13:03:55 -0700 (PDT)
In-Reply-To: <20170810184936.239542-2-jamill@microsoft.com>
References: <20170810184936.239542-1-jamill@microsoft.com> <20170810184936.239542-2-jamill@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 13:03:55 -0700
Message-ID: <CAGZ79kb8cWR1P=1FSkfZ72Ai63T0WapwtCCN3gwqrWE_=MzOLg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] dir: teach status to show ignored directories
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:49 AM, Jameson Miller
<jameson.miller81@gmail.com> wrote:

Welcome to the Git mailing list. :)

> Teach Git to optionally show ignored directories when showing all
> untracked files. The git status command exposes the options to report
> ignored and/or untracked files. However, when reporting all untracked
> files (--untracked-files=all), all individual ignored files are reported
> as well. It is not currently possible to get the reporting behavior of
> the --ignored flag, while also reporting all untracked files.

Trying to understand this based off the documentation for
--untracked=all and --ignored, I realize that the documentation
for --ignored seems to be lacking as I do not understand what the
--ignored behavior is in combination with --untracked=[all, normal, no]

> This
> change exposes a flag to report all untracked files while not showing
> individual files in ignored directories.

By the description up to here, it sounds as if you want to introduce
mode for --untracked, e.g. "normal-adjusted-for-ignored" (it's a bad
suggestion)? However the patch seems to add an orthogonal flag,
such that

  status --no-ignored --untracked=no --show-ignored-directory

would also be possible. What is a reasonable expectation for
the output of such?

> Motivation:
> Our application (Visual Studio) needs all untracked files listed
> individually, but does not need all ignored files listed individually.

For parsing output, I would strongly recommend --porcelain[=2],
but that is a tangent.

> Reporting all ignored files can affect the time it takes for status
> to run. For a representative repository, here are some measurements
> showing a large perf improvement for this scenario:
>
> | Command | Reported ignored entries | Time (s) |
> | ------- | ------------------------ | -------- |
> | 1       | 0                        | 1.3      |
> | 2       | 1024                     | 4.2      |
> | 3       | 174904                   | 7.5      |
> | 4       | 1046                     | 1.6      |
>
> Commands:
>  1) status
>  2) status --ignored
>  3) status --ignored --untracked-files=all
>  4) status --ignored --untracked-files=all --show-ignored-directory

(2) is --untracked-files=normal I'd presume, such that this flag
can be understood as a tweak to "normal" based on the similar size
between 2 and 4? (The timing improvement from 2 to 4 is huge though).

> This changes exposes a --show-ignored-directory flag to the git status

s/changes/change/

> command. This flag is utilized when running git status with the
> --ignored and --untracked-files options to not list ignored individual
> ignored files contained in directories that match an ignore pattern.
>
> Part of the perf improvement comes from the tweak to
> read_directory_recursive to stop scanning the file system after it
> encounters the first file. When a directory is ignored, all it needs to
> determine is if the directory is empty or not. The logic currently keeps
> scanning the file system until it finds an untracked file. However, as
> the directory is ignored, all the contained contents are also marked
> excluded. For ignored directories that contain a large number of files,
> this can take some time.

I think it is possible to ignore a directory and still track files in it, what
are the implications of this flag on a tracked (and changed) file in an
ignored dir?

What happens to empty directories that match an ignore pattern?


> @@ -1362,6 +1363,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>                   N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
>                   PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>                 OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
> +               OPT_BOOL(0, "show-ignored-directory", &show_ignored_directory,

Is it possible to directly read into  s.show_ignored_directory here?

> +test_expect_success 'Verify behavior of status on folders with ignored files' '
> +       test_when_finished "git clean -fdx" &&
> +       git status --porcelain=v2 --ignored --untracked-files=all --show-ignored-directory >output &&
> +       test_i18ncmp expect output
> +'
> +
> +# Test status bahavior on folder with tracked and ignored files

behavior

> +cat >expect <<\EOF
> +? expect
> +? output
> +! dir/tracked_ignored/ignored_1.ign
> +! dir/tracked_ignored/ignored_2.ign
> +! tracked_ignored/ignored_1.ign
> +! tracked_ignored/ignored_2.ign
> +EOF

I think our latest 'best style' is to include these heredocs into the test.
