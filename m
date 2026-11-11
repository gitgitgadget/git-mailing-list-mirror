Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405462;
	b=kxtD5HVwXmMoyi1AqQ4E3LLavs0NmMNPE3n8WnCikj+xO7Zf8KukQglDDV+9RZV0i8jL
	 66I8aMqGYB/WarCLR6KSzp3QTAKxdxD77E2kBgNdy0tBtypVNPDnqSHq/TbOzEdObfyAm
	 BhdMkNZHZTMVTSyk2LlHQBcGMFqrYwxXlUa3yMomnEBk+x0+nocS3cf8NvVgV2QcjLf0M
	 pV+WkFt5FqLkdjI6mW45jE/8aVXC5j7mJxrJXHdBkmURERlS6hZIfn6LzecxEky+BziRM
	 /Ld7EhdmpRvpd15ixbmtfR3xbYSurY+XNHEcUSRSDwc+PeRApC4V872dnaLUPYieOdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qWfb7rYKzJNCABQaZ6Tu0gaLzRvAMN7cVRnyY87EJX4=;
	b=ytRc/56HbjEmXVamCCsxCgTxIZHaMUs4+DOUJGG3gIJV7n7WgtnpE5sDxZ3ibVjuFAM5
	 HREzqcl7sLmGfZqnog8BrLCsGnk5DefpNW/Av1BNCl6tnSwGu/UnXnN5x9YhTI399yXX+
	 hoF/lPa3boaa42P1Xn2mu2hUoQdvuxN5RCtL06uH/C9mGOyUH/TZiCOqF1mhalGQuBg9R
	 td2JsAnp/5xWmfo2Xbf1xQ+F67BbHOYMnarZISh9VaTT4/EqjVriUmof6puT9UYMCTcnf
	 e+X5m6cnVpHG/O4y1pAo0yLkXs4PUDD2iCT+6XsW0QTjOIk3pvNuhM6CYgvgAmcta/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j0Atlqfa;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DEF606A338
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3DEF606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j0Atlqfa
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so38737495e9.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794405460; x=1795010260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qWfb7rYKzJNCABQaZ6Tu0gaLzRvAMN7cVRnyY87EJX4=;
        b=j0AtlqfaLiNEe5C4zTtRmuwV6mO7IVBp043RjwOqqC2IUin6UuVwCsUjcMDCB7+xLo
         rY57mgx1ExzI8ObUMQHMsAhOUQTJjUP8ulFD4/SD9zhqFGp48ekcEdUi/k+RZ4hO1cJK
         ym5vSqKCT6yyOrg+0f5k+O4lqR78IXMCAvcn36vYZPhq0eX6h4OI02upmAi2SOfWbsWY
         QLU3O30a/9lHJnBw+nKFHKYqVMwwgzx4UviP1lllgvt4rT6eF6N0m+QGKvG2Xv6QUh1L
         2MA5A0AjAW8r9uxJjTBkiqAhlGDY72HHIcm1prr4PEZhN5Vw7ZMEZKjbKwbV646mKNfv
         uLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794405460; x=1795010260;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWfb7rYKzJNCABQaZ6Tu0gaLzRvAMN7cVRnyY87EJX4=;
        b=geYwqteIdYa/fKKBq7YwQYhxwqSLc/R4NKtwvWwMxNlxVheRBzG+ZBVmx0u95ysI32
         HUYCWD7gAiRw4OyrJNALhwXWNGjAWOvO7JwgVialrPw37E19OLTujquRTCj1lOYVocic
         9ASrAla6ed5ZbJsD6qKE1TBS5bNBxuxdji07qr/zpT5PJbpOcL4m4e5OB2Zac/mTRyi2
         OVb9pfPsK9c2wf53TvZFHdiwQIEm9Vkv3Ca32tYnPSxloIYN4c3PeiScV8k5NGWpgmV4
         WYN6zDIodiZdqbc9OjLhmfknBOYeD8f5MbURaqe4PlQNgt4f2QnxIypi9triaChtd/bU
         89xA==
X-Forwarded-Encrypted: i=1; AL+hErFwJFN7BpW3plr0HV7mqG98gyQx58HnnenssZIATAosQOT9snjjO5jAR/Wri6iskXgSmdA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UltgpHNJV7Sn7sSEmliamJXxIFF3HPU8H9gktWvSemxQYFu24
	an0CI1bP7kEGDOOYP7vh3v427VsCD7o8LOtC+D6JbaAZz/WiNbFXFoAv
