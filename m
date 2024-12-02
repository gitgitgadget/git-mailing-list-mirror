Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9B1DEFE5
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172181; cv=none; b=PCuG7TCVSnhuLzwQTDnwyT7XyMjuOpG07KfC/gYOcUaSvG7vD3Ow2pPfN0qsJG4Na6/rpxjuzug46iSUcHct8BngfbaI7Mi6AbDUmfj2Ov2cpu/q9tCmJ2lemjEYl+DE7B5birzn/ZUyZbQbd50CmP94pRQ9ss8fBxdkr60tZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172181; c=relaxed/simple;
	bh=rqPtyElAV9HFdOsujbUI03+dJ/b9pX/PO3P1jEjtvd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5K9d2vHPU5uDt9Tam6z/a4vAs6Jo4jVOoX4iHmH8MsueL5mLVo96KGzCMFA8YSjyr/Pv7hvnt4X/9ndHqquQbtuSYAkmjFXP4iCepDMOxXfnaGGlK1jYC508c+cL7kjnoH7PxFFd7su9RmXiLNKuGRSay6LYpew5/xXhyXQPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCc8nbpC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCc8nbpC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so44484065e9.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 12:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733172178; x=1733776978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RC+UmtaQu5vqeT2EFqxt85C3YVWXI9WDpeNj67i7cIs=;
        b=aCc8nbpC5yug6fkmgBaIbXlwHMDeCkQs5UWNcQiwoziRLDIeo/DmYyxgdLGsJcBllu
         L8oDr7mJ5N/TegWNDKdmyN3SBpUIs6KcOZaQYRNDQU8/jJjtR2yziX9L4ObbJbTSZA5N
         gNkUOJ9I12WzsO9Hm1W6QKwyY1Etpmk7S2pz3pRwDfvXGneXhj2TlyNKjNN1gmKvqHej
         ryzKWRMOSKWLIEdYyDhRFVs9DcXSCfoaj0PfsBOyUmGEJhP4aQ+tbovud4RP5odPtz0L
         3voaacmLt4qmcAmvy62aUFMCXzJtyb8vuW3KunjpgK0GWqKjWA6IDjidJYe8shjCAQzG
         WbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172178; x=1733776978;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RC+UmtaQu5vqeT2EFqxt85C3YVWXI9WDpeNj67i7cIs=;
        b=K2a3v2hMR1B9UApeJbWbGIrGidCF9Ifj3d+orYz1PMHQHhIZRpuTqR1M5q2rg9k4U1
         jK+XNRMcRLgPEI6iiNQfPePBjLrtZKG7RhM+uA2dHB8ogR58nvrj92WrnTKoiSFF++Gc
         PBTE5ju9kYAz24w7wK5CYI4238OJvjdwj0QFYbsbds3K7/2ziRVQslMbUa+GojA99Bin
         Om9evuVKTWkYI9qthS5zgP/S6ioM0KlmA2SQKWRFfM5e5O6yTpyNG3BSVekBRvqBPMeH
         Fi/H5C/k+VN4R4o0Q2jfsfD/rCUY6CBjHoAe8du3QrsPwi6fzhz1l8yLUZE0BWuzLvuz
         1u4g==
X-Forwarded-Encrypted: i=1; AJvYcCWsuKeZIA2K8qfNctf7tSf+u9dfqIhGYRQRSo6LFsbL+vQuvOolWZa0toy+KNw2bhq/zyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSu8A5Yz/Qb+FvL2AlwRYt0PIV3/OHOivE03tIAdcgPg8JuBXn
	qaWyGjMdCSSOV+oxNKQ2eFmwdxGT/Jsf5wCof294r8Rn2HDL++NN
X-Gm-Gg: ASbGnctu9tOfvEqwYWfu16X8FZNr/itD8rAR5IOdPqUbr5u4gj1m+U8mquzXJx+hpet
	E2+C04rEz2Ki6GMEvkZDV3AP1lsScgL1W/4ocVZ0mFushjNhaKiZd9jgo0yE31jPB0JR2i5sRuC
	fjOqkD1GLHDZeFUmVkJUyXJEnFiqgoiUJptGG3MpNZ3ppZY/IaxDUj+qpIsmB0I9nBWa411pgJC
	aRfXBDnc5oG+hTDP+/SBy4lrBbmLkanv4K4rD2vd02uErb3HITxDCN/YR3eM0Apmkjr8qI5MWFP
	U+fN6hrpw3I=
