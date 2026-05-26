Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E033FE33
	for <git@vger.kernel.org>; Tue, 26 May 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823521; cv=pass; b=t8OG8YsBIKfuoJC6+jnxnwBrOuSBSNuBMP980v1JxZap7+hudFzRn3CIQqraCF60cqKT+g5hTNkpGQ3LJluP1KiF7AB6dGnTprTR8E/u5cvq5kUVBFqeWGyYUhYHKat7HtD4uwHfTGFA7C2Pdyr/+QGMuPRbAorwmar1VvpJMg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823521; c=relaxed/simple;
	bh=idRaVTW5LWCLbFbRZNT76/5u6FL82aUEt4jbKDGD6/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4udEgXWCoD6h/7T1PQrywReU4BL5xSC/XmMcmEVMZaJB9EFJn/FhVqpA/pRU5BXHvoDrtFuH0m23VfBtDG/6SMx9X/AVQl1VU8wR3Ewru3nCEElMbIZai5ciJwwfCRNHm85L5djULagqjXbY+WWmg44RdKk3PHm9Ejfd7wxBWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOhJFFrp; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOhJFFrp"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bdb3fd39045so846644066b.3
        for <git@vger.kernel.org>; Tue, 26 May 2026 12:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779823517; cv=none;
        d=google.com; s=arc-20240605;
        b=PTMTKcM0vcQajI9SLtj/DFLJ9kmveESHgnuR1Ktzw7XU6VhaFrq+VVhOmKjnB6+GVm
         QKifj1Dkt5izehs9Zzxs/k2ehWph1vwsQ20GVeKupIC4LAlLf64c/jN5Zc9AQRxayRI3
         uT8pHCAj/fX/MeHOEiOfVii+UT2z67z3FrCbi9tnVke/HQM4NNrlEYxSADrKzaGzZu98
         gfI+bzFeun6+bGEicdvCzygT/5XPK+4F2qCjGQbHxn3kLdsQnBhs8TMWF0aG82ctCTXE
         WFTYQyEg0aicwuRvYm3HnJD593o9Qexrpcf+yRsH6Emx8w9NUPPH9IUYO0f5WYKIxx/b
         WrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=scUh6/Qi2OX0U3iZSCK7FJzW9VKPQicgpbF7YjU0kRo=;
        fh=LLZkrkm6RWj2MiNsCgkIhEq73i57mlc9EXCxiMLYlMk=;
        b=i+e7ZqWL0TlL6N4I1BAwgIFw0RspJ2D0lOKOWZ9b/KEei16HOaQW5YzrHezLzlNxlp
         5wzegZMoUZjn0UpdAV0qp7tqktFdTvX02OpIoyUDuKUq1HeKGXIIgyzuDnHvruyNdGZH
         WWV0O+goCbeyA+3qiH7eiDNzgUA1F9WNy5AvgT1CjNzOLT7VxUYaMJwo+2pTT1Vi4t/O
         MTlJf5/yg9Tx4iIFXvX5deIABJpzdaqD0mBqxv7kWQJ51e2cyEutFNFirqPE5RyTEz5C
         0yOdvOnfczrpNhHzEFvFIsKHfeB+ptmENfAL1XhuxkGr8/bX8PQD4ZKfj6iCyZrGKOxY
         XzyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779823517; x=1780428317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scUh6/Qi2OX0U3iZSCK7FJzW9VKPQicgpbF7YjU0kRo=;
        b=jOhJFFrpfsBLMNXdZK6PtgSN6miFrVeuYo1XoFmJ4LeYaOcZouwpos1f25WOSN8jRZ
         z/TtqFZtBHLEafeq3jCBjqUgUhpZRJoxmo+mm++UXe0kjAoY2WvrLwMd/LHd586WwhWf
         uEOWxPLQZfjsChFi9f17ycg5ryGG2bVec/+vR3BJAO8j8dlkhUtbBSJQtimdvFzNj6rx
         KTBHZkyymcDQIPQHT+XzyfmSanmeNt+IvVUxsMUV90Q88uFkfuKExYo6c1WftycYMBK+
         aJoUozgF2rWGoQbIVjNNtFkpnABxzLWI0GFCYoxeZRSQBfiwPM6KZRFxzjaCDtsI5r8W
         n21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779823517; x=1780428317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scUh6/Qi2OX0U3iZSCK7FJzW9VKPQicgpbF7YjU0kRo=;
        b=S8VtT5Tv6hUaC5E2att95VV2rCeF5LSxqGY+vDoXsestckQUnkyjmjsy3OzWHmjMEm
         TOS2GplrvUqEbs4L5X9G1kZ8/kMzWbRfVLuCp/o4eHTAFPSq9FKLlkEVHvqddlA9a/RN
         8Gsk4NY4Se4J6OJL3CMuONVC19/STP35LsUo3Wkb7AVwXk8fwhtaFjLy4/ZEmrc+4MRY
         zNE+BpTm9DmLWHfb4rZPbD00hViRp9B8KzmFRDWgoQG/xbe+N/mjEXuGzoNKwdmWQrc5
         6dqMlf7HeUBFocgdCLZnnlJ4UYCRA3oPzFLX5oGX7lSqoj75Ns2UY2Gl7czdh0XjanmW
         wvOQ==
