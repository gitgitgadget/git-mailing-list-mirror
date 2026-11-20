Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178932;
	b=5cV0oxUR2z8yewBKTkwPDnrOPSMVdLjw4+8YlU+Srwb2VPCAFirzwrAs/nez4Td0R6YY
	 Yt1ZTBFPYUQleb6bJ/bFUFohihfeLfvIB2zPJrD+qCTdJSRizzf6/fOO42zXVP1j/6HP0
	 XgKgmQJDe7BamFxRELD6I0SSXhHhAukS6OPBuELUoJauUwidfnPI0XJEq3YQqxLyBf7Cl
	 nssBE7ViQw0F5HYVfBmijA87dGG6/XQWX0LP2RJBhWu7uMpiqQFQ/cLWwH2DYRlY3V9+q
	 xKBbaYE+PCdhi6O0zTPYDPD4GY0CHTrRc3+x7QoThl2hYQkiYzwvYVCdXeqMCxnJFyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5MWO1J2hIWNjOuS0y2RFwpAlwBlhm+YBTysMDC3YljM=;
	b=vsnTS5NFuZR8ev8sjObuPH5rPZuauV+Wj4Oe/PPVx3JQX2a0y5YyMkzZATIbc/mK05Wn
	 GNTqaKCXpmExpd9tWO1t51gr15QffXtOzD2moCIPP5Mn1RTbE5jq3HiFqlu5D8Csv1/jp
	 Wrhn0j6Qjbnpsuz4E5hJUVzWsIA8L5A80NHVbqxpvBvoBkzCXyeXliEYHI9RamlRuk3it
	 zdQjOB9Sv7T8ct5QsPJWr34bO/GFHN9DLp4BSx7tw49XVYefSUVT/w06tCl95MkXilSL9
	 sObuC1nHLb88jOPd3Pe58OVr6aU1fwbgCS2aBqpfcsy9st5Hb949k8VHfm15Jzp5Tbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M/CqQEpn";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B0606A325
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D81B0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M/CqQEpn
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso1123771c88.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 04:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795178931; x=1795783731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5MWO1J2hIWNjOuS0y2RFwpAlwBlhm+YBTysMDC3YljM=;
        b=M/CqQEpnj6TVqmweymzr7U1K5TjFEpcMUZxcqVl4mVjB0W6b4B1NzwNVOawacPEAkq
         nNrP9wIkAGfteWFfUlhB7swUY4L+xZKouHDkzoAjcIzXEPSpp8ez9cbA3DtMfc4QTbUm
         Uipi/kKMDWELcQDaQvWRBlxBwHqr/kTKWtaHs/eyZnG6Dcl+GtgTy/BQAJu0XpYlLTQt
         KN+qp9NBE73j4X4/rPbyyyhyOTEPbn07OaOP77S5WOvlBMgN4ZVP8SEB1GNK3KSok6uX
         ktP7RE22UXPmW/u63dtefgENXsCjqH28geM99qfZjB4ljwrKRSA5zudDmZKjqA4wPQeN
         mVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178931; x=1795783731;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MWO1J2hIWNjOuS0y2RFwpAlwBlhm+YBTysMDC3YljM=;
        b=VD7XB0LnGPao5m/GrN8LqO5ExUvbWAftmoPLQhtXq/84ARbR9g+I+AWqoouOgEiqh1
         H+1vnP00pTYcArtiNO3eTdJ6RAr4R624HviHui1lrzMxHvTLLn+ne5/A93/U2LsoP7ma
         +eaCXLcO5mnJ40T3ka+6t1b7H231tYBQYPQ6X7AKDPhrErCCKxJ1bPe8/w9kyDyQTVYQ
         VmSHGKCB8nCqzaJbddwq354X8dqDr/S4oagzJ/RGm+9KDHBDv1CLU+7/Z48wRZJAWb34
         Z2Ard0OCL+6XosubMRcKKo4iPM6RmrbDPkiod5FCszo5lzVUfjPn1idCT1IEMaDIDPkN
         6nzg==
X-Forwarded-Encrypted: i=1; AL+hErHrHLLFo3sbE43qUBNZS8bzjq6azE1ynKakYJljiYqwsZ/NGpU6cZ45/4du2xqU9gDP/lU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2tqyd5qTSBQ3iDrBcv2npRUJRne4kEqun0f1YBqu2m26uHE7M
	0hC1bVxg1ug29dqGVasxyi3WnlBkoMvwncjoQOHYjguqHIDU8yiuIv14
