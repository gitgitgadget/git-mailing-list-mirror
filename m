Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362A39E18C
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685488; cv=none; b=P10QAM1CtViDJh0X8/vto90evfcaebNtLK8x3n4D2VpcbbF3tTMfr4nkzYsf8bWi4FXlDAtjyHoEv+hgymSPGN3V55pMsYWGxNX3lMqZ6yHJnNqN4Kc0n4V8ApIBlrg+tKPZYc/NxN/G2jWRa9W93pvgA/OwRWukmnSFnlLq0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685488; c=relaxed/simple;
	bh=kOoLirx+r6/LnBWjfDtSKfHIYBgIP31oLWrm6SaEQco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbU0Z+AfalV1XR5Pe9SOrRvHDhPsvfwRpTkbgD0ZeQbpQz1alOSHCCRbiI0SfxqW89eDlt9dNOPF0XbA+UVekisthLBc01RdCOkYSfXwoHwLbVFFGYBh9F/+soiZl10Tc+vbJc4IaMfhjIge1LNFRsjYbAB2LpDAmks1jgSkSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjzpPZL5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjzpPZL5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ec37d52c0dso49692285a.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776685485; x=1777290285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIzf0XPsAhz/8t3+FJPuZxmLsPQBayTBK/OeNxwFo+8=;
        b=CjzpPZL5QAxy4JmXvd4s6529k1xzmY9ojdnMH6M0Hj+KIRSq2ESHfzCvvE4No1wlgJ
         OY4rznKGXTUF6oXMA6eTIE8kVfTKFxCtKZoiLyXIccXv3EaPdm2UK7q+EMxCI1ipqm9F
         CepEaK2JJRt2oDppFCtuQQ4D4VwB1y87WMfeyUE7+aEgeDYvvRoEc3aIAp/soKTVTuI2
         oUpTuFArvMNi7gSx+cPg+vStwKWjB1YJX/iBMwNmgcSu4klQnZU8G4owYJbAG8VLRSMD
         kdyWi3wiRHbyhVLHTToGdxiX0WPpqWSl2J2TtIgTXzzHYPQIagUvSepG7AO/UNr6cEG8
         0wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685485; x=1777290285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIzf0XPsAhz/8t3+FJPuZxmLsPQBayTBK/OeNxwFo+8=;
        b=hm0aVa9vNx6PUWhK7pAqmTVggHPTxoa5hz+g0+kfVWpUDS2vVwKSyKN0yyfHrkKJSR
         xRae09AmuUmjkC6vkc8hBS8zb3C+Xi5Ps7PH9nk+wDw4niRFLaTqgiAR2bOG5bUjINLU
         HdAOOZ/Qu4pzgXykZJ2eZ+fL6U04ylwkihmA0WlnTzmr6qeBZjJviLhCXgdUx1JLoHWL
         mpOCrVl1Y2GumY3rLnHnxjlzNaMqjbh8/97Wdo2ubG/Kwm45GY9UkP+ffJXyvoaylC4p
         XNFhk5t52CmG1Q6ANh4sjCHMmJ1o76QsQrJS/b48tN9CfETFO7370v8t9OOm2aze8Fj9
         x9DA==
X-Forwarded-Encrypted: i=1; AFNElJ98IgAWwB30aK9xJrDjFz1Zp1mKffOLK2xgwj2hQH992VfH1TDQoW+NelF2dbGV+IyoPdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywrSYiove0OT40OC0XHFYAAqq9JwXk0cB+Jd9KyNdKlH6WhggF
	pxbZQZSjSnpSOzs68k6Lcob/yCO5T7DGfMN872WP/M4vb5AtHymlIM0Z
