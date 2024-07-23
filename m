Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195D144D36
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771730; cv=none; b=slxjpxb5UTSzzmNgLV6mf2Vjv6kbe3+BTaFDNoGc3vzUVTLL88BxJiYOrMJOm4cM02xszQSG6LJjXx3hNSYPUdEEa/AQEzcn8RJKS5/XPV7GrtixMLLWJfDUhhBuRKvsPNoBln9ySaIwGnAeUMJ0gGCFG9TqsPHBLubCGMjOEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771730; c=relaxed/simple;
	bh=es+lmBPTm5wv3VsBXKwys6Ue4yUAC0xYxukeFqfhp9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stthhZ2imnhVamshoUjc5p0ymQJPHpeDZ26cs9NnM+ZB3KBcKn/a6u2eugAcm2b7xKDQPkbOuN3C7ZeSu0tKU58hF+dh9heO37aZRzo7eJb8UgEn8QShQQ2wcSiBT9jJ7+o5qCFRlaeZRqlWibENnJCpl3/7FYf47tblZHoiR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dtry0Yuf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dtry0Yuf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427d2c8c632so43281685e9.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721771727; x=1722376527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=olZvZm+7Qwq9/zmkhWn3IXI2shjbe2rmXoAoTFPVvO8=;
        b=Dtry0Yufsy878SlaPcSvSpQ8C5BmrUjHkTRjunp6JYPIPDkX0CC+/kDVEEc+iEZeXv
         J01iTti2BKXfiXe86gNBN2YKEYvKlsjVQcd1i5IOR5Vgk89icPdMwZUylOHBc/03sw4K
         hBijb0NNQv1WigSu+hJ8OBTEqgBDThaTbRSnjF77ok7JKszXPS8WrArvDjD6WRClZJTQ
         eA2Y2/OZJvYkckji86jdN7ZD4C68TZRROtOhoqthA39iRTQ5/dlUECTF03WLrOpqskYk
         1QCUTyGxFAMbA3/ZxTfJ/WBywoO6IFPDPRkKYBDSD2KAmf76xUylwHBnFPDz3u37PaH8
         RIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721771727; x=1722376527;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olZvZm+7Qwq9/zmkhWn3IXI2shjbe2rmXoAoTFPVvO8=;
        b=LHRf2hzjZM3Jt+TnnmMWE7biB1d6LvhmMLBYEVHhHdQHFPZhRD+tt/VTpOfvRO0klp
         WWQglFyxJqr2WfYj3l5K4XIAyR6rxn5/4uSbD08fJ3ovoWzGWZUUjpMEHhNpxMFHHgv7
         XT2hyTbjX7YuD+NWH10MRaZrxpxAEURAVqlQiv9UBSY39mG+lH7alvTQiR2hIeRlVWI8
         d0a2b2uqyPMa9CAh/C7/1yPZykoAg4e1Fgz+OsCldUxiGGvQufT7Fo4PwR+UeJMWLJFr
         XK/c7IPPnmfO+aemTFzGQFveMkGEo43xOq/rqbQIleGPGkn24O9lr0Bsu+v9QyrNX1CT
         7ViA==
X-Gm-Message-State: AOJu0YwKSPmfBTeZX+V7HRFOUFlVgij7bJi+c1slzfYbCclxkgfWu3K9
	Z4gY0KpMHds5CGx2hk85dxEsoWfIs2vt+wOvozXyrowrlT9fswGZ
X-Google-Smtp-Source: AGHT+IGIOXvtR2ydNSNnOBsEw8RwfHDr6Cro9QMwpwBtfF1QagpaSyNtsiy14ks132olWLRogRG/HA==
X-Received: by 2002:a05:600c:3412:b0:424:a5d6:6512 with SMTP id 5b1f17b1804b1-427dc559daemr87461995e9.20.1721771727017;
        Tue, 23 Jul 2024 14:55:27 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f937348bsm2403435e9.18.2024.07.23.14.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 14:55:26 -0700 (PDT)
Message-ID: <f613ed64-fc5f-4204-a364-f671f315390d@gmail.com>
Date: Tue, 23 Jul 2024 23:55:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] CodingGuidelines: document a shell that "fails"
 "VAR=VAL shell_func"
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqjzhd81la.fsf@gitster.g>
 <20240723033418.GA1838963@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240723033418.GA1838963@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jul 22, 2024 at 11:34:18PM -0400, Jeff King wrote:
> On Mon, Jul 22, 2024 at 04:10:41PM -0700, Junio C Hamano wrote:
> 
> > Over the years, we accumulated the community wisdom to avoid the
> > common "one-short export" construct for shell functions, but seem to
> > have lost on which exact platform it is known to fail.  Now during
> > an investigation on a breakage for a recent topic, we found one
> > example of failing shell.  Let's document that.
> 
> My recollection was that FreeBSD's /bin/sh was the culprit, but I
> couldn't find any mention digging in the archive. However, I just
> checked on a FreeBSD 13 VM, and it does have the same problem (that the
> one-shot variable is not exported). I don't think that changes anything
> for your patch, but just reinforces this part:
> 
> > This does *not* mean that we can freely start using the construct
> > once Ubuntu 20.04 is retired.  But it does mean that we cannot use
> > the construct until Ubuntu 20.04 is fully retired from the machines
> > that matter.

And adding more confusion, which further reinforces the need to avoid
the construct and the usefulness of Eric's change [1], it sometimes
appears to function differently:

   ** dash 0.5.10.2-6 **

   $ f() { echo $A; bash -c 'echo $A'; }
   $ A=2
   $ A=1 f
   1
   
   $ export A
   $ f
   2
   2
   $ A=1 f
   1
   1


 1.- https://lore.kernel.org/git/2e1c8fc6-86f0-404f-bef6-9502aa0d31d0@gmail.com/T/#m3470fc6c1df59d29312bbe3de0444f1f608f3611

> 
> since now we have one other instance.
> 
> I thought it also had the issue that the variable would remain set in
> the caller after the function returned, but it does not seem to do so
> now (if it ever did).
> 
> -Peff
