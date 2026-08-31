Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263A3B3C10
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180668; cv=none; b=ZShroYhDsGiAMtSpk4eTErNZ/gTSaKWHf1TDj348QnVEEBHHxGL0XZFExjoao4m2L2Pf/vqCEhYQTdVMjRdcwIvSejm67QUMiRbgaq/WJ+SW/EHraSWAH266WWg/g6AkO0RE/1Qh9tn/UuzX7V7pUo2IYDcrOITkL99dBhWxGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180668; c=relaxed/simple;
	bh=i4PiaefIO39uZANHIeNRONwQL8YT/XAZjOGNzKsWkj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbPDpaJkdkBA1QWq+vSxOv0zEh0gdCWvCrHVLYNgWSsvbD/6QvXSyWGmd0DDUwVppziV64gfp2EbZZXW2BwY6UNUQWjX2w39qO1ICEuIyaiz9g9BVAveQJqP4nSkeXIsS2bmPcGEfNOhi4VhL3jnnOyCr7vkI5vcmjLLo31UntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+J+dhJ8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+J+dhJ8"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so761561e87.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180664; x=1788785464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vgwGJVS7uRBRlqJSK8n87eWjNOgMgrm+9jKvEHsBMo0=;
        b=q+J+dhJ8J57GRtifnyYdeRa266RfQYdYHSGiUh32U63t3sslyA2ov5O2p1HseBIn10
         eC5vg+5rWUQW2BDlTAFj5Wk4gL+9D39qUceQv3Vb5IK66b1gTOj+7IhLg8xSJEc3AR0N
         mhCb/mNc+UgmAhlnjqI9ETku19VIOD5PGJHrpxVkyHIn0M85797DVq9EhVMtQgLwzzuj
         1G3A19KTRHL0NGZG2TQlqHI25zeR166Jy4rQClRjkRFNbXSHOtYlEbcgG70HO6gtg9Zn
         9u94xx2LjDbl2qC8oHsVObFa6ZRCyQYV6jEY3Z6ZsJejF5qUSC148RjHrrRZG4jaBirb
         H9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180664; x=1788785464;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vgwGJVS7uRBRlqJSK8n87eWjNOgMgrm+9jKvEHsBMo0=;
        b=E9FRQc8hmpfT5U36LdKf5Et17g+oL5a+XI7npqxh/7zFPHF81vrGy8OKpBSllot13u
         A9vcyiOJOuD4RQRt5FRy5XYwcaEo4yam54sX6sPZBFIvhnZm8CvAER9ZiY1CZe60EZTC
         u6krHsKFZL4yIHO+hmiYl53QESPEmlOp5rYSOmqL+kQDy1TanIfQtbFfmcQxtY5ULJb/
         rmG5q9SO30UGfiup9R9TwxJ0yUMrL3BpTGXN2DsKwT2SZVjQUkfM+iNyz1RrVD0pJlmT
         Wla6HM+qMbCbrxOc3kaCN2B5U18kLhoCJ3Ra7QH8f+7mPOrXpyJzLUf8awIUjsGEE9he
         hDMA==
X-Forwarded-Encrypted: i=1; AKwUvBx96kGu7lN3d9MwydkHEwO9SuJOaMeD+VJ9aLaGVpAlQLeC3A5FJHFOES7r1f94GQS3q/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lXg+CjMbzt/drSUBw3LuAgtGrkMBX9q/PBDx/cVYA38CG+VeVy
	xAlCfQ3tDIab7Gkje22fhl/4Zwv1Z7T8anQW0j2kSQhncIn7qSeabTPG
X-Gm-Gg: AYBFou0f82yJtkb+L7OUQs1qV0mt7lAXLtjy0yKdjidqP9RQhitcR59eLpI3t5oesJB
	HRLzDqmLGrlDefzzuHnSemk6IDnbeyoyNOWD7Kt4dSjQ02gS6rKj3t9+Bg6vY4Xwpy9Gfn1tOLO
	W8i47M775ZFc0EaQcXxfTEcHRb5Egmtah1jUeikF+MIlL8OO4gGlFF/njqu7qGALx+9ZAhSrz/U
	YdpJax06/enNwTRgSiDuYcqlE2UHWs7PwSTD81gpSCBd2ez9b7elKFGHkK+NnWOZLHkNz4PCoHS
	KynZLul6O96eRTs1jVdoEXXdAKu405oVcIQz25mo7jmRdMC6W4J2+xUUeOyZlzkPDREVpTCPMqK
	/EoDT9zDt7F5J+ykmYYL573PoaZiFlAFfvXSSU8rZjmH8A1t5FJqEC7d+H+dfaeWSJ2ATWUG70n
	yI1/K/Wy2WddgRSOpsyQbdKaK5O+yXKqlirlJzvzkmksNVkShIyww2Q7jtXfEF2jbnazUC6F1SA
	66hmq7bUneOs+ofvaI/rvlkDUE1AHyFDu2QNWwQX67R0nVZqcpriiZJ7rcpoRqUQLitju7E1Ffq
	lswAKsY2CfSe5Yw=
X-Received: by 2002:a05:6512:114c:b0:5b4:5880:b50b with SMTP id 2adb3069b0e04-5b5fe058f29mr143955e87.4.1788180663964;
        Mon, 31 Aug 2026 05:51:03 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e89c5c9asm2246093e87.11.2026.08.31.05.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:51:03 -0700 (PDT)
Message-ID: <feddbfb8-9b1d-4bfd-980a-9d51e05ee0ee@gmail.com>
Date: Mon, 31 Aug 2026 08:51:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] trace2: remove use of xstrfmt()
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Taylor Blau <ttaylorr@openai.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <7f0bb405ad380fd35ae6381961ac667fd7e5dfd9.1787684181.git.gitgitgadget@gmail.com>
 <CABPp-BHxpt1UBTY5LCn9OFMZ6EtOcUPc-61RMWvjpjDBmv1rzg@mail.gmail.com>
 <xmqqy0dtket5.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqy0dtket5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/2026 6:36 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> On Tue, Aug 25, 2026 at 11:59 AM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>> [...]
>>> +       const char *redact = ":<REDACTED>";
>>> +       char *redacted;
>> [...]
>>> +       memcpy(redacted, arg, prefix_len);
>>> +       memcpy(redacted + prefix_len, redact, redact_len - 1);
>>
>> Only copy redact_len - 1 bytes?  So only ":<REDACTED" without the
>> trailing ">" ?  Why?
> 
> Yeah, if it were (redact_len + 1) it would have worked better, perhaps?
I should have been more careful and realized that we don't have any
tests that cover this logic.

We have tests for ":<redacted>" in pkt-line output, but not for the
trace2 version.

Thanks,
-Stolee

