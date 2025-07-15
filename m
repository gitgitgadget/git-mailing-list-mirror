Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C348272813
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571795; cv=none; b=HjmidoD/aPB2qQjV2LNkTx9Km3dNTU4ciSfTSZqWQB7hSPN1eJuq/w3XPi5PTNNm3zMYy/4pnJpiRATJXG7yzvjipM1yelA17CMIglLXRX+DFnMZMQj55pXQwBtJeW3lrmkhEHDnDp4HA3MjHpo3be+r8ozwRg58F6Y8gVerb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571795; c=relaxed/simple;
	bh=H1KCjqIm+jU094En9GxshZzPrR7mffSDe3G9jW8Gq1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYtjKDHOCeAasLAGWIw4LJx+grlmrW7/Rq0+sYKrTjEeKvAoZdaOnheRhQZm0oGKK83FHVzZ3lU1f83IaSLQalUNB3OaT8/Q7WgHHZeG6qotf3NXntTBdWmTr4nsxIMpZWhYz097Cbh/9Vgi93afE8/5FSleHxyF/R5gixy7BbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2yxnwJU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2yxnwJU"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so3425798f8f.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752571792; x=1753176592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj/9LXNKhhIFl//oruT72B01a0tmyPlmWUpmUbr2rbA=;
        b=d2yxnwJUEOOGKSsOLTfw/R0EUBka+mHqU57Ll6WHHWJkbxrcdc0y74YpwZkA54AIjO
         w4Mi3kFBxUtxOXGMcOdS+XGvb+gPrCKrdW5ADU4hhDZHV0V1GOoItur7e2bl/DERO02O
         Lvr93G1UX46f82uCce9NagXUPt0481ke2q6gBWcn27gk89sky8qccL0IsvfrrgA8/Ap3
         mIff+NhUkk5EltZXX3Sea9UuKDcaoGoaYA4hL3CV26Sa1vdPrTobNN73NSTciPhOx9e4
         bs0e3whDTTu9bFBSsxMI+XNgSOANRAcVAeefg6QUMrwkXswIKaqSrR6b1t2M6ApNw4wJ
         7Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571792; x=1753176592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pj/9LXNKhhIFl//oruT72B01a0tmyPlmWUpmUbr2rbA=;
        b=rPlJFaG01hyIX6hcdaxnY+LoffyIS59U8jIvv5JArQx8kICZj5lZydMnaiG5krqUc3
         Gf56yacSAu8mBsAvoHZChTw4sPKigwpzs2V1cAO+xkLxtR151zTZS5hIvXQIoZBkUST0
         jCJHlAIlqJS0pWRxJ0BGwlcmsOr2QODYo3v9xvitx+BY7VZ6+KLbUkdZi9xkAjFPHMgZ
         r7SaJuzD9Z8URtzgyolZN1RcZ75c12IJ94BnLAbPqQX47OJfGXKkIBEEaJLg7vUvjSUb
         IeuA/fF9BRgp0Nzyqt6kdPzOddB3iaMOtSuLGpymVInekAeXdIwsXTx8MUI/trLS2MPP
         AyhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo9GHtSWVMXsnAkw+FzuZdomf890Dk7nS4uUYEAVXSo5dIdinMx7c/H+GonlxJyfDB9eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNy5KoYl0lIDc7WAit1rtc8gLWWuIGyzlalsaFP2uvk/twfJf
	THknFE7NeZfbEEWjr0fqUWD/Z1ijX1VdtMp28J/l6tAV48PiygklnD0jb+lwlg==
X-Gm-Gg: ASbGncve2NwZ6KcqcVqavt3kJ9cRkYtxlbJKWsTAVAyouWHcvearxN0jMvhI/jhFznq
	PSvWI2H5EAg2jYCw6O08pnt1VnQYPm+wSwtCV8KzQdxXw7mEP95rObd8a9p7kI2sg3TaUSaMYNL
	l2dOQSNk5xGGKJ6rd8uQYtbKY6qyzEko0vYp/MqPqnK7OuaFXfK50IX6ElMBZZGOYw5GxAOXRZw
	6/Ti3uLJv+zvViptIaWvBnpXzvixLVTUz2Q0hgvJCZACy/epOBZImf19a4Wh88tf7lTcvgLuPjE
	tR54hmkdyi9AWOAjF4LJPgE5CcJri3hriN/s+MVN3W7rQCzwtHNSDCfLBjkn1mi87VWy2jUB0wL
	0pjFwjGgcvqhiz2T2DHbzOLSFoJQZrAGMfG0hvBm3TfpALMYlWbVaSYahYjtyS4l6k+1kqEGxAT
	cfbLTQIMkpwt0=
X-Google-Smtp-Source: AGHT+IGFjdOjLFEDfbZx+ziRNiwLGElSUwP+2I0F2idqcsnDuVPuJhV6xN1CByi9JrMafhRizgPIjA==
X-Received: by 2002:a5d:64e3:0:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3b60953af23mr2150128f8f.16.1752571791927;
        Tue, 15 Jul 2025 02:29:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd43906dsm158250355e9.3.2025.07.15.02.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:29:51 -0700 (PDT)
Message-ID: <0f884a77-f8a8-4c0c-9a0c-dcd8d514c0ed@gmail.com>
Date: Tue, 15 Jul 2025 10:29:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/2] daemon: explicitly allow EINTR during poll()
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Chris Torek <chris.torek@gmail.com>
References: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
 <xmqqfrf368lz.fsf@gitster.g> <313e3b1a-a095-41ec-adb9-fc500589b979@gmail.com>
 <xmqqecuil9sm.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqecuil9sm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/07/2025 22:52, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> Let's queue this round and then patch the errno issue up on top
> after the dust settles.  "might break something" may then happen,
> at which time it is easier to see where that breakage came from,
> and we can go from there.

That sounds good to me

Thanks

Phillip
