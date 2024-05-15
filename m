Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF103C466
	for <git@vger.kernel.org>; Wed, 15 May 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801634; cv=none; b=DSe25PindW+2Bl0gQGRB5vx9iVPheoIGmVyii+eGEgHOmXO614qWr1YJ8+SdtUSQi6RVI5Z66csqgtm0P3UPw2JfDaiq+vxmSjFolLBiOaioSAuYRZi/3sM/6wTI9jhBPgG5lvRRLP94gT/XekTv+cLM+2DZyJoqs0bewtFsmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801634; c=relaxed/simple;
	bh=A2rX2qkMW4DA9zGm1a0sJfqsTNgmPLMm8Q+pDAyK3WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SL8zf2Opee2Bda4aZWh53wccs4xRlOSflDR7BLqIh3EX/yqi1xwoPC/yFR69eOV+h2+yQweDJqx9uCiuqWAMtFN2UQ+aWgKEAdOARiaue0G50fa7tYqec0ssCZ+PwHrvWnDJ/9oi/FSwFVN2aQk1/rvDsyfyK7paj5FFegdMx/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDok0lfx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDok0lfx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-420104e5390so45684645e9.1
        for <git@vger.kernel.org>; Wed, 15 May 2024 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715801632; x=1716406432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcJ0hrAP4wOT4cGKqjkb3GIObINonVCxOp5QMEwmDRc=;
        b=lDok0lfxEEJ2obD8A3xOBasZnd437wTAx4RXn1R4k7gUlA8GV4XSr4JtXGDeKEtlJ/
         5vuCZ/QZ5vucjIruCux0LF9AMsB/EnIGfJsWuhv/aWAzPMYUR6IT9XbmLMWzFYsSPO7Y
         Ud5Y2uAPUhbYRlr59Smj9vdO3IWMMlcIxJpQ/WFHutwzATsidpjYtRHf5FdC7F8R3u/3
         NnbP97vrswpHkiTjzHoOx0AYJL45ih0ICRPbZQqPGZ6Ix1jDDuC1KdvOh50wwdKuydEC
         m4i2MDAwYAJfzkGhDf04SirgBoraeRr6Vk0pVRYZuqzVjcnbAo515woeNtcKg02fS/MN
         BMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801632; x=1716406432;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcJ0hrAP4wOT4cGKqjkb3GIObINonVCxOp5QMEwmDRc=;
        b=SnbCFn3bT/wOd06p4k9CucyGxZ4kHCdgSZKgACmU8/8ED4bktVWgEHUD4E9+ibkkgR
         f/g2JBVV60EkqZ2PJQ8a8xGnjqb6bTeAaxtojc6u3kpDHFxs6iRIYWXv0hhfwfNfmNPY
         e8n2orNK1rXZFOKx7Hldv6etBIkGk2mBICiHLgUZwKvjEtZl5QvOdWaMfXS9vhb7qtOJ
         5OD02MzgFAxRH678GaKcD2qskTV9NRl1xBgCBXpRAbRG2s3aCDelvroXsY9ET3M609KG
         kw+7wLhBtgzVy/9Kbl/G6TKgqhH/O37OBLcUpVvR3R4Bmo3YQxJTu1pdjRydlMs6ZpFy
         U6MA==
X-Forwarded-Encrypted: i=1; AJvYcCX4AXFQoz7nLuUpR/YF5xPY0E3yx818zSgnWb6beSiPCKVc0Ec+s5W0PLD1ovXCKDL96gS6MgCVNUDkiZ7+U1ghoWzt
X-Gm-Message-State: AOJu0Yy7RfXAq+K1aZSa2vm+QiDtFeh+V0wjxOIKGeNWIMrwztBMwdY/
	H+OdxjpVeGf0aX5aufIdjSnmdSN6YhGdLn5PiJDb9qt6W4muAvu66ltbnC35
X-Google-Smtp-Source: AGHT+IExQuxfpJh7QBU+kTW+YrpyTh5F8cBSZpxzSkACu2HAPyTOwC239ipw5etEv00dZfYF+dA1EQ==
X-Received: by 2002:a05:600c:3d87:b0:420:182e:eb46 with SMTP id 5b1f17b1804b1-420182ef112mr99690065e9.38.1715801631448;
        Wed, 15 May 2024 12:33:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42010b1076dsm161104255e9.41.2024.05.15.12.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 12:33:51 -0700 (PDT)
Message-ID: <bd1c80f9-e8c5-42d6-b36b-52e40a78aeda@gmail.com>
Date: Wed, 15 May 2024 20:33:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (May 2024, #06; Tue, 14)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqcypo47p7.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcypo47p7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 14/05/2024 18:36, Junio C Hamano wrote:
> * pw/rebase-i-error-message (2024-04-08) 2 commits
>   - rebase -i: improve error message when picking merge
>   - rebase -i: pass struct replay_opts to parse_insn_line()
> 
>   When the user adds to "git rebase -i" instruction to "pick" a merge
>   commit, the error experience is not pleasant.  Such an error is now
>   caught earlier in the process that parses the todo list.
> 
>   Expecting a reroll.
>   cf. <88bc0787-e7ae-49e5-99e8-97f6c55ea8c6@gmail.com>
>   source: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>

Sorry, I was hoping to re-roll this week but that's going to happen and 
I'm about to go off the list for a couple of weeks. Feel free to drop 
this if it causes you trouble and I'll re-roll when I'm back on the list.

Best Wishes

Phillip
