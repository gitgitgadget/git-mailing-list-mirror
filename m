Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254734CFD1
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348740; cv=none; b=kuRTzNkZHi82ko/bBOBLpFsU9k2DbTOVTM0vc5v9QfCr6nm3RZd20N1fa4mbQhGkByS1WxXPSxyTZuhgYpTg0f7yxHrTI9th9Q+mV/Tn8+XYH9Is5rQo84cPUo8Q6h1rTFiYP5+nTw1I2C+oDOvuHv649//Z3n7VHezmzWwGXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348740; c=relaxed/simple;
	bh=1dM4veFg6S+lNuupleF8TzWQoL87p6c8V/bWp9V4x2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjueHEfB4/+8AA2Fc1rTEbv/Db5a8+4e8ICWZM3tPr5MNxvBlmKNlC1qPuD3NTh/7jksZhjH1fdgHLvxxX8fh1XwBud4sX+auCJZGc+ca4hMlh73vAHSrp3U89hv9SNLRRzPEXRduo5eKBgEk2o3LGIXSYIhyy4ndYgefbI6YJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQSY9cZJ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQSY9cZJ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso36882341fa.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776348737; x=1776953537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBhdHLlZHBixEo9NU5Ip+RZoGwrTykQ7nIti5ErVlZs=;
        b=JQSY9cZJIBpMYBpBla2ZwdjnjBmyf45wuCUdfZ1Iy2TLX3g2mgtN2rfRVNLTRLH3+R
         a4gmbFkRc9I1mvDLa3OhKo2r/OCs+BSimQQSgOaeeKJ7W1aGZg4sfkfALPC6666AwXto
         w2LYFx/rFanaBnBEh6OX3/szzhmyJL0zXkgJu0m8GgR/+4splrD6177Yh+uIaG1qieS1
         xxsQQyZctFBK1XVNmGOyV4NDqbsZBakIrhKyWi8HRBWcJPTA9+a+iuBmwWkT5H8afpaS
         LA2vkGl1b/H9Gd1I1vpyFXrmgATbj53sY/lLXnp9aA34uK/iTDz/+MwYGrnPkQzf6RRj
         C0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776348737; x=1776953537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBhdHLlZHBixEo9NU5Ip+RZoGwrTykQ7nIti5ErVlZs=;
        b=qha+ZN46wRGQfhvjDJU3ffOlNey1uydfl2cnOdgMduX993WCKbgncCN3e2g7Ru7hnC
         h0vJ2Sz9smnB4qMRa54aIWU8vGG1121SM7arjz5LcIs2XS5ATM5Gc5XeQbg8foQMQPWC
         Wmz+/ZI4FMRK8eeB8p9UD36Vc00sdguIzJZZM+9kLlLFIpSlcsI2VzLCRk3csd0UyATt
         7XjH8gBm7CJIFIYmG7yMmnKCedef9ILtaRvjDZDPVEN7RNs8Ty/4Jfv21h4AofQbuqUt
         LJaxw4zeyDfANrAIOMDDMLX/TnpTjYeU0l62tkoo+O/fPwZlq6qCMCfZKXqD5C/mV3X5
         zLlA==
X-Forwarded-Encrypted: i=1; AFNElJ+ybkU4v2P/rscRHtP2Y2jYbjD50kE8qXg4RAj7XzPXasWT65Za2iKHRMZE4I8V1D5bpR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLaOV+KmfTb7DBjIW3CxHZ+HR3Vsq99FbucjFTj45vaJoHo1sv
	kTSmMQQ7D+QAbJo5NTZFTlNQq0u7t1sShK2Y/5qdIo3hnAmuEtWwhBsJ
X-Gm-Gg: AeBDieuhurquAZxVp/byovHQxUk3IWrTMYNKUq7QtlZvChChDa4FyVc/92r+WDcZsHY
	Lr5o/wkai7+Tx9b06LNQ7779IpZUdA8f58BrQd+/UB2UuclUFYRCTtEmVrScTm1I3WgeOxWwowr
	Pw2y4f2WSh/iYhkMvRV3B8DwGNrTw83+OjnYBdLTuviVfH1Yi4YLE+M06ggUpDMMorWth8TPisX
	cBc69zp+x3NNFLYSR3294HGKloY5OpkmZJ2HZTltSdi7tuOHDcy62S/ZPyCVTvk/GWRSbanRy/H
	gwK6UrzxtB3fkLZwM5YDXEt/tS8xlIyoqk25m5p6Id3go6uH+7xcCsxNoX+tTj1U5+O23kxIFhk
	IqG+CIYFI/zo7GyekctTnER2lB9H7GsQLZCdi8xlH6oiZMpxbnolnWRGEE0UPmeEVoDCWRzo1K9
	ZW6N1JDee3HQVJAbTfehDKagnNby7b6WJy2vba9KxQaDnoUcH1Qaum+6oyejnBTNlmFjc5hw==
X-Received: by 2002:a05:6512:6c7:b0:5a3:cc75:26e9 with SMTP id 2adb3069b0e04-5a3efb38d38mr8616013e87.29.1776348737094;
        Thu, 16 Apr 2026 07:12:17 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4111483f2sm385695e87.39.2026.04.16.07.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:12:16 -0700 (PDT)
Message-ID: <3c9df807-90b5-49c7-92b7-cb5cf6f4f0df@gmail.com>
Date: Thu, 16 Apr 2026 10:12:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] backfill: document acceptance of revision-range in
 more standard manner
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
 <173831ec92ea712a72f790f3a8eea6643ef7488b.1776297482.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <173831ec92ea712a72f790f3a8eea6643ef7488b.1776297482.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/2026 7:58 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> 302aff09223f (backfill: accept revision arguments, 2026-03-26) added
> support for passing revision arguments to 'git backfill' but documented
> them only with a prose sentence:
> 
>     You may also specify the commit limiting options from
>     git-rev-list(1).
> 
> No other command that accepts revision arguments documents them this
> way.  Commands like log, shortlog, and replay define a formal
> <revision-range> entry and include rev-list-options.adoc.  Commands like
> bundle, fast-export, and filter-branch, which pass arguments through to
> the revision machinery without including the full options file, still
> define a formal <git-rev-list-args> entry explaining what is accepted.
> 
> Add a formal <revision-range> entry in the synopsis and OPTIONS section,
> following the convention used by other commands, and mention that
> commit-limiting options from git-rev-list(1) are also accepted.

Thanks for your attention to detail here. I like this version.

-Stolee
