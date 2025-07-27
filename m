Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9BB1A76BB
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753651034; cv=none; b=GlrEPJeR2mhGnUVRyhD9oxzA+SR+/v0bl11GTPk4FLgujDTCBY+bgCTSN/Tgiqi1k4J1La6TMnZ8LiINEKOn9d62bRF05kFU5qwi0ub/pRydkiFdqCi9TeEpgDjpfWfgI4BdZpepBm7L9eu1U4ExCfuwLEu/eEC+UldCJd5Xkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753651034; c=relaxed/simple;
	bh=0vM++oIl6m//wVdnzchtbQMyo/4idLIEraKAdfoiPGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWcW1uZxGH/QzyReM2jc8FyCg2NTUKx0WVd1/vjbx6TbXQfyvQVHEICdnYOm6bJq8h4W20C3HDpfCj2m3DohgYhgf7yT1ezD76C9LixIVFr7U+5rTTRgPAZKdogBfZleGvP1XJEA68oRMj5mGkAZzfloK2M95hio0uGdrIhfbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4aabba49c97so4061911cf.2
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 14:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753651030; x=1754255830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78gj+2X4ShZIIpGLoSRXgjfgHuoILYN853H6uva462Q=;
        b=M5NfmwVKEsW+EK9etg3K3UGgO0oDlkpzuBojf76cQ/cZGyWwal6dUv03n5Y8g9XdBw
         A+C8trVL+WwbvakOfrRdcgwJ+iLK70buKdIxIsIOfCYIb6YCD77e27y77ZNjafzuqxTk
         6DUXEdAcBWE/othzmqCuNfcdVfSbgqr7SM+NQxqYxQSYN7xAtrJ3QgltvbLN17HPOiUd
         vebKkd7siFTv5ai9Nb3JJqx57k2KgMK24B+5nSoJqtPxXg6Wqk8IgMToARXLWxyaRZ87
         TjPZLdGmlVdtASFArOXvBT78ERhesMzVdnQmUdJPaT0tdi7wCfAHK0ao1sj8hFlvloFA
         O17g==
X-Gm-Message-State: AOJu0YzL7HRntNnP7YAjvgf5QJVldaToenOmRmErcb30Qk5yhCWEmVS3
	pVQMlc5el+vcfw1sildZlYL2+F0KVltvE/i3jOdN4MSY9zRKTRTmRFpIji5NVH/QhoxbqjlJnsJ
	FJ6yrZzdGVtK9khVd8bwlGHBucxAtifY=
X-Gm-Gg: ASbGncsTSKOhsk8pkEBQkhq9nMSPJlOMIZNLXmu7mPfTXw8ectmHcATTQGjaCzl1Ygs
	dtbiOA5l2wNyHRrNiBaUxY9op96V5Cu9t0+u/zkg0b7FJdb10FcXQtZzzRTuZ7QFymY/e+GkRie
	X85Hi2PGod+cbSRpZLdYgeK9pA6tIAS1LIuElhfoPSfbKtcMd/C12ZGyV3GnvXSQx+vZa+ah1Ry
	SE4P0GteLB+SfpWTPLR9PPiRVhI4x58oIozUqml
X-Google-Smtp-Source: AGHT+IGS25+7g8QGkH6FKZ1UfqbWLq+CuLHNg1s6ESIs9SvGna+QwwRLjQPt/56Rgfezk4TDSoxpZYQIpj+CPCq98Po=
X-Received: by 2002:a05:6214:8018:b0:707:3b3b:4eac with SMTP id
 6a1803df08f44-7073b3b5928mr20935896d6.0.1753651029986; Sun, 27 Jul 2025
 14:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com> <20250727175110.84770-3-lucasseikioshiro@gmail.com>
