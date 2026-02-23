Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62401799F
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771807964; cv=none; b=OK56Y7MTUaAbNqGUOjYpDdwnbmeZiiY4LygulD2EeyweHyQ3+cxuieyewxhBEabDMhDeY94XQlclHXEHahz7fa74uhQZVG5UZMXhYDI3uK7tg9LUDOTNZNiKGMxIJ3318k35X20LferjiD2LNuVzYTan6IVtmzFihpwCJYRsOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771807964; c=relaxed/simple;
	bh=hkMDXiZk4UvFLsjHdr+gcOMltsErIzyDUTewoiNYzUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWhOT3iRWAPUlGPMpmfBShw2lqNuTwq7RAkDMvBTC6W+i39v+L99kt5PoyEUZrv0xj0dQ1bS9PCBac71hCOKdvu0ov8xeC0BJc6GVul5lY7QrpjIwElMWDUd5qS8yvbbvr9POK9jvRyeGZnzkDeC0lyIQnh/3TACbMfm+U5kLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngma2x4d; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngma2x4d"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3fb47559so358696585a.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 16:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771807962; x=1772412762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mh+hefL3AZrrj/+dpAd28AAq/rZRRWtuDyBRFjKzF3U=;
        b=Ngma2x4dB/2mz1imJL777Xn6YtDzj5DIqUCNZQWJ0bX7v1/zgAQayUjkTBXoWlrQ/K
         dsiP7JxGhW0ey1GKiSNGQnRJLR0u9J7VbWt8s7y5fNBV/iDuV4kWegZxTF+WKg9LIMBK
         tOs5jLt4hQKHw3cP8QuyDkr9FY8JMy6s9maaRWvp9dShN9C3CV8+aJ9brlOyhbB1Ayk5
         KuR6+zBHcMp7EWYSUcy0hjBoyAutZV2fMLtd8jtGmsqyRQ1K+Vg/p91cNAsq3T9gyG93
         HJvGFn5DbfuYxWVJ2JFH5q3AEhS39At2ADkZbb9cLQvxA8qgNI82dZAskBkkzRYRDcep
         TRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771807962; x=1772412762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mh+hefL3AZrrj/+dpAd28AAq/rZRRWtuDyBRFjKzF3U=;
        b=jZYox/ProZdiw+Wk3MKi2gDa4ktYj2/xT1Bm7J2mPiwOUOriOH5BAV5noDqpGJv8TG
         7CaqJL9XTzGfBI9VlcZF/vqbTn/MFlfHNw2EozaYL/LpjxfRoLANL19jReqg91lG0Efa
         aFw6cr8s2Tu6K+mfWBM5b8HP0CsvpICMv+guepa1mLvzFJ7mMMzp+NBW4mys8MEeQApX
         cdTCj/5H4pS/ah9R0OG/UGRP/pTAGMtyNqaEe6PUgwh/aTpvzrV4eEu8Fi6mx/+qOceJ
         /hyMHMWSjR7SE75uJOMBHVw/K/2LgoMX23PACDwlb89n7lV+zJ8kFQI/eTEr38c9lI14
         z1fA==
X-Forwarded-Encrypted: i=1; AJvYcCV38ISek+G3siM3yUD/UKJBfWZz/RjlIHzxSFRt8/n1APgcPq1bDg68eOThoOLisFfAplw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz24gfFBIrSjC6tfSzDkTpnXhzcTwX0zmIiffSz+3jN4hk+cXJ5
	YSj5W0hfDmYwUIlLoR5BibgQ1SicUADVXMpeCaZf550shMHHuJtSBqGrv6U4FQ==
X-Gm-Gg: AZuq6aJukoAcQ5ji+HaarV6jT9pauWP6r4abz9Fep6llDF0wnUt01GqBPJXeSMA/2r/
	kwSZQP/oKugPGc3hNqpIpkMXueaDocfv19HzKkekIjjZRkHoiupiG6WmCjaEGac0oLMxgfWIWsf
	n8FlFPM8ivPyGACSO1BMFPH3j3MfJuiW92e9+g/tlsVpvfRNP6p7aQCx22qSDEVV/+2IEPusgsq
	vq7wwy2zRjZJbFHozKpPDm/QnubafZC5PHqvuUWgghuEVsB8ZcoLycv0PHzHEAyElrVIiI9aQ2e
	JUD2foMniPBG9rkUGqPzwE/RNwug7DqUwFU0WVcWrdh1drFBaperSc+Y37VDPVleBf7dXomRFab
	nF/CRn6aoT/v8bx5VArZREMqUeGnzHtee3YCUIeqKDZ43xKDvRkahiIZc7Xizp/xKQDn63RG9od
	dppo/FUNFNTvxoAca796AgABcHH8P8HuxADL8ND1Dzsd8LpyfWA0F4kpuZ7Y0eISK+LQsnLxkxu
	B8dDOVuUVFKTsJu1lOGvE8qsUgZYS2oOBH4SC0pxMT8VZh9
X-Received: by 2002:a05:620a:414d:b0:8cb:4d93:ee69 with SMTP id af79cd13be357-8cb8ca930e3mr949434585a.75.1771807961851;
        Sun, 22 Feb 2026 16:52:41 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a1e6fsm54609001cf.16.2026.02.22.16.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 16:52:40 -0800 (PST)
Message-ID: <4ec59d18-5aef-48e9-a4ec-77e20a2a14c8@gmail.com>
Date: Sun, 22 Feb 2026 19:52:40 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] builtin/maintenance: use "geometric" strategy by
 default
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-8-faeb321ad13b@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-8-faeb321ad13b@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/26 5:15 AM, Patrick Steinhardt wrote:
> The git-gc(1) command has been introduced in the early days of Git in
> 30f610b7b0 (Create 'git gc' to perform common maintenance operations.,
> 2006-12-27) as the main repository maintenance utility. And while the
> tool has of course evolved since then to cover new parts, the basic
> strategy it uses has never really changed much.

I agree that the 'gc' strategy no longer serves users as a good default.
For those that want foreground commands to trigger maintenance (detached
on Unix, and as a blocking child on Windows) the 'geometric' strategy is
a good one.

> Switch the default strategy away from "gc" to "geometric", but retain
> the "incremental" strategy configured by Scalar.

Instead of "configured by Scalar" I'd say instead "configured when
initializing background maintenance with 'git maintenance start'" which
is how how Scalar sets this up indirectly.

Users could still opt-in to 'geometric' in the background, but it
would cause difficulties for the largest of repos that rely on the
'incremental' strategy's limit of the amount of data processed.

>   	} else {
> -		strategy = gc_strategy;
> +		strategy = geometric_strategy;
>   		type = MAINTENANCE_TYPE_MANUAL;
>   	}

Should this include some kind of documentation update in
Documentation/config/maintenance.adoc?

Thanks,
-Stolee


