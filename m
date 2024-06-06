Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44371E52A
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649777; cv=none; b=Hypr0QBBiJ/w0qITqgYg39Y7LpDeoy/q8R5xi72q/yeflq94rMm4/652DlUm8r1eCbTUJDpj7aC5XLNDcB6L5JbeqgM5NO3u0IHYk337gMq48vt0Ydzfp479554uEx1cE/uaWs1ri2qx4758LzDZLs9NDmSmPbhuyvNND8hJbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649777; c=relaxed/simple;
	bh=AwnjjM1rTljM+7tCIJDoKc0biPx5+BrSF1TQjECLQvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXyNtgqslniptC/MoV/6BI7jNarBDUUs2dgdHLvQ6VVQmnHTtbmmrYmCXEkOO22no7yuCeT3WxnKbmr5wtayU0kandOn1U/1scHPnhxkbSuCtgplGRwIbkvFwCZDFmqpXvFl+biefi4Gf2a0T+Umiiwc4uvJpK4+LqGMPX2Mbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIsqboev; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIsqboev"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c7bf648207so427534a12.0
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 21:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717649775; x=1718254575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlQ5ROVDE+PqJnHaltzIRtzAs37ZuEDHJlDNB59C5/M=;
        b=ZIsqboevCtU57JldtL7Tzw6dYWimjnl3kgDq8PlnAywFRV1SQisCzL9xs6d7rORk4R
         fluZ3FUmqhAggoArPG+8NAcbh2gvWKb1+l9lcw+5eiDOAWa2j+hrxTBLRb1ZAoK5Abch
         L4inqV+Y02ktf5X6TmhqjsOdTjKPpvpjyOr2dHhDHhx4BLncVf2mdRmD14q2A1yiIHpO
         ExAWsSVCyBG6xoLqSTWMPxFC9IYjvdqZe+hmxVDJLXUI+Afe0qSeUYW9GXGnDthpIpuh
         jwXUtwQQsD30Af2ZoH0ilGMCiicqGSaXAan+EprEjyKuV/Ab920N7/sG3rgLRPglnkim
         4YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717649775; x=1718254575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlQ5ROVDE+PqJnHaltzIRtzAs37ZuEDHJlDNB59C5/M=;
        b=PwtGbhRj6kSnDSUPNeP5kdayM3JSDLi2LUOqSfjbWl4Lq/GKjkGEUs3lZgQj4FuNdq
         jYS1gL1Hm3czCrD+w1JzwZtUGuo9NO6LjTmHD1XdT+RgNiYhu8sIKv/VFL3kj3oxW0Q0
         tXzmBv9f/dvDpr2gEr5eAtZofO2LBM+fUq4E4ojByt7YETcSEr/7WiiuoFoNjCwtX5g8
         TSgfj53MOnrOPxNY3zt5i09brubDZeiGrYB/SVpBblNZdH9XfHfU2lv72P9ChMwu6eF7
         w52CojVSvRJb0+ptIe4j4H6yyJ/bDvlxjgb8Mq2FL/VWO7gYQ/6rfoS814pKSACHILB0
         Qgkg==
X-Forwarded-Encrypted: i=1; AJvYcCXhIhQrO/XCQwoH1VGSiL/9IpacINRH2EoatNO742ZRIYc7grcc/YZnd6qnzSN5zLq/3svQTt3G7Y4JdbCgRYU2/suS
X-Gm-Message-State: AOJu0YxcbkihwBRfY1JBQ2FkL7cSKFVc+drA6gC9ix8X7AFlK3y62MCu
	2EfDBK4VPxYKPxxt4YcTS5iy0lFgU5W1IxKMUn7OlrYMeRXbvHUq
X-Google-Smtp-Source: AGHT+IFEb0QHdJOs8X9TPQEH9GWhMJ1ZuS8Kzm3gdchFA4+vdsxMYRoOTqrIejUy8OLdycaG/7I36A==
X-Received: by 2002:a05:6a20:2588:b0:1af:dd56:76f0 with SMTP id adf61e73a8af0-1b2b6f2cc6bmr5515245637.22.1717649774840;
        Wed, 05 Jun 2024 21:56:14 -0700 (PDT)
Received: from [100.113.38.39] ([116.90.72.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806bd67csm2431735a91.43.2024.06.05.21.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 21:56:14 -0700 (PDT)
Message-ID: <a3b8a245-fd88-4798-990c-a06c911ce067@gmail.com>
Date: Thu, 6 Jun 2024 14:56:08 +1000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2] date: detect underflow when parsing dates with
 positive timezone offset
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
 darcy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
 <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <xmqqwmn66zzc.fsf@gitster.g> <2d771a72-3021-46db-ac32-e008a7ace34c@gmail.com>
 <67c23773-21a4-4ad5-9b98-5e44578166dd@gmail.com>
 <4574e410-ca1a-495f-9835-14ee3fa454a1@gmail.com>
 <7ae05b6a-fb63-4ec7-8006-e968862cc5c7@gmail.com> <xmqq1q5bti4g.fsf@gitster.g>
Content-Language: en-US
From: darcy <acednes@gmail.com>
In-Reply-To: <xmqq1q5bti4g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/24 03:27, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Thanks for taking a closer look, I wasn't aware of that. Reading
>> Peff's reply it seems like timestamp is actually unsigned and as we
>> limit the maximum year to 2099 it seems unlikely we'll overflow from
>> too larger date after all.
> Thanks all.
>
> I haven't seen one question I posed answered, though.  Has
> https://git.github.io/htmldocs/SubmittingPatches.html#real-name
> been followed in this patch when signing off the patch?

I have changed the line in the commit to properly follow that rule.

