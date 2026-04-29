Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348F23EAB2
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469665; cv=none; b=K9feM70Oxi2Hx0+/xbiy/JIki6FAnBFDuuFenSC/yMF37Q7UYVzIjHenF8rIH3oNjRcu3jVG0osqEDDdI6zcvxX3hFG8F2ZIRSkwMbp+k/0Wan9XeXpYslLEHUL4UFHENXHU7HCh/OipkIXUsHtfODwMRoGfvR+TobPqOSE8wCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469665; c=relaxed/simple;
	bh=/x9Pe0tL6pf6//snhI78loNuhh7wqxeoOjDx4fimyqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+08p+YRHIUyyQ+Rmtvm9sqKXQs0wuu6QdIREwo4Qds+sKqlQOSRNxedYVcT5zT9MAwX37sHQG9HQgL5Kwb+fzGxviCcO5eVm19LHvF9A/5PAnitZ0fMOVyErUrkNlGJ2V9WVTnyJK5RJcBfRusvuV0CDZ9DUBr6aH4KwpUgy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNp9HcIi; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNp9HcIi"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d87c138e1so125003081cf.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777469663; x=1778074463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sX8nuCLpweX5qWzrspfGWVKMToqoGvO0eKUdkA5hE0=;
        b=nNp9HcIibIqiYOmddA+vA3pUVnfOxjDhA3MjY0WUHMbZOsBWIIkQLX61gEvwIixlmf
         WcE5NbXaSMEAreEM4vT3BMNKlaC2hMuyZweOUH3Id9S/qJlcs7fttX9dmSxTHnzaBSpF
         kpM7MppxeKuiu50/ReRMDGGRgmPhPQKe2o4iUG4qUC2YuScr0dxJJ/1d6Ph5Kw04qPhc
         /UAJb2LWsvlDZdM6Ef4d7XZeDjj8BsUg6cWA3CRT/dpHTbd0mjnbr2REHKI1W/23f/E3
         OIRfiusDr0hBoGGX7NAB61o6Xk2J79E//62fqlzcRuUpojRdNIqsgpgDhTCBTChWfbN+
         JI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469663; x=1778074463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sX8nuCLpweX5qWzrspfGWVKMToqoGvO0eKUdkA5hE0=;
        b=oCViZCD8WFRGgtdIEE0fwOF9/7rz1GnvherRlslCTaGL/kOJFnTg/oSpvgA/xTKfpv
         UFB9ki0d38lDH8yNlpRbJBnKS8vYd7aGW2h1qSeYCIbc4EaMGPE9y779QCod/6MsCj6T
         DuoMLAo2DbITopJGAoLU5IYEL2l7sKVijdZFJTtR63BPDPg0QBQr2XVdL9Nx67Ge7mmn
         g3uKDLvdB+jpxEv1JqadGhIqdSWyUptmsh45FzoBmTiyzRI2t55OQ8efyL8rTc6ciCOZ
         +nKi2YEZIt6tK39JCSKX6w23I3+2DBIt0fuB0LFDjsZhuwoSchac/JSvvZosw8hP/RsG
         ZXGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/e5w+UEI6DJntCfd3p7+xomASkgQRCTxCzabRZzx97753+jNsYSEps7RZiwKkU38Gbgko=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9Ro94LsB+13q/yvK8sky/XdlD9oXu+x/iGfszoajkJHq5VSv
	ivOmgTWx7Ly1DDPtBf0+Ri6pjQyXzVOMfB4chsPD48MXgpq6JNxvywGEWav8BzrF
X-Gm-Gg: AeBDiev9uLKmJcTu+EETyBHD+HI9XcCCwHAWhWC7OT5wXCN2mofjS0GIcZBNlK6W8fK
	0ywCInQn30FHsOQ43/cSc9Dd1lkXIauFoURrYqWBKRikoAuJrGl+3Elo1YTLV05t/PfB/fkQfEr
	HGJJ7PerO0SGWXOUM2z7y6HQ0Xh909TXvjYmKejMcoX95tmF0XTSkj0eQbQt1qxnG9vdKLlVJnG
	RzVL4bcOKUG2gJnG1EcuvLOqh1ai5l21Opi8ACdpTQ8zUCdUFEWNfVy+Q5Iok/Ui+I9kT+1WvMF
	VmUZ6R1/sW1hJbIqge/MGet+lhp99iGQwNhDHKfvDM5p6u3P+PGOZQlysVf6gAif53kU3jZ/Acu
	N2JjScUWIUtf/i69lrC/UcelLWhOOXyLq6U/aPgcJ4b0nlsNQvukTezRlR1x2giIHnyoWrJDBDA
	z+PX6tlONp/0PjzeJlZUMCOxdHkQxiFwP0mSgkwaKRBMcPgisVbCIqGRQs4QHydUxDnt0WaZrFB
	XHysm46Hpw+Eq5UqRhxEcUPU594Dw0m8a6BKZCjkei7UgGyBZ9Jvq0acY4UtQ==
X-Received: by 2002:a05:622a:1e8c:b0:50f:bdc3:656b with SMTP id d75a77b69052e-5100e21f693mr112534981cf.59.1777469662771;
        Wed, 29 Apr 2026 06:34:22 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:c8b0:7338:485b:4bd7? ([2605:a601:9b88:8300:c8b0:7338:485b:4bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101accdc2bsm19338101cf.10.2026.04.29.06.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 06:34:22 -0700 (PDT)
Message-ID: <e1e8837f-7374-4079-ba87-ab95dd156e33@gmail.com>
Date: Wed, 29 Apr 2026 09:34:21 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] t5608: add regression test for >4GB object clone
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <a3019888d8465e0f77926a91a20db170fef6989d.1777393580.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a3019888d8465e0f77926a91a20db170fef6989d.1777393580.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 12:26 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The shift overflow bug in index-pack and unpack-objects caused incorrect
> object size calculation when the encoded size required more than 32 bits
> of shift. This would result in corrupted or failed unpacking of objects
> larger than 4GB.
> 
> Add a test that creates a pack file containing a 4GB+ blob using the
> new 'test-tool synthesize pack --reachable-large' command, then clones
> the repository to verify the fix works correctly.

As mentioned in the previous patch, constructing this large packfile
takes ~4 minutes in CI pipelines. That's quite a lot to handle for
every CI run.

> +test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '

Your prereq here prevents it from running on 32-bit builds, which is
good. However, I wonder if it would be worth also specifying these
tests as expensive. It's less likely that these layers will be touched
often, so it should be enough to run these on major occasions, such as
testing a release candidate.

(I also think it's appropriate to have these tests _not_ be marked
expensive in their original contribution to git-for-windows/git,
because the pull request build should prove that the tests work. And
maybe git-for-windows/git should keep them for every PR since that's
where the tests matter the most.)

I suppose this also is a question for Junio and our process for
validating releases. Do we have a certain cadence where we run the
expensive tests? What has been our threshold for hiding a test case
behind the expensive label?

Thanks,
-Stolee

