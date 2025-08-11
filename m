Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4F2D29D0
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923297; cv=none; b=Ag6HaCQoKrAeQ0Q6rs1VfO2wgSwuvjKRGeaz46UM7zymS0FJkIabrov5YRyFva8+iKDqJF/mlArDGe3wLrMjzqLKnNlySw0mykgMkgTTllk4VwuICBucn+dtUGqve5JBf3wfE8iPEhjcqnxdI4jxNPXZxvPOFkrrFlghlV53g3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923297; c=relaxed/simple;
	bh=rEtN4niaOYZIkHyh9b9wOwzCZwhuOBiqTMRtJVKiP2c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZXxoMcIane0B7dSqsOOnmaK84b7TPu4EY+Ig+7MDlqp1mx2TY7UqGGRuwKPZR2T0BlsLJyIgY0Jq+WxOthiwh+N+9WPhHYRAdOPwVZW0nsNLD4h0kI1b0hqtPc8rxS5++SM3AjI9tuC3G9zWnNgKYUxV9nm+7eMB1kaewH0OBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD05y1tF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD05y1tF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so37684025e9.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754923293; x=1755528093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jxh3iS7HJ442Wn0s6y7mXGIhXAkMopLwMgCP4rPR8v4=;
        b=WD05y1tF9AWra0AnPnm3fhzH9CT3GCIITDaZYlRw7Or/SzS7KnNsByZJSy3l1X6uDV
         zIRF1ICMZihYMjN7833jAHP31UMAEmBoHP9yL5BdQ9RbwbgWBKMRr9b5yy7E3JFcFaRi
         DiJT+RuOP8ObMGojm/XgnNpIP+iXCg0UsppEAM0ymf15PbjuzM5fhqR9n0ffucyYJQU3
         9jncaZEzIY604wm+q9+2e799AB4NgBoNLYgD/9yxncqVspLsX0eE4cDlxC6ycxY+9gIa
         NyQhVHoW1QPubcUdpHKr2ZdltgEDZfjKVQFT/0MMppA82he/cFik5meRwczjvSjIlk0A
         48XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923293; x=1755528093;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jxh3iS7HJ442Wn0s6y7mXGIhXAkMopLwMgCP4rPR8v4=;
        b=oyea9kAggsPxq4hI7BQiJFYdvnhwZucSjbeXdNfFGy7VgSLAwpAGLDQGmqi2Aez/+l
         DwVoOIGTKdwqD0cuGPQppKnO237P2zkeYlN/kbig72JvujQoy53hol7K6y5dHbEsTQ+J
         uI1RDxBsxbTWt/qCGVEf03aZgsa1B1Z9E2ZV9J3Ho/P20pVA9U7/MKdCtX8fEtwXPO2l
         qSDQD8VfeYiKgQgoQOWI6DD1ZuMcWbseAjVYvKfJmhUlavK+DFdl+0p3RD206lnBoJZV
         X9bSZXuTJrSeyusqWmdaKtj4pyGq6m2+8FitA+Wa5pWQ8beZbQx/7OKgim/4UxCdUSFV
         X9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWr90EyEQvDfE5ax/LhQB6gFlrGsXFLK2Dbv+fZauwHZWYTQqe67Nybt0/On/e/ye0V+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUWkoLgXekeRjAaBbVE0/S3ek81uLdom9jIcBYhDse3jtA+Ou
	HDlDUDJA5mma7UynE916uOmYytbRyal5q33ajjyvgTuokwPfnWFMJHZO
X-Gm-Gg: ASbGnctEvGSqU0SQh9dlKwe3n5i6+dQ5omx1Ej3+cTvCDpjueXtYaWZpJwfNEIczUz0
	/Z9jhujsodGskcOLD1fUILo6kPESZyCP0nuIRoK55ayyjodEN60MrtfC5dCVD2sZ5jd+PNdqDoQ
	NVXsvxijifmzpvUu5GsrTBqVXJPpyKKveiube1oFafimRgdv9dkWb8cNCxxOqAVCpu+CFnhiiU6
	szKz/k5a4d4PVGLj6SwInH1z/rGzZTtaoyp+PepZnJ6kbFIx+OV+2EL7y29d541uLOn4RR7pznB
	zT/4o5Ru1v5/BqKejC9Vtf86VUYn54ElfzrmmSGV4VkiZ3kH8fafpz/H41sxVGdSV2VtgxCWO4/
	k4Omu20UwqunV+9Ij7l9MR+VHw42JVjL14QtPPsDoE497C+YHZwDgsvj2b7NkM2XflWN+jvQO5X
	Sg
