Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C13630A5
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582741; cv=none; b=tesdD3iRYQU8GYyieUBtApu4jNN+oGXxbtC76vm5Tsfp8wFu1CdBtjWiA+Oe+r8aibrB2gSB3vrng3TxIFxxbtnW6Cjr/G0KzNGrvoXuxaSx0CfwYIuO+3CpG1+dQcObLnAYlONG9Bm9FvSo/Fkv1XFg9wFmX2D03qEfZjVCHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582741; c=relaxed/simple;
	bh=udd9bs9jcSqW7r5amWlAxHwPryJaHZkj754UbRawhfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oV6Zq+qZAYQKggA4Wjq2IAC4da5CZ3Ab9ziVEc4UzwBJBs5y9iV33s0OFcnPS3ji7mGKuQqo68588NqKQIZgFFHAcPrN1dJY2Y7imSHfxbbhD5YEZF5lL/ZzRbJJYBqyjiBSwDwvpU+lHx1daI5eRIm85kN7mKsyAUxte6k/G1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyKW4xDe; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyKW4xDe"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e7c6ec9dbso154221085a.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787582739; x=1788187539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=700uH5Cr3l/sC+EC7R+9NsGtFAxhWYobTCjcr1sJQ3s=;
        b=CyKW4xDeQaa9X7FFn6JGkpHb0+SWqjcCoaqd8x5Ny7+wrUUuTtYiM9P0iHjN3Ks9qv
         5U428ntXtbsZkGceQ/+RiNjw6Ct2wxdaPYSs5ejDcmdGAaJ5Zi8AFmfkCZI8Asva00QY
         he8tdEn9CCUdBFNidXdhHBqB0uA3gp9lyzLznmRVAHwHlg7WZWoRkZN/NLfsj1pTu32i
         80Z5XA8fp6K9nQElDw2C5OwVTUfmxA/07YoRoEPNp6jEqVl5RpbsudNnxXHMX+5EldeV
         MEZE1kEI0o17sVSUrwgLRxkW1s86vHvpEhAM1/zOUys0XirvYRWqaw2dPyGIdcrJso6y
         rxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582739; x=1788187539;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=700uH5Cr3l/sC+EC7R+9NsGtFAxhWYobTCjcr1sJQ3s=;
        b=A8UfGwzC5FGZ2mLvlZipsKeV/O/sEEuvKRymHmy4MlZf0GlwMh/6nycifsz1+Tq0nX
         tAxyBRy8etUIhnZt1b0kdGBBRzF48/qnTdUzM45/XMs6p34RF7BujaIbIo+6H2bSKA1X
         4gw6EgdvWybJSXb2iyf5GssmI1yK/oxi84WPBn4UD902+jnk/EzYX6Fz8z41MvUGkp9C
         odPXTyMnY57XyJOJ8UguTyTB7M119AhS1hXSzpvB+jDDXdAlM1988BJ3iT6JJO46bbbH
         q/VStqsAiBmQ3UpiawW0j/74fx8qLlYi0vwM8gFeIs9nIzDv5urcdybE9j+dpc9LY1st
         F+cA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0oB1RzEleb2N7XOoQ2ofp+Ao2oZmLPq8zWPz450ETZcC6HunLVMdFHpRgEhDibcWiMb0=@vger.kernel.org
X-Gm-Message-State: AFuF++lCFrxNC9uy+kRBbC3hjYAiEm7jXrnv+0gh2kKcMoNfar25RFkI
	TpHvTGr4zQFkVW9agU4EcYzXrVBCJKdLtWuFiRpt/KTBMDfVeBjsJO8V
X-Gm-Gg: AR+sD11RrCjp4h1OoFl7EeIAKoY9B/MF3VECvUwqOFa6KgyjBcyoWP6ZQlAPza1pX8P
	ZDDlJeIPPtCTQC1k7/sPhiBlSO3SJ+J1jFDiJI3uItposdjS3xAkXbzLGsvuy7N9cu37/8HYXKz
	LWD8rrqYf+OJhU0rfWBrvUEMeL53fLWdYqBecuAjJm247H2+TpDPHwfYo0ebIpWdcEteji/V0hJ
	HLBIGc0yNuG8vvbTPuSoQDixa8B6OU+0Pd7kLB4xHjkk0udRgWzI7c2h3C0HdS2GpmLp5uKDDyS
	y2AaUMb6z7M+OkISevcw3eG1Yd7cCIfylrbyTAXS7AcV+I2DfqilN79e9HUYAz5WShWxlmLK4J8
	sLf/yVRpqTGjYwYTs6cX9wG2RIdVgCS6XDAS96XEouA2FyoMD+hbYmi/+XK83vrAtfHg2aoSSDI
	adOoPONKy7gZiJrl3xp3tErH4yDkcJIKw7xYN2JcatMygxla8nUG791oftCnJw1atexq3Mwd9J/
	tyrZiTocWHNrIrmLSEt6CHh3FYvUoIQtXO6bkhfONTi7kG4zkHWC0Ehi1vHqNa0Ds9ocHQXFLa+
	YQU5KANw9g5otmU=
X-Received: by 2002:a05:620a:1b84:b0:91d:6ac3:565a with SMTP id af79cd13be357-93739496be1mr2614516985a.12.1787582738824;
        Mon, 24 Aug 2026 07:45:38 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749abeb0asm513796785a.2.2026.08.24.07.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:45:37 -0700 (PDT)
Message-ID: <ebaae70f-9e21-4673-b051-09e30420631e@gmail.com>
Date: Mon, 24 Aug 2026 10:45:36 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/2026 6:34 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When a geometric repack runs concurrently with other git processes, it
> can write a new pack and multi-pack-index and then delete older packs
> that the new one subsumes.  One or more of those older packs may have
> been indexed by the previous multi-pack-index.  A process that already
> had the previous multi-pack-index open keeps using it, and that stale
> index still records the removed pack(s) as owning some objects.

This kind of race is why 'git multi-pack-index expire' exists, to
delete packfiles whose objects are all referenced within other
packfiles. The inclusion of these "stale" packs in the multi-pack-index
helps halt reads of those packfiles by new processes while allowing
them to be read by existing processes.

This is currently used in the incremental repacks done by 'git
multi-pack-index repack' and maybe could be used again in this kind
of geometric repack.

(This dance is more important on Windows platforms where read handles
prevent deletions, so it's common to have a foreground operation
prevent a packfile deletion in background maintenance.)

I do think your attempts to be more robust to missing packs is good,
but the comment thread does show that it's a complicated situation
that we may want to avoid whenever possible. Leaving some redundant
data around for some time interval can reduce the number of times
that the fallback logic is triggered.

Thanks,
-Stolee

