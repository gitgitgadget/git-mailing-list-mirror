Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D18148821
	for <git@vger.kernel.org>; Tue, 21 May 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716327322; cv=none; b=i+6f11Gf9vTYN8vWXh3aPt2CWhkeL2Mp7rRoEPOSW1NPbNqChjTu5shV2AtcqLLV8VkWKvjQbl4dMXx9yPynZK/MjbOekPQJJNKYpVsuX3iI0wWYF+fHAMG2Y8e3p+EDPHT74MveJwwyvcp/OtHaI+ahAeKLPrr92j2XwwB001U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716327322; c=relaxed/simple;
	bh=0HWgmxMAcDKcAZm+UMmEhnzrnLCBKkXoGBabdh2cP10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1vmFCEka2gTFh5eyU9Xc8M5+2L5lp2oasnGn3XPSwwkELVqEFWJ2mWfDylP1/Rf0xJYpf16QmKj9q6sZlk+tjbuBTnV1iVOteQVRq9Wii6FtSQuVw0qk67xvRwn8+o+mXiVtoAYENKBPSByKlDc1MEIYBePyASBC5v7nHJZ6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg3NfY+u; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg3NfY+u"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354b7d76c52so135277f8f.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716327319; x=1716932119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBF38ihW5Ea+EDr8WyF/TyGlL+IQ2krLqckJk1Xy6ms=;
        b=Zg3NfY+usdYmwjucHtKa5sk+HHkujPDSbbkfnB9EH+kwPc3D+AzyQl5hdX3W5MTifr
         lBAyoEHxvA+oOkNdbiyWqDZWLXR1lYN22s7zwlUhqZBOEiby4I+F915k1DfGSxQOCnz9
         YFtFspIJpWjEUfUVGKeQ57u6rrXIckzEKHswVzO/HJX8mNwQ+FYxY3AwxSjdt0M1h9cC
         zkGEKTng5PhNf5BMeHzlVx6UIOU0ktsulrolWqW68k9oCIcOqQF3f12+klj89cyLAMOz
         oW7xCr39R37M/QgkiwSCCWB8WZkfjYuRJbinVXMAU6FEEIabuBI+k6+SZrwOjznt9kc1
         ymEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716327319; x=1716932119;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBF38ihW5Ea+EDr8WyF/TyGlL+IQ2krLqckJk1Xy6ms=;
        b=VBo3Or0I3+e796WeUuKYB+KNekDV4Q7XzKVZr2vAa/BFq46Nadba/C597pvH/KaQVN
         K9aBmPQGJgrG8K0wAJDEVCWERxYsQBvGDVqsd2JA0s2OmgeRO453i8YiymF2Qxxo95Tr
         7rG/uFMqwq1oukO2tlwxM/tdrR5wVdkm3H40kFG0nms/j/XIcETTKn4X3zpswjfA2QX5
         zhJBLDft5TlzLtWji7DJf9BeORlSPegY330ZOuL3kwzAzfgR4S/bS0apLzBHKExL6pvl
         TapoJ8Se+4U4RQiiquX2w64ThiCF9ijI8Wwm0wdN+UJRLBhT3ubNcMgO0aqoJooz8cRq
         8v5A==
X-Gm-Message-State: AOJu0YwS8P4FgegzNXQWMM3XKWL3zS8NyU5z9En8v+B3pxv8g3AmaCxw
	kgoYLFHWOubmUnZ4FyDHyjtLCidwoL/MHnjotsQcN/gCnp9gE3rM
X-Google-Smtp-Source: AGHT+IGMZgJ04J34kIJW7I1b3HAjX20rOWcvrosJ/h4aI92hyjM2UPynCuaT7AqZPKgJsFchRQWaxA==
X-Received: by 2002:a05:600c:2318:b0:41b:82ba:7997 with SMTP id 5b1f17b1804b1-420fd2dd894mr1231115e9.3.1716327319181;
        Tue, 21 May 2024 14:35:19 -0700 (PDT)
Received: from gmail.com (254.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420152a2a8asm377502355e9.45.2024.05.21.14.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 14:35:18 -0700 (PDT)
Message-ID: <0574914d-8088-434d-8db2-013c1abe27c3@gmail.com>
Date: Tue, 21 May 2024 23:35:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pager: do not close fd 2 unnecessarily
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <80f15223-246e-4cfb-a139-e47af829c938@gmail.com> <xmqqo790fg8z.fsf@gitster.g>
 <a9f199d8-bb06-479f-88c2-63d80338a4e9@gmail.com> <xmqqwmnm993k.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqwmnm993k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, May 21, 2024 at 01:57:19PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >> >  static struct child_process pager_process;
> >> >  static const char *pager_program;
> >> > +static int old_fd2 = -1;
> >> 
> >> What does the magic number "-1" mean?
> >
> > Invalid fd.
> >
> >> We often use it to signal
> >> "uninitialized", but then what are concrete "initialized" values
> >> mean?  "We dup2()'ed something else to stderr/fd #2 but before doing
> >> so we saved the original fd #2 away to this variable, so that we can
> >> restore fd #2 by another dup2() of the value of this variable when
> >> we declare that we are done with the standard error stream"?
> >> 
> >> But that does not look like what is happening here.
> >>  ....
> >> Equally unclear magic number "1" is used here.
> >> 
> >> This value is different from pager_process.in, and my earlier "we
> >> are saving away" does not apply, either.
> >
> > It applies, in 3/5.
> 
> We need to be prepared to see a series chomped at an early stage and
> it should still make sense.  If the series does not make sense when
> you stop before applying patch 3, it is a strong sign that this step
> and the next step can be separated and structured better.
> 
> Or perhaps if they are made into a single patch it makes more sense
> and becomes easier to explain?
> 

Adding logic to adjust when we close(stderr) in close_pager_fds() makes
sense on its own, I think.

And, the values for the flag "do-we-want-to-close-stderr-at-exit", too,
to me.

I am happy with the series;  the 'P' command introduced in v2 is a good
improvement.  Combining 2/5 and 3/5, I think it is not a good idea.

Therefore, I'm not sure how to alleviate the puzzling.