X-Google-Smtp-Source: AGHT+IF+PymlcLRNK4XMNMMSGxUOTurwUkwW7GQsGwk6qlzD6GkVK1BOAuiiAPtXFg3+EOqUxy697g==
X-Received: by 2002:a05:600c:4fc4:b0:458:a7fa:2120 with SMTP id 5b1f17b1804b1-459f4f2670amr110552285e9.25.1754923293126;
        Mon, 11 Aug 2025 07:41:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm280532285e9.1.2025.08.11.07.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:41:32 -0700 (PDT)
Message-ID: <f97b712f-95a4-480b-8ed0-174e4f45ff81@gmail.com>
Date: Mon, 11 Aug 2025 15:41:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC PATCH v9 2/5] repo: add the field references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de, ps@pks.im, karthik.188@gmail.com,
 ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
 jltobler@gmail.com, jn.avila@free.fr, sunshine@sunshineco.com
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-3-lucasseikioshiro@gmail.com>
Content-Language: en-US
In-Reply-To: <20250807150239.6987-3-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 07/08/2025 16:02, Lucas Seiki Oshiro wrote:
> ++
> +The returned data is lexicographically sorted by the keys.

What's the reason for this? If I query three keys from a script then it 
is much easier to parse the output if I know the keys are going to 
appear in the same order that they were on the command line. If the 
command re-orders them my script now has to check the value of each key 
which results in a bunch of unnecessary string comparisons because it 
cannot determine the key from the position in the output. While we were 
producing json output there was a need to de-duplicate the keys when 
that output format was selected. However, we no-longer produce json and 
in any case de-duplication could have been achieved without sorting the 
input keys by using a hash table, or, as there is a small fixed number 
of keys, an array that records the keys we've already seen.

Thanks

Phillip