X-Gm-Message-State: AOJu0YzbQMkG+3O0LusLqUUbEwXpNnSR3snIH0N4mXZYk0xoVWE61UkL
	7S7VGHW4rZp7IoNHDidVajWSG+yXo9CNHVu9tlT9Z5te15ivYN49/Xg9uqe2hhaRg4h1XgMZuJq
	EQbrEqQY9H5aIIYgaHVEEGwQXc7qFLYw=
X-Gm-Gg: Acq92OGiGNsnRS1hBPPqfnxaxYZTlWVY0xEVCs3ODN+IwJLkFPsoL5ftpbU7ZlOX8wA
	u9nYCOBmXNK8fQ02xT63lXNNWFW73H0RAF2dE9Lo5VmG6vexiRHTSehIE2y3K5S9N4tx5I04XUQ
	1gGEAAmhhVGoGVOImp9itcaj/aeYUZOVL5d5JxvQXVtY0pM6UnxT+ibGtS55wlNlw1AQso+/CJk
	7wWxiIHUP26sWMiySy6pOD5CxNlCujOYlnzpPEMQbR3YHhV+HbPe/p1c0R1xDmP2Qy73ycOmKBX
	/mt1nW8=
X-Received: by 2002:a17:906:fe06:b0:bd8:53c:b105 with SMTP id
 a640c23a62f3a-bdd2533921fmr1199624766b.2.1779823517112; Tue, 26 May 2026
 12:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2302.v3.git.git.1779697995418.gitgitgadget@gmail.com> <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 26 May 2026 21:24:40 +0200
X-Gm-Features: AVHnY4Kr4p8VFEDoR9hSlM3ZiedWoB4bG9UKeY8EW3kaZUJh4biJWcDFPEK8YvU
Message-ID: <CAHwyqnVxpBv1CEru4sYKu3TtXDLjK-ZZoYnqfdhFf8_Kh1Ostg@mail.gmail.com>
Subject: Re: [PATCH v4] config: improve diagnostic for "set" with missing value
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I forgot to update the PR description on GitHub, it should have read:

- Diagnose the 1-arg set form (explicit and implicit) directly: report
the missing value, and suggest the split form only when the prefix
before `=3D` is a valid key.
- Did not act on Junio's secondary suggestion to reword the 2-arg
`error: invalid key: <key>`, fix seemed to become too big.


Harald

