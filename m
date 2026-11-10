Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338715;
	b=S5OpeN8jO0zdmoR4mn+jycp6su/RUKIs6RO7b/oVgmmhakkgDC3woR7/QuH58EteoKJ1
	 6pW5ZF1C3K/3oz/reeuN4X6ec8Skl1iHXJxQecpaGL+gEHs3cGR2nJ4yq5njZaiJNd7/J
	 IRVwmv8Uo20nkzLZ9+jaePJPvwWN1iz5nc8ZyM/GEfQEcF0X9ZpL8JhoEHmeVT3Aoqe/m
	 QuObFZnPGSOIyZEbvPIJ7xqKpQIwRqpclsX5Z/jQ7mbq+DKLAU3U8wlwKh+C+cbIW7C1+
	 ZNcb2Ex9VzYBvJTDea5nlySPF2HS6iay/Vc9s+yjmNyhhpmpJkJq/MqNPb4eB8YyBwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=F3epRJn1fUpv1bDlXz69d46A+mckkjmpMEanX1otdjc=;
	b=r7PaEnTIib55jlXfZOURjIiDsLax8z8xGaRM0vTp7tJo3tD27hgAlnF8gKZ1yiPfGhSr
	 bjYTJCLXzkI1z23UwHcRdcC4C4L/51auRjqlZcGH97niWbf9GUzx19u6RE9BHxCCXVrC0
	 3ylQ8oB9PMVEX1MReS1aCV6HcopUJjbC+oARzA2gXyRjQGlNptMPKrm1WLUWjAd2xcrNb
	 Ar6SEb1koLlBv3vNo2rldlyr3kalNfzm33UEpTByY1aF0SwWhlPyNszYowWzkoV5o04N1
	 WJbnpTlkSZd+vIzYIRlU4TIjYluLwAs6nCIwoDUeoxM7MEY7YnFJqxMG07bUTS7caSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ehOffebx;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EE606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 19:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 877EE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ehOffebx
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85a5455bd3cso1319246a34.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794338714; x=1794943514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F3epRJn1fUpv1bDlXz69d46A+mckkjmpMEanX1otdjc=;
        b=ehOffebxYv1/HlkWuw4KrX/bM6akcjmNKJ0IodpJa89SEOTq2FmY7NkSOZoxJB0K5m
         72YWswAILT0TZ14k1SgtZEj+hEf6DZ9oJfaM6QeefY6DaLkcKs18uWrjqwDrDIMfQxH4
         3geBeUyeSpKRfXvbidTncwiSFao5tcbNXN2KcT5rvDFi/X/bf+EtterYQNpn8Dt58NdA
         haokaPXVXxJhXHv2fNtd72dvD6bxGbmFAaBSRk29NbS7uHLUFb80kCKRTx/3YSqXTETQ
         U7lReGlKtMBG0KKvcOsTYVT667uU/p28xE/4/u1daWmeiTGBIRfJC3FXCH2LN+SQBi8N
         vSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794338714; x=1794943514;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3epRJn1fUpv1bDlXz69d46A+mckkjmpMEanX1otdjc=;
        b=1DqYviR69sCzrWXLvEptD5g74BzqcAvMKI0hP6j+qn7ShLBJQ1418llsgedH49ZPMO
         vyOFoUmsdvCzRyoWiIGgDmE5PphtD9FR4JeRZkE6Yt1MFkNpnXzHzEVD5w/Bv9bdtWaH
         uAQ0UgkCm6EnMmukIFBNKjtsBRhv/gIVGwBGVjxwT0obrq9kqdmp+SFaFBg/ksw9eUKs
         WxFEX5bu0JpCsdTFBIdQOARTGKLjs1ScX1+ZJPXPJv2NKI///EvH+lDu252H5fem1Os1
         95SWin5+5CiK/zmK1vsODaUWyvuIpsUDxZsX9GeGxdaYET7S28k7VJChTtZ+OoWOJfV1
         BuJg==
