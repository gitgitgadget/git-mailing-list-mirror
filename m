Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431E1758B
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720841003; cv=none; b=R4S4RtFjFme9G3+Gc84HhBlweb1plgwnOaxxTYf10LCNtcihzpQOyzak1ezOGkDkilYDZM/a5FkBH1t1iwYaogTfNYxgcaZGKAO3jGWLw+Tt6Fa2dpROrKxTw+Gy4wpQ/upr/5LDhK/9kLlkj7zP91SE4OBg0j+bPWvhL0TKf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720841003; c=relaxed/simple;
	bh=txDknMG28gLCCvDTVmi+GfBdNonOEPKVuIHjrJgb7k0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O7ofVbhoqQ4SjckOKidhhKwpWG4Tlk8RaqZXG9g+Lcpff1Lu8weTUndMAkVwjWTAdB4FSDYYGiWgSCSfQmjXtHZIuUVxDlFkZzZ7Pd8iXZPufEdI69kdENOsQLCybNHZVB2nZ0R1bJK1vqK4VebGg0GdtrqBr7ThE6tZT6cRZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlU9huqC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlU9huqC"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c980b08b4bso2054968a91.1
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 20:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720841001; x=1721445801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7UEyQWM9DVl/ZgDZMh7ZL+Wzv7jUMtaMlUJOX9Sy6pw=;
        b=QlU9huqCFjrWYmgOAjEzlGhBa4nrS4WZXKJ/9KLolqm9Qo5jYZdIR1Ck0+tjNYJfTX
         l86DOpeMUpin9ix4lA2nKQbCJVNZxZ3Hg7dahQReV+HowCjSYzB/+jXcBMS7q0pEnnBf
         MY79zc7IpE22c+NOwU3W8MFjlvAILgpuKoCSxy+6s6iXOCtpfWWUMiZ165JeZQo34IS3
         quXLFhrJKoCrnluXSaZPQlW0wPH8tZwHSoAttTcRMbVWtiawJh75T0tPUZmpOdbSIg7p
         uyNfp6aAXzsj994j8mUZLif7QxcyczX8yVA77ekMHg6c5dO/d0NTVnYFAZ6ijWyZm3DW
         mNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720841001; x=1721445801;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UEyQWM9DVl/ZgDZMh7ZL+Wzv7jUMtaMlUJOX9Sy6pw=;
        b=XHELJ3QUCQ0MqqsBbTU7oD/2FR7OPuih+wlwQC56+us1XhsgmGb/iI//KbiICMV3aH
         Rva8G9pU0kckwNb1D5nW51FWv/ZJhA2YoH64eDvXi07WmQYVe3bpRIiw1tNo01B2wVha
         sUZ91JPjYynZl01SjnwstxAnCkSTgiom0m1YeM0eygD8DkCNBd164janP0PacSdSZk6s
         B2DQ5R05qRGJpgb0sn2pqqA48RS0OBeZDEThxsb3qx4LuFNLyIfnKt5XloQyWCjGyi20
         JI1UHKPF+G3fRIeSQtD76v4LfLJvRoz02Z3iD57H1PALbtvTwHUlfrdf2IOzIkKvjpHq
         r9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFmFlmPulGohU+vu6q3W7R9cn/91qtlogjsRRUT0W5pnwq8MugkVQ7IsWLI87KD1FHIiSXE0Aoi7eul1W/Oze+xV3w
X-Gm-Message-State: AOJu0YxFVtvgzOztMaJ1ZIBDVjj3i2pYehyNogpe2+tqGhhgthe4tzWV
	oWZnsrSWePunWiwxlxkZzI0xXGLWbSyqn1psmNKJr1HO+KzkwU4q
X-Google-Smtp-Source: AGHT+IHPWoA/GCsuRsSJa8LJSRMoDgdWTpuqaFFOlabHRoEzEq+ReCf16oU8GWd0zGB6hiKVSp57gQ==
X-Received: by 2002:a17:90a:1305:b0:2c9:9ad5:7cac with SMTP id 98e67ed59e1d1-2ca35be7c6amr11060044a91.1.1720841000899;
        Fri, 12 Jul 2024 20:23:20 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedc92b75sm244720a91.45.2024.07.12.20.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 20:23:20 -0700 (PDT)
Message-ID: <91941519-04c0-4306-bc5b-4fa1283d2de6@gmail.com>
Date: Sat, 13 Jul 2024 12:23:16 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
 <803b10ed-1cb3-4314-82c9-cf48d5d0bb90@gmail.com>
 <ba8ad59d-d125-41d9-a482-ee8eda187762@gmail.com>
Content-Language: en-US
In-Reply-To: <ba8ad59d-d125-41d9-a482-ee8eda187762@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/7/24 1:24, Rubén Justo wrote:
 
> Maybe a test like this would be clearer?

test_expect_success TTY 'P does not break if pager ends unexpectedly' '
       test_when_finished "rm -f huge_file; git reset" &&
       printf "%2500000s" Y >huge_file &&
       git add -N huge_file &&
       test_write_lines P q | GIT_PAGER="head -c 1" test_terminal git add -p
'
