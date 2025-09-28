Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1861373
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759026878; cv=none; b=VKx7kumXAxqK9oQn+tvD0SSUdN2p/dnt3S8x7fYAy8IepRkJdsA1hho1cvDXewhtxNHGz5xjRSdk9YOzPNe6GHPh+AKSaUIoZM6RAU44NSb9aoIiUfTDXGfBaWfbmGOGDlSRP/tvOTXzyJFX0bs3+1R6Pp9eO3GxUT91StGCldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759026878; c=relaxed/simple;
	bh=Ydqde2L+jStq8f01eBag1AElr3i6oSnuRmpv7WNkEF0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mewcCEAPdACAH162qpWwbf+h1mqwSMylQoJwxOhJON9ZrfZSjpm5swludcfLCJm4q4+QUAmJH0hSzo9vdfL65+M4lcEhw9e3MC0r+Ar2IDPLzeHJPpfp5NaK6mV8wJhL3mAS8lO2IH2ai0zpGmCIt8tvWFsZptLgr0uZo80EZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq1zVJ0o; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq1zVJ0o"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85780d76b48so364273285a.1
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 19:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759026875; x=1759631675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qtcUULQsBwe2YHwjREsGOAKZxjTFTrU1+oy16/AeErU=;
        b=hq1zVJ0oF5IWRYZhOv7Sd6uEMY94+e7mUpq7EHw7ZS5KQSTI3kooMhZW9tl0ilvWuS
         ITEFgj3shNKXLQjQe8huSbG3HLCvbeDMd2s7sov1Io0eaGo4cDc66O1VIuz+MXTKSeSK
         3C3pN7hptcDudipxmcNnvLNbINLdI40LHjRvzntEL0lfwsbnvvCSWS4jnz3EVzVYA3Ow
         Hj/rFNl+uZyZ8apJNdneA0eWG6V9OukOzQmScWXazzGal1Ugbc7pJ0DEdZ4Wg3/M98kI
         WLeZ3uOzsG0EtZz8vDr70QVC8bHtqZV74b6I69Ta7/Xc3Zff6kedxy+T/+uUwgHNowz2
         7KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759026875; x=1759631675;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtcUULQsBwe2YHwjREsGOAKZxjTFTrU1+oy16/AeErU=;
        b=oMOt1vOn4Zbdv+1Fnu/bxpHJX821WjMAYASGoqMvC10c4jnY3aK9lZmZm3hOMvQRbN
         Vyw5kJ69XNYKwPeIeIOVeXabFS7JF0ftyW5Asb4CXVM8m5MywRk2ikJNsp/Tp9/P78rx
         l/vEnYLrxRdLIHsTtWipWd5Upq4GtMcXXT4Nxze/iFOIujZ52zQobaobr8TavtXfPute
         7wBv0GAst0TpwT2jgYV0mLPtTQtJbm3mhq3fnF4M0JPT16u5T4hMU4ybwJnvptB0RurC
         Tccvti9SZrKpS7hY0f6O4ZciB+PqD/eMlk/6+u36VjAMoGqONNZzsBw6DX3m4+Yn6r9/
         AqvA==
X-Forwarded-Encrypted: i=1; AJvYcCVtfHnUU+lJ2T5TO0wNW+NtDDBq7QgechRApD7lHJsvRgPXt9Lw687KaXZfXoJCHX8Q5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QqGyNkYKkM8nYjUSOUvE7w0O4qLoGBjXIuxjfr9C0rkXGHGQ
	ZOC4WgmRXrEJyCWRUfPXorrkwPTijDh7TdPfwKNiU6jzaFhf+FB7CVpV
X-Gm-Gg: ASbGncsuK94vcXpcS26HIWYyN5CD1L0HbeAKRv+94MNIv6OBVAoW2zuNKwdd7nSqUt7
	/HE9isBblISEVBNVBeKg0Kk20QNMBfQia7UyRjhYlmMBsl71JxejhTX2apAljf93cHaISzJFSe8
	2obQXTbF5g7Lp67ICmb3yrjQTPZL9Jv5Vvpy+GzUhuPyKJwn9oO0hrFE7drNFkePbHe59uWJyEQ
	1BYkj2MZidbOmMz//OW8KYbKuY7uyWZKZLSraOawPZS5/VyqM7qGtoXItF/0rd4o+kXg/1iOgBj
	V32Lg88eHAblF94D9CciLfEdc8icTXOVY3LrYRngqMM7hZALrFVlo9+/TJqG/Dw3V02AIkZm8Me
	ZAJY8c4H6MHTuhED54DCB1aW6BeR5oxKbgwVISNLvUA89
