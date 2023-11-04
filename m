Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00677D30B
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5h2tuQY"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC81BC
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 02:52:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40837ebba42so18433125e9.0
        for <git@vger.kernel.org>; Sat, 04 Nov 2023 02:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699091519; x=1699696319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlllPCAobMzz8v6aYu3Xh6cDxD8JWQX6OM2KeaSHww4=;
        b=C5h2tuQYvOm7rZfl+CD9rsT8OH3fIr5Eyx2xyFA5FbL7LcEy+tfm5EpyubJ9cpHxJn
         8PLv8aOp7gQ30Jduye41tcR4BLCbg1qCBI7k8XijERw6ryOKtVu4YRAUXOx0pHUmm8tO
         zKmR9WvLndV5cXTVZMqG89lGlXL9L+e37tiSwW+YFGbjp5LZknp8W/8vXa6JhqhEy+wa
         OI6xAoV5SHuScET0GSixCp/O4txJg+DkE1g4kL1qY+PyweGc+8BD6qgGxn7KrjnEAhgC
         rlOxiLeVkEPalRAy95VJonUy41TC7NIxNDnIERGbk3Tj2T+kVax9xxXvpmeluno0uJyX
         BNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699091519; x=1699696319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlllPCAobMzz8v6aYu3Xh6cDxD8JWQX6OM2KeaSHww4=;
        b=GaEreHMVv/SQWh6E1epg1ZWg3EqL13hMqumhK+x5UgdVlrMZP1Ad2mkcKg7I/EXr09
         AOesfaIzyF+v8qZ/zP8Uuz+yVsPwyJBJrnQDn58CDyT2j8/tAdxNCmLo0KP7YaUjZhEQ
         09HdWzPG9+MJcKBQU3UbuTzqQjnlApFFTU3SnYuQidnJ+sSZsV4wGYmr1ReDGuguEaAR
         t0/hPqoEMjZq9FJjUfXMPpMfkkdmnQcSiebWMXQWs3LvcKNl6JsvDDdDyJB33JRS+nGV
         z0prgeExG1UZEyU4H/j7+ViO/Esho1x/aElIFmtrMVAE09A9TEOdmdbATTfBjkKj4HWg
         sYgg==
X-Gm-Message-State: AOJu0YwrKtarHCCgFoOFndiEDFu/DyhyQj8blHWWbr3fTF7R9Fs5KHfr
	NPG2miGx9tpmfgzitNBcElE=
X-Google-Smtp-Source: AGHT+IHB2vbFpbksMro9WN8gcfnQtiGg961BGYMdhQ7Wd74bye/I5GDtoWj/uNGYZJ+snCHBQQt7qw==
X-Received: by 2002:a05:600c:4514:b0:408:53d6:10b3 with SMTP id t20-20020a05600c451400b0040853d610b3mr19594302wmo.22.1699091518463;
        Sat, 04 Nov 2023 02:51:58 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c4e0500b00407b93d8085sm5299067wmq.27.2023.11.04.02.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 02:51:57 -0700 (PDT)
Message-ID: <9662afd1-a596-4d36-8c50-6c2e953a36cb@gmail.com>
Date: Sat, 4 Nov 2023 09:51:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
To: Junio C Hamano <gitster@pobox.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,
 Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
 <4e3a5661-cba0-4849-8340-06d8d4094f48@gmail.com> <xmqqy1fegu5i.fsf@gitster.g>
Content-Language: en-GB
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqqy1fegu5i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/11/2023 01:54, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> 
>> I'm not sure that this is the right way to handle a missing '@' here
>> actually, because %al already returns the whole email field in that
>> case, which makes sense as the likes of the 'mail' command would
>> interpret it as a local username.
> 
> We could expand "%am" to \C-h (\010) so that "%al@%am" would end up
> displaying the same as "%al" but that would be way too cute for its
> own worth ;-)

:)

Unfortunately it also wouldn't always work, because ^H only moves the 
cursor, so if the next thing is a newline, the '@' wouldn't actually get 
deleted.

> It is unfortunate that "%al@%am" cannot be the same as "%ae" for
> local-only address, but giving an empty string for "%am" if "%ae" is
> local-only would be the best we could do for our users, and certainly
> much better than giving the same as "%ae", as you said above.

I suppose "%@am" could mean prepending an '@' when a domain is present, 
similar to how "% am" would mean prepending a space and "%+am" would 
mean prepending a newline. With that, "%al%@am" would be equivalent to 
"%ae".

But that then raises the question whether it should be implemented just 
for "%@[ac][mM]", or for all placeholders. In any case, I don't think it 
needs to be part of the changes at hand.

Andy
