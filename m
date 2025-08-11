Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928C2673BF
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889187; cv=none; b=cqsuyHdKclmzzGyRZhyA2IEY2dTmSmFZ9TQVnFi/umpDfQsUpxBmAEO+YTA6BWIEPlABBrXwqKdIacXEuIr08+lVcusravWrRmklIv7S488hCEuWmdh9wp+etkNjS5e+YhcKZ3Q6+n3VuIRW383nAMvLnSXN2C6jetIXrGkdXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889187; c=relaxed/simple;
	bh=5oTXqgZuYA6i0HfGCqyviLb4erv14wZrxKiyQJhKc1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQt2ayGoMj2KJOCiPAivMR9uKyURtpNy5DwwBeGWz+TqxxAQJn7bPjRj1OCMNcOS3tGx7n+RQvSw8Zf1zEZMp1Hi58U0ueiuHd3BFVb1xTR6nAWg1+7Vtpti9/TIFQ7LpBDygoq2EzAeaVrq41UAnonV6RWHzhTRvx27wqpj1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4af1a5aff6eso5950041cf.2
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 22:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754889183; x=1755493983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m/HQfmplf9Kh8q8XHm0FWdAo6mJBipynPIhc/gmNHU=;
        b=nkcrCnIbge5HoFlQuCH5whG4S3AS4xxwhNfZ8dWZ+Q+yfjuUROectAL1pYd//B5nrt
         JdWxntzmj28oWMXK+0o4NHOvZafvbpwpC67+vc9PydKjCuOfkFizmRaUOMmb4p19ra7V
         Fo3Nqhsko1qqbee321FWPo59JMCrV16lwHnjBuu2crDxMUOXdlth7buy9efhx/55QNpR
         CdsYMpdGjAtocRU4sO2Rz7XjRDLMnvPnf6oG1erJiKewkCKh9vGvC1ThLJeYYLjt+Mr7
         56iizncMfWbxawZ5MOJhaYgeN3LRQpxJVwiAQ9cJN0TL2LvDsKxf6QmZMf5ACuQRFjSV
         x49w==
X-Gm-Message-State: AOJu0YzSezgkqGUucIj/xwhe5EIHROrXc0W60PkmhRkHDkEBVaXZqkVU
	pClunuz8SPHxjqnDh9e5yMm3SDk+JZQQsdDhy2PpLytnqn8ehEBLKXgLuO4dGDh939vZbQdoB9B
	GT2WqpluyAMkqfogZlM88yA4cm9VAXFfdZ090
X-Gm-Gg: ASbGnctXvkSioEv6HGTVt2Ab/a1e9dY11brrHf+eKg+EV2fRp6MYiMPImFHiFMMoPcw
	6u6nTsZ3TffhkpKvJsZWf3N6uhJMesHUuLt7SOudv8Ykh7j+VhGD5pZIF8RsGRtwag7RuZSDmbb
	Je7dAvIUPwRnRoqA6XHCGOG/y8tUU8Jrb3mpBjsivnuT7GPKImpD6vW5xf70ohlz988hfprs8ST
	WkgMZegP8B43bf+wqXfu3BFUz2aD5sdPBEhUgDE
X-Google-Smtp-Source: AGHT+IHhbeH4mLePKCeBG2CpdxrSiIa6ncUyDbrsjnYqR6v37Tys0zOtibe5TgQnn37+PgMXlY7C6vOHtWUu9z+vjdc=
X-Received: by 2002:ad4:5f45:0:b0:709:8dee:52bb with SMTP id
 6a1803df08f44-709ac2fda81mr45692336d6.7.1754889183356; Sun, 10 Aug 2025
 22:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com> <20250807150239.6987-3-lucasseikioshiro@gmail.com>
In-Reply-To: <20250807150239.6987-3-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 11 Aug 2025 01:12:51 -0400
X-Gm-Features: Ac12FXwTdH0aLuAg6xsKgRXCZe3WpVyPKxrlbNrBO6ee02CXlh2LvF403bl0HRs
Message-ID: <CAPig+cTA=UKbHd+BdCQUdTjvz1AzCNHi2XTREPhfUJfz_2Ny_A@mail.gmail.com>
Subject: Re: [GSoC PATCH v9 2/5] repo: add the field references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:04=E2=80=AFAM Lucas Seiki Oshiro
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
> @@ -22,6 +22,25 @@ COMMANDS
>         Retrieve metadata-related information about the current repositor=
y. Only
>         the requested data will be returned based on their keys (see "INF=
O KEYS"
>         section below).
> ++
> +The returned data is lexicographically sorted by the keys.
> ++
> +The output format consists of key-value pairs one per line using the `=
=3D`
> +character as the delimiter between the key and the value. Values contain=
ing
> +"unusual" characters are quoted as explained for the configuration varia=
ble
> +`core.quotePath` (see linkgit:git-config[1]). This is the default.