X-Google-Smtp-Source: AGHT+IFoJjUU2MpuXMKFiJAcpNS4uELiwtrJTbIN88jkktjp6U426arRK2JEcATtP+ZZneOWafrjkQ==
X-Received: by 2002:a05:600c:2308:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434a9df0a16mr252971215e9.30.1733172178201;
        Mon, 02 Dec 2024 12:42:58 -0800 (PST)
Received: from gmail.com (119.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf9f5sm163101565e9.16.2024.12.02.12.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 12:42:57 -0800 (PST)
Message-ID: <ee2af264-8d4f-401d-893c-e08c30f5a9b6@gmail.com>
Date: Mon, 2 Dec 2024 21:42:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tag: "git tag" refuses to use HEAD as a tagname
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: git@jowil.de, Jeff King <peff@peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-5-gitster@pobox.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20241202070714.3028549-5-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Dec 02, 2024 at 04:07:14PM +0900, Junio C Hamano wrote:
> Even though the plumbing level allows you to create refs/tags/HEAD
> and refs/heads/HEAD, doing so makes it confusing within the context
> of the UI Git Porcelain commands provides.  Just like we prevent a
> branch from getting called "HEAD" at the Porcelain layer (i.e. "git
> branch" command), teach "git tag" to refuse to create a tag "HEAD".

This sounds like a good step in the right direction for me.

From the subject in this patch, I was worried that we were also
preventing deletion.  However, I have confirmed that we still allow
the intuitive deletion of a tag named 'HEAD' with "git tag -d HEAD";
for example, in repositories where such a tag already exists.

Perhaps tangential, but a silly change like this hasn't broken any
tests:

diff --git a/builtin/tag.c b/builtin/tag.c
index 670e564178..b65f56e5b4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -88,6 +88,8 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 
        for (p = argv; *p; p++) {
                strbuf_reset(&ref);
+               if (!strcmp(*p, "HEAD"))
+                     die("Hi!");
                strbuf_addf(&ref, "refs/tags/%s", *p);
                if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &oid)) {
                        error(_("tag '%s' not found."), *p);

Therefore, if the previous seems reasonable, perhaps we should add a
test like:

--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -97,6 +97,11 @@ test_expect_success 'HEAD is forbidden as a tagname' '
 	test_must_fail git tag -a -m "useless" HEAD
 '
 
+test_expect_success 'allow deleting a tag named HEAD' '
+	git update-ref refs/tags/HEAD HEAD &&
+	git tag -d HEAD
+'
+
 test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	git log -1 \
 		--format="format:tag: tagging %h (%s, %cd)%n" \

> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs.c         | 2 +-
>  t/t7004-tag.sh | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/refs.c b/refs.c
> index a24bfe3845..01ef2a3093 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -735,7 +735,7 @@ int check_branch_ref(struct strbuf *sb, const char *name)
>  
>  int check_tag_ref(struct strbuf *sb, const char *name)
>  {
> -	if (name[0] == '-')
> +	if (name[0] == '-' || !strcmp(name, "HEAD"))
>  		return -1;
>  
>  	strbuf_reset(sb);
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index b1316e62f4..2082ce63f7 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -91,6 +91,12 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
>  	test_must_fail git reflog exists refs/tags/mytag
>  '
>  
> +test_expect_success 'HEAD is forbidden as a tagname' '
> +	test_when_finished "git tag -d HEAD || :" &&

I'm not considering this as a test for it :-)

> +	test_must_fail git tag HEAD &&
> +	test_must_fail git tag -a -m "useless" HEAD
> +'
> +
>  test_expect_success 'creating a tag with --create-reflog should create reflog' '
>  	git log -1 \
>  		--format="format:tag: tagging %h (%s, %cd)%n" \
> -- 
> 2.47.1-514-g9b43e7ecc4
> 
