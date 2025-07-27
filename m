Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C204A33
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631214; cv=none; b=n09WQ6UOQ0qDgGEIqNokaV9IcrCFopkFM3JieR6nw2ub7GEfQeBSefATAQZq1g2tia5i7amhWL9efiKkqpfrRuiQ0bYVpg3Wo8M2Ykm5SRhY6yxQrUecL8F9DVM0byJ5rBTwY+j5rC5R4xoYFQQ/7pAc9I8amWnbbdd5CF1TYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631214; c=relaxed/simple;
	bh=Bl6UsqqyotGu37R2f4izCjRTwO7OKy7fYyxTjO1F3jU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hyU10oTIr8tzP5R0Ncu9uXfGLD458bnavPZnlM51+Fr2fzC3P1X+4UmhTVg2Mt/cGy79W5hS/EVkvvY+tbZUxz13oOaMCUsbKSPI5WCFNFvKStirTT25oe8OikThsK4GrBXU+UsYpp5jUxieMZzm2UnUv7rTzMmxbpydXYS19HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiXsERSu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiXsERSu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b783d851e6so521992f8f.0
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753631211; x=1754236011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtOPfDkRd0onHbk9KGr1p+3AMm74YwRgIjvAXJhafaM=;
        b=SiXsERSu4jnecmbm3/HCzlInOxbFCoa3XfIf1jfGzTmyR4faGZdj81ZN+wl8v2h8tH
         +aQG97GbVS/batwh/Fl0btrZQ6O74RDcp8D0F89iaA7aeaonWE4ngsd9+maRtCxOrEbT
         Ah2u/nZMo2AyBCtOTT+2Sqga5IfRnwrq96C1qtZRfMAxZJm6AsrojV8Hu6KG5JxNfmH0
         JV2CeD7oG4hfczwjAxtOyA9XbIcZds6HGCaqJDz3gH/IdTxNWWURwXeItrpDWSY0Bmdt
         P/wGicWukGlU9fp2NdLl8uIoslu7XxnBtdtgTXM1J0BvDKfQCG1JnYWWeOA/8qH9Xslx
         ECtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753631211; x=1754236011;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtOPfDkRd0onHbk9KGr1p+3AMm74YwRgIjvAXJhafaM=;
        b=r6sZ+TuolhLAHi9drEZdR89rsIX7VYa8o0koQy0apMeEczo66yroAtDyjJeIvN9AoB
         Snzdc7YGTNHqKXLbtWwGN1ofEucgmcFRN/siarVw9m0iqrNTHD7kExlL6EqczVQKKYL/
         7EAQ0dMb5VqiotWxuRTs/khUZMCzpiqCmwUDZ39U8oX2LxFdA4z6sE+8udM0X+x6Bf86
         WwLH+Cs+F0yAE3X41n9ieUiWt7Wh9sYY8ZCg/zDnRc2ivZE4uOj+pxQ1AFIyKlgdZSKR
         wVIxsqm6cvNQ/dfRTnx3biu3Ik973F8IkfV7jpe4kQGNtO5cBfg610asjlUKJRuLIlzt
         6iJg==
X-Gm-Message-State: AOJu0YwHrRPciV0kUjdh0ZQMYmBaqv5UbuxViP7tPcg5JMYtiBcsfZfb
	Vatp0KzXB+0fsOgZPfTjGyQsxtRCvlnSLPoY0ewtGrertW5rMbCxlHB0wmMmig==
X-Gm-Gg: ASbGnctT1hoKlfG5YJ5lM2pw7kC40n4MNZqiuwyLimzw8JK51mjBvcsgdk4fu+ae92R
	CqePfv73FR1sRK57JV/DnCLRFltGtKqObwDcYs29uiIeZRfN8RGDHnl5IrRG3jVYHVijUZM34nx
	xUxrISfo5jlGatNfDlMlZ8YhLZUXWrzcQUmvxWKbJN1cswFpMEtdokuJbhPKRIjmTbnRzO7YUs1
	DbzNYlAmvqX+BRWAfFzak0CZ4FfJuiSC7TZXxx2ecGvsU6xncRFNevYPKHUuzFfwzvCFPMGfs8Z
	bTftgUxglXnMGb5exRZsSyKv9u4tNZcXQlXf/rKdw+oRMAdhfHZBnWq8P6U40WmtuN7nfJXIB+p
	aC0JLeLiijL1JMfrV0EhDKTVUSxXPzRNCwvFxIzefAjCMBiRtDkJz4h7pOSzDA3MOPI/kvVJLcF
	fj
X-Google-Smtp-Source: AGHT+IE3veVZdhos+4UCW/6Ch74jw3fE0asbnwRYMEqHQkyPmQ/EZCgYUjfhgxblH/hlVpqxFQgNog==
X-Received: by 2002:a05:6000:22ca:b0:3b7:791b:649b with SMTP id ffacd0b85a97d-3b7791b67d5mr4593973f8f.11.1753631211010;
        Sun, 27 Jul 2025 08:46:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7822d8cbasm3913899f8f.68.2025.07.27.08.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 08:46:50 -0700 (PDT)
Message-ID: <b4316fea-ad1f-495c-bf38-e39f5180bdc5@gmail.com>
Date: Sun, 27 Jul 2025 16:46:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Taylor Blau
 <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <xmqqjz4iv7mt.fsf@gitster.g> <f679151a-c843-44d4-9e28-27112d26f30c@gmail.com>
 <xmqqfrf5nxnq.fsf@gitster.g> <b811a0dc-fb49-4f66-a9ae-89a45d7ff104@gmail.com>
 <xmqqh5yy1r3t.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh5yy1r3t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/07/2025 00:15, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I'm leaning towards dying to avoid any nasty surprises when the commit
>> message contains lines beginning with '#'.
>>
>> I'll try and re-roll next week
> 
> What's the current state of this effort?

It's getting there, unfortunately it has taken longer than I thought it 
would. I reasonably confident that I'll have something to post later 
this week.

Thanks

Phillip
