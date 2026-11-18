Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023311;
	b=3kCY8jSnuH+vrhgxSpMHqSLZE3AbeKCIEHipVxUQ9lqnxlEktzI/UyaaQu5+vYjzyEw0
	 5k9vxQz0CYkGLtmQdtMprZDjuuxhO8Ec55aHZ31vqUq5oXHOzPb08fJv/TfnE/0dDeyep
	 FcTwkzQpe7i+ystV3ynmlRmE4tsaofwkdOZjuzzLq1E3M4dY1SLBSL6ep843Vm2KSOE5R
	 sEYz8OZyH8ccaC5BygV2uUqdO3ZwIATG31e7bgBCGsTB02M9KMVaSHmm8risO8H/idsHR
	 YE4oDjk5MpdJuz+4kjyUq1oKaB8UGwGQUPL73jdLTScA2ZqH7+UhCh9UhwEc+jOncZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2JMQiFLlA83psVc7TRv3VoxsezfNqATy/fW0tigNZ/E=;
	b=WUrij6FZnUWAImj8oIbiHyBwBXPdgwOCJlrQ1D0goQIf+6Hbw0R4WWsrRAMJzcsrS3Pz
	 Zich6iDmYUkHMyK2yIZJbCzld1+zCun8aw6KhFSCy1YHte/9j4dbFk1jRZlPf55gcmyhV
	 PWHYBwWs3urea8X5hWDu3NF2gmt5hdSwLE9jywonrC9y549I90bF4ZBleGYOa5saOy+Ys
	 xkb5IJN7UWYGFkR2oFu7C0uZNqHqaaxkEuerInxSVmQmamOePKRhJbdCLY9fN2Ee5TDRq
	 pD9mGOIq34eGrBeXHqhfOihsOD4K7W/aWEZPiyhZMH3bsejZ91Z/6aUqzBwYBnz7xdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V7jgXTWT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C1606A331
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 17:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F3C1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V7jgXTWT
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so1955536c88.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:35:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795023310; cv=none;
        d=google.com; s=arc-20260327;
        b=ExKWDVOa51leMVpNRYd9HxTEXtqf8WqQucmSn9OCBVFQEptyZ0V6OtcmcB47jPn/rx
         peGE2Ph22Nx5J6kHFGgJnxjnvgLsvi59dFWEYxFPTLS+QxdBjbdYzJdBn/a8gsI0bjEC
         ye3VzcGg6uLQbP2lMcs6pGu58NH0RZ2cv43/q3debdk+rkaGGpEXbXtamk6/wIbV1+G9
         VTrxyXVNSvpxNvi7v2EviaxQjGYd9QOEpYnMwus2MmVHZCYqG76jtwy1OCEMYWTgfVa5
         ICc4C/Z4jlHAh9BMsv9QLNF9GukuockBtFMsC2vlPihT1FqicflGrrdrTY0TK0lOZw7m
         8jWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2JMQiFLlA83psVc7TRv3VoxsezfNqATy/fW0tigNZ/E=;
        fh=XhrkE/43V8t+PRT51BaZzfmatDRqywpwBCpxYwtL3QU=;
        b=I21OSiwOgFJIUCT7D/xAiSNk1jdQOeZQmy452FhNINazLOyPT0Ig2glYeYEAQwY/dO
         Q0pGTNjvzhIr+Sg0zvdRiwkUOBAQGWgv5GO+nSQEh2tmRpjD2xAOa8ao53FFYGrJerFP
         6aoDqU5Vv/J6UFFA1XxTO1xEuGDeUnR8/y8tKL4czHkSuQ0LkkkzXcwSdsoOM8h1GRZi
         bn7nkmwBLasu3L+4tmA0NLflHs12di6xXaynGz8Uy/jUwsyqBt3UgIBQigXle+mop80N
         Vrz6gbeGKZMoSw9I0RjnRw0pNT4L3E6VD4MDRAnxqFmU4aCJ5chpKfMvok2obIHUmKoW
         d9FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795023310; x=1795628110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2JMQiFLlA83psVc7TRv3VoxsezfNqATy/fW0tigNZ/E=;
        b=V7jgXTWTcFbQqT65s/XbPfe/D4WRb6kzJcMFJfg7MNta7vliBaddJ4V0owE0Psc7H3
         35J9CXh6Cmd2Qv0xUO4IdneFCtREVyVST5acE+VV5y6EWc38TQoTcY68G/Pb1BTe7iaJ
         A8CryArXyIxwWwcCDskOC5nktEllVFA/Sh+G/y0KT2PQ8wCChVL33eASJfgNvxYb+1Fd
         6oBeYBkajcdp244QtCdX+OkjIPlHj7c/Vk/q2oM6U812tjp3vLcmX5jOycPt7CQvsj7P
         0clr900/u4wJc2Ikfw9Dgb2pl4p9uYvU/1C/6gmvUfVNpu3IpHTvyobSyHg0bpJzazDo
         0Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795023310; x=1795628110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JMQiFLlA83psVc7TRv3VoxsezfNqATy/fW0tigNZ/E=;
        b=dJwixehHiIWMFHtgZ9dd/aT2vcU2oMf8B/QBGyIZYhuSkUktfbAYGWzBpxHJEmmyhx
         9bYPXSF4m2mDScO5SMtZlexclKdtUBMhgsb/p9NkfD947jV7NhTCN4vxKcjDs29RWV6k
         i2pIe93lXE8iczL1aQlLjdwky09aO3ZMVgjI2mlr0SjQ3xfnAQX1S6K01AgFFrdInYQy
         cwSyBWt/eUa45v1Y+EkPbtMPEyb0+JvRQD/kXGJXdO2CH/JcbavAKCP1AV/5WBiD8OUh
         bIUFq32IKEBnx5lG8giRhDxmaRrwQQtS8yQGqhzCzDS7YNieBhkuCX4f7yDwOjufMCMl
         d82A==