On Tue, May 26, 2026 at 9:21=E2=80=AFPM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> "git config set pull.rebase=3Dfalse" currently fails with "wrong
> number of arguments", and the implicit form "git config
> pull.rebase=3Dfalse" fails with "invalid key". Neither points at
> the real problem: the value is missing.
>
> Report that directly, and when the argument has the shape
> "<valid-key>=3D<value>", also suggest the split form:
>
>     $ git config set pull.rebase=3Dfalse
>     error: missing value to set to the variable 'pull.rebase=3Dfalse'
>     hint: did you mean "git config set pull.rebase false"?
>
> When the prefix before "=3D" is not a valid key, drop the hint:
>
>     $ git config set foo=3Dbar
>     error: missing value to set to a variable with an invalid name 'foo=
=3Dbar'
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     config: suggest the correct form when key contains "=3D"
>
>      * Skip the hint when the inferred value contains whitespace, so git
>        config set pull.rebase=3Dfalse "hello world" no longer suggests a
>        malformed command.
>      * Replace the inline actions =3D=3D 0 check with a named actions_imp=
licit
>        flag, simplfied the code.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-230=
2%2FHaraldNordgren%2Fconfig-hint-equals-key-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2302/H=
araldNordgren/config-hint-equals-key-v4
> Pull-Request: https://github.com/git/git/pull/2302
>
> Range-diff vs v3:
>
>  1:  6b9d66361d ! 1:  780b99409c config: suggest the correct form when ke=
y contains "=3D" in set context
>      @@ Metadata
>       Author: Harald Nordgren <haraldnordgren@gmail.com>
>
>        ## Commit message ##
>      -    config: suggest the correct form when key contains "=3D" in set=
 context
>      +    config: improve diagnostic for "set" with missing value
>
>      -    A user who types "git config pull.rebase=3Dfalse" gets only "er=
ror:
>      -    invalid key: pull.rebase=3Dfalse" with no clue what went wrong.
>      +    "git config set pull.rebase=3Dfalse" currently fails with "wron=
g
>      +    number of arguments", and the implicit form "git config
>      +    pull.rebase=3Dfalse" fails with "invalid key". Neither points a=
t
>      +    the real problem: the value is missing.
>
>      -    Emit a "did you mean ..." hint suggesting the split form.  Rest=
rict it
>      -    to plausible-set contexts ("git config set", bare "git config <=
key>",
>      -    and their 2-arg forms); explicit "get"/"unset" keep the existin=
g error.
>      +    Report that directly, and when the argument has the shape
>      +    "<valid-key>=3D<value>", also suggest the split form:
>
>      -    "=3D" is legal inside a subsection, so only fire when "=3D" lan=
ds after
>      -    the last ".".  When the user supplied a separate value, use it =
in the
>      -    suggestion instead of the suffix after "=3D":
>      +        $ git config set pull.rebase=3Dfalse
>      +        error: missing value to set to the variable 'pull.rebase=3D=
false'
>      +        hint: did you mean "git config set pull.rebase false"?
>
>      -        $ git config set pull.rebase=3Dfalse true
>      -        error: invalid key: pull.rebase=3Dfalse
>      -        hint: did you mean "git config set pull.rebase true"?
>      +    When the prefix before "=3D" is not a valid key, drop the hint:
>      +
>      +        $ git config set foo=3Dbar
>      +        error: missing value to set to a variable with an invalid n=
ame 'foo=3Dbar'
>
>      -    Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
>           Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>
>        ## builtin/config.c ##
>      @@ builtin/config.c: static void check_argc(int argc, int min, int m=
ax)
>         exit(129);
>        }
>
>      -+static void advise_setting_with_equals(const char *key, const char=
 *value)