In-Reply-To: <20250727175110.84770-3-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 27 Jul 2025 17:16:59 -0400
X-Gm-Features: Ac12FXzAKhdNnNsJvto_aAfqOAbFR9Rmez_II92kuFFp1UcZcDFsLBDJ0-jLDww
Message-ID: <CAPig+cTuiUy=+2Jf1Lrp1gaM03_zPf8EFMVSKmShqU05t-3aWQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 1:52=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> This commit is part of the series that introduces the new subcommand
> git-repo-info.
>
> The flag `--show-ref-format` from git-rev-parse is used for retrieving
> the reference format (i.e. `files` or `reftable`). This way, it is
> used for querying repository metadata, fitting in the purpose of
> git-repo-info.
>
> Add a new field `references.format` to the repo-info subcommand
> containing that information.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> @@ -29,6 +29,10 @@ INFO KEYS
>  The set of data that `git repo` can return is grouped into the following
>  categories:
>
> +`references`::
> +Reference-related data:
> +* `format`: the reference storage format

Based upon the implementation, I can see that the user must type the
key in "dotted" form:

    git repo info references.format

but I wonder if the above documentation actually conveys this
requirement. I don't think I would figure it out easily. Perhaps
hand-holding the user by giving an example would help.

> diff --git a/builtin/repo.c b/builtin/repo.c
> +/* repo_info_fields keys should be in lexicographical order */
> +static const struct field repo_info_fields[] =3D {
> +       { "references.format", get_references_format },
> +};

How can we ensure that the lexicographical-order requirement won't
break? If someone adds a new entry which is not in its proper place,
presumably that will be noticed because some existing test in a test
script will stop working, but it feels unnecessarily fragile and a bit
of a maintenance burden. Also, this requirement does feel like a
premature optimization. Do you expect this list to become so huge and
the corresponding lookup function to be called so frequently that a
simple brute-force linear search would be too slow?

> +static int qsort_strcmp(const void *va, const void *vb)
>  {
> +       const char *a =3D *(const char **)va;
> +       const char *b =3D *(const char **)vb;
> +
> +       return strcmp(a, b);
> +}
> +
> +static int print_fields(int argc, const char **argv, struct repository *=
repo)
> +{
> +       const char *last =3D "";
> +
> +       QSORT(argv, argc, qsort_strcmp);

I can see from the implementation that you are sorting the incoming
arguments in order to detect and fold out duplicates. However, that
raises a couple questions. First, is it really a good idea to do
something other than what the user asked for? Second, if this is a
good idea, then should the behavior be documented?

I can see arguments in favor of sorting and de-duplicating, as well as
in favor of producing exactly the (unordered) output the user asked
for, including duplicates, so I don't have a strong opinion either
way. But, if you do retain this behavior, then the sorting and
deduplication behaviors should probably be documented.

> +       for (int i =3D 0; i < argc; i++) {
> +               get_value_fn *get_value;
> +               const char *key =3D argv[i];
> +               struct strbuf value;
> +
> +               if (!strcmp(key, last))
> +                       continue;
> +
> +               strbuf_init(&value, 64);
> +               get_value =3D get_value_fn_for_key(key);
> +
> +               if (!get_value) {
> +                       strbuf_release(&value);
> +                       return error(_("key '%s' not found"), key);
> +               }
> +
> +               get_value(repo, &value);

A couple observations:

First, you don't actually use the strbuf until the call to
get_value(), so the strbuf_init() call seems to be too early, with the
result that you need a corresponding strbuf_release() in the error
branch. If you move the strbuf_init() so it occurs immediately before
get_value(), then you can simplify the early exit case.

Second, this seems to be getting unnecessarily intimate with strbuf. I
can guess that you're doing this late strbuf_init() to avoid an
allocation in the case when a duplicate key was encountered, however,
STRBUF_INIT doesn't actually perform an allocation, so it would be
clearer to just initialize the strbuf at the time you declare it
rather than calling strbuf_init() manually. However...

Although it is a micro optimization (as well as a
premature-optimization), it is far more common in this code base to
hoist the strbuf outside of the loop and instead call strbuf_reset()
it upon each iteration:

    struct strbuf value =3D STRBUF_INIT;
    for (...) {
        strbuf_reset(&value);
        ...
        if (error_condition) {
            strbuf_release(...);
            return error(...);
        }
       ...
    }
    strbuf_release(...);

> +               printf("%s=3D%s\n", key, value.buf);
> +               last =3D key;
> +               strbuf_release(&value);
> +       }
> +
>         return 0;
>  }