X-Google-Smtp-Source: AGHT+IGnt6YEY04XHvxKPR8pIreW9CWa3RjlltZDKS+27vzntnaL+7JN5UEZK0zFbhqYkY2IySDgGg==
X-Received: by 2002:a05:620a:2a01:b0:84e:3c02:810e with SMTP id af79cd13be357-85ae033cbe4mr1568620585a.19.1759026875271;
        Sat, 27 Sep 2025 19:34:35 -0700 (PDT)
Received: from [192.168.1.174] ([71.192.65.134])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c306b662esm514443385a.35.2025.09.27.19.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 19:34:34 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <e6ad07ab-2c0b-43eb-8c1e-b69d97458e74@gmail.com>
Date: Sat, 27 Sep 2025 22:34:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git merge --no-ff failure
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
References: <5cbb5c0a-4c51-4d15-816d-6d7d4fdf4fe1@gmail.com>
 <1f78a660-3c1b-7aea-5b3e-945ec2b1ad80@gmx.de>
 <f3a051ef-328c-4778-9c78-33d52d273479@gmail.com>
 <CAPig+cTOeCWGeNHvnBK8v2UyAV2DRs8QW7DMHGkfRHW3vSTgQA@mail.gmail.com>
 <CAEcERAxiuSAvpPCzsWSpoNQRmbgF0B92augTVgSqNN1jb7mJYA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEcERAxiuSAvpPCzsWSpoNQRmbgF0B92augTVgSqNN1jb7mJYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sigh. I added file with dot in the end to the p4 repository that on 
which git behaving well before, and now, with the same scenario, git 
fails the same way.
So, I have to agree that you are right and it is, indeed, the root of 
problem.

BTW, Windows does have API for working with the such files.
Cygwin, for example, uses it, and has no problems with filenames like that.

Thanks and Cheers,
- Nikolay

On 9/27/25 07:55, Nikolay Shustov wrote:
> Thank you, I will experiment with that. But why would these files be 
> involved into merge operation? They are not the ones that changed, git 
> does not see them as something that would be merged. For all that, it 
> does not appear that git would have to be concerned with them in this 
> case?
>
> On Fri, Sep 26, 2025 at 1:41 PM Eric Sunshine 
> <sunshine@sunshineco.com> wrote:
>
>     On Fri, Sep 26, 2025 at 10:03 AM Nikolay Shustov
>     <nikolay.shustov@gmail.com> wrote:
>     > Now thinking about it, the only quirk I that I did not mention was:
>     > Our p4 depot, unfortunately, has some files which names end with dot
>     > (.). E.g. "/somehing/blah."
>     > Naturally, (a known thing) git p4 on Windows created
>     "/somehing/blah"
>     > for it and then showed  "/something/blah." removed and
>     "/somehing/blah"
>     > as untracked. I renamed "/somehing/blah" to "/somehing/blah."
>     manually
>     > to calm down its double personality :-)
>     > (BTW, I think git on Windows could be doing a better job about
>     such files)
>     >
>     > But the other git p4 repo I created from another p4 depot, where
>     merge
>     > --no-ff works fine, does not have such files.
>     > This is the only thing I could think about may be a bit... unusual.
>     >
>     > I can try to experiment with that if you think this could be
>     relevant.
>
>     That's almost certainly the issue. Microsoft documentation[*] does
>     state:
>
>         Do not end a file or directory name with a space or a period.
>         Although the underlying file system may support such names, the
>         Windows shell and user interface does not.
>
>     And, indeed, functions such as open(), fopen(), etc. which Git calls
>     return an error on Windows when presented with a filename which ends
>     in a period.
>
>     [*]:
>     https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file
>