> ++
> +The output format consists of key-value pairs one per line using the `=`
> +character as the delimiter between the key and the value. Values containing
> +"unusual" characters are quoted as explained for the configuration variable
> +`core.quotePath` (see linkgit:git-config[1]). This is the default.
> +
> +INFO KEYS
> +---------
> +
> +In order to obtain a set of values from `git repo info`, you should provide
> +the keys that identify them. Here's a list of the available keys and the
> +values that they return:
> +
> +`references.format`::
> +The reference storage format. The valid values are:
> ++
> +include::ref-storage-format.adoc[]
>   
>   SEE ALSO
>   --------
> diff --git a/builtin/repo.c b/builtin/repo.c
> index fd2a9b4216..2b7ab5875e 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,17 +1,102 @@
>   #include "builtin.h"
>   #include "parse-options.h"
> +#include "quote.h"
> +#include "refs.h"
> +#include "strbuf.h"
>   
>   static const char *const repo_usage[] = {
>   	"git repo info [<key>...]",
>   	NULL
>   };
>   
> -static int repo_info(int argc UNUSED, const char **argv UNUSED,
> -		     const char *prefix UNUSED, struct repository *repo UNUSED)
> +typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
> +
> +struct field {
> +	const char *key;
> +	get_value_fn *get_value;
> +};
> +
> +static int get_references_format(struct repository *repo, struct strbuf *buf)
>   {
> +	strbuf_addstr(buf,
> +		      ref_storage_format_to_name(repo->ref_storage_format));
>   	return 0;
>   }
>   
> +/* repo_info_fields keys should be in lexicographical order */
> +static const struct field repo_info_fields[] = {
> +	{ "references.format", get_references_format },
> +};
> +
> +static int repo_info_fields_cmp(const void *va, const void *vb)
> +{
> +	const struct field *a = va;
> +	const struct field *b = vb;
> +
> +	return strcmp(a->key, b->key);
> +}
> +
> +static get_value_fn *get_value_fn_for_key(const char *key)
> +{
> +	const struct field search_key = { key, NULL };
> +	const struct field *found = bsearch(&search_key, repo_info_fields,
> +					    ARRAY_SIZE(repo_info_fields),
> +					    sizeof(*found),
> +					    repo_info_fields_cmp);
> +	return found ? found->get_value : NULL;
> +}
> +
> +static int qsort_strcmp(const void *va, const void *vb)
> +{
> +	const char *a = *(const char **)va;
> +	const char *b = *(const char **)vb;
> +
> +	return strcmp(a, b);
> +}
> +
> +static int print_fields(int argc, const char **argv, struct repository *repo)
> +{
> +	int ret = 0;
> +	const char *last = "";
> +	struct strbuf valbuf = STRBUF_INIT;
> +	struct strbuf quotbuf = STRBUF_INIT;
> +
> +	QSORT(argv, argc, qsort_strcmp);
> +
> +	for (int i = 0; i < argc; i++) {
> +		get_value_fn *get_value;
> +		const char *key = argv[i];
> +
> +		strbuf_reset(&valbuf);
> +		strbuf_reset(&quotbuf);
> +
> +		if (!strcmp(key, last))
> +			continue;
> +
> +		last = key;
> +		get_value = get_value_fn_for_key(key);
> +
> +		if (!get_value) {
> +			ret = error(_("key '%s' not found"), key);
> +			continue;
> +		}
> +
> +		get_value(repo, &valbuf);
> +		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
> +		printf("%s=%s\n", key, quotbuf.buf);
> +	}
> +
> +	strbuf_release(&valbuf);
> +	strbuf_release(&quotbuf);
> +	return ret;
> +}
> +
> +static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
> +		     struct repository *repo)
> +{
> +	return print_fields(argc - 1, argv + 1, repo);
> +}
> +
>   int cmd_repo(int argc, const char **argv, const char *prefix,
>   	     struct repository *repo)
>   {
> diff --git a/t/meson.build b/t/meson.build
> index bbeba1a8d5..252dbbc031 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -230,6 +230,7 @@ integration_tests = [
>     't1700-split-index.sh',
>     't1701-racy-split-index.sh',
>     't1800-hook.sh',
> +  't1900-repo.sh',
>     't2000-conflict-when-checking-files-out.sh',
>     't2002-checkout-cache-u.sh',
>     't2003-checkout-cache-mkdir.sh',
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> new file mode 100755
> index 0000000000..2b2516dbae
> --- /dev/null
> +++ b/t/t1900-repo.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +
> +test_description='test git repo-info'
> +
> +. ./test-lib.sh
> +
> +# Test whether a key-value pair is correctly returned
> +#
> +# Usage: test_repo_info <label> <init command> <key> <expected value>
> +#
> +# Arguments:
> +#   label: the label of the test
> +#   init_command: a command which creates a repository
> +#   repo_name: the name of the repository that will be created in init_command
> +#   key: the key of the field that is being tested
> +#   expected_value: the value that the field should contain
> +test_repo_info () {
> +	label=$1
> +	init_command=$2
> +	repo_name=$3
> +	key=$4
> +	expected_value=$5
> +
> +	test_expect_success "$label" '
> +		eval "$init_command $repo_name" &&
> +		echo "$key=$expected_value" >expected &&
> +		git -C $repo_name repo info "$key" >actual &&
> +		test_cmp expected actual
> +	'
> +}
> +
> +test_repo_info 'ref format files is retrieved correctly' '
> +	git init --ref-format=files' 'format-files' 'references.format' 'files'
> +
> +test_repo_info 'ref format reftable is retrieved correctly' '
> +	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
> +
> +test_expect_success 'git-repo-info fails if an invalid key is requested' '
> +	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
> +	test_must_fail git repo info foo 2>actual_err &&
> +	test_cmp expected_err actual_err
> +'
> +
> +test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
> +	echo "references.format=$(test_detect_ref_format)" >expected &&
> +	test_must_fail git repo info foo references.format bar >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'only one value is returned if the same key is requested twice' '
> +	val=$(git rev-parse --show-ref-format) &&
> +	echo "references.format=$val" >expect &&
> +	git repo info references.format references.format >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done

