Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A161FF602
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012384; cv=none; b=czEiCDVz/ZE/9q+GNK4nqnySOkZfTTDg9x4ZC1Q5B6BLjNdQ8lrIQu/vGrWgwxi7trjyOOSX/KPsWmDXSlH3EAPipiAOg87vI7+vZPYYX9l8wvZcBX78RpBp4ykO2IeJTGgItRkj7KpuXmxXU3/wEetC67LkKfFfE9rkhXEZT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012384; c=relaxed/simple;
	bh=e/oLaqfo3GR3PINAGvXQoMfYQivzOHFWPohamMbUbDE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qZSKRasC0mNb8QAqx/JnEylqluNv62DdbJTEfWOrr7hO0QetaKISjQErZiD/23aCWs6LOhs49Dv6cMnC7D04Dp0+VE6lpFvcgHVepU16soUTunZRMud2ZPSwbtNzve2Gu7Sm8aceWzSXgRy3qREeYXEHnLLa2Pky4oPoYlUvrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDIT32pd; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDIT32pd"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e4ce6e3b8cso536723a12.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741012381; x=1741617181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mASd0uVFDwOlG+TFxNM5tf91Eay4R4AnNc4ApJkcV5Y=;
        b=DDIT32pdP85ibBNdWd5DLCB+p2bdOKYgROtTwPVCqL7Yl3MueTnajdDDPiwjvlkVE3
         46V7vMTFRI+ZY2MjJfT2MCof47q01nXluxxwh485uEtv6Q8jr8/nXV1MWrK/xBfeGBAW
         xl+91/OAyCSL3K+9u8oqUkQjbxDuAG77TtantdPofuqE6dsp4SSJiJPvF26jGuCsfqQq
         O5OcaBR1BO+rr+Lj0SUivmNEHzyCfoEcOmrGv6WaVBX5Kn2NATpvuy3rIPgObFf0jriT
         ugw/45hi9pwuSq4aPrzWEfc+vNYxrB/8AlANApWMk5y6excslR8YRPsHzpTaina+RRpb
         VV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012381; x=1741617181;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mASd0uVFDwOlG+TFxNM5tf91Eay4R4AnNc4ApJkcV5Y=;
        b=XOeyfl2Cbtf0GUMq5NJ+0lLPvT8D/Z2f1mCqaJV1aVVkD8toLk8sV69BfcJq5jPF0k
         04oVKMo7Wtdu1wLgRgWvd0dfyjbUWwqXQsDPdz7/wSasW6M4YtbZsjrKlSiqSmYlxAT4
         pULCbyipMDqbxw73pe0D3pzxW/OrACB8lFSlvn/C3HmJ0YzSQp7vILPaFaeXbAm1ZNWg
         HAfl0HGTjntPynFS7U3u6ZAWHLKSAMvriEOkZOf9A1N6mNc5wCcOCQ4ixTi0frPqO3nW
         p5W5XJZJb12GseddsLSLizJcKbcd6rYK6GQf3pWu5Kbn57ClMAnxLeZx5R5Nj0tB0Rwy
         fj0Q==
X-Gm-Message-State: AOJu0YzbzKFbDmzKO3xqDm4J4VlRXk2Y6F3gR8vunRLiIbcYKYZOHsXF
	shOSDAsrslxwcc/Zov7CPbUejSwuO6r4REEilSZXw2rEYRNHqxSE
X-Gm-Gg: ASbGncvdsy3EFGyFFB4ISvWqk8Nx6i9HRIWCRldmtMDZW7QXLQmftMM79EzJ2e3gYYr
	a3bI9fiHoFMY3zb6iXi+CgHeQjR9cgybeu8P7D9cjKt2mjG+NmW/OBgqq3qt5GDCmZjmtgTrpsz
	ZuRm4tzcdABlc/PolLWnWHZnhG2YpBUFmsgrYHSvIcrND8dG2EQFuoS3lo/yROURZEJWzzZB/j+
	inpSqHaDEcI9PkivuxagYOkCWJvei592jmIJogSU2cNkM7jId/YSigd1e26/3K/YZWOR8bipyws
	KS9tG7cwbgKjSZtLaGaP07WFvhHb6BMlKG4+4T0ZqQNGVA6f5XUcEK4qd+ug9u+xrqP7epfBhqx
	+5bdfBUWNwZnI+S0FdoXQ/vs=
X-Google-Smtp-Source: AGHT+IFjTTI1nhs3v5AJQSwLrsEuTbU9PBok64UJFmLF/5Qsuz2o78LGATQGCriTGtBffsMfpObMkg==
X-Received: by 2002:a05:6402:1d51:b0:5e0:5fe5:6166 with SMTP id 4fb4d7f45d1cf-5e4bfaa5d28mr20422154a12.4.1741012380931;
        Mon, 03 Mar 2025 06:33:00 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a7a1fsm6926210a12.80.2025.03.03.06.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:33:00 -0800 (PST)
Message-ID: <71b5dec1-a50b-4624-87a5-b1ede8767166@gmail.com>
Date: Mon, 3 Mar 2025 14:32:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] meson: fix building technical and howto docs
To: Patrick Steinhardt <ps@pks.im>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1870.git.1740931350451.gitgitgadget@gmail.com>
 <Z8WBw1L50zVmjGIs@pks.im>
Content-Language: en-US
In-Reply-To: <Z8WBw1L50zVmjGIs@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 03/03/2025 10:17, Patrick Steinhardt wrote:
> On Sun, Mar 02, 2025 at 04:02:30PM +0000, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When our asciidoc files were renamed from "*.txt" to "*.adoc" in
>> 1f010d6bdf7 (doc: use .adoc extension for AsciiDoc files, 2025-01-20)
>> the "meson.build" file in "Documentation" was updated but the
>> "meson.build" files in the "technical" and "howto" subdirectories were
>> not. This causes the meson build to fail when configured with
>> -Ddocs=html. Fix this by updating the relevant "meson.build" files.
> 
> Good catch, thanks! I wonder: do we maybe also want to start building
> documentation with Meson so that we would catch issues like this
> earlier?

I think that would be a good idea.

> In any case, I'm happy to defer that to a later point and for now only
> land the fix.

Yes, I was hoping this minimal fix would be acceptable for inclusion in 
the upcoming release. We can change the CI once that's out the door.

Best Wishes

Phillip


> Patrick

