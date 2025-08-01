Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6520C00E
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081970; cv=none; b=u3G01hIDvaxFFBlEKItPTjlOz9cAJJIkMGp4Yzt1rkUwznthCb57EWzJnw6GmlEH6MncIewnL1oUhqvEXHXObFQAsfZkSDvlRk74oL/H8142wFFQPJghci8Fm+xLVxfLi1Bv4UYmG/E8MpBH+Nt+53MHD5xPwS7Ytnl6Oz679co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081970; c=relaxed/simple;
	bh=Nul5lzLWH1zxQr8Hxn4THhKn6DylpIxLBgFaeUmphD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QF70XAfy63cHG46nouM6mfFuykVJCJVepUFb5C6ux8p/XpNt9AvOv1jm/fbe5qTYAT9HSCAJfsskHOxS8ghF0C6FkL4MDlPQdrxZkbwQn5EMBQirL1qexG2qEHqvmhu1J1z6KKXYifiOJWSY5tLOZ1fs+Zf7VWE/+hPysa0l6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70739dc892bso3541416d6.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 13:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081967; x=1754686767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6CPsIzcJscv8/aOQb+8DwRh/VN4++o/eIEX38L8uO0=;
        b=NEOxWTlKA3MEz5pCPdmSaKf1LrZRH3f27o8sTmclRO28nJxw4lpLN036YUBuUf7xnO
         LxDQjzkjKU6RJlFLTTWCm0LDRHioImC8hgELT9ucnQlP1yv0MsJ0xadef1xkNLIIFVWi
         O03ZZ1VBFlqZUYtpECaQizAXZu9dGMpRsSQW8ZXzg20dOi45o3QzNcSzcN4Kttvm/mXZ
         4Igz4VNFeHfp7N1IamPClL2oGFIVSpbZJS67PMtDlXMHPiGob8wfnXr+jT/lInL6voL1
         Oq6HfibZ8ZnJnz2Ay8v4g7719W2IBXKFtFC7QIO+3xqjysd9usBBvLNoXgqAsQCVmBiK
         jdWg==
X-Gm-Message-State: AOJu0YwV44a1RqEyjj9ITHFUBmkmP0FbdEMF2o2/4vUmP+T6DsA8gNrL
	/xiImvvGTAsXkZfGMcDct1ZfZJn5vVnHGoGGkRIGC9fgRBK843zQzXXWJ+XO+ha8YUGefyEu+cT
	gs0+Lru/lNAe8LDOdLZvpNQFUO3IxNEM=
X-Gm-Gg: ASbGncvuTwwVILZkJSxqfSNb9AGXInKHfV2BFF27+OnFSufjkbSA7syzZsHAgNeIaqm
	qE/QU554hujB3NHQ/okleHXJp2tFhZSS/smIoxgwikzPx6vGGwINsDbl8p57V3RImmh5KDsIN9j
	cGjMZLQn+XtDTyneHih/T4Xu1IoFlqoVZz15nzS214ozYPQkEe1I0tGVX0pYN2NXWGgSu3heY91
	iRC7Aeog0KjOBXonp8FXZToGH4DaCD23PGOInLy
X-Google-Smtp-Source: AGHT+IETfrdayGCtQV1asRxEeDRQNyDMLbPZ3IYTANhpahrrYzLsyrPQ/PM7HCdgwCd6+pCB+Zdh2MbbZQEy9ev4pH8=
X-Received: by 2002:a05:6214:d6d:b0:709:12b6:5a8e with SMTP id
 6a1803df08f44-70936475d2cmr7855186d6.9.1754081966507; Fri, 01 Aug 2025
 13:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com> <20250801131111.8115-3-lucasseikioshiro@gmail.com>
In-Reply-To: <20250801131111.8115-3-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 1 Aug 2025 16:59:15 -0400
X-Gm-Features: Ac12FXyIB9NKo-8FWazse3rhXVre83IWSfxqsCBSQF--BEYLO0qFjkYzfeE6FaM
Message-ID: <CAPig+cTxNUPayO2SdCL-BPtjb2rfr3e3RK=BsQxAiiEAtpBaRg@mail.gmail.com>
Subject: Re: [GSoC PATCH v7 2/5] repo: add the field references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 9:11=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> This commit is part of the series that introduces the new subcommand
> git-repo-info.
> [...]
> Add a new field `references.format` to the repo-info subcommand
> containing that information.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> @@ -22,6 +22,20 @@ COMMANDS
> +In order to obtain a set of values from `git repo info`, you should prov=
ide
> +the keys that identify them. Here's a list of the available keys and the
> +values that they return:
> +
> +`references.format`::
> +The reference storage format. The valid values are:
> ++
> +include::ref-storage-format.adoc[]