X-Gm-Message-State: APuU4Z/J1KQUp4h+IKDmUDgrpCCdA7wPfLadqtMuW6iCNFZe+w57aIn7
	dg3edYamwKyu4qe6feP40eA2FH2mloU2JuQPg/3o4zxoYw5w0rIjUnUlDAHkg5Afkg6OfydctKH
	ZIxB8tPe9mTMfY0t3F8Zkl1K1FZUTAQWAx3EmNx4=
X-Gm-Gg: AYBFou32t3al4Kvx69DBB6ivqstd+Be40eXVYRA8fFEcTWU2ibOJ+Jmf4cNrYYsMVes
	Iqu91WwN8l1Rqai6mfSEriXu1uOYWbmNynqKXsopHh8JynBqV4/gz7i5ITqLkEme7cRbowCRJXy
	sqElxk3ufAvnYHi9RVC6h78+cvRr8rs0fI4J0JFn2+hki+zln69nUCOji3bp9nDIm7VZVejNXrV
	FS7i40qv53mpPZs29VDr21IfUEfUDl1L9OKxkvqXlfpqLRHBvhmBtzIKYOHigOsTSKEtk7E2D8I
	+hbcFrQ2EmB97ob0D0kgsKMUKaitVNIK9wL/3jY8YF+20uoiVyt9eAB2N/mpIjfF6yYk4e2cGW9
	mRfzR73WjpcC5QAw2szkQ65O4HBvUwKVCt8ucBmlf+Zf2DB7O6rEWUIhRyFiQjHdg4XWqzWZrxp
	cnTLm6o23efB/wd9dt7h3lak99e19t30ylMxwKj+PlmtY+IfJbJ09rgMuv9liQMSKWT/60F5Ekg
	HPqzf8lTKcPB6ej1CNKJTke
