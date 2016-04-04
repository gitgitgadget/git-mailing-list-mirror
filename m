From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 5/5] commit: add a commit.verbose config variable
Date: Sun, 3 Apr 2016 20:58:12 -0400
Message-ID: <CAPig+cTYHFyDXJ2ZECtje2OG-ObT04gnQw+0+LbMMVO51bx2fg@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be81-1859e6e4-81e4-473f-a2fa-7e27305b4e3e-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 02:58:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amsqQ-0003PE-4U
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 02:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbcDDA6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 20:58:13 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36769 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbcDDA6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 20:58:13 -0400
Received: by mail-ig0-f195.google.com with SMTP id kb1so1654797igb.3
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 17:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=t34RWqIGFv6Qlkwvb1zYFb54flhiuPngPlNkZ8MrKXo=;
        b=N08uqJD4G0DrUkFSQk2oialfmtH8RnBxjM6Q0bMgUjhm4l2ueVUo1b7kaGOQdHN/rz
         D/SgRpnBtogcoQlSPO7dbzYYLV5OSkA4rU+SHDSaU+fazVHRKMeI8Tuir5FprO2C96+s
         38C5PyvowD2f3yjxYCyLXny3NDXzRPgyQcL+LU5Kz3/5dVhcnNAuw90oECf/zFFR4RUr
         k6NgrVwvav/NEkhRT9R9qhDiCxVT3UTd4RWNGBjxeG8EoN5qNzSHv8K+fSD32aMYJhgI
         ZK8qeuZyV4TvO6cy8pDhK25g+s5wCMayuylgIfDN59DLdwT1V4DWCaYRDhqM3mMsgVbn
         kTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=t34RWqIGFv6Qlkwvb1zYFb54flhiuPngPlNkZ8MrKXo=;
        b=iQczZvEOztb0Z0649paLaubdGok9Y0ixAhX+Od60uKe2J5aweCf+PBUiMa5UcVucIR
         3bT6PbpJd+GLuvoFfSxTnsJJ1GYdhwMuzEQ/IeRZkO7M/DhOqIA+rYwduEK2NdCKh8Ky
         yL/hHuKnJWRoG0eYOKi48NrSE7lOrWiuQeIB3rj/CKEhDho+lsf3A0iVP7nZ9adctvbC
         pAGqhjVCtRviylcgHEqsjgCM40HFTdcwJGsBggAA+UThhXFrC1+1xl19xp0Cz3RjLx1P
         /Q+496637geNo4KFOybtwMolYmA9tur7gJ66p0jdkYO1r4AVucZcNG0Kf1uTLJu1q1mQ
         lnkw==
X-Gm-Message-State: AD7BkJLEpfrzY/s2X/mwUyicQ1vk5R9fKF5sGdXDZZd0eqyjWlJMLEQDKOi17GrZM3WCR7Nqfr/ACvy8CPkyPw==
X-Received: by 10.107.9.28 with SMTP id j28mr4713456ioi.104.1459731492243;
 Sun, 03 Apr 2016 17:58:12 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 17:58:12 -0700 (PDT)
In-Reply-To: <01020153d952be81-1859e6e4-81e4-473f-a2fa-7e27305b4e3e-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: MWdJ7ZvqEc6wob-N5dTeDcQkaYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290664>

On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Add commit.verbose configuration variable as a convenience for those
> who always prefer --verbose.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1110,6 +1110,10 @@ commit.template::
> +commit.verbose::
> +       A boolean or int to specify the level of verbose with `git commit`.
> +       See linkgit:git-commit[1].

s/level of verbose with/verbosity level of/

> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -1505,6 +1509,11 @@ static int git_commit_config(const char *k, const char *v, void *cb)
> +       if (!strcmp(k, "commit.verbose")) {
> +               int is_bool;
> +               config_verbose = git_config_bool_or_int(k, v, &is_bool);
> +               return 0;
> +       }
> @@ -1654,6 +1663,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>                                           builtin_commit_usage,
>                                           prefix, current_head, &s);
> +       if (verbose == -1)
> +               verbose = (config_verbose < 0) ? 0 : config_verbose;

Okay, so this version compares 'config_verbose' with "< 0" rather than
"== -1" so it won't misbehave when someone sets config.verbose=-2 as
pointed out in [1]. Good.

> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> @@ -98,4 +98,179 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
> +test_expect_success 'set up -v -v' '

Style: "setup -v -v", not "set up -v -v"

> +       echo dirty >file &&
> +       echo dirty >file2 &&
> +       git add file2
> +'

Why this extra complexity when all you need for the "-v -v" case is:

    test_expect_success 'setup -v -v' '
        echo dirty >file
    '

as suggested by [1]? Try to keep unnecessary gunk out of the tests
(and code, in general) to avoid misleading readers into wondering if
something unusual is going on. Which leads to...

> +test_expect_success 'commit.verbose true and --verbose omitted' '
> +       git -c commit.verbose=true commit -F message &&
> +       test_line_count = 1 out
> +'

Why is this new test different (by using "-F message") from all other
new tests which simply use "--amend"? The answer is that it is
performing a "setup" action which should have been done in the "setup"
test just above. But, as noted, this extra setup is unnecessary, thus
also misleading and confusing for readers. Better would be to use the
minimal "setup" shown above (from [1]), and restore this test to use
"--amend" like all other tests.

More below...

> +test_expect_success 'commit.verbose true and --verbose' '
> +       git -c commit.verbose=true commit --amend --verbose &&
> +       test_line_count = 1 out
> +'
> +
> +test_expect_success 'commit.verbose true and -v -v' '
> +       git -c commit.verbose=true commit --amend -v -v &&
> +       test_line_count = 2 out
> +'
> [...large number of almost identical tests omitted...]
> +
> +test_expect_success 'commit.verbose=-2 and --no-verbose' '
> +       git -c commit.verbose=-2 commit --amend --no-verbose &&
> +       test_line_count = 0 out
> +'
> +
> +test_expect_success 'commit.verbose=-1 and --no-verbose' '
> +       git -c commit.verbose=-1 commit --amend --no-verbose &&
> +       test_line_count = 0 out
> +'
> +
> +test_expect_success 'commit.verbose=0 and --no-verbose' '
> +       git -c commit.verbose=0 commit --amend --no-verbose &&
> +       test_line_count = 0 out
> +'
> +
> +test_expect_success 'commit.verbose=1 and --no-verbose' '
> +       git -c commit.verbose=1 commit --amend --no-verbose &&
> +       test_line_count = 0 out
> +'

The fact that the 32 new tests are nearly identical suggests strongly
that the testing should instead either be table-driven or be done via
for-loops to systematically cover all cases. Not only would either of
these approaches be easier to digest, but they would make it easy to
tell at a glance if any cases were missing. See [2] for an example of
how the tests can be table-driven, and see the bottom of [3] for an
example of using for-loops to test systematically (though you'd need
to use nested for-loops rather than just the one in the example).

I'm leaning toward systematic testing via nested for-loops as the more
suitable of the two approach for this particular application.

[1]: http://article.gmane.org/gmane.comp.version-control.git/290000
[2]: http://article.gmane.org/gmane.comp.version-control.git/290344
[3]: http://article.gmane.org/gmane.comp.version-control.git/289860
