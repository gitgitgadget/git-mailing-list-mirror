Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705228;
	b=JYv1tJr0snLlkqBXqWgPXbTyfZaMQE6qU5WT7RMIXjJyLRZfvaxtmLFLD24jJSg6v0Ef
	 MqaQG2pTKOAKI9BQNh9vE8QEfgH1ol4CqBnyDK3gu36Sc4dt900clbn1kI1MqDwu/Bl6v
	 kx9fpVfJqDFig0woDkmT853YaFGYjUjntZyD2frLPbLw1ge+4zuFxtumVPA2DttJGhs2I
	 5WHWOU1kxk5Ebwet2478j8wD7bFF0pcpPmcius8OMYEA5iiCtHRZ9DbYcklj+b3QQ2b12
	 FqbdNO1tNjlf009a7ayKpUT2aFSiws1A4Ixpq5T7NjbMMyKjmI0OdPNQwvv009Jk2mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R/Sax/BCqJcnY15aYLmY2jyReYu0+3VvFIuFdPISXwQ=;
	b=FucuEIwoF2HHJ1KPcHXDl6Vetl4GdT9llEszv+qI016oMJ4VWiAEphRIccnyorSOmJhu
	 STZsoWEfo68xTn76W1OKudLBM6EyN0yw0BjQU3jdl73JKDdbdnFVPTkYJ+26/HrtnY6dQ
	 QdzhPMIA7k8Qx9uU57RnCYfF97G0R+CtWF73qnY+MWwp3L87lY5NpeOXIwLBa6kONT274
	 rixH4Il5Z5c5e96WhtthwVSusk2Gnzu/UnGaaPx5um2gmsr7vpkLh+XjS4fxbwinLs+Wn
	 DyklO3E6xSGHq0RCTnqDS2kegRx3O1uOepzjg5oV9VbRjRjhawQODrpuxFxiZEr4kow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yxl8UdLX;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D237606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D237606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yxl8UdLX
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b8786bb305so8588035a12.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795705227; x=1796310027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R/Sax/BCqJcnY15aYLmY2jyReYu0+3VvFIuFdPISXwQ=;
        b=Yxl8UdLXi27ZHAwcv7GUZrIudZJAkVG12Y1vWE3FzGrzYVZDnZaf2DGLqWLnZ67Q7/
         lPZTsSekTHb6aSj3u3F21yu+919ZDCWgZUyj0V4Uk+zdO0Vl0R0FJWWTkLX0+iF7GTTZ
         DVO8oZfnpn2pkN4+JBnwblgEKML4y/l8RuDtVY4VYIMy/3TbZ7A66aPzcogjzvoyHEcH
         YrmgkmyQx+roOZry9NJzjpT2ngzGY9m+NmYcO0kOhXRKYM+r280YiQ3sIaqSI0ouZrWP
         oki20mO4doxEiZs7DctjnAPUq/bUJ2n57rugq3RwE4q5bBXh0bQNGfOQeZJf/cfqz7ON
         m1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705227; x=1796310027;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R/Sax/BCqJcnY15aYLmY2jyReYu0+3VvFIuFdPISXwQ=;
        b=FlZ84SInqb6nCZxvL8ud0uZx/ohQ6B/iA/0+z9RQCxuiZSxIbr3QWZkrSszP55x12H
         kHYaKb6vZ5h/ZIPjvCIK979hh8FeuKEM9O8X5oxxDKz0JymegA7VSluVx/GgpCrUXX8y
         aF9AfLj3xus5MuO6hYw2pVNO3letaVZhqbDDzBymO+dmayNBaqBE4DP+khzlZOGT+TAG
         n6DLVcMN/NgdFRGD0Fbp6SziRVglEIwgP28QfX/2URA+73KTMFGmL0nr/nUJKQFc6ysh
         bvvf8JYoOddlqAFMHLWoXATsvz5F0wiaYGu2oOp2cgxG3khw0ERMPesMoHh0KCyhGur0
         s6Ig==
X-Forwarded-Encrypted: i=1; AL+hErHxWH6DwTUgvE6HUUWLGYHDYNxL1QULJv2gbL+j77Ehc1tXH31uKaNo8Mu8s63PCaOclXw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lEcKnH7rQpOeU60VgHGISotaVheEYFTPxhL4uqngxK7djo4QR
	zpcUUYq6b3PvVOdb5E1KApKfjdkQ8Kg1WL31RQUTPLKdVU/jK4VOwlxIDxlsJg==
