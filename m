Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE246372B2C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863845; cv=pass; b=O3JzEVZ2dJYWtE+e7+8p9CAgbcp5NLQDYK6hvygUA1nQgiJevosoXMiOsTt7bd+xcmkQQBj5wn3vHED0WXQtT/l1oy0//JxY2LiijQuKKvR/hHPmz//zFUfJM/iud26ovBHOb8s7gI1LbvelpwRcj6Kh/xIWhqx/82uPD+a2lSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863845; c=relaxed/simple;
	bh=H1bBAibpg66BRUZOQGdLvGrh8H/GCVdwtbnfFtH2D5A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoUjutS/NDmFER8l3k9fpOOfeT4SnL3UfsfIR+gdpVRHZbhy341KhjQVcZfWJLFJME/0eStrp+3YJB9SDLP+B2jVsflcbss7Ptqo9Hy0rpCqo43iGh7YWNfih1q8W8wTJYgbMMEO46+jlcGBk+76ChdkNzWFOZXKMKZZrSu5UYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2IYoA5n; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2IYoA5n"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56d36e7d8e6so2765171e0c.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 02:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774863843; cv=none;
        d=google.com; s=arc-20240605;
        b=ROvR/i9rTS9MUHmxm0iJaZ+yxxCQlb8CuoQwn/4Ldlj+NtA+54XrcwtzRH3vIXyj8h
         +Hc5qgA60fySslni8zpiUPwf8GrQlIlRkQQ20r4f90gexfly2d+HTNEJ0DLvDDy0ymX7
         okbgFtcvgXPpKKtMkSgC5ttMJtXBq4D3jmEh2kiciwz5FYbdVkLKxjcdr7Bhyl8OkH50
         yFsgSHeE9TlrGZRF3nQTBYh9UbdZkHsmyHnmZUMFS/g8DJdbCF7o8E2OBKf79aLqUYRO
         khsho3lNJL6k7vuuIEQcyCPbbX9popfoU0eoVf7HL7CFmwiWNnqTDI7CAmTVjBfOS/sH
         fA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gAuwwh4Wjxw+/Xm3oMUeVi/MX05iGzfwLtguREK3chw=;
        fh=EcxhL+klDDOSQlr57SuUBOFA7N8vKylW55rybY709cA=;
        b=lg5n072s5gQEdtqMRqAKOeP8MdzSufQs58glr+dPHRGZq5f1LnycEg05mUlj+wAB3P
         /GYTkq1NLoyv+htlurjahpl78Uq3TaGQSbEEorXvK3i4ktcfJYw22GJZsv0yG66J3Hai
         7/aSDVgFYh2liMyR8xopfDoTUbDH8uDtmYc+GvwNSTQKH/rZGzUlh/wNx2JaOUlxA7Oe
         5LSg1XR5HgG2SNDcmhBTTzJsNYneN8DHmONp1oeBJx6hp7R4PFdZeh4sdRv6rhZ+aWGg
         cuozEWMZWfl53UKm6VU3fua+M8JUZ2KIP68DxhU82xIWxx7ttp8BUHmRonDQ6abCjK/G
         ur6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774863843; x=1775468643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gAuwwh4Wjxw+/Xm3oMUeVi/MX05iGzfwLtguREK3chw=;
        b=Q2IYoA5nQMtRjGz4/qjRQddIobQRO+VOquUaa1nBpbF8oKNuDPf/DcWCWo4inTacDG
         jXBPPO2rczt7MT4VREpdqSYrkSdsgGDeMcep0JyieWbA0ZxdOKh1rtvNe9hyDhH3qA7V
         kaZP8XGOlUtqgc1Bzg+dAdgerZB9dbei3La/wJxKSXuApH41sRl9JxSLLDUbwaAakVTf
         x2w5wElIEzuvbAY2+uHwCE7DkbRa9m6qpB4Mm7irlHTmWwYxG8C6NK4tqc7PsLIH7WMN
         XvPthoTZiUOXRpft8ZzJ9UBduQKOfIy6S5jRhaKVXBFSJ2qkIXglsY8w90KUMTljOvso
         Xcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774863843; x=1775468643;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAuwwh4Wjxw+/Xm3oMUeVi/MX05iGzfwLtguREK3chw=;
        b=XZ98TurcgdQsKxZFnPwHtLtIWlCHg4dBUpb7wdjryznuMCivERIWfPXgsau0o1zyOt
         3WbqWp/98U3UTAGXqrNovnEcdZo5h+s2exAWEg8suHzDO3W5py4YjtL4m2O6CuyFih32
         06Yq6zMhDO26ZV5jaIGQGqxcpc++r4NI51OjxtJL2OzeJvR0klSjM11qO0XdfIxt40U7
         dXg13+ushrqwSbZVZ/bf+VCwzx/U6Ig9SlyiO9csaJEQM7qwl+k8TETxLT8vE+yRWAZt
         kmbLHLgx3PB0yPm69Ni27AAiv3HhafG9xF6othSmkcsNTJFLnahDvNlFoEdx/7zYtnZC
         4tJg==