In the implementation below, I see that this version of the series
passes all the printed values through quote_c_style(), which is a
welcome change, however, an equally (if not more) important change
seems to be missing. Namely, we _must_ document that values with
"funny" characters will be C-style quoted. Without such documentation,
consumers are left in the same sort of situation as they were in
without quote_c_style(); to wit, they will be surprised and their
tooling may break when they suddenly encounter a value which is
quoted.

> diff --git a/builtin/repo.c b/builtin/repo.c
> +static int print_fields(int argc, const char **argv, struct repository *=
repo)
> +{
> +       int ret =3D 0;
> +       const char *last =3D "";
> +       struct strbuf sb =3D STRBUF_INIT;
> +
> +       QSORT(argv, argc, qsort_strcmp);
> +
> +       for (int i =3D 0; i < argc; i++) {
> +               get_value_fn *get_value;
> +               const char *key =3D argv[i];
> +               char *value;
> +
> +               if (!strcmp(key, last))
> +                       continue;
> +
> +               get_value =3D get_value_fn_for_key(key);
> +
> +               if (!get_value) {
> +                       ret =3D error(_("key '%s' not found"), key);
> +                       continue;
> +               }
> +
> +               strbuf_reset(&sb);
> +               get_value(repo, &sb);
> +
> +               value =3D strbuf_detach(&sb, NULL);
> +               quote_c_style(value, &sb, NULL, 0);
> +               free(value);
> +
> +               printf("%s=3D%s\n", key, sb.buf);
> +               last =3D key;
> +       }
> +
> +       strbuf_release(&sb);
> +       return ret;
> +}

This logic leads to a poor user-experience if the user asks for the
same non-existent key multiple times since that case subverts the
deduplication logic. For instance:

    % git repo info non.existent references.format non.existent
    key 'non.existent' not found
    key 'non.existent' not found
    references.format=3Dgobbledygook

You can fix this by performing the `last` assignment earlier in the
loop prior to any other `continue` statements:

    if (!strcmp(key, last))
        continue;
    last =3D key;

    get_value =3D get_value_fn_for_key(key);
    if (!get_value) {
        ret =3D error(_("key '%s' not found"), key);
        continue;
    }

That aside, the strbuf detach/repurpose/free dance that the code does:

    value =3D strbuf_detach(&sb, NULL);
    quote_c_style(value, &sb, NULL, 0);
    free(value);

is unnecessarily confusing and difficult to fathom because it is
repurposing the strubuf and increasing the number of allocations and
deallocations for no apparent reason. You can decrease the cognitive
load simply by using two strbufs, one for each distinct purpose,
perhaps like this:

    struct strbuf valbuf =3D STRBUF_INIT;
    struct strbuf quotbuf =3D STRBUF_INIT;
    ...
    for (int i =3D 0; i < argc; i++) {
        ...
        strbuf_reset(&valbuf);
        strbuf_reset(&quotbuf);
        get_value(repo, &valbuf);
        quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
        printf("%s=3D%s\n", key, quotbuf.buf);
    }
    strbuf_release(&quotbuf);
    strbuf_release(&valbuf);

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -0,0 +1,57 @@
> +# Test whether a key-value pair is correctly returned
> +#
> +# Usage: test_repo_info <label> <init command> <key> <expected value>
> +#
> +# Arguments:
> +#   label: the label of the test
> +#   init command: a command which creates a repository named with its fi=
rst argument,
> +#      accordingly to what is being tested
> +#   key: the key of the field that is being tested
> +#   expected value: the value that the field should contain
> +test_repo_info () {
> +       label=3D$1
> +       init_command=3D$2
> +       repo_name=3D$3
> +       key=3D$4
> +       expected_value=3D$5

The function documentation (including "Usage") talks about four
arguments, but the function expects five.

I'm having trouble understanding what is meant by "repository named
with its first argument accordingly to what is being tested". Also:
s/accordingly/according/

> +       test_expect_success "$label" '
> +               eval "$init_command $repo_name" &&
> +               echo "$key=3D$expected_value" >expected &&
> +               git -C $repo_name repo info "$key" >actual &&
> +               test_cmp expected actual
> +       '
> +}
> +
> +test_expect_success 'git-repo-info outputs data even if there is an inva=
lid field' '
> +       echo "references.format=3Dfiles" >expected &&
> +       test_must_fail git repo info foo references.format bar >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'only one value is returned if the same key is reque=
sted twice' '
> +       val=3D$(git rev-parse --show-ref-format) &&
> +       echo "references.format=3D$val" >expect &&
> +       git repo info references.format references.format >actual &&
> +       test_cmp expect actual
> +'

These tests are easier to understand and are more robust in this version. G=
ood.