X-Gm-Gg: AZFdTZcHTvzHUp4Elcm4GWwglQ5Q6pvo4tYYS74pFSHywg2HfdL4KnCmZySCQmouMrI
	Rehm0WYby2dwlqbqVy2xhVSDEvyDerSAa9mcxTXGknEQOcl/pFlfV5/9GKjsjRnPWAXRRyNRTK3
	yTzYS4auM57cO/pEZaa45gcWkIbIIs9Xl+szvdM3XQX9RpqNjoZ0NT/yiTfUDFEn7rjwVtKu224
	TOiWAzhKbqchq6Y5ZZqm0LCTRm05/MzUt5Ahu6iWguPC+lae+xid0dxEj3l9+YP9c0ogQnmhVU1
	6IbyZ6rFR/Gn3DUSsyJ7DQEDgngGDKYrcnVtemId8K/ZjYTNdtHs9ggr9WxzIwDzqsC2v3Si027
	dWsPh273uyZHWF0uW9Opd2K51cB8lCYPJdQ4Y8iz8iGnb6F54Cn6yIuXmhikcrGk9Tk5OVb6RVM
	lQeslxjCCvDy+uI5xmOBmCOZCuLWu/Q7FoC3hsIcqPyGUenjrodhRJRmQFowyi8aclq8e+xCD+T
	yHxVafW9H7cFrkhB1qe3I81XgRq+M34euan/QJv0kHfGK5gp7+9P3etq6OLRqT4Nr1pdA63tUJ6
	QXCBOZH5yHeQWq/ykSK6Chvf7rmB0/LmdtMnyeKV2u20BTUBQesGm7iMsYghWzm602QBj5oHjQm
	abfLMiLE=
X-Received: by 2002:a05:6402:897:b0:6b8:8328:8e66 with SMTP id 4fb4d7f45d1cf-6ba37d62a2dmr10719627a12.7.1795705226237;
        Thu, 26 Nov 2026 07:00:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1d49d992sm2792266a12.26.2026.11.26.07.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:00:25 -0800 (PST)
Message-ID: <7e093731-37f3-4ddf-8cb8-adfb9e6c4c73@gmail.com>
Date: Thu, 26 Nov 2026 15:00:20 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] config: make the suggested "set" command safe to paste
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
References: <pull.2457.git.git.1795632875345.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2457.git.git.1795632875345.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 25/11/2026 18:54, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> When "git config" is given "<key>=<value>" as a single argument and
> the value contains spaces, the suggested command does not work when
> pasted back into a shell:
> 
>      $ git config status.comparebranches="@{upstream} @{push}"
>      error: missing value to set to the variable 'status.comparebranches=@{upstream} @{push}'
>      hint: did you mean "git config set status.comparebranches @{upstream} @{push}"?
> 
> The shell splits the value into two arguments and the command fails
> with "wrong number of arguments".
> 
> Quote the value when it needs it, and put the command on a line of
> its own the way other hints show commands, so it can be copied
> without the surrounding quotes:
> 
>      hint: did you mean:
>      hint:
>      hint:   git config set status.comparebranches '@{upstream} @{push}'

This seems very sensible. It would be nice if the tests checked that the 
key was quoted when needed as well. I'm also confused why we're 
post-processing the output of sq_quote_buf_pretty(). That function is 
supposed to be the way to produce shell quoted values for human 
consumption, so if it isn't pretty enough we should fix it so that all 
it callers benefit from the nicer output, not hack around it.

I agree with Ben about supporting a wider range of shells, but that need 
not hold up this patch.

Thanks

Phillip

> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>      config: make the suggested "set" command safe to paste
>      
>      When git config <key>=<value> is given a value with spaces, the
>      suggested command fails when pasted back into a shell. Quote the value
>      when it needs it and put the command on its own line, the way other
>      hints show commands:
>      
>      $ git config status.comparebranches="@{upstream} @{push}"
>      error: missing value to set to the variable 'status.comparebranches=@{upstream} @{push}'
>      hint: did you mean:
>      hint:
>      hint: 	git config set status.comparebranches '@{upstream} @{push}'
>      
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2457%2FHaraldNordgren%2Fconfig-set-hint-quote-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2457/HaraldNordgren/config-set-hint-quote-v1
> Pull-Request: https://github.com/git/git/pull/2457
> 
>   builtin/config.c  | 21 ++++++++++++++++++--
>   t/t1300-config.sh | 49 +++++++++++++++++++++++++++++++++++++++++------
>   2 files changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/config.c b/builtin/config.c
> index 2554322317..795a5fb136 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -211,6 +211,18 @@ static void check_argc(int argc, int min, int max)
>   	exit(129);
>   }
>   
> +static void add_suggested_arg(struct strbuf *buf, const char *arg)
> +{
> +	struct strbuf quoted = STRBUF_INIT;
> +
> +	sq_quote_buf_pretty(&quoted, arg);
> +	if (strcmp(quoted.buf, arg) && !strchr(arg, '\''))
> +		strbuf_addf(buf, "'%s'", arg);
> +	else
> +		strbuf_addbuf(buf, &quoted);
> +	strbuf_release(&quoted);
> +}
> +
>   static NORETURN void die_missing_set_value(const char *arg)
>   {
>   	const char *last_dot = strrchr(arg, '.');
> @@ -218,9 +230,14 @@ static NORETURN void die_missing_set_value(const char *arg)
>   	char *prefix = eq ? xstrndup(arg, eq - arg) : NULL;
>   
>   	if (prefix && git_config_key_is_valid(prefix)) {
> +		struct strbuf suggestion = STRBUF_INIT;
> +
> +		add_suggested_arg(&suggestion, prefix);
> +		strbuf_addch(&suggestion, ' ');
> +		add_suggested_arg(&suggestion, eq + 1);
>   		error(_("missing value to set to the variable '%s'"), arg);
> -		advise(_("did you mean \"git config set %s %s\"?"),
> -		       prefix, eq + 1);
> +		advise(_("did you mean:\n\n\tgit config set %s"), suggestion.buf);
> +		strbuf_release(&suggestion);
>   	} else if (git_config_key_is_valid(arg)) {
>   		error(_("missing value to set to the variable '%s'"), arg);
>   	} else {
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e3f8064889..796e11000c 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -470,15 +470,47 @@ test_expect_success 'invalid key' '
>   '
>   
>   test_expect_success 'set with 1 arg of "key=value": valid key suggests split form' '
> +	cat >expect <<-EOF &&
> +	error: missing value to set to the variable ${SQ}pull.rebase=false${SQ}
> +	hint: did you mean:
> +	hint:
> +	hint: 	git config set pull.rebase false
> +	EOF
>   	test_must_fail git config set pull.rebase=false 2>err &&
> -	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
> -	test_grep "did you mean .git config set pull\\.rebase false." err
> +	test_cmp expect err
>   '
>   
>   test_expect_success 'set with 1 arg of "key=value": implicit form suggests split form' '
> +	cat >expect <<-EOF &&
> +	error: missing value to set to the variable ${SQ}pull.rebase=false${SQ}
> +	hint: did you mean:
> +	hint:
> +	hint: 	git config set pull.rebase false
> +	EOF
>   	test_must_fail git config pull.rebase=false 2>err &&
> -	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
> -	test_grep "did you mean .git config set pull\\.rebase false." err
> +	test_cmp expect err
> +'
> +
> +test_expect_success 'set with 1 arg of "key=value": suggestion quotes value with spaces' '
> +	cat >expect <<-EOF &&
> +	error: missing value to set to the variable ${SQ}status.comparebranches=@{upstream} @{push}${SQ}
> +	hint: did you mean:
> +	hint:
> +	hint: 	git config set status.comparebranches ${SQ}@{upstream} @{push}${SQ}
> +	EOF
> +	test_must_fail git config status.comparebranches="@{upstream} @{push}" 2>err &&
> +	test_cmp expect err
> +'
> +
> +test_expect_success 'set with 1 arg of "key=value": suggestion keeps shell alias readable' '
> +	cat >expect <<-EOF &&
> +	error: missing value to set to the variable ${SQ}alias.st=!git status${SQ}
> +	hint: did you mean:
> +	hint:
> +	hint: 	git config set alias.st ${SQ}!git status${SQ}
> +	EOF
> +	test_must_fail git config alias.st="!git status" 2>err &&
> +	test_cmp expect err
>   '
>   
>   test_expect_success 'set with 1 arg of "key=value": invalid key does not suggest split form' '
> @@ -494,9 +526,14 @@ test_expect_success 'set with 1 arg: variable name starting with digit is invali
>   '
>   
>   test_expect_success 'set with 1 arg: digit-led section name is valid' '
> +	cat >expect <<-EOF &&
> +	error: missing value to set to the variable ${SQ}1foo.bar=baz${SQ}
> +	hint: did you mean:
> +	hint:
> +	hint: 	git config set 1foo.bar baz
> +	EOF
>   	test_must_fail git config set 1foo.bar=baz 2>err &&
> -	test_grep "missing value to set to the variable .1foo\\.bar=baz." err &&
> -	test_grep "did you mean .git config set 1foo\\.bar baz." err
> +	test_cmp expect err
>   '
>   
>   test_expect_success 'set with 1 arg: subsection plus invalid variable name' '
> 
> base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb

