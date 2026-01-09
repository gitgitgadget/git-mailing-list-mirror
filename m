Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E350097C
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958676; cv=none; b=oclOf8aWML8dnvG3tEXYgDaOayprnfDLPGZa3YystAzzlX5ODTOsbIkLtgW39OBBoYY+xZYj4Uv1WPmXQ9ty1oais50eW4Sx7UQwcbTkVR/G9ctc0N1I5zfQjZOcZbWVU6C+3Q9s5PYwvqMGm2ULERdnmFsIysnxslBxozA0TmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958676; c=relaxed/simple;
	bh=uTclQve7v3p7Pv8AQMDDl1gAPri3m6tevae7rq9VXKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN22IsgFqB7OEOLAzl0H3c1Mwr+p+us3HB/HR+462ZLBW6SjfE4bsnoX1yq/W7wPg+74Ks72JhVO63iq5YmEBICa5FpCttwZNi/RE5WtO6L26CzqIik8pnR068JUfbolfRsN1pARwpjPOlo3z0WP8Isf2NbGJgjW0B9kMwO8gtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5hOcp3C; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5hOcp3C"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-646e2b3600fso3851976d50.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 03:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958674; x=1768563474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JR/dK/BlIpR3h8tTWii5FZXzKwVwW0oUe2w73jGVyo=;
        b=C5hOcp3CdWG56ufJysGHhJl/9TT2Ygu3OjjmUbkXnFAYBXxYRO+D3B9vM8gKvBUrLO
         Mw3YqWjEczbVTbQ7QWB8thTfZc1A1Kw87txh80L5A1uIVbp286IlN+jwxCqXwQ699MUk
         8Ocj/it/cHR8h31L7t0dq8wGky2o6T9ImolVVOjnmZbqGSQWlsUT6khApeX2hYtSQ5OY
         PuoS3+bcz3hUkbFzb+G2LMZfTdPmwmP2L0rCnRmqkJOd/LY2kGbNTD3icyPY+HUruW3g
         PpHVuM1cOacaKQchThYAQLR1rVIpDSfuZbTYC0IIC9efWkaTBI14eyyrBybDdoxEcGWo
         EejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958674; x=1768563474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JR/dK/BlIpR3h8tTWii5FZXzKwVwW0oUe2w73jGVyo=;
        b=pP1felBJbqRXc9O940ATAQzOHZlHw5+hlmosGZ9/+WxdIXjxyZtCIF11eCh18KvKvb
         ZHNQptL0xqL0/KoJPf0KbaXu6Dcgo+1adtPaVEpeYw2aYBhON+wbgj82KYMZyxtfC4cq
         pio6plTls0VoNUMCFHEZezOFCJAedfvfADjpes1tXez59j5E1jmmIbu5A0tswaec/clC
         VFyWNRfcL/Uynp6GRW5WYH+dAdzuAriAP6FJtfaJ9UyIdE6Tlcc9/zdMQFpv27mjIt2f
         b+tm+1RjnT4E5+ROvvBI4D6/YcQxCM2/UD1lUajirXdowGyCXIN7C41fgf4rBoUiGgGV
         l8dg==
X-Gm-Message-State: AOJu0Yx/aMq3d6ImHMYTRhFuqdbtocBZm0eYrFBVDcHMxMTjkxrVLooj
	eXYRdY/DNo5UZK3olJ3Or3KdR1Kkp4EjdvS7LbxFF4KMX4dF364ytumgE6w/WfMIQfOQc2WfJZY
	ZfYGBxxKddc2yPMKXuDzOJUxmWOUoKPv9G4kIFCsv0Q==
X-Gm-Gg: AY/fxX6CnH/+21I1SOTXZjxgTF8NJw55FMKuhmdrKx1Gei8eY3FyiL5OPKHOgaOPnk/
	ciU2WQ7eMdJosbAqUX6L0NWAL1TM52Z6M4NDyLK3ycRp5f1wtsvG14dogQLvB5iLOWSrtnVnOB+
	H2P2rLLA+1JZe4SzMj8Ew9Ub1hUujeuw8qGl9UTcsPZ5gfWubKJJLB1C+PggKIeaFAmrRuO/+zd
	m0eSMXIYhIx+lQa5xLJcPVbSLfPU4Kl51umVw3e9LmQKNWjkQg03zb+ANVI9ijD3aMRnWk=
X-Google-Smtp-Source: AGHT+IEIszyztcIURxFO9YrWQBKeYNDoOJV/84qHek5zWqRMEnEJvakHa6ssIGCLWOrNIPKr+5Y+XfVPlm1gDs6waMY=
X-Received: by 2002:a05:690e:1901:b0:641:f5bc:6984 with SMTP id
 956f58d0204a3-64716c36bbemr8147933d50.80.1767958673987; Fri, 09 Jan 2026
 03:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2028.git.1767929941577.gitgitgadget@gmail.com>
In-Reply-To: <pull.2028.git.1767929941577.gitgitgadget@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Fri, 9 Jan 2026 17:07:41 +0530
X-Gm-Features: AQt7F2oiqYZJxfwrAa2HmlheaYEcLpmgzufUEIL1duEqb_u4CTu1BzVxKekJaAw
Message-ID: <CALE2CrT=W8=gzhb_y9w+Yd3H+VKSL6251c8vzn3HaT-WSFYinA@mail.gmail.com>
Subject: Re: [PATCH] builtin.h: update documentation
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Derrick,

