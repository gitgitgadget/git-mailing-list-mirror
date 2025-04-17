Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B4366
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905744; cv=none; b=nw5lFpluWyaHH0O6ctzFS3OuB7yl1eJjA7zpqinGrQsZ552/LIyrJ/4XZuclpH1kcALmtRSJWIJDzUSYqXor/9b8KGm71vPNj/yCCOwfxUgVU0ArrLEw7r2Cc7p5qHC/Qtrsqz0q/ShDPFDY+b22BTh1I+n0ABmeyrVQiMDW0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905744; c=relaxed/simple;
	bh=fMeFREKf28Z5hLuqJz/ZKmj5j28fZR5Pl0Fqsjr+riw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QEX7Lznl+DHAGmGpkuEfIP1eb9OXNgoTJVfYT7EzDViiqF5U8aBtjus46Jj1VpaHaQxmvepPzmrWWt+eJD6yijYHhhl94sdYspKW/0Q7XA/+C49irUFIPDVetfz10lyn7iyNnWv9VqS/HQ3o5ANMrkBDTE85/PZawciNkEBuNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWUueHnc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWUueHnc"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af579e46b5dso688664a12.3
        for <git@vger.kernel.org>; Thu, 17 Apr 2025 09:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744905742; x=1745510542; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMeFREKf28Z5hLuqJz/ZKmj5j28fZR5Pl0Fqsjr+riw=;
        b=LWUueHncRCbjxNUCJLiRhyJAVNSLDxOgSQQEY9f6pvbUGHcvtki0cXMnw6Ah3TFp/6
         pXJpjoNn8dYHNAc1ycVQdrncCoKeC+3ES7LS58oeNc+xD9Q0yUq4AHUwLX+VJGBp2NO+
         PnbnuLhAl+ObTuhhip/LNJmIGHwO/CdyTf0qf3fMGgM8vefxl7z2oXEl5JhOV1DRspfd
         Z1pAUQyHtCtrCuPEaVhGSY9nkHwQh8av+AVSuU635VUHq5ixWFMd3O4uL8xgaEz1qv1O
         +I6YLK8EI41DNXEEFLuRpd9CeYb0x7RcXiZcFL7OQojoGBURuoFumH2rSMOT9ng/kL1d
         9skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744905742; x=1745510542;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMeFREKf28Z5hLuqJz/ZKmj5j28fZR5Pl0Fqsjr+riw=;
        b=oyLPs29P7tkU8cOPzDzzjuhawlqIVN7MqS7f4XZjoJ5FdBSBXm9nkpFJ7qiG3BWEn4
         eKRBX+0kOClpGtsiUsoRX7OCq0fO11n3bYA3dQ/ubSFYaPF+iA/kb/RFoWaQaSjWa4y3
         uJREEV55VsYiQ1GvxaA8EbJln1k37znyVGxX6iFu/DUP4DVC5L+ksKDtR4mAgttwcWIz
         XUaVZCF7Uc8MKu1BLMZkWVJhuIPgnnbcbAh4IHlm5+Woe9fRTsWVDFoC+n0OO8scdZJS
         1JE/xCGjWJTAYHzZuExDqZ6zhhVeBT3zDR4LQxIUv2Gq7RtdSwKBcgxa0xtbBn8j5UHu
         wcSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVab1iuAYKN3s9xxOjdE4bl05r5/r8x5yoGp7iM41qbTBtdeGnI9CsVszcg3zLooh2wg+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMnusMPIvTNIwxbNMIC8B7hXCwMunX3tGyrHP5NDXJYVDUIafX
	xi9Sfp17Ptj9W3fGq3Vqwg4fuJW6PTfQ9/CnTE9BaCnimXt2La/m
X-Gm-Gg: ASbGncuXmjrukk0eT3J4NAsTgn6mlVvTZ9aJnbmulw+NScdSq9w9OdqQKOq2w3OXTmy
	llSHOSByms+hDn61sWX1r4gkY3Lytlnxtz0j/TPK6TUkijtOdZgu+PatJ9V8LHN6eXfr5KOWEXu
	aOH5ef50FTh7YHyNa5vnLuqAnEesG0fcP5r2boMxvKdQw2ExnGH4ZdJFatTmFpwidFbKQKkDBOB
	LxIUygjNJZh2CTEtPRXYEj4MnTbmisXE1cJ23LeNLqBLrxA2K84BzKsjtN52RV60ef4Ga9chsvK
	KCDL5LY6DyX4B6MvJYIXJTWIWkT/n+Qodldtxcwh1I3qp23ZRMPWFa2PIKBE8Q8xpY9+NAhw40B
	aZfkVN/cp
X-Google-Smtp-Source: AGHT+IFK9r0xQAkX+Lc0nqDuafqYCyW0SC/tt2g3PLFukZlYLho/SnMy7Br3/G/EnbUn9tebv5QGrw==
X-Received: by 2002:a17:90b:53c5:b0:2fe:9783:afd3 with SMTP id 98e67ed59e1d1-30863d238ffmr9959082a91.2.1744905741782;
        Thu, 17 Apr 2025 09:02:21 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:1436:5869:957a:a396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3086121304csm3865397a91.27.2025.04.17.09.02.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Apr 2025 09:02:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2] docs: document core.hooksPath=/dev/null
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <9e14443c-e549-46e1-9fbf-ee72800e6944@gmail.com>
Date: Thu, 17 Apr 2025 13:02:05 -0300
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 gitster@pobox.com,
 james@jamesliu.io,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood <phillip.wood123@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B60E6A23-05F6-4391-8CAC-1CAEB509E32A@gmail.com>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <pull.1899.v2.git.1744818135435.gitgitgadget@gmail.com>
 <BD8FCCB1-C97D-4057-982E-93A7F8B01AB9@gmail.com>
 <9e14443c-e549-46e1-9fbf-ee72800e6944@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> This is a "there be dragons here" kind of warning, implying that you
> better know what you're doing if you are messing with hook paths.

Fair, I understand your point. The paragraph itself looks very
clear to me!

Thanks!

