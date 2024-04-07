Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA82B9D6
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712499001; cv=none; b=VHVVbR86/a6CTnKAIo7OSn3P/e/PEoI+hIJTzXU5WLcG8My/WidmzhviBo4UoEiz6iMimtXX2/JyG6Vuk4yiUwqnen6t12uwKUp/Q+L9LXe/6hiT/rMRxBFnRMs+AGBu2K7uxZAOAOkE0apyxqpgR2H6Tq58qP+jdh/U/Ai3WBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712499001; c=relaxed/simple;
	bh=0NQ2HcipOg6+3w19tfbNGb0afzi8qShqq1ppTakXuIQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fGgcTeEfKpnYTNeLUCG8b4EcFb/Bnw0BeVNkG3pUqoF97MPJ6JcnTZAhWRCn+CIoOnjyUlfe98Owl257eXEVGlK4Esbh9IF38wdL8ZDW4dfdDOfRsLSA318CFSvTty6wQLJBTE5Z3cwLCeC3fnHiPfaqd2XWDXFxhQlzd0o+EbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUZkbXti; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUZkbXti"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41638a0a87bso5526255e9.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712498998; x=1713103798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uG6/eJ9yDOZDgsJbJ96UN1JLpMjIT/h8pky8nI56WOs=;
        b=IUZkbXtiIMAAiTHI1/urQk4juU+AbXCwWnrPiKeOcV1ATPqXfahQmMIZaxxnpPrcNr
         uoQYzmmkdZgv/8/GDdWXUnbkl9a6+IIr92IJ6HwGc0+r1nYSXdqSyj2dd8DTCgA9k/hh
         AIoz5haiiSsq0i/28krnO8hDjT6iChenUfDsqsjq45LiXNsHpK5jUpdlvT64iwW/J0c5
         UIzgj7k+noUAec48OZ/pMXg5tz+dVhoukDj5r66EMEHORzN96yL0W8SHz+P98lSy/Aha
         rpkkUJEjT+eH/J6m2DJuJwefgbTtp1u7eNJnVz7yfp3eVaK6aTRZWTOD+geGTjZMO4k5
         1KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712498998; x=1713103798;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uG6/eJ9yDOZDgsJbJ96UN1JLpMjIT/h8pky8nI56WOs=;
        b=Y1qvJSwrceIXhFnGlDKmRhAanyCw/VKDM37qkKe+oM5nUQd4mgXZkxsBCbEFw12Nov
         AWsZGAfnpwZ9R/f4S20V/Yy6Oj1vSgUk+UbbCTkFyVbEs4wbJwGZtIXERorLVRkB5NLV
         lS9UvOfbiyBkerL7c2pEgAl0FgJ84d/wojHtLREWhQ0Wvn3gmFr3m74gxSHyNz1iai+j
         T0tGDFLsonTyj4dwS8ED+4CW7pKwjIeVD28HdDtYNKJa81jGepdR1z8ZFNsD8uQEocT3
         mkyR7/+I4X5TgFp66LuBtgpRA8wolSomnVU5h3m1KzIB5MUwuENAdgzYZWe4UD1Qd0LM
         +zAw==
X-Gm-Message-State: AOJu0Yx3WyMhNe+yoH0DAlbGbTvWWW3sPrDTEGv6PTrEgDImbFOvm12P
	BDUCl8lx083j5AZfWn4WrO/jjsKZenIsruZJYbIX9+Oew3Dc1TwJ
X-Google-Smtp-Source: AGHT+IFzyjbvL+Umb/DnlZKHdi5FcRJapkTyPATIn6R/v0H3nvr6hjXCTg5HKRLK9Y5Tb9jxnIH2Jg==
X-Received: by 2002:a05:600c:1e1c:b0:416:6bd7:cd88 with SMTP id ay28-20020a05600c1e1c00b004166bd7cd88mr290594wmb.8.1712498997499;
        Sun, 07 Apr 2024 07:09:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004162a9f03a6sm13159698wmb.7.2024.04.07.07.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 07:09:57 -0700 (PDT)
Message-ID: <d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
Date: Sun, 7 Apr 2024 15:09:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Olliver Schinagl <oliver@schinagl.nl>, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
 <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
 <4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
 <6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
Content-Language: en-US
In-Reply-To: <6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2024 20:17, Olliver Schinagl wrote:
> Hey Phillip,
> 
> On 06-04-2024 15:50, Phillip Wood wrote:
>> Hi Olliver
>>
>> On 06/04/2024 11:06, Olliver Schinagl wrote:
>>> On 06-04-2024 03:08, Junio C Hamano wrote:
>>>> Olliver Schinagl <oliver@schinagl.nl> writes:
>> If you search builtin/bisect.c you'll see some existing callers of 
>> strbuf_read_file() that read other files like BISECT_START. Those 
>> callers should give you an idea of how to use it.
> 
> Yeah, I found after Junio's hint :) What threw me off, as I wrote 
> earlier, get_terms(). I wonder now, why is get_terms() implemented as it 
> is, and should it not use the same functions? Or is it because terms is 
> a multi-line file, whereas the others are all single line (I didn't 
> look, though I see addline functions for the strbuf functions. Should 
> this be refactored?

get_terms() wants to read the first line into `term_bad` and the second 
line into `term_good` so it makes sense that it uses two calls to 
`strbuf_getline()` to do that. It does not want to read the whole file 
into a single buffer as we do here.

> So with the name, I started to think some more about it, and after 
> playing with some names, I settled on 'bisect-post-checkout'. Things 
> then sort of fell more into place. It is still a hook/commandline 
> option, but it's a much smaller change (since we don't have any special 
> code to check the exit code anymore) as we can (obviously) run `git 
> bisect skip` instead of `exit 125` as well of course.

Does that mean you will be starting "git bisect skip" from the script 
run by the current "git bisect" process. I don't think calling git 
recursively like that is a good idea as you'll potentially end up with a 
bunch of "git bisect" processes all waiting for their post checkout 
script to finish running.

Best Wishes

Phillip
