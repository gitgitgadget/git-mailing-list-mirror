Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C87823B5
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200621; cv=none; b=JocSCCa/b78jDyWtuVovkSD9/piQPfi836RT6XjulroR18SrMR40ALKfHr0w3/YAFLTnv1P5lzjC34ZgiEfc/z9YHuOQawviocRRFg+XORsMUCSrcpC0ld6Ssui/egjPwc2mB9eO4z7n1NfOLJN5VpBcC9XEswPYimgm5j+dKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200621; c=relaxed/simple;
	bh=lMB43imtnfXDHyPC7C3M7MS6h2Dh6P9lGJCk6HsUS/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdmsvReN1756CxgZ51FLdXJHvD208PC/v3YPiE8FLvVkG//2R+IJXzTnTYj2EcHFWOW9WMYYErN/6NYln3MPh6B2C/7Rce2W+ClqBpXRZXCzl6UyurWivtwlycYQ8gamdFQjxtamQykMxfrzEntAt2p5jDNJhuC3hAONnMBkUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9yKNWUz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9yKNWUz"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so33840781fa.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713200618; x=1713805418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMtBCE4e/RmoEGkHC33F/1s/GINRx5Gx/zcFVxzhVJY=;
        b=V9yKNWUz1fFQyRKqEmRkYFE0xKrK2c0CrC/w4qRmM5frKkyV421/Ax1VWJwb5BybLb
         cpTNFhmMwansqyAWBBscH3YJpe9mQd5sPlnGrA4fzrlFTJC/51shteUcrwFeLezR8kl+
         lGaMEmDBYNdqUEpuEMkhsXd1CpJtU4ZSfHXfoLMAzUOw87R4Z1upecqMDJG8UlKr5rRN
         lPRjjLjmi455C4y9ss9u+lmDeB+vmxXhleKUpMELzcy+C8E6UYLxccLyWFQew9jzAmrZ
         TznbDmto9QGmqw+3wn6DStTgzh3z3Ty2b1T/cXuzivbECi/sT4fyBdr5/0UuR+cz5woM
         cPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200618; x=1713805418;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMtBCE4e/RmoEGkHC33F/1s/GINRx5Gx/zcFVxzhVJY=;
        b=Pez6zYjmHp4mams2LBeAvXYVBWUHfBgGgUJOiT70Sa+fbiUsJFmY+C6VU1asSI1dH3
         Tn0N+UgHFlQJG7hssmBkfxzT64k8VCR1U6wmFx+iFvpD0V/hApuhfhrzEx8WxXn5oFZc
         1dN/zVi8adQ+GKBLaA+6ckF6sPlsehhmgtRnBKWm4zlapPJ0DdgBp6WoST0r/o9jBweo
         +96xwraE10WclXA/rwtcWPqzskHJKJdFDHTEecn6QaGgqHGQsTTWAhvfz7fiHzQEMuQV
         8/6IrTpftOgYRRpftv9OsagRAvncoF7ElYqeMG1aE4EFAeHKlILoKgGkg9EHUAZDlWoC
         btnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfR1R5OyM0IrzW2Cgu3F0OiHjnJcvdRvN44AqV7yCnRewBIgDqtxPY0VDz2y3/9OYwf7BtBH7ykF2AjQxTPl45WB0D
X-Gm-Message-State: AOJu0YymVo50XmbQ6GHonDI6CKc+Pt9rFnuslzAkkNQDLbEU+kAFjtnV
	Kmr+j5y0j5Vuu+0AdJkFOJTSpR+8dZC2CwFWXebrWC7cNtXVH3ACLf677Q==
X-Google-Smtp-Source: AGHT+IHJFymBY3wBg6F6wyEuUOJARwg6A4yFxw8wmf2B4x1V7EerBobnbtl13LgXCgWIMTIKUO1Mbw==
X-Received: by 2002:a2e:b005:0:b0:2d4:a8cf:e798 with SMTP id y5-20020a2eb005000000b002d4a8cfe798mr8515694ljk.14.1713200617698;
        Mon, 15 Apr 2024 10:03:37 -0700 (PDT)
Received: from gmail.com (91.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.91])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c450900b00417e01ce03bsm15912862wmo.17.2024.04.15.10.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 10:03:37 -0700 (PDT)
Message-ID: <c9f3b358-bce0-41dd-b717-e845f0b2dab3@gmail.com>
Date: Mon, 15 Apr 2024 19:03:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] launch_editor: waiting message on error
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
 <e208da74-8f16-44ae-912e-ae968da82057@gmail.com>
 <beebf170-31d0-4ecf-b029-d6bc499f6da8@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <beebf170-31d0-4ecf-b029-d6bc499f6da8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Apr 15, 2024 at 03:05:32PM +0100, Phillip Wood wrote:

> > However, it is possible that the editor exits with an error status, in
> > which case we show an error message and then return to our caller.  In
> > such a case, the error message is given where the terminal cursor
> > happens to be, which is most likely after the "we are waiting for your
> > editor" message on the same line.
> 
> As I've said before I'm not sure how likely that is as I think the editor
> will probably have printed a message if there was an error.

For instance, Vim with ":cq" does not emit any error message.

> Assuming the
> message from the editor ends with a newline the proposed change wont do any
> harm so I don't object to it.

Thanks.