Looking at this from a higher level, is it presenting a good
user-experience by potentially printing some output but then erroring
out upon the first unrecognized key? Would the user-experience be
improved by instead continuing the loop even after reporting an error,
and then adjusting the final `return 0` to conditionally return
success or error depending upon whether any keys were unrecognized?

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +
> +test_description=3D'test git repo-info'
> +
> +. ./test-lib.sh
> +
> +# Test if a field is correctly returned in the null-terminated format

This is talking about null-terminated format, but the implementation
doesn't seem to emit NUL-terminated output at all.

> +# Usage: test_repo_info <label> <init command> <key> <expected value>
> +#
> +# Arguments:
> +#   label: the label of the test
> +#   init command: a command that creates a repository called 'repo', con=
figured
> +#      accordingly to what is being tested
> +#   key: the key of the field that is being tested
> +#   expected value: the value that the field should contain
> +test_repo_info () {
> +       label=3D$1
> +       init_command=3D$2
> +       key=3D$3
> +       expected_value=3D$4
> +
> +       test_expect_success "$label" '
> +               test_when_finished "rm -rf repo" &&
> +               eval "$init_command" &&
> +               echo "$expected_value" >expected &&
> +               git -C repo repo info "$key" >output &&
> +               cut -d "=3D" -f 2 <output >actual &&
> +               test_cmp expected actual
> +       '
> +}

It seems that this could be simplified by crafting the expected output
more precisely?

    eval ... &&
    echo "$key=3D$expected_value" >expect &&
    git -C repo repo info "$key" >actual &&
    test_cmp expect actual

By the way, we typically avoid cleaning up test detritus merely for
the sake of cleaning up because doing so slows down the already
too-slow test suite. Instead, cleanup is usually only performed when
absolutely necessary to avoid some undesirable interaction between
tests. Avoiding cleanup also makes it easier to debug failed tests
since (hopefully) the cause of the failure is still present in the
"trash" directory.

In this case, if you call this function with a distinct repository
name each time, then you don't have to remove the repository at all.
Moreover, giving each repository a distinct and _meaningful_ name,
rather than reusing the same name, could also be helpful when
diagnosing failures.

> +test_repo_info 'ref format files is retrieved correctly' '
> +       git init --ref-format=3Dfiles repo' 'references.format' 'files'
> +
> +test_repo_info 'ref format reftable is retrieved correctly' '
> +       git init --ref-format=3Dreftable repo' 'references.format' 'refta=
ble'

This is overly fragile. The `test_repo_info` function hardcodes the
name "repo" but then the caller is also expected to pass in the name
as part of the initialization argument (i.e. `git init ... repo`). To
make this more robust, either don't hardcode it in the function, or
stop expecting the caller to supply the name as part of the
initialization argument.

With only two callers, it's not clear at this point whether the
`test_repo_info` function is providing any added value, especially
since the additional abstraction increases cognitive load, but perhaps
later patches in this series add more callers?

> +test_expect_success 'git-repo-info aborts if an invalid key is requested=
' '
> +       test_when_finished "rm -rf expected err" &&
> +       echo "error: key '\'foo\'' not found" >expected &&
> +       test_must_fail git repo info foo 2>err &&
> +       test_cmp expected err
> +'
> +
> +test_expect_success "only one value is returned if the same key is reque=
sted twice" '

This test title can be single-quoted rather than double-quoted.

> +       test_when_finished "rm -f expected_key expected_value actual_key =
actual_value output" &&
> +       echo "references.format" >expected_key &&
> +       git rev-parse --show-ref-format >expected_value &&
> +       git repo info references.format references.format >output &&
> +       cut -d "=3D" -f 1 <output >actual_key &&
> +       cut -d "=3D" -f 2 <output >actual_value &&
> +        test_cmp expected_key actual_key &&
> +        test_cmp expected_value actual_value
> +'

As above, it seems that this could be simplified by crafting the
expected state more precisely rather than slicing and dicing the
actual output. Perhaps something like this?

    val=3D$(git rev-parse --show-ref-format) &&
    echo "references.format=3D$val" >expect &&
    git repo info references.format references.format >actual &&
    test_cmp expect actual

Aside from the above tests, based upon the implementation, I also
expected to find a test checking that the command correctly outputs
multiple values, but perhaps a later patch adds that since, presently,
the implementation only knows "references.format" (thus with
deduplication, you can't yet implement such a test).