>      ++static int is_valid_key(const char *key)
>       +{
>       + const char *last_dot =3D strrchr(key, '.');
>      -+ const char *eq;
>       +
>      -+ if (!last_dot)
>      -+         return;
>      -+ eq =3D strchr(last_dot + 1, '=3D');
>      -+ if (!eq)
>      -+         return;
>      -+ if (!value)
>      -+         value =3D eq + 1;
>      -+ if (!*value || strpbrk(value, " \t\n"))
>      -+         return;
>      -+ advise(_("did you mean \"git config set %.*s %s\"?"),
>      -+        (int)(eq - key), key, value);
>      ++ return last_dot && isalpha(last_dot[1]);
>      ++}
>      ++
>      ++static NORETURN void die_missing_set_value(const char *arg)
>      ++{
>      ++ const char *last_dot =3D strrchr(arg, '.');
>      ++ const char *eq =3D last_dot ? strchr(last_dot + 1, '=3D') : NULL;
>      ++ char *prefix =3D eq ? xstrndup(arg, eq - arg) : NULL;
>      ++
>      ++ if (prefix && is_valid_key(prefix)) {
>      ++         error(_("missing value to set to the variable '%s'"), arg=
);
>      ++         advise(_("did you mean \"git config set %s %s\"?"),
>      ++                prefix, eq + 1);
>      ++ } else if (is_valid_key(arg)) {
>      ++         error(_("missing value to set to the variable '%s'"), arg=
);
>      ++ } else {
>      ++         error(_("missing value to set to a variable with an inval=
id name '%s'"),
>      ++               arg);
>      ++ }
>      ++ free(prefix);
>      ++ exit(129);
>       +}
>       +
>        static void show_config_origin(const struct config_display_options=
 *opts,
>      @@ builtin/config.c: static int cmd_config_set(int argc, const char =
**argv, const c
>
>         argc =3D parse_options(argc, argv, prefix, opts, builtin_config_s=
et_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
>      -+ if (argc =3D=3D 1 && strchr(argv[0], '=3D')) {
>      -+         error(_("wrong number of arguments, should be 2"));
>      -+         advise_setting_with_equals(argv[0], NULL);
>      -+         exit(129);
>      -+ }
>      ++ if (argc =3D=3D 1)
>      ++         die_missing_set_value(argv[0]);
>         check_argc(argc, 2, 2);
>
>         if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
>      -@@ builtin/config.c: static int cmd_config_set(int argc, const char=
 **argv, const char *prefix,
>      -                  error(_("cannot overwrite multiple values with a =
single value\n"
>      -                  "       Use --value=3D<pattern>, --append or --al=
l to change %s."), argv[0]);
>      -  }
>      -+ if (ret =3D=3D CONFIG_INVALID_KEY)
>      -+         advise_setting_with_equals(argv[0], argv[1]);
>      -
>      -  location_options_release(&location_opts);
>      -  free(comment);
>       @@ builtin/config.c: static int cmd_config_actions(int argc, const =
char **argv, const char *prefix)
>         };
>         char *value =3D NULL, *comment =3D NULL;
>      @@ builtin/config.c: static int cmd_config_actions(int argc, const c=
har **argv, con
>                 case 1: actions =3D ACTION_GET; break;
>                 case 2: actions =3D ACTION_SET; break;
>       @@ builtin/config.c: static int cmd_config_actions(int argc, const =
char **argv, const char *prefix)
>      -          if (ret =3D=3D CONFIG_NOTHING_SET)
>      -                  error(_("cannot overwrite multiple values with a =
single value\n"
>      -                  "       Use a regexp, --add or --replace-all to c=
hange %s."), argv[0]);
>      -+         else if (ret =3D=3D CONFIG_INVALID_KEY)
>      -+                 advise_setting_with_equals(argv[0], argv[1]);
>      -  }
>      -  else if (actions =3D=3D ACTION_SET_ALL) {
>      -          check_write(&location_opts.source);
>      -@@ builtin/config.c: static int cmd_config_actions(int argc, const =
char **argv, const char *prefix)
>      -          check_argc(argc, 1, 2);
>      -          ret =3D get_value(&location_opts, &display_opts, argv[0],=
 argv[1],
>      -                          0, flags);
>      -+         if (ret =3D=3D CONFIG_INVALID_KEY && actions_implicit)
>      -+                 advise_setting_with_equals(argv[0], NULL);
>      -  }
>      -  else if (actions =3D=3D ACTION_GET_ALL) {
>      -          check_argc(argc, 1, 2);
>      +                  error(_("no action specified"));
>      +                  exit(129);
>      +          }
>      ++ if (actions_implicit && argc =3D=3D 1) {
>      ++         const char *last_dot =3D strrchr(argv[0], '.');
>      ++         if (last_dot && strchr(last_dot + 1, '=3D'))
>      ++                 die_missing_set_value(argv[0]);
>      ++ }
>      +  if (display_opts.omit_values &&
>      +      !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REG=
EXP)) {
>      +          error(_("--name-only is only applicable to --list or --ge=
t-regexp"));
>
>        ## t/t1300-config.sh ##
>       @@ t/t1300-config.sh: test_expect_success 'invalid key' '
>         test_must_fail git config inval.2key blabla
>        '
>
>      -+test_expect_success 'misplaced "=3D" in key: bare 1-arg form hints=
' '
>      -+ test_must_fail git config pull.rebase=3Dfalse 2>err &&
>      -+ test_grep "invalid key: pull\\.rebase=3Dfalse" err &&
>      ++test_expect_success 'set with 1 arg of "key=3Dvalue": valid key su=
ggests split form' '
>      ++ test_must_fail git config set pull.rebase=3Dfalse 2>err &&
>      ++ test_grep "missing value to set to the variable .pull\\.rebase=3D=
false." err &&
>       + test_grep "did you mean .git config set pull\\.rebase false." err
>       +'
>       +
>      -+test_expect_success 'misplaced "=3D" in key: bare 2-arg form uses =
given value' '
>      -+ test_must_fail git config pull.rebase=3Dfalse true 2>err &&
>      -+ test_grep "did you mean .git config set pull\\.rebase true." err
>      -+'
>      -+
>      -+test_expect_success 'misplaced "=3D" in key: set subcommand uses g=
iven value' '
>      -+ test_must_fail git config set pull.rebase=3Dfalse true 2>err &&
>      -+ test_grep "did you mean .git config set pull\\.rebase true." err
>      -+'
>      -+
>      -+test_expect_success 'misplaced "=3D" in key: set with single arg h=
ints' '
>      -+ test_must_fail git config set pull.rebase=3Dfalse 2>err &&
>      -+ test_grep "wrong number of arguments" err &&
>      ++test_expect_success 'set with 1 arg of "key=3Dvalue": implicit for=
m suggests split form' '
>      ++ test_must_fail git config pull.rebase=3Dfalse 2>err &&
>      ++ test_grep "missing value to set to the variable .pull\\.rebase=3D=
false." err &&
>       + test_grep "did you mean .git config set pull\\.rebase false." err
>       +'
>       +
>      -+test_expect_success 'misplaced "=3D" in key: explicit --get does n=
ot hint' '
>      -+ test_must_fail git config --get pull.rebase=3Dfalse 2>err &&
>      -+ test_grep "invalid key: pull\\.rebase=3Dfalse" err &&
>      ++test_expect_success 'set with 1 arg of "key=3Dvalue": invalid key =
does not suggest split form' '
>      ++ test_must_fail git config set foo=3Dbar 2>err &&
>      ++ test_grep "missing value to set to a variable with an invalid nam=
e .foo=3Dbar." err &&
>       + test_grep ! "did you mean" err
>       +'
>       +
>      -+test_expect_success 'misplaced "=3D" in key: get subcommand does n=
ot hint' '
>      -+ test_must_fail git config get pull.rebase=3Dfalse 2>err &&
>      ++test_expect_success 'set with 1 arg: variable name starting with d=
igit is invalid' '
>      ++ test_must_fail git config set foo.1bar=3Dbaz 2>err &&
>      ++ test_grep "missing value to set to a variable with an invalid nam=
e .foo\\.1bar=3Dbaz." err &&
>       + test_grep ! "did you mean" err
>       +'
>       +
>      -+test_expect_success 'misplaced "=3D" in key: unset subcommand does=
 not hint' '
>      -+ test_must_fail git config unset pull.rebase=3Dfalse 2>err &&
>      ++test_expect_success 'set with 1 arg of valid key reports missing v=
alue' '
>      ++ test_must_fail git config set pull.rebase 2>err &&
>      ++ test_grep "missing value to set to the variable .pull\\.rebase." =
err &&
>       + test_grep ! "did you mean" err
>       +'
>       +
>      -+test_expect_success 'misplaced "=3D" in key: value with whitespace=
 skips hint' '
>      -+ test_must_fail git config set pull.rebase=3Dfalse "hello world" 2=
>err &&
>      -+ test_grep "invalid key: pull\\.rebase=3Dfalse" err &&
>      ++test_expect_success 'set with 2 args including "=3D" in invalid ke=
y does not suggest' '
>      ++ test_must_fail git config set pull.rebase=3Dfalse true 2>err &&
>       + test_grep ! "did you mean" err
>       +'
>       +
>      -+test_expect_success '"=3D" inside subsection is valid, no hint' '
>      ++test_expect_success '"=3D" inside subsection is valid' '
>       + test_when_finished "rm -f subsection.cfg" &&
>      -+ git config set -f subsection.cfg foo.bar=3Dbaz.boo qux 2>err &&
>      -+ test_grep ! "did you mean" err &&
>      ++ git config set -f subsection.cfg foo.bar=3Dbaz.boo qux &&
>       + echo qux >expect &&
>       + git config get -f subsection.cfg foo.bar=3Dbaz.boo >actual &&
>       + test_cmp expect actual
>
>
>  builtin/config.c  | 39 ++++++++++++++++++++++++++++++++++++++-
>  t/t1300-config.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index cf4ba0f7cc..6fe2d85814 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -1,6 +1,7 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "abspath.h"
> +#include "advice.h"
>  #include "config.h"
>  #include "color.h"
>  #include "date.h"
> @@ -210,6 +211,33 @@ static void check_argc(int argc, int min, int max)
>         exit(129);
>  }
>
> +static int is_valid_key(const char *key)
> +{
> +       const char *last_dot =3D strrchr(key, '.');
> +
> +       return last_dot && isalpha(last_dot[1]);
> +}
> +
> +static NORETURN void die_missing_set_value(const char *arg)
> +{
> +       const char *last_dot =3D strrchr(arg, '.');
> +       const char *eq =3D last_dot ? strchr(last_dot + 1, '=3D') : NULL;
> +       char *prefix =3D eq ? xstrndup(arg, eq - arg) : NULL;
> +
> +       if (prefix && is_valid_key(prefix)) {
> +               error(_("missing value to set to the variable '%s'"), arg=
);
> +               advise(_("did you mean \"git config set %s %s\"?"),
> +                      prefix, eq + 1);
> +       } else if (is_valid_key(arg)) {
> +               error(_("missing value to set to the variable '%s'"), arg=
);
> +       } else {
> +               error(_("missing value to set to a variable with an inval=
id name '%s'"),
> +                     arg);
> +       }
> +       free(prefix);
> +       exit(129);
> +}
> +
>  static void show_config_origin(const struct config_display_options *opts=
,
>                                const struct key_value_info *kvi,
>                                struct strbuf *buf)
> @@ -1133,6 +1161,8 @@ static int cmd_config_set(int argc, const char **ar=
gv, const char *prefix,
>
>         argc =3D parse_options(argc, argv, prefix, opts, builtin_config_s=
et_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
> +       if (argc =3D=3D 1)
> +               die_missing_set_value(argv[0]);
>         check_argc(argc, 2, 2);
>
>         if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
> @@ -1371,6 +1401,7 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
>         };
>         char *value =3D NULL, *comment =3D NULL;
>         int ret =3D 0;
> +       int actions_implicit;
>         struct key_value_info default_kvi =3D KVI_INIT;
>
>         argc =3D parse_options(argc, argv, prefix, opts,
> @@ -1385,7 +1416,8 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
>                 exit(129);
>         }
>
> -       if (actions =3D=3D 0)
> +       actions_implicit =3D (actions =3D=3D 0);
> +       if (actions_implicit)
>                 switch (argc) {
>                 case 1: actions =3D ACTION_GET; break;
>                 case 2: actions =3D ACTION_SET; break;
> @@ -1394,6 +1426,11 @@ static int cmd_config_actions(int argc, const char=
 **argv, const char *prefix)
>                         error(_("no action specified"));
>                         exit(129);
>                 }
> +       if (actions_implicit && argc =3D=3D 1) {
> +               const char *last_dot =3D strrchr(argv[0], '.');
> +               if (last_dot && strchr(last_dot + 1, '=3D'))
> +                       die_missing_set_value(argv[0]);
> +       }
>         if (display_opts.omit_values &&
>             !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REG=
EXP)) {
>                 error(_("--name-only is only applicable to --list or --ge=
t-regexp"));
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 11fc976f3a..4a8a381bd8 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -469,6 +469,49 @@ test_expect_success 'invalid key' '
>         test_must_fail git config inval.2key blabla
>  '
>
> +test_expect_success 'set with 1 arg of "key=3Dvalue": valid key suggests=
 split form' '
> +       test_must_fail git config set pull.rebase=3Dfalse 2>err &&
> +       test_grep "missing value to set to the variable .pull\\.rebase=3D=
false." err &&
> +       test_grep "did you mean .git config set pull\\.rebase false." err
> +'
> +
> +test_expect_success 'set with 1 arg of "key=3Dvalue": implicit form sugg=
ests split form' '
> +       test_must_fail git config pull.rebase=3Dfalse 2>err &&
> +       test_grep "missing value to set to the variable .pull\\.rebase=3D=
false." err &&
> +       test_grep "did you mean .git config set pull\\.rebase false." err
> +'
> +
> +test_expect_success 'set with 1 arg of "key=3Dvalue": invalid key does n=
ot suggest split form' '
> +       test_must_fail git config set foo=3Dbar 2>err &&
> +       test_grep "missing value to set to a variable with an invalid nam=
e .foo=3Dbar." err &&
> +       test_grep ! "did you mean" err
> +'
> +
> +test_expect_success 'set with 1 arg: variable name starting with digit i=
s invalid' '
> +       test_must_fail git config set foo.1bar=3Dbaz 2>err &&
> +       test_grep "missing value to set to a variable with an invalid nam=
e .foo\\.1bar=3Dbaz." err &&
> +       test_grep ! "did you mean" err
> +'
> +
> +test_expect_success 'set with 1 arg of valid key reports missing value' =
'
> +       test_must_fail git config set pull.rebase 2>err &&
> +       test_grep "missing value to set to the variable .pull\\.rebase." =
err &&
> +       test_grep ! "did you mean" err
> +'
> +
> +test_expect_success 'set with 2 args including "=3D" in invalid key does=
 not suggest' '
> +       test_must_fail git config set pull.rebase=3Dfalse true 2>err &&
> +       test_grep ! "did you mean" err
> +'
> +
> +test_expect_success '"=3D" inside subsection is valid' '
> +       test_when_finished "rm -f subsection.cfg" &&
> +       git config set -f subsection.cfg foo.bar=3Dbaz.boo qux &&
> +       echo qux >expect &&
> +       git config get -f subsection.cfg foo.bar=3Dbaz.boo >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'correct key' '
>         git config 123456.a123 987
>  '
>
> base-commit: 56a4f3c3a221adf1df9b39da69b8a6890f803157
> --
> gitgitgadget