X-Received: by 2002:a05:7022:f90b:b0:1b0:166c:6a94 with SMTP id
 a92af1059eb24-1b543d11160mr2777752c88.28.1795023309405; Wed, 18 Nov 2026
 09:35:09 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-b4-repo-structure-concern-v5-0-2d8f37b70b75@fastmail.com>
 <20261102-b4-repo-structure-concern-v5-1-2d8f37b70b75@fastmail.com>
In-Reply-To: <20261102-b4-repo-structure-concern-v5-1-2d8f37b70b75@fastmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 18 Nov 2026 18:34:57 +0100
X-Gm-Features: AclHuK98-mn7qRMzUxq9uOBdW7AkcDI2uTocJKWj6QnKJeIBBKcdtRVLSSuXT-k
Message-ID: <CAP8UFD2rmfaSrNJsBcSyWPJiPneFrJyXxT5KtJUWz-SNU8=8SQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] repo: add level of concern reporting
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 9:52=E2=80=AFPM Mark C. Chu-Carroll
<markchucarroll@fastmail.com> wrote:
>
> "git repo structure" computes a set of statistics
> that are useful for diagnosing performance issues in
> a git repository. But for a typical user who hasn't
> encountered any issues yet, it can be difficult to
> interpret the data - when should a value be considered
> concerning?
>
> Add a new option to "git repo structure" which causes it
> to generate an additional column providing a level of concern
> for many values.
>
> To select defaults for the thresholds where a value becomes concern,
> a (hopefully) representative selection of repositories were analyzed.
> Based on empirical exploration of the data, the measurement that seemed
> closest to accurately assessing when a repository's structure becomes
> concerning was based on the base 2 logarithm of the value. Across all of
> the sample repositories, for all of the measurements, the point at which
> things become problematic was when a base 2 logarithm of a value was
> more than 1 standard deviation from the mean of the log_2 values in
> the sample set.
>
> Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
> ---
>  Documentation/git-repo.adoc |  16 +-
>  builtin/repo.c              | 419 ++++++++++++++++++++++++++++++++++++++=
++----
>  t/t1901-repo-structure.sh   |   1 -
>  3 files changed, 397 insertions(+), 39 deletions(-)
>
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index ed7d80c690..f186b27d87 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [synopsis]
>  git repo info [--format=3D(lines|nul) | -z] [--all | <key>...]
>  git repo info --keys [--format=3D(lines|nul) | -z]
> -git repo structure [--format=3D(table|lines|nul) | -z]
> +git repo structure [--format=3D(table|lines|nul) | -z] [--[no-]concern]
>
>  DESCRIPTION
>  -----------
> @@ -56,7 +56,7 @@ supported:
>  `nul`:::
>         Similar to `lines`, but using a _NUL_ character after each value.
>
> -`structure [--format=3D(table|lines|nul) | -z]`::
> +`structure [--format=3D(table|lines|nul) | -z] [--[no-]concern]`::
>         Retrieve statistics about the current repository structure. The
>         following kinds of information are reported:
>  +
> @@ -88,6 +88,18 @@ supported:
>         quoted.
>  +
>  `-z` is an alias for `--format=3Dnul`.
> ++
> +To make it easier to know when one of the values is something that
> +users should be concerned about, adding '--concern' will provide a
> +level of concern to be added to the output. In 'table' mode, this will
> +be a table column indicating the level of concern as a number of stars;
> +in `lines` or `nul` mode, a `concern_level` line will be added for each
> +statistic with a numeric value.
> ++
> +The level of concern for each statistic is computed using the log_2 of t=
he
> +statistic value. The value is considered concerning if it exceeds a heur=
istically
> +chosen threshold value; the degree of concern is the difference between =
the
> +log_2 of the value, and the log_2 of the corresponding threshold.
>
>  INFO KEYS
>  ---------
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f83f..7a50605779 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,7 +1,9 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>
> +#include "git-compat-util.h"
>  #include "builtin.h"
>  #include "commit.h"
> +#include "config.h"

This may be only needed by the second patch.