X-Forwarded-Encrypted: i=1; AL+hErGqyRjCsEKvWVK5VJeomItLsrGARt8oYKXVj8cXqGi/GkiulgniEsLrFWEFZzBfLmHKcoI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xiJcL7RtJ3MKNUKJU7eUdx9aZRurJ+m7upuqUVrQK5ujGARfX
	a0vXIoyW02+BownDzIlVE4G6KUrtENvkwLHqtjiSVzgvTyHA9f93dJk/n5rtuQ==
X-Gm-Gg: AYBFou1dkw+bNtcuMvW1pYlpLIPn0VPhxP8EypY9nz5JEZTU9UDzeXiBglLf3uWx3Dc
	X19tgElpEmwBFJhdvkSDkZBeWMu03cfEqSGfZNxTQrV94FSwEXFB8hX6xdwbHk6jPjpp3FEaTDS
	WHX8psuVh2960td7MhO0P5+HPR4FUj2GD5H1skIBhGwqCMtDQIfHrR/ma5zXmx/pjGJsUJ9pyHJ
	x1yEz3FBfvY7QtOv1T2Mw4ZaPrA9k1uJRqPFNJ7ae3S4tVwvdHj6LKx661NxaIC8NJnl43JtqiB
	pGEHxONv+/y4HmsN1ceLt8O/NPgrZjeucjJLxpScpBU4GgAzzL09fcwFjsSrrh1+j4SprahFNaS
	Tf4QAt+9VU7rV9TILMvH2yLZO5wyzJVciUC4RMgTmyH8fooY0YosEE4ZIDoV5xltsO3vfMTsPs6
	1rECQRhETTOHtufnGqNEwACN0wOPRstZNicCJ35gOhI3WzprWszPAylcw24/mpIDMMfCuBcPa/C
	X+JdKl79mnl6kavfMh7uUKf0e3pbIeb6KKwLdnxk1ELJYPsyyPwFu+YzIvFmeQw9MGdPm7IuGo5
	OBcuM1KmXI21LFqHxh1VQW/MnDUdGYP/iloXNsT/we0B0MDy3gIVeg==
X-Received: by 2002:a05:6830:440e:b0:814:8259:780c with SMTP id 46e09a7af769-860dc76e7f9mr2755205a34.19.1794338714259;
        Tue, 10 Nov 2026 11:25:14 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb62443sm2671518a34.6.2026.11.10.11.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:25:13 -0800 (PST)
Date: Tue, 10 Nov 2026 13:25:13 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: return error on index-pack abnormal exit
Message-ID: <avNvUL5KUWuoHIZx@denethor>
References: <20261103212410.1389988-1-jltobler@gmail.com>
 <20261103212410.1389988-3-jltobler@gmail.com>
 <xmqq8q38yz5i.fsf@gitster.g>
 <4c7c44df-4eca-4abf-a825-1bb3b16015c2@gmail.com>
 <xmqqmrrgtz6i.fsf@gitster.g>
 <590c5765-fc4e-44da-9326-b8242caa80ae@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590c5765-fc4e-44da-9326-b8242caa80ae@gmail.com>

On 26/11/10 11:27PM, Kaartic Sivaraam wrote:
> It is an improvement indeed. No arguments about it. I was just wondering if
> his change could also include a change like this on top:
> 
> diff --git a/object-file.c b/object-file.c
> index e04ce0bc11..c52004014f 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1429,7 +1429,7 @@ static int odb_transaction_files_write_pack(struct
> odb_transaction *base,
>  	struct pack_header hdr;
>  	const char *hdr_err;
>  	int err_fd = opts->err_fd;
> -	int ret;
> +	int ret = -1;
> 
>  	hdr_err = parse_pack_header(&hdr, pack_fd);
>  	if (hdr_err) {
> @@ -1498,13 +1498,11 @@ static int odb_transaction_files_write_pack(struct
> odb_transaction *base,
> 
>  		if (finish_command(&child)) {
>  			strbuf_addstr(err_msg, "index-pack abnormal exit");
> -			ret = -1;
>  			goto out;
>  		}
> 
>  		if (report_err) {
>  			strbuf_addstr(err_msg, "index-pack failed to report pack name");
> -			ret = -1;
>  			goto out;
>  		}
> 
> 
> But, I would agree that this is a digression.

I think this is mostly just a matter of style preference. I'm inclined
to leave it as-is, but an open to change it anyone feels strongly.

-Justin