X-Forwarded-Encrypted: i=1; AJvYcCVRxUu3XJs19BXzot3aRcRyG9fzuY+WmSdELpwMoM+K7ha9SqnoLL7dxYWmBoztrJpg9mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAypL9mTWYu+j6NPZo/XwEKzwYdzswr2coWiiXK11/gGPHpa8
	7XvN2ZixJlsYc1oD+aShXsYg3gsz6lO7XNHrybnlb39Q28mcl4v+Rs90QG24tK6DMe5h+ZWTQkm
	py3j7mYO+kNH5d8mTlLVtrM2SZTsmY0IxCw==
X-Gm-Gg: ATEYQzwOc2fiuxD+Qr/zKqJ1QfKz6EE1D7qMELhXfMTr6iUo318WoS3sTtGdnlWiBPP
	In5rKwfY4tYY9ibtBUGMpTngUKhNMiEOhlXQpm1koH2Q3FMpoS/XnwkQHBhLxWU0kVEyIU1+1Ur
	ziSVVrLxegpmdRHHHoM/MHmWTYByurL4HvEBmAElJcoL6AaCQr53IJWDqoruAMthn/EInDRfLKv
	mmkh3CgMY1de4nGJWqCfMk+l4EmfqWuDXXvWwXb6nY95X/vuaDVsuPpP/5KySAOAcxGPxbvF0Tw
	KkFDrnliRhP6QAvYdK9Xg4XdfmqIACcVtEwv1ZG9io3lGQyn4naN
X-Received: by 2002:a05:6122:e144:b0:56d:31e1:2c9c with SMTP id
 71dfb90a1353d-56d4a4d217fmr4637917e0c.3.1774863842753; Mon, 30 Mar 2026
 02:44:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:44:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:44:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260329082808.12609-2-siddharthasthana31@gmail.com>
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-1-siddharthasthana31@gmail.com> <20260329082808.12609-2-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Mar 2026 02:44:01 -0700
X-Gm-Features: AQROBzCWyqipJChJ2VSvlyg_HawNXwtBkCkYtL6RFyn-u73chfwPzDiKYT70vow
Message-ID: <CAOLa=ZTqk3rG21e5H5HLDCw6MWK2ndgi=4pC0ZUWn98z39SSEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to --batch-command
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, gitster@pobox.com, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000df6f1c064e3ab089"