X-Gm-Gg: AeBDietIPUsjP7HZa0b8c1B0/drH6tEbt0+2TXZx8B11CP0cHIjQjtXoebS7WkpzZZ2
	k+5/scCpf26t5KIHQvPn7oNgkstkdA69IWV7PfkSLmx88gf7R/TCEClmXKHpw53ONS3TXKupNx1
	I5hZs9CksImTkvMeKlgykhVoc4XxCWuT/BatgXVCZe1phN/cbdoIFDaic8B2coopWN0t209UskE
	gy8vAHZ9/usPtV0IED+6Dy2MpsVEVWBodPOQQvTxhPprHXTY44RCcmVoJ0dGbbfyk0mAm+BsA0n
	UWctxBzgCpIQzPJGeoPgEjKMIvLVghFALe63/ykia9c9mp7+i6u/DnmWdy25vEBcAR8a6VmOFOZ
	r2SjY9ajpEpZ1rwBZewpUJlhH4UI1FVTS7s1jseITa/ZJGo5zq9JYlm2MEthXm7BKNPZb7owbXd
	6libYdf9X3l0Kk7RxyrrTYDbBANjVCLHsblNrKFr2GWH7u7pB96cmljD8N5skDJSS+JsGP+lU5X
	XH/x7Z9YHnGyO0smmI=
X-Received: by 2002:a05:620a:691a:b0:8ed:c5ef:119e with SMTP id af79cd13be357-8edc5ef1e44mr45954285a.22.1776685485580;
        Mon, 20 Apr 2026 04:44:45 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d99c3c17sm787974385a.45.2026.04.20.04.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:44:45 -0700 (PDT)
Message-ID: <8a3e3a38-3f8e-4363-9e45-b5610c3efbc5@gmail.com>
Date: Mon, 20 Apr 2026 07:44:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rev-list: add --missing=print-only mode
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org, toon@iotcl.com, ps@pks.im,
 karthik.188@gmail.com, justin@parity.io
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260419084840.33986-2-siddharthasthana31@gmail.com>
 <4c9fee0b-99bb-4e41-9227-f09c63df9f9d@gmail.com>
 <9e2ca91d-9091-4d4d-9427-ec8a23ee8909@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <9e2ca91d-9091-4d4d-9427-ec8a23ee8909@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/20/2026 6:24 AM, Siddharth Asthana wrote:
> On 20/04/26 04:06, Derrick Stolee wrote:
>> On 4/19/26 4:48 AM, Siddharth Asthana wrote:

>>> -    if (line_term)
>>> +    if (arg_missing_action == MA_PRINT_ONLY) {
>>> +        printf("%s", oid_to_hex(&entry->entry.oid));
>>> +        putchar(line_term);
>>
>> Is there a reason you didn't use a printf("%s%c") here to
>> put the oid and line_term together?
> 
> 
> I just followed the existing pattern in the same function where every other path uses a separate putchar(line_term). Happy to combine if you prefer.

>>> +    } else {
>>>           printf("%s%cmissing=yes", oid_to_hex(&entry->entry.oid),
>>>                  info_term);

I was just looking at this line in the patch context as
comparison, but if there are other patterns that prefer
"printf(); putc();" then that's enough for me.

>>> -    if (show_disk_usage)
>>> +    if (show_disk_usage && arg_missing_action != MA_PRINT_ONLY)
>>>           print_disk_usage(total_disk_usage);
>>
>> I'm a little worried about all of these checks that need
>> special-casing. These seem like options that are enabled
> 
> Phillip suggested making this a separate --missing-only flag that composes with existing --missing= modes - I think that's a better design. will work v2 around it.

That's a good idea. '--missing=' formats the output while
your mode _filters_ the output. They are different things
and worth different options.

>> how this interacts with those options. And perhaps some
>> warnings to say "these options are not compatible".
>>
>> On that note: this patch is missing a document update.
> 
> 
> There is a doc update in rev-list-options.doc, but it doesn't  cover interactions with --count/--disk-usage. Will fix in v2.

You're right. I thought I had looked for it in the patch
but missed it somehow.

Thanks,
-Stolee

