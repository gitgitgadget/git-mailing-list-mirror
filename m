Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE4482F5
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqJHEQuU"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e461c1f5cso37790865e9.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704897161; x=1705501961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPdu0u2nyxvorHMLktfU4Cn70Xp4ZO/Usy3G8g3GVuo=;
        b=mqJHEQuUQl7cmPDyn2mL5Lz94cjTur4XnozAXm46R+uN6UhX2Cc/eio0xhYDZGC43Z
         9GCVuzZ33nSW/z99MFF3BgKJZUG5sRJS/o7TUZf1sdtQSVasZG0RTQq/htOgus8aJzJ9
         zbgMFcwc8OrHZ6pgPIWtw8j00cloGFPHNIeoR/p/iosiwyvtaGpqe78RjmsGZFbR6Url
         5vLA2tGonaGrKmAg0ZaVoED1AcoV0MJxkCE7tTI03AloE3GdYUQks5csZSapTfdvPVbG
         9a8RqMQHRdtBo2ehb9fmW8dIXGcbUClgDlohElsoUeeF3lKWN30rFfX2hKwBq2NHIr5Z
         0Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704897161; x=1705501961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPdu0u2nyxvorHMLktfU4Cn70Xp4ZO/Usy3G8g3GVuo=;
        b=KA0tgtMU9be29nU8jWHFssFjEobRcrnskZsM5ADpbEuen+/hNKS2GvqGc2NQi8N4th
         aQfW+CXPp/lZKKRlE13Ol5B2sQn87dUKT2dNV5jf/gNchpJSg5loCxKWucRQkqMay8Ci
         YJEdqpNumMW4+ZTIn3j2N7rLAKQt5rM2Pe+xfTuz7bYorGM/2KhgSpXXNwwQSieVh1od
         r0qmCeIX/pAhUTyEFCH2wpp34so7OZCPwGJoJGz0RpOnyW+JTSfJd7xOH/CQI+hpDum6
         bvvfulF5iazUtQcUl7aO5t2Vb+O+jZoXMHkscsPzodKSCs3S8j3UIcYyVopWSN5Z6zMK
         VImQ==
X-Gm-Message-State: AOJu0Yx6nlhShIPKYPrejWmxTmJPCt+/H64apIr+gthkJf4tqruZgoNB
	HnQa0O00fZYUs5l8uXyZoNY=
X-Google-Smtp-Source: AGHT+IEEX3sIlKu/zfopZasLNKhjToopMeT3k04bxyQi9hRw1Rp04xK6cOVfIMamS0X0fP4uv4D8mw==
X-Received: by 2002:a05:600c:1e0d:b0:40d:8fcd:319e with SMTP id ay13-20020a05600c1e0d00b0040d8fcd319emr460051wmb.240.1704897160834;
        Wed, 10 Jan 2024 06:32:40 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b0040e34ca648bsm2407093wmq.0.2024.01.10.06.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 06:32:40 -0800 (PST)
Message-ID: <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
Date: Wed, 10 Jan 2024 15:32:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
To: Dragan Simic <dsimic@manjaro.org>, Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
 <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10-ene-2024 15:18:17, Dragan Simic wrote:
> On 2024-01-10 12:02, Jeff King wrote:

> Just to chime in and support this behavior of the advice messages.
> Basically, you don't want to have them all disabled at the same time, but to
> have per-message enable/disable granularity.  I'd guess that some of the
> messages are quite usable even to highly experienced users, and encountering
> newly added messages is also very useful.  Thus, having them all disabled
> wouldn't be the best idea.

Totally agree.

This series is about disabling _the part in the advice about how to
disable the advice_, but not the proper advice.

Maybe the name ADVICE_ADVICE_OFF has caused confusion.  Sorry if so.