X-Gm-Gg: AYBFou3vPAbIrxs7GA9TLCDad0pqQveCD6Z5vkoRpm75ktHUufTEPrz9LnXZVPjzWsy
	upXdb0vaKsAZp7e1L/6TOgLA+6whrH4I/2ibcN2ewR+ExB1wkyuNma5bHq6lPbIfbQxgt9GyjhF
	ckfF16pxA4o7JunitomJpF2oy+B1KSw6JFP4UpJACADI0Lh8x/ugcg9h/TJ0pS2d0VP3nYCHtTD
	otfWKH9ZJ0EL9s1M/ZJX7FkV4w/UT62Z+yifyNNalG34nZrOKI4L4uPqBzBxnI/Ua+Sn6S5UETZ
	i4qkxObQesjC7HD42SkOZdTyehEHFd3WM0SVveuHVRnwcOOm6oZ/fTp6HxxSZ+DWPUFdVeLWfNn
	V196Kk0ckg5N2MkYWvafP2Cvsu1jZ7cZdh6vrJNlLG65wjeTHLNVDMZD8RVMi9CEeCUaYQoXxek
	7JsR1qe0RJ6bXwr9v7sGTXcdarXT6j2+PHjn63HqCsYPGIJRtF3twbRciD1UzXwOMXkhfXqyMS7
	Rsn4z9lkT2H07vQYmiMQEE+F5ErAjZaqvuCPuGa3qEGOQ+9F3gE4/llf4zxHGsGj9ra4jFDuK2k
	qa+m1Sc+SajfzL4UWPfQsBS/fwkqXSaZ0tO/06LIuIXOvJHa6E6MFrxVrPqEbl4OhkCljewMA0A
	+EJ9xqIn2rA==
X-Received: by 2002:a05:600c:8119:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4ba0936c932mr44435595e9.10.1794405460208;
        Wed, 11 Nov 2026 05:57:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:1921:262:1f9c:7285? ([2a0a:ef40:724:6601:1921:262:1f9c:7285])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea9eesm226925645e9.11.2026.11.11.05.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 05:57:39 -0800 (PST)
Message-ID: <e93076c4-cd5a-42ab-b383-e77ef68c1214@gmail.com>
Date: Wed, 11 Nov 2026 13:57:46 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
To: Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Jelle van der Waa
 <jelle@vdwaa.nl>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Harald Nordgren <haraldnordgren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
References: <CAOLa=ZQowi+fepj+RNegTZhK_Jy4G8VLE_Af2UdsO8-rCdviJQ@mail.gmail.com>
 <53CA2747-58F6-4A7C-81EC-33EABF0000FC@gmail.com> <avRHowwvxoo3e78H@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <avRHowwvxoo3e78H@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Patrick

On 11/11/2026 10:46, Patrick Steinhardt wrote:
> On Tue, Nov 10, 2026 at 12:15:20PM -0500, Ben Knoble wrote:
>>> Le 10 nov. 2026 à 08:13, Karthik Nayak <karthik.188@gmail.com> a écrit :
>>> ﻿Phillip Wood <phillip.wood123@gmail.com> writes:
>>>>
>>>> Another case where we might not want the diff is scripted editing as it
>>>> is much easier if the script does not have to worry about the diff
>>>> getting in the way of its edits. Personally I'd be happy to see this on
>>>> by default - the history command is marked as experimental so if having
>>>> it on by default rather than following "commit.verbose" proves to be
>>>> problematic we can always change it in the future. If we were staring
>>>> again I'd also make "commit.verbose" on by default as well so maybe I'm
>>>> biased.
>>>>
>>> I'm on board with this suggestion. Plus, I see 'git history' to be more
>>> user facing and it's always nicer to have better defaults for users.
>>> Showing diffs and verbose information seems to be inline with that. We
>>> could add an option to disable such output for scripts (but that can be
>>> done later as you suggested).
>>> <signature.asc>
>>
>> I can live with opt-out as long as I can turn it off via config.
> 
> Yeah, agreed. For me there's two important parts, where being able to
> disable this is the first one. The second part is that we need to make
> sure that such a format can work for every subcommand of git-history(1)
> so that we don't have to have multiple different formats for it.

Can I just check what you mean by "format" please. It is not clear if 
that refers to the option name, or the way the diff is presented in the 
message template (or both?).

Thanks

Phillip

