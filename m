Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8229E10F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921391; cv=none; b=RWcY/a35pMWKHTJCUF4PiXQ0hlOyOjcKJenVkIr8hiqV3fa+ekkUvhn7gLE+UHoI6IzPUKH0Mz+FLg7K4WG6Wgncgld8Lp0imAuGPpTfc694PtYDc/sI0BknTGfU6FWazW5liro7HqeR1f2H1T/7iIKE3wVMJDUAQl8fYgDrIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921391; c=relaxed/simple;
	bh=xgHKwieQIa/9ZybmMAjBKFK+7jPdOxDstOLKIXA6OKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1Yen4G25CqQ0XSlj7Gywoo14QA8UC8z++3TbZSa40n1PA1gNNQjHy//PFiIdyNLJkLn/p9ZZQ8xLHDzpcvcw3kkhRpyIT3K4XUi6IqudyMXEvqNtgMzrQUgS9FyNPIIiWzJpkbEKYyroFrqPJV09amDTgQJCncv/Xz2ykd9qFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxBTbaoS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxBTbaoS"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b24fdac394so18359995ad.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774921389; x=1775526189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KjlRwXwhHtf/S87vDUs1fPhFpd2FcPO9hdjGfcAfR4k=;
        b=ZxBTbaoSx+u0iJOOlsf9QUZghQZ10uOIfxSVFJ3/zRS1xKWZYTVaLh3XOvDFICOC7a
         oKYY9Ev4rv7xRQvhpx6yn/NgFcwSEDHlzMjUdwhPkn/dnQcrbQpMpm2Bj3xCh6htn8Z+
         0xDi94cYmYiAAxhIQyhADxKr7c+VJE/toGSpA3uJ/aTR+SRAEjybAPUhnP74CGEPBThx
         9FeFoQgEsO8jVmiOEtPv0bpTyrdlj3165SCrAK0zMUYm8GmDOb1/qaA39l0L9sOY+Efp
         aZ2NtifHsImaEEcfyc0Djla8Ql9a+363+pJKhUBmCVywMSVRJ35zbw4ZVnIGnYjty340
         MKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774921389; x=1775526189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjlRwXwhHtf/S87vDUs1fPhFpd2FcPO9hdjGfcAfR4k=;
        b=syM/WhVI+qAc5cTmmozWZliqXF/yrXc6drb/hEcGKBbdRWxPNHdUSWyD5lwyaUFHn8
         ZspwLHuGxdiJg1noR0UUFR4CcrEafR2DNRKd8ivrXXJXpvAad2iI2UpW8CBf1t/TgEKb
         1Pzgbr4x8PHr5Xnn9SQilYHEEqGWQdj17E0ZmTuZhmLNWuCse8AYPaT85oIe5as0dvmT
         +hntolCLF62kDu+Of06Dc2XRhdX0203M/0QtsoRp3fvE4kn+8E5zrKJdaKPRurf0g34y
         6fmtUWMu4HiNVTrePAclveLsZvzE63dW+rF7ZG3ml4k2M0rjGXmGdIYUTbWbPh/4C94z
         0XQg==
X-Gm-Message-State: AOJu0YzU3isE5aY+0lPtzbNiEujfRI4dj7ikoJH0M17uIhBNr+84MGd+
	nL/tcxx0trKmht1MTftRlAMHwKv528RgWsa7ue9U9ySigm0P4zZLIpft
X-Gm-Gg: ATEYQzxWsCimu9BaSgsAETLctgPa/m5FRxxnnojSKsUaQYyNljiCSga07JYfkx0knjw
	UTf1wbSuXjzsjgPPYPYol2bUiJCnwUqAfE/IgdcQK959pdyo9L3bFLUDLzJjoc/rG9/H/hINImI
	MQZ9lbHZmmaX1j4/YhpS+ovaSHwonnJcameJ8c5eEJga5Cplh8KKwo3geVQM4BFCj1GtXSEzWnA
	6hNFURxt9v32stltvwNSfq/aN7veOR07nhnGqeMQMiwBKGxClEcajzMsk7EqQH2NaAyM8unZiw7
	us3xiZfZzGXEq9kKGAvr7iiSroOdP3cZDEzRGdyMD+I8SvJUlbOLzCdZjKvEqg6xyOhTMkLbTej
	QmGea1Z6n5V+LWAQGq+DFJVdp7cqYx0mRtH5HpWWpksbjtc81aXTFwwJtIOf2bK8yZ93OtA9mI0
	E2FovxOOPlU0tVUp/b/dUx8wBknZx3UsCK1KtpBKRKeWJasaumsJzwuUR2YOWC12sXAXwv4tAVE
	xDlVh3j1pFWEXSFoX9gwQ27kpFgjtCN4lHSHWUzaCFPlQ==
X-Received: by 2002:a17:902:ea0a:b0:2b2:42f8:1a45 with SMTP id d9443c01a7336-2b242f81f39mr116739285ad.39.1774921389392;
        Mon, 30 Mar 2026 18:43:09 -0700 (PDT)
Received: from ?IPV6:2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b? ([2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427bd672sm90595695ad.76.2026.03.30.18.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 18:43:09 -0700 (PDT)
Message-ID: <81fc274c-a1ff-44d6-bd55-afc2308b6d9a@gmail.com>
Date: Tue, 31 Mar 2026 07:13:05 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to
 --batch-command
Content-Language: en-GB
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com, christian.couder@gmail.com,
 gitster@pobox.com, toon@iotcl.com
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-2-siddharthasthana31@gmail.com>
 <acpSgZ8RgBIE-h1Q@pks.im>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <acpSgZ8RgBIE-h1Q@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/03/26 16:07, Patrick Steinhardt wrote:
> On Sun, Mar 29, 2026 at 01:58:08PM +0530, Siddharth Asthana wrote:
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index b6f12f41d6..a53926d2bb 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -692,6 +693,24 @@ static void parse_cmd_info(struct batch_options *opt,
>>   	batch_one_object(line, output, opt, data);
>>   }
>>   
>> +static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
>> +			      const char *line,
>> +			      struct strbuf *output UNUSED,
>> +			      struct expand_data *data UNUSED)
>> +{
>> +	if (!strcmp(line, "yes")) {
>> +		if (!mailmap_loaded) {
>> +			read_mailmap(the_repository, &mailmap);
>> +			mailmap_loaded = 1;
>> +		}
>> +		use_mailmap = 1;
>> +	} else if (!strcmp(line, "no")) {
>> +		use_mailmap = 0;
>> +	} else {
>> +		die(_("mailmap: unknown argument '%s', expected 'yes' or 'no'"), line);
>> +	}
>> +}
> 
> Not commenting on the overall chanegchange, but I guess we should use
> `git_parse_maybe_bool()` here?

Yep, agreed. I will switch to git_parse_maybe_bool() in v3.

> 
> Patrick

