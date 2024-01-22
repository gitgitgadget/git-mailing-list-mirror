Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDD40BE1
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953303; cv=none; b=ABpdYDPpCSOizpUU4a8fZwVQnzGAnvEs+L70iVot9RBzd+6wQfwt4+ED3E15DDo2XN1OVRKaeg2tyJEJvuBR2PuVigAVLCv99jzTPSEp80URKnR0wd+AlU49fweUmNICtL6/96R3HeXZYVDawSWKRkwnrA4p3FNCV7MPKvQNRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953303; c=relaxed/simple;
	bh=gHZVHLtA7G9ClGZkFsc2MCwZkq0EnkX9ShpMEiORKfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGipHWHP2r1jsaROQKZUyvxFtlvQ6f4QfWRQYeM4Z30oBzcvWuxmSQKrCfINwzdR9HKjmnt2dAIPYIf2fPAw/jfFsTYUGfv3B3HUMR4zBK2NsoBk6+CwcfGnUhd6yAXs0NMhQvnKrW1Dd2JDTt39xYVo0zJYmK/QwFUg6Zkl3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv1U3jTo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv1U3jTo"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso40647985e9.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 11:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705953299; x=1706558099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Fe1nDdOVHbSQyuRf8d3Lnj6s77HB6LFcWcGlxGc/R4=;
        b=dv1U3jTopFNYzqbYYXy+LXbCGRF/kTOByW1s69syaHPZbg/8jvZHJ5DRRMiiv4hFeA
         ItY3LTvAOY8JGbEFIQTD/pxRs3AovpVCiS06DtyqDdAEsfWFA6TjNjZ5Tn0tJMdUbETq
         IHL+a5y827xS5WF2zvP47+cZ+Vaxoo389iejg3V2NWkGndr1EU0dGRcqQvyvdWxDCkfy
         Vxma6gesYF8/zdRSGajuH54OYJhmtTI1dAMJX2CuR2Fts2vicrrj50++eiSgwKjnP+aJ
         KtbK2UinBv4uFW5N/qKf2JnsKo3XMRUlEskr3+9eNXEvAeGbwiJUV8VE9e2igTO7Bh5x
         QDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705953299; x=1706558099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Fe1nDdOVHbSQyuRf8d3Lnj6s77HB6LFcWcGlxGc/R4=;
        b=UKTdWSY45X+nHCSsW4eJ1ALMqzinzK+KJIga7EiZZzMHTpCmIDXlrWRJikcCXKVy1O
         0fuUrf+4pqm5fTAKIpvMZnc4f0gLwmUlgvZ/qOloBS+oSV0hTbyWFDBr8xGN5RS0oOrm
         6+9AXTHa42RVPKlgiWwbfLzAAewGafQNrc03/oSy1KRb60YE5VlREgjsqDeKz+TASFgK
         lY+u6wkOGCZC2LXJc6YIWSrW7A4HTjfqZ0T/SMGSQ/T09jGx+Go4JYtCe4y/SHkPhReb
         PbQW9roeSRRULpoCcrEkwjzK38nyG+s4fpUTc1QPf1FbEjybeltJQCeWper37cXFQFew
         LmQg==
X-Gm-Message-State: AOJu0Yz0wjg8MPiwceir6Npa1P5/XR+fKeecrhdNOu8zngj4PLUPQozc
	kEE8Wd9TK66BN4AtcM2Hut5XCCLuPV7uJlPrlbBSQTZ3aDIaImhU6134/4Nq
X-Google-Smtp-Source: AGHT+IFXCGt9JcUwa6ZXAUnvbNtTrqNJdGdNLjdY/BN19qc9UNhq0RvOJQpCd0pz2SnKUXLmQEZsNw==
X-Received: by 2002:a1c:7711:0:b0:40e:5cb5:916c with SMTP id t17-20020a1c7711000000b0040e5cb5916cmr2728463wmi.129.1705953299070;
        Mon, 22 Jan 2024 11:54:59 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id bh11-20020a05600c3d0b00b0040eabc7cfacsm5793087wmb.16.2024.01.22.11.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 11:54:58 -0800 (PST)
Message-ID: <a7712d26-7c63-4c77-b339-126d05be6b0d@gmail.com>
Date: Mon, 22 Jan 2024 19:54:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/7] sequencer: introduce functions to handle autostashes
 via refs
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <cover.1705659748.git.ps@pks.im>
 <abcf1f5cf428072d19639dc4209e0c1554f3eb53.1705659748.git.ps@pks.im>
 <xmqqbk9hjdai.fsf@gitster.g> <Za5IoEjs0q7cf354@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Za5IoEjs0q7cf354@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/01/2024 10:51, Patrick Steinhardt wrote:
> On Fri, Jan 19, 2024 at 12:09:25PM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> The conversion (rather, the introduction to allow refs API to be
>> used to access them) look correct, but offhand I do not know what
>> the implication of leaving the file based interface would be.
> 
> We have said in past discussions that the sequencer state should remain
> self contained, and that requires us to keep the files-based interface.
> Refactoring it would likely be a larger undertaking, as we have also
> said that refs must either have pseudo-ref syntax or start with "refs/".
> 
> The sequencer with its "rebase-merge/autostash" files doesn't conform to
> either of those requirements, so we would also have to rename those
> reflike files. I doubt that this is really worth it, so I would keep
> those around as internal implementation details of how the sequencer
> works. These refs are not supposed to be accessed by the user in the
> first place, and we do not document their existence to the best of my
> knowledge. Also, `git rev-parse rebase-merge/autostash` would fail.

Exactly "rebase-merge/autostash" is a detail of the rebase 
implementation, it is not a ref that users should be using.

> So overall I think it's fine to leave this internal sequencer state as
> self-contained as it is.

That's my feeling too

Best Wishes

Phillip
