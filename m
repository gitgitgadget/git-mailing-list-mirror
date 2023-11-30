Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EruiCfcM"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB8310F1
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 07:22:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so6358055e9.2
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701357754; x=1701962554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+wNaIIP37e7+SDICH/Xb92wKAAxFAm+tOahN+LEkF9A=;
        b=EruiCfcMXyCm4d/dJtNC8iCO+i+NIAuF7riJAkkgP8YU2fKnCdgNQS+JMlaeFwuzNR
         2B+ajV33NV2uFxbbHgVV7eOy8eaW3lMfz/B8UvMvhdnITGQAZ8t0WuM7In3KI2wpJvmh
         MJokJfy9x5zZujSyU+V+hk5vAd5ka4Hdt5rVFVLyljnX7Vj6Oi4/YZBkNS26e6fl2u3G
         gTnfS95MtbPZFXeSP5kNYqVLLN7juJS/rjr+wJjItz4jSr0ji5WQAqwCjqD0F87AhQvh
         11i5t18Zur+hpxeMsLAmnco/iplhG2SLKDQaUY+9iTola7+Ph5EJKPfKuM1syWCUARId
         /Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357754; x=1701962554;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wNaIIP37e7+SDICH/Xb92wKAAxFAm+tOahN+LEkF9A=;
        b=pr+WuM9uDCHRgPTqM6v2cY5iOLrhfsmf0UMbk4tYRHRKafDh/BIS+7rbgH0GCEI9U4
         dRQTO1zy526NEW3YzYiL6/6Ex5H1/2ne0pFbfu8aqlfFszfxbdPutOYzhFMOEcmvfNTK
         15sN9Sg5v/Xr+FoA6ZrzfTLRriSlc149mGnymjKiAhP//QvWEV8kx/e2O1r2yeURLvVZ
         weq163yP30HsmP2YyK+BkgIT+92z5HV7JdcuKd/n4m5L2I8CL3177XUTmwo2maf0K+Kr
         /FB9IKWWgKzjHd98383jjESbqCsx5kU7g/oYLvHpA3tSxl7OfaAjV5qUstamCBwTdDct
         qhdg==
X-Gm-Message-State: AOJu0YxFv93j2RfCwPskn68fg0wTRZ/pjwQrMkhSy7/u0RXXm6VPiP88
	+R+cvWhJ+jdzUFWTNBGjIgE=
X-Google-Smtp-Source: AGHT+IHozLnMEJ+Ry8U9RCNqhqN6KiVqgIpMnvJ3+Hho1B8kNDc/S/6NsUl5XrArxlNg/Ksji6zB9A==
X-Received: by 2002:a1c:4b01:0:b0:40b:3417:a667 with SMTP id y1-20020a1c4b01000000b0040b3417a667mr13827667wma.12.1701357753804;
        Thu, 30 Nov 2023 07:22:33 -0800 (PST)
Received: from [192.168.1.212] ([90.247.162.103])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b004064e3b94afsm5958493wms.4.2023.11.30.07.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 07:22:33 -0800 (PST)
Message-ID: <b3532261-3cf4-4666-9cbd-4ce668cd2e49@gmail.com>
Date: Thu, 30 Nov 2023 15:22:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a branch
 used elsewhere
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Willem Verstraeten <willem.verstraeten@gmail.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
 <xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g>
 <xmqqpm01au0w.fsf_-_@gitster.g>
 <bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com> <xmqqwmu42ccb.fsf@gitster.g>
In-Reply-To: <xmqqwmu42ccb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 27/11/2023 01:51, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> At the moment this is academic as neither of the test scripts changed
>> by this patch are leak free and so I don't think we need to worry
>> about it but it raises an interesting question about how we should
>> handle memory leaks when dying. Leaving the leak when dying means that
>> a test script that tests an expected failure will never be leak free
>> but using UNLEAK() would mean we miss a leak being introduced in the
>> successful case should the call to "free()" ever be removed.
> 
> Is there a leak here?  The piece of memory is pointed at by an on-stack
> variable full_ref when leak sanitizer starts scanning the heap and
> the stack just before the process exits due to die, so I do not see
> a reason to worry about this particular variable over all the other
> on stack variables we accumulated before the control reached this
> point of the code.

Oh, good point. I was thinking "we exit without calling free() so it is 
leaked" but as you say the leak checker (thankfully) does not consider 
it a leak as there is still a reference to the allocation on the stack.

Sorry for the noise

Phillip

> Are you worried about optimizing compilers that behave more cleverly
> than their own good to somehow lose the on-stack reference to
> full_ref while calling die_if_switching_to_a_branch_in_use()?  We
> might need to squelch them with UNLEAK() but that does not mean we
> have to remove the free() we see above, and I suspect a more
> productive use of our time to solve that issue is ensure that our
> leak-sanitizing build will not triger such an unwanted optimization
> anyway.
> 
> Thanks.