--000000000000df6f1c064e3ab089
Content-Type: text/plain; charset="UTF-8"

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
> but this option needs to be set when the process is created. This means
> we cannot change this option mid-operation.
>
> At GitLab, Gitaly caches git-cat-file processes and it would be useful
> if --batch-command supported toggling mailmap dynamically with existing
> processes.
>
> Add a `mailmap` subcommand to --batch-command that takes a single
> argument: `yes` to enable mailmap and `no` to disable it. When enabled,
> mailmap data is loaded from disk on first use and kept in memory so that
> toggling back on does not require reloading.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
> CI: https://gitlab.com/gitlab-org/git/-/pipelines/2416081861
>
>  Documentation/git-cat-file.adoc |  7 +++++
>  builtin/cat-file.c              | 30 ++++++++++++++++++---
>  t/t4203-mailmap.sh              | 48 +++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index c139f55a16..af32e929a8 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -174,6 +174,13 @@ flush::
>  	since the beginning or since the last flush was issued. When `--buffer`
>  	is used, no output will come until a `flush` is issued. When `--buffer`
>  	is not used, commands are flushed each time without issuing `flush`.
> +
> +mailmap <yes|no>::
> +	Enable or disable mailmap for subsequent `contents` and `info`
> +	commands. When `yes` is given, mailmap data is loaded from disk on

Are there any commands that the mailmap wouldn't apply to? Would it make
sense to simply say

      Enable or disable mailmap for subsequent commands.

also we can s/is given//.

> +	first use and kept in memory; passing `yes` again does not reload it.
> +	When `no` is given, mailmap is disabled but the data stays in memory
> +	so that a later `mailmap yes` does not need to reload it from disk.

I think the first sentense here jumps directly into the the caching
mechanism on using `yes`. It's more important for users to know what
`yes` implies. So perhaps:

    When `yes` mailmap data is used and disabled on `no`. The first
    `yes` caches the mailmap data until the command exits.

>  --
>  +
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b6f12f41d6..a53926d2bb 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -54,6 +54,7 @@ static const char *force_path;
>
>  static struct string_list mailmap = STRING_LIST_INIT_NODUP;
>  static int use_mailmap;
> +static int mailmap_loaded;
>

Nit: should we use a 'bool' here?

So we use a variable and not simple rely on checking `mailmap.nr`
because it is possible that we do load the mailmap but there are no
entries. I assume we could rely on `maimap.cmp` being non-NULL, but
that's getting into implementation details.

