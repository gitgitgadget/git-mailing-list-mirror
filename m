Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575720E039
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385128; cv=none; b=C9Lb1TTwSUDdbdiLbQ2yv6zgO+V59eVlOlf4f1Mc5bEXS2ZGLBR28jPMv83xgvwjlNDtyrPlj4zbNra8aoaNe7dP6oToAM/GmqdUAph7IQz3EReTtUdHnJckYi/1qnQc+K6KKKRUEkuBRN72ieIXU8vXPkHT0YNoTE88sd7SOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385128; c=relaxed/simple;
	bh=Ji+lz6sRPqZhGQTaQEo6wQECEBhu543pMnb1jS2Sghg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yeg1igtJNVK1n/i65yDs6bV4l24/YJHxOaE0W/umcaA2qyrakbZUezRZrl3WlbWz5WVrHNk8w/ISNijPJU0p35UK3MTfGc/qxR5aSYn08ytwgATUgG/8bmMolEl7mFxAAY8OgpFig+Atc+cu0N1TdsrzAL6TE5OXSQK9IFNEXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFuWZQDi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFuWZQDi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f55fbb72bso96406385ad.2
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739385127; x=1739989927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ji+lz6sRPqZhGQTaQEo6wQECEBhu543pMnb1jS2Sghg=;
        b=eFuWZQDisffFJK8ONk2fG8Qdv+rlsN6eXzVvA7x62CVSfP0qO/+LZi+WDvKPox0Yg5
         XgmIlrJ4J5QKh3Y/TGNbxOCz8gHsR5AyjacfReXwLL6VOme7fwglrpP2tjSmriOxgBnD
         mWMcOkqnHHSp/tLEbObU9r2SBhdxV1THr5w2DYDHW8g+Y4XsFb6jFf0Vg06I0EswLAic
         MFIeZLDpxYIFwlYfE2t1J2EcCOtyZBosiSBaerAOs89Q8A/m1FkuweOkJYzJRa1WaAav
         BG8hkh2h7Wn1IDuiKXJGNrebV/u0b8OsZsCu91xyT2AoHu1DvYx4R8Hf4aDXD00jd6Qc
         UXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739385127; x=1739989927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji+lz6sRPqZhGQTaQEo6wQECEBhu543pMnb1jS2Sghg=;
        b=EnqW6ovrjEDN0y80L1k0rylgZP4uL4xqzEFPjuPXDxcYV2D8PMhuMdEuyKn9W/MnrL
         /UYght660P//r3h5QltwGHbLa+UYUAz+5uFQN4UqOVSV/mgrd0neXgryzkbv107bl1HD
         DvCCoabBt2Hi4DsnQwZeg8PFDWJ9ktOCctqGWdzlxLCunO2lxgHsJUowr1JVTL5MivDT
         sWSNHHyHJ75ORbmFSo3wC6hht8+3SD0RV0GfrvIZ+VGNIqLEtF/FRVjIldqRIDZ3vcVa
         qrnxLWcbx5KJ20DLCBcEkFK7sBAC6JnRNlxqe4OdJK45BqQMzk4HI6P4alBCavuQPEYm
         9Pqg==
X-Gm-Message-State: AOJu0YzkC+WpF+Z4eFqlolCcpTN+9JoMNmhZU46XYU4Cp7gygMc6VuvA
	kejhI18J0mnccwEEdCM/uUz7vbwy2u7MocL8cCdNKRrRTyKiOZzlq9La0g==
X-Gm-Gg: ASbGncvq01o+vEOXJ4F3NSelhZZTCXJJlmrfNOKcVfPk/qibBdDEpoE9BqO88OZSu9M
	H4nOm/qjQ0PzwFVD/dKS+PMLLqwnshYyqxlsffCKfF/NYB2E1/jb/pHnY9BJszkLJqjIIfpwgS/
	WIyDTwU1+ti5grP4JXTyGiISPZnfQ3kYu6L9tT8F8NcKVlSt07ULUB31ucdeG1dFKLu3xmQ7bAh
	7tTLxsK5G/fDfaosUGYGRM7H7v/qv2nIy5/Xsf0MLuV/unG/0XWcmNgapSIonkru0r1z4yNrRzE
	vLi9jarh1quAKKaj0TWzNxPGaF/6WVM8ReEC5au6VehorHdmNAMS8g==
X-Google-Smtp-Source: AGHT+IHsFd3ndibD7/awq0BX9GUwMjss7AeaRXz663auE0q7Vp6ZrVXU9/OzbcjPhSgXqziqadYMsA==
X-Received: by 2002:a05:6a20:d80b:b0:1ee:615c:6c8e with SMTP id adf61e73a8af0-1ee6b2e1251mr924593637.9.1739385126855;
        Wed, 12 Feb 2025 10:32:06 -0800 (PST)
Received: from [192.168.1.105] (23-93-96-117.fiber.dynamic.sonic.net. [23.93.96.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73097569a1csm4953634b3a.154.2025.02.12.10.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 10:32:06 -0800 (PST)
Message-ID: <09049b05-ed3f-4673-9d10-34870a70e2b3@gmail.com>
Date: Wed, 12 Feb 2025 10:32:05 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using Visual Studio Code to Debug/Trace Git?
To: Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
References: <vlrkbd$a0r$1@ciao.gmane.io>
 <A53D82B2-4F5F-4BCA-9C85-88B2A89139DC@gmail.com> <Z4TJIzVc4Ib2QyPV@pks.im>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <Z4TJIzVc4Ib2QyPV@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just to follow up on this, I've had surprising success by
simply building git the normal way (e.g. make),
having VSCode open the directory contain the Git source
code, opening common-main.c, and then executing "Start Debugging".
I'm able to do full source-level debugging this way.

I'm not entirely sure why this works but it's good enough
for me.

I'll be interested in seeing if the new Meson build system
works any better in VSCode.

Cordially,
Jon Forrest