X-Gm-Gg: AYBFou3e/7d8vLfakh2bHdbuMTyg9yutMgfQJtYNjyh4fLrg2oJuHRWc9u/JPlCZPy8
	X1sS4fTFd53giGDIhgLC+cNe5qpELbi7kWQBTAkqLYz93qkUpDGIBDMe0Tq5KwBnM2J5ImEQkRM
	grhR+Xqm3FEY+XPtH82RuU17ZzPiOmMgf7Q6gfzFaDtf1NatC75MEzqenmxuY764rAQc3PgZp9c
	hlD8WAYR+/vMbkxCmDKy3VRGkmmrS/WfPSMBuEO2Z/vIZC8BM1x3fjyPvEHBM8rxZUjwVLQ/3sC
	r5Ox8r/9xyL1Gt4Z2/EMpci+Yx+/adI0TZRzUoLWdJ9JO7eI9GNO6C1PIKgomzkpvISq267bQT3
	KGk4Jz94m42mwVvSsNVfdBtzB5iS/WHXDNwQBH32AZCfWDR85lKypUk8IWunBBDc8Vmlwn8SrRf
	LpvQ7jWdGHWQyOLQita+ubWHfg0YTkBK3FHwMbNSAi1aIula45q5IsV+iJqtkuUp1WRFJNIVvHb
	zeEdAYuBncuBPpAj0tSkzUOtdmq1ZqpooywMjXUqz8L+xfxfQDQlNMOGuvXHwW+6meiqqb0LIlj
	rPDsxcEoTUPKJtNyHwhFbMtAfv/PDL/qJvPGK+ej/ATIa2CR4ZzBVDBUnbFhxZg=
X-Received: by 2002:a05:701a:c9c1:10b0:183:3c2a:ae8 with SMTP id a92af1059eb24-1b55690bb6emr2508865c88.41.1795178930771;
        Fri, 20 Nov 2026 04:48:50 -0800 (PST)
Received: from [192.168.0.11] ([106.51.27.147])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm6917173c88.15.2026.11.20.04.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 04:48:50 -0800 (PST)
Message-ID: <8c88dd99-dbfb-4207-bd43-64063795e907@gmail.com>
Date: Fri, 20 Nov 2026 18:18:47 +0530
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
Subject: Re: [PATCH v2 05/20] t9300: make the series V tests self-contained
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
 <20261112-kn-fast-import-tests-1-v2-5-b8c3a0ab27e8@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-5-b8c3a0ab27e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 23:04, Karthik Nayak wrote:
> Similar to the previous commits, modify the tests in 'series V' to make
> them independent of state from previous tests.
> 
> Move the setup to a 'setup_checkpoint_repo()' function, so each test can
> invoke it. The tests used to build on the 'U' branch from series U, so
> let the function create a 'base' commit instead. For the same reason,
> the tag test now tags 'base' and not 'V'.
> 
> 'background_import_then_checkpoint()' registers a cleanup with
> 'test_when_finished', which is not allowed in a subshell, so call it
> from the main shell.
> 

May be also mention that it sets fi_pid that 
background_import_still_running_ expects?

> The 'no new objects' test needs the 'V' commit in a pack, because
> fast-import only detects duplicates against packs and not against loose
> objects. It used to rely on the 'fastimport.unpackLimit' set by an
> earlier test, so create the commit in the test with
> 'fastimport.unpackLimit' set to 0.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   
>   test_expect_success PIPE 'V: checkpoint updates tags after tag' '
> -	cat >input <<-INPUT_END &&
> +	setup_checkpoint_repo &&
> +	cat >repo/input <<-INPUT_END &&
>   	tag Vtag
> -	from refs/heads/V
> +	from refs/heads/base
>   	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
>   	data 0
>   
>   	INPUT_END
>   
> -	background_import_then_checkpoint "" input &&
> -	git show-ref -d Vtag &&
> +	background_import_then_checkpoint "" repo/input &&
> +	git -C repo show-ref -d Vtag &&
>   	background_import_still_running
>   '
>   
> 

The way this test series is refactored is different but it is consistent 
with how the commit message describes it to be.

LGTM.

-- 
Sivaraam