>  static char *replace_idents_using_mailmap(char *, size_t *);
>
> @@ -692,6 +693,24 @@ static void parse_cmd_info(struct batch_options *opt,
>  	batch_one_object(line, output, opt, data);
>  }
>
> +static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
> +			      const char *line,
> +			      struct strbuf *output UNUSED,
> +			      struct expand_data *data UNUSED)
> +{
> +	if (!strcmp(line, "yes")) {
> +		if (!mailmap_loaded) {
> +			read_mailmap(the_repository, &mailmap);
> +			mailmap_loaded = 1;
> +		}
> +		use_mailmap = 1;
> +	} else if (!strcmp(line, "no")) {
> +		use_mailmap = 0;
> +	} else {
> +		die(_("mailmap: unknown argument '%s', expected 'yes' or 'no'"), line);
> +	}
> +}
> +
>  static void dispatch_calls(struct batch_options *opt,
>  		struct strbuf *output,
>  		struct expand_data *data,
> @@ -725,9 +744,10 @@ static const struct parse_cmd {
>  	parse_cmd_fn_t fn;
>  	unsigned takes_args;
>  } commands[] = {
> -	{ "contents", parse_cmd_contents, 1},
> -	{ "info", parse_cmd_info, 1},
> -	{ "flush", NULL, 0},
> +	{ "contents", parse_cmd_contents, 1 },
> +	{ "info", parse_cmd_info, 1 },
> +	{ "flush", NULL, 0 },
> +	{ "mailmap", parse_cmd_mailmap, 1 },
>  };
>
>  static void batch_objects_command(struct batch_options *opt,
> @@ -1127,8 +1147,10 @@ int cmd_cat_file(int argc,
>  	opt_cw = (opt == 'c' || opt == 'w');
>  	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
>
> -	if (use_mailmap)
> +	if (use_mailmap) {
>  		read_mailmap(the_repository, &mailmap);
> +		mailmap_loaded = 1;
> +	}
>

The rest of the code looks good.

>  	switch (batch.objects_filter.choice) {
>  	case LOFC_DISABLED:
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 74b7ddccb2..f66637cd86 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -1133,6 +1133,54 @@ test_expect_success 'git cat-file --batch-command returns correct size with --us
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'git cat-file --batch-command mailmap yes enables mailmap mid-stream' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	commit_sha=$(git rev-parse HEAD) &&
> +	git cat-file commit HEAD >commit_no_mailmap.out &&
> +	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
> +	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
> +	size_mailmap=$(wc -c <commit_mailmap.out) &&
> +	printf "info HEAD\nmailmap yes\ninfo HEAD\n" | git cat-file --batch-command >actual &&
> +	echo $commit_sha commit $size_no_mailmap >expect &&
> +	echo $commit_sha commit $size_mailmap >>expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-command mailmap no disables mailmap mid-stream' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	commit_sha=$(git rev-parse HEAD) &&
> +	git cat-file commit HEAD >commit_no_mailmap.out &&
> +	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
> +	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
> +	size_mailmap=$(wc -c <commit_mailmap.out) &&
> +	printf "mailmap yes\ninfo HEAD\nmailmap no\ninfo HEAD\n" | git cat-file --batch-command >actual &&
> +	echo $commit_sha commit $size_mailmap >expect &&
> +	echo $commit_sha commit $size_no_mailmap >>expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-command mailmap works in --buffer mode' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	commit_sha=$(git rev-parse HEAD) &&
> +	git cat-file commit HEAD >commit_no_mailmap.out &&
> +	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
> +	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
> +	size_mailmap=$(wc -c <commit_mailmap.out) &&
> +	printf "mailmap yes\ninfo HEAD\nmailmap no\ninfo HEAD\nflush\n" | git cat-file --batch-command --buffer >actual &&
> +	echo $commit_sha commit $size_mailmap >expect &&
> +	echo $commit_sha commit $size_no_mailmap >>expect &&
> +	test_cmp expect actual
> +'

Shouldn't we also add tests for how this interacts with '--mailmap' and
'--no-mailmap'?

>  test_expect_success 'git cat-file --mailmap works with different author and committer' '
>  	test_when_finished "rm .mailmap" &&
>  	cat >.mailmap <<-\EOF &&
> --
> 2.51.0

--000000000000df6f1c064e3ab089
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a4fd529c0909129a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uS1JlQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1BFQy85eGNWT2tabHpYTmcvQUwwQlM1dHliZ3pqbApweVE0c3k1U1FB
ZWpPOTV5cDBNL2RDN2RSOHFXeTdOaG1FOHczcmIxeDU5eDNOak9OSGpwTEhuem5BaDVDb1UwCnFE
aWNxa1ZBb1QrRDRQZTB4TkxjUU5KUVBBTU9WWEM2VDNleW5ydFU4NWJHbGJhc3hZc1p1SHNJKzBF
Vm1xTGMKT3c3VG8wc2JBQXJZSHpiVzh2Kzl6SWRiY25LbjRTMWNjWDdhMHZUTDU0OFdCWXM1NjlT
YncyOWdZWDBnd2d0TwpaeHBLNDNxeVhXbTN5U2p4UHZCWlZXSnhjWXBnaytWQ003Tnk0Zk5XVTJZ
YXczbEVLMWNLSHAvUnlPUHdWZHAwCk5BV0dkbVAyYlNCZkRMVmNlclFYUXc5ZjlNeHBFWENPZHNT
aWFkbVNZZmpneVJTSHR1V1hRNDhseCttOUI0Qm4KWnQyZGMvTDRQbXZjM0FicTBqZVc2RlpBcHd5
RHR4VmxWdzlJMU1sb0ZMcTBwV3JvSi9OL0tzbWV4SnpqMFU3cApodmdFUUJibi9NNy9xNm5ock9E
SmJ3ZWtqK0RkalE4bWVDUEFyT0NMN09hSnU5N1JlT296dUlGcWE3eEJMa2R3CnluMEk4cEpKcm5L
MjdQVXRBdS9YWmdPZ0lXeGV6Q2RiSG9JRkFUZz0KPU1Ca0kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000df6f1c064e3ab089--