>  #include "environment.h"
>  #include "hash.h"
>  #include "hex.h"
> @@ -21,13 +23,16 @@
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "utf8.h"
> +#include "wrapper.h"
>
>  #define REPO_INFO_USAGE \
>         "git repo info [--format=3D(lines|nul) | -z] [--all | <key>...]",=
 \
>         "git repo info --keys [--format=3D(lines|nul) | -z]"
>
>  #define REPO_STRUCTURE_USAGE \
> -       "git repo structure [--format=3D(table|lines|nul) | -z]"
> +       "git repo structure [--format=3D(table|lines|nul) | -z] [--[no-]c=
oncern]"
> +
> +#define REPO_STRUCTURE_CONFIG_PREFIX "repo.concern."

The above constants could be defined like the following:

static const char rs_config_prefix[] =3D "repo.concern.";

This improves type checking and debugging. Also as the constants are
internal to this file, I don't think it's worth spelling out
"REPO_STRUCTURE" in their names.

>  static const char *const repo_usage[] =3D {
>         REPO_INFO_USAGE,
> @@ -348,8 +353,93 @@ struct stats_table {
>         int name_col_width;
>         int value_col_width;
>         int unit_col_width;
> +       size_t max_concern_value;
> +};
> +
> +/*
> + * For computing level of concern about a stat, we need to have some
> + * baseline values. For each of these, we define a minimum level
> + * of concern, which will appear as 1 star. Then we scale exponentially:
> + * each time that value doubles, we add another star.
> + *
> + * The threshold values for concern are expressed as log_2 values of the=
 size
> + * at which the statistic becomes concerning. The default values for the
> + * threshold were selected based on observed values from a collection of
> + * representative-ish repositories of varying size, by finding the mean =
log_2
> + * value and standard deviation (sigma) for each statistic over the coll=
ection.
> + * The threshold for each metric is then set at mean(log_2) + sigma.
> + */
> +struct concern_stat_threshold {
> +       const char *name;
> +       size_t threshold;
>  };
>
> +#define CONCERN_STAT_COMMIT_COUNT "commit-count"
> +#define CONCERN_STAT_TREE_COUNT "tree-count"
> +#define CONCERN_STAT_BLOB_COUNT "blob-count"
> +#define CONCERN_STAT_TAG_COUNT "tag-count"
> +#define CONCERN_STAT_COMMIT_SIZE "commit-size"
> +#define CONCERN_STAT_TREE_SIZE "tree-size"
> +#define CONCERN_STAT_BLOB_SIZE "blob-size"
> +#define CONCERN_STAT_TAG_SIZE "tag-size"
> +#define CONCERN_STAT_COMMIT_LARGEST "commit-largest"
> +#define CONCERN_STAT_TREE_LARGEST "tree-largest"
> +#define CONCERN_STAT_BLOB_LARGEST "blob-largest"
> +#define CONCERN_STAT_TAG_LARGEST "tag-largest"
> +#define CONCERN_STAT_COMMIT_INFLATED_SIZE "commit-inflated-size"
> +#define CONCERN_STAT_TREE_INFLATED_SIZE "tree-inflated-size"
> +#define CONCERN_STAT_BLOB_INFLATED_SIZE "blob-inflated-size"
> +#define CONCERN_STAT_TAG_INFLATED_SIZE "tag-inflated-size"

Same comment as above about using something for example like:

static const char concern_tag_inflated_size[] =3D "tag-inflated-size";

> +static struct concern_stat_threshold repo_structure_concern_thresholds[]=
 =3D {
> +       { .name =3D CONCERN_STAT_COMMIT_COUNT, .threshold =3D 19 },
> +       { .name =3D CONCERN_STAT_TREE_COUNT, .threshold =3D 21 },
> +       { .name =3D CONCERN_STAT_BLOB_COUNT, .threshold =3D 22 },
> +       { .name =3D CONCERN_STAT_TAG_COUNT, .threshold =3D 15 },
> +       { .name =3D CONCERN_STAT_COMMIT_SIZE, .threshold =3D 28 },
> +       { .name =3D CONCERN_STAT_TREE_SIZE, .threshold =3D 27 },
> +       { .name =3D CONCERN_STAT_BLOB_SIZE, .threshold =3D 36 },
> +       { .name =3D CONCERN_STAT_TAG_SIZE, .threshold =3D 18 },
> +       { .name =3D CONCERN_STAT_COMMIT_LARGEST, .threshold =3D 18  },
> +       { .name =3D CONCERN_STAT_TREE_LARGEST, .threshold =3D 18 },
> +       { .name =3D CONCERN_STAT_BLOB_LARGEST, .threshold =3D 26 },
> +       { .name =3D CONCERN_STAT_TAG_LARGEST, .threshold =3D  15 },
> +       { .name =3D CONCERN_STAT_COMMIT_INFLATED_SIZE, .threshold =3D 28 =
},
> +       { .name =3D CONCERN_STAT_TREE_INFLATED_SIZE, .threshold =3D 32 },
> +       { .name =3D CONCERN_STAT_BLOB_INFLATED_SIZE, .threshold =3D 34 },
> +       { .name =3D CONCERN_STAT_TAG_INFLATED_SIZE, .threshold =3D 25 },
> +       { 0 }
> +};

Actually it might be better to use enums like for example:

enum concern_stat {
       CONCERN_COMMIT_COUNT =3D 0,
       CONCERN_TREE_COUNT,
       ...
       CONCERN_TAG_INFLATED_SIZE,
       CONCERN_STAT_NR
};

static const char *concern_stat_names[CONCERN_STAT_NR] =3D {
       [CONCERN_COMMIT_COUNT] =3D "commit-count",
       [CONCERN_TREE_COUNT] =3D "tree-count",
       ...
       [CONCERN_TAG_INFLATED_SIZE] =3D "tag-inflated-size",
};

static const size_t default_concern_thresholds[CONCERN_STAT_NR] =3D {
       [CONCERN_COMMIT_COUNT] =3D 19,
       [CONCERN_TREE_COUNT] =3D 21,
       ...
       [CONCERN_TAG_INFLATED_SIZE] =3D 25,
};

struct concern_thresholds {
       size_t log2[CONCERN_STAT_NR];
};

See `enum color_branch` and the following related definitions in
"builtin/branch.c" for example.

> +static int get_concern_threshold(const char *name, struct concern_stat_t=
hreshold *thresholds)

I think this should return a `size_t` as `thresholds[i].threshold` is a `si=
ze_t`

> +{
> +       for (size_t i =3D 0; thresholds[i].name; i++) {
> +               if (!strcmp(thresholds[i].name, name))
> +                       return thresholds[i].threshold;
> +       }
> +       return -1;

We could just BUG() here instead of doing so in the caller.

> +}
> +
> +static int repo_structure_concern_level(const char *concern_name,
> +                                       size_t value,
> +                                       struct concern_stat_threshold *th=
resholds,
> +                                       bool show_concern)

This function could also return a `size_t` instead of an `int` as it
never returns a negative value.

> +{
> +       if (show_concern) {
> +               size_t log_value;
> +               const int threshold =3D get_concern_threshold(concern_nam=
e, thresholds);
> +               if (threshold < 0)
> +                       BUG("unexpected repository stat threshold: '%s'",=
 concern_name);
> +               log_value =3D (size_t)log2u(value);
> +               if (log_value > (size_t)threshold)
> +                       return log_value - threshold;
> +               else
> +                       return 0;
> +       } else {
> +               return 0;
> +       }
> +}

[...]

> +/*
> + * Define a symbol for 'no concern value for this stat'; this will
> + * make the code below easier to read.
> + */
> +#define CONCERN_STAT_VALUE_NONE 0

This could also be for example:

static const size_t concern_value_none =3D 0;