I don't see any alternative formats presented, so what does "This is
the default" mean here?

(I'm guessing that it might gain meaning in a later patch when NUL
output format is added, but lacking such context in this patch, the
sentence is more than a bit confusing.)

> diff --git a/builtin/repo.c b/builtin/repo.c
> @@ -1,17 +1,102 @@
> +/* repo_info_fields keys should be in lexicographical order */
> +static const struct field repo_info_fields[] =3D {
> +       { "references.format", get_references_format },
> +};

The comment ought to be more assertive: s/should/must/

> +static int print_fields(int argc, const char **argv, struct repository *=
repo)
> +{
> +       struct strbuf valbuf =3D STRBUF_INIT;
> +       struct strbuf quotbuf =3D STRBUF_INIT;
> +
> +       for (int i =3D 0; i < argc; i++) {
> +               get_value_fn *get_value;
> +               const char *key =3D argv[i];
> +
> +               strbuf_reset(&valbuf);
> +               strbuf_reset(&quotbuf);
> +
> +               if (!strcmp(key, last))
> +                       continue;
> +
> +               last =3D key;
> +               get_value =3D get_value_fn_for_key(key);
> +
> +               if (!get_value) {
> +                       ret =3D error(_("key '%s' not found"), key);
> +                       continue;
> +               }
> +
> +               get_value(repo, &valbuf);
> +               quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
> +               printf("%s=3D%s\n", key, quotbuf.buf);
> +       }

Nit: To avoid unnecessary work in the two `continue` cases, I would
have placed the strbuf_reset() calls just before the call to
get_value() as illustrated in my earlier review[1]. Subjective and not
worth a reroll, though.

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -0,0 +1,57 @@
> +# Test whether a key-value pair is correctly returned
> +#
> +# Usage: test_repo_info <label> <init command> <key> <expected value>
> +#
> +# Arguments:
> +#   label: the label of the test
> +#   init_command: a command which creates a repository
> +#   repo_name: the name of the repository that will be created in init_c=
ommand
> +#   key: the key of the field that is being tested
> +#   expected_value: the value that the field should contain

The "Usage" is still wrong (as mentioned earlier[1]). It shows only
four arguments despite the function taking five.

> +test_repo_info () {
> +       label=3D$1
> +       init_command=3D$2
> +       repo_name=3D$3
> +       key=3D$4
> +       expected_value=3D$5
> +
> +       test_expect_success "$label" '
> +               eval "$init_command $repo_name" &&
> +               echo "$key=3D$expected_value" >expected &&
> +               git -C $repo_name repo info "$key" >actual &&
> +               test_cmp expected actual
> +       '
> +}
> +
> +test_repo_info 'ref format files is retrieved correctly' '
> +       git init --ref-format=3Dfiles' 'format-files' 'references.format'=
 'files'
> +
> +test_repo_info 'ref format reftable is retrieved correctly' '
> +       git init --ref-format=3Dreftable' 'format-reftable' 'references.f=
ormat' 'reftable'

The quote placement used in these calls to `test_repo_info` is still
unusual and confusing, as mentioned previously[2]. Calling the
function in the more traditional way would be preferable:

    test_repo_info 'ref format files is retrieved correctly' \
        'git init --ref-format=3Dfiles' 'format-files' 'references.format' =
'files'

> +test_expect_success 'git-repo-info fails if an invalid key is requested'=
 '
> +       echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
> +       test_must_fail git repo info foo 2>actual_err &&
> +       test_cmp expected_err actual_err
> +'
> +
> +test_expect_success 'git-repo-info outputs data even if there is an inva=
lid field' '
> +       echo "references.format=3D$(test_detect_ref_format)" >expected &&
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

In my previous review[1], I identified a problem in which the logic
would/could present a poor user-experience by emitting "key '%s' not
found" multiple times for a given unknown key, but I don't see a test
verifying that this problem has been fixed.

[1]: https://lore.kernel.org/git/CAPig+cTxNUPayO2SdCL-BPtjb2rfr3e3RK=3DBsQx=
AiiEAtpBaRg@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cR=3DvRu7GwGx_wpS_GZNdX7giosDK12K+qQ=
dOW1va-6oWw@mail.gmail.com/
