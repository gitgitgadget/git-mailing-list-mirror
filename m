Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD247F7B
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158401; cv=none; b=UmlYT+Gzki3Xdh1cIRWxStCx0QoRUYVw4fl3utNp4L5OwJFgMStcX66fr0G5aOjZVliVzQgIP9yerspd52W968gPV3UHzaKCaGZyok4LCGB3xONa0+WV/Ox4YsYyiC1efXdsfB6RLMAHjBZT7sdZswzGTp/oNUKWLxJkph3NHLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158401; c=relaxed/simple;
	bh=kwbBAYXqcUdDQAgJOEROp2JSfFnYUqnR83b8rIiWb3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g17Gg6i/NmtJSDn0Vf4ljCLIuNe8EYBjkFplLPN/y1XbTN9K5LMpEJc6rxSrcSJSnxDtah05YIlgTID9YLghNOGf8xPTqWq2cxolzy+HqUGTRm1tNJ6Yqxo1BJm6riKm2BrLoCFrhqF5Gd3KFh3S2n1jnMobu3kUTHUO0t6AwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYNTu5cM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYNTu5cM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d98fc5ebceso8679685ad.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 10:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707158399; x=1707763199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k36q6fntO9jaAJaDEKgU0DBkUF5IEpk7Cysdy3r+5WA=;
        b=MYNTu5cMlm1JWjVT2IWM7C3hvzZydz4uXNJmPRV2kEe9EbV4VCyNhgpwAG58RmghFb
         5N5+CW8H5sjo/uIUNKrgYVEMPXq6q+ua6wnMvxBvtEkg8iKeTbysHJApTYSaMupEeHuQ
         jXXyKRm1m5w7t/r+UrQk8WVlSizXxORtPxvphWFbAwhlLy0YKL+VLdSF8Iw8lI3VW29k
         wQrzLIhmuAO+PFI45eoNp7+3dN7q74FkPT0bafZoUG5WRPE+6UFlxSiqZ8bjqPL78rY9
         +BIqFo/GNA+2kRyaiNJ3+p89ok9+VRNOzpLkzBGEU70ChY5atVbgHqWdjAvJNle4kXMS
         gPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707158399; x=1707763199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k36q6fntO9jaAJaDEKgU0DBkUF5IEpk7Cysdy3r+5WA=;
        b=Ey9k/tNkQTvhY425TLzrh4IG7dHnISemDJMO2SExPnPahQRliyTZzEA3kxIPnS8+jC
         rGe1kbhhP2NJ6Y7XBxRdZPxqAwIdWvBzsSpCVqY6GyOQzKaLTaQUiNTjFgsK6WQovWBy
         lttNkEyUXqkLn9Yr0Ed2EZ2oSku/Ur1cZ1YW1FnDzYN8kE2LrmFvHcbc0tQ+Udt7wwIm
         YqQ5aul7lMpwXahLNSLlkcohLsYQznV/2r83RdrtA/vs5uzabznkK+j4j3DeaO8e3nUf
         56u5nk3odYGnbOz52Hs6mUrk1Wlcr8iBnuy5bNuJWK0wlOrhVCor9XQfn/eN/mATZk1j
         GSXQ==
X-Gm-Message-State: AOJu0Yy+w0OH33oZsxlJn80yIGF0g7QtSACx4swRnc8sjlrXDwpl9/xd
	CyOLEstyRtiQFcrpJCqMcwG01DLTmd1HHcvZSOEYKcdj9/Ac3qVbSrm4zOm9
X-Google-Smtp-Source: AGHT+IFxn7BBh8SSbWXaDk4Jx4Qpwx3ipxnPcDO0vk8ZNJekjQhp+28VwvSYrNAVr7lKCGGjXzbU/g==
X-Received: by 2002:a17:903:11cd:b0:1d9:a2d3:8127 with SMTP id q13-20020a17090311cd00b001d9a2d38127mr335091plh.52.1707158399325;
        Mon, 05 Feb 2024 10:39:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJAoKG6/ihGKnOeHmAS/l0jafi3A6HKb5y65f4JR+vIrkDbke1OlVH0VjM3RPMKrHVA5A4POMgtHVhVADf+frhZ+GdPwuwOw15fkGMszH0vz3Yuww20iPphXIXrapBpXKx6WW6iT41GDVeoqh0JpcA50Yao+oVKRCdneBXqQSGK1lrMx5AhEZNmUWINx4Y1Q==
Received: from [192.168.208.87] ([106.51.148.224])
        by smtp.gmail.com with ESMTPSA id mp4-20020a170902fd0400b001d9a91af8a4sm191258plb.28.2024.02.05.10.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:39:58 -0800 (PST)
Message-ID: <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com>
Date: Tue, 6 Feb 2024 00:09:55 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2024
Content-Language: en-US
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>,
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Victoria Dye <vdye@github.com>, Karthik Nayak <karthik.188@gmail.com>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki>
 <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com> <Zbtmoo8qTmj-yt99@tanuki>
 <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 05/02/24 22:37, Christian Couder wrote:
> Hi Kaartic, Patrick, Karthik and all,
> 
> Thanks for creating the page!
> 
> I have just applied the patch Patrick sent to the mailing list with
> the ideas related to reftable.
> 

Thank you! I've now successfully submitted the application for Git using 
the Ideas page we have :-)

Let's hope that we get selected this year. We should know about that by 
February 21 - 18:00 UTC.

> Yeah, we need a decent idea page, but it doesn't need to be finalized.
> I think we can still make changes after the deadline (which is for the
> Open Source Orgs to apply).
> 

Indeed. Let's see if we could get any new ideas / potential mentors for 
this GSoC :-]

>> Christian,
>>
>> It would be great if you could look into and improve the detail for the
>> unit test migration idea. I just added a very terse description based on
>> what I could get my hands on. If you think the description we used for
>> the Outreachy round would do, kindly update the page with the same or
>> kindly share it here so that I could update the same in the ideas page :-)
> 
> The project description for Outreachy was not very elaborate and is
> now quite outdated. I have instead improved the project description in
> the Ideas page.
> 

That's great. Thanks!

-- 
Sivaraam