Thanks for updating this comment block. The old builtin API
documentation being out of sync with the repository-aware command
signature has been a real source of confusion, so having the correct:

int cmd_foo(int argc, const char **argv,
             const char *prefix, struct repository *repo)

spelled out here is very helpful.

The addition of the NO_PARSEOPT flag description is also useful. It
nicely explains both when a builtin might use a custom parser and why
such commands do not appear in git --list-cmds=3Dparseopt, which is not
obvious otherwise.

I also appreciate the references to the test scripts (t0012, t0450,
t1517). Pointing new contributors to the checks that will be applied to
a new builtin makes the expectations much clearer than before.

From what I can tell, this matches the current code and test behavior,
so this looks good to me.

Thanks,
Pushkar

On Fri, Jan 9, 2026 at 9:09=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The documentation for the builtin API was moved from the technical
> documentation and into a comment in builtin.h by ec14d4ecb5 (builtin.h: t=
ake
> over documentation from api-builtin.txt, 2017-08-02). This documentation
> wasn't updated as part of the major overhaul to include a repository stru=
ct
> in 9b1cb5070f (builtin: add a repository parameter for builtin functions,
> 2024-09-13).
>
> There was a brief update regarding the move from *.txt to *.adoc by
> e8015223c7 (builtin.h: *.txt -> *.adoc fixes, 2025-03-03).
>
> I noticed that there was quite a bit missing from the old documentation,
> which is still visible on git-scm.com [1].
>
> [1] https://github.com/git/git-scm.com/issues/2124
>
> This change updates the documentation in the following ways:
>
>  1. Updates the cmd_foo() prototype to include a repository.
>  2. Adds some newlines to have uniformity in the list of flags.
>  3. Adds a description of the NO_PARSEOPT flag.
>  4. Describes the tests that perform checks on all builtins, which may tr=
ip
>     up a contributor working on a new builtin.
>
> I double-checked these instructions against a toy example in my local bra=
nch
> to be sure that it was complete.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>     builtin.h: update documentation
>
>     This is motivated by curiosity and thinking about how to train a new
>     contributor on how to create a new builtin. So I found the api-builti=
n
>     docs on the web page and found them grossly out of date, but was glad=
 to
>     see some updates in this comment version.
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2028%2F=
derrickstolee%2Fapi-builtin-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2028/derri=
ckstolee/api-builtin-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2028
>
>  builtin.h | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/builtin.h b/builtin.h
> index 1b35565fbd..e5e16ecaa6 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -17,7 +17,8 @@
>   * . Define the implementation of the built-in command `foo` with
>   *   signature:
>   *
> - *     int cmd_foo(int argc, const char **argv, const char *prefix);
> + *     int cmd_foo(int argc, const char **argv,
> + *                 const char *prefix, struct repository *repo);
>   *
>   * . Add the external declaration for the function to `builtin.h`.
>   *
> @@ -29,12 +30,14 @@
>   * where options is the bitwise-or of:
>   *
>   * `RUN_SETUP`:
> + *
>   *     If there is not a Git directory to work on, abort.  If there
>   *     is a work tree, chdir to the top of it if the command was
>   *     invoked in a subdirectory.  If there is no work tree, no
>   *     chdir() is done.
>   *
>   * `RUN_SETUP_GENTLY`:
> + *
>   *     If there is a Git directory, chdir as per RUN_SETUP, otherwise,
>   *     don't chdir anywhere.
>   *
> @@ -57,6 +60,12 @@
>   *     more informed decision, e.g., by ignoring `pager.<cmd>` for
>   *     certain subcommands.
>   *
> + * `NO_PARSEOPT`:
> + *
> + *     Most Git builtins use the parseopt library for parsing options.
> + *     This flag indicates that a custom parser is used and thus the
> + *     builtin would not appear in 'git --list-cmds=3Dparseopt'.
> + *
>   * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
>   *
>   * Additionally, if `foo` is a new command, there are 4 more things to d=
o:
> @@ -69,6 +78,21 @@
>   *
>   * . Add an entry for `/git-foo` to `.gitignore`.
>   *
> + * As you work on implementing your builtin, be mindful that the
> + * following tests will check different aspects of the builtin's
> + * readiness and adherence to matching the documentation:
> + *
> + * * t0012-help.sh checks that the builtin can handle -h, which comes
> + *   automatically with the parseopt API.
> + *
> + * * t0450-txt-doc-vs-help.sh checks that the -h help output matches the
> + *   SYNOPSIS in the documentation for the builtin.
> + *
> + * * t1517-outside-repo.sh checks that the builtin can handle -h when
> + *   run outside of the context of a repository. Note that this test
> + *   requires that the usage has a space after the builtin name, so some
> + *   minimum description of options is required.
> + *
>   *
>   * How a built-in is called
>   * ------------------------
>
> base-commit: d529f3a197364881746f558e5652f0236131eb86
> --
> gitgitgadget
>
