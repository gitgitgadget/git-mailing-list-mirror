Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A441C72
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 05:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760504711; cv=none; b=XkhanFyUKlnzb5DZEKNJIwDtA4M7YLy0UN0yFj7ZRjwTTSWqib9Q7Tfq1mZT83LlodFnLoNDfvYfnMHCscSbWqO6vs1IstuSltSOr0FXInJHr4eGwYzhUVf+qlQGbQEBXnEDj7AONP+EBNG5bfqd/XNavxjvaZraWBnhHQMaP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760504711; c=relaxed/simple;
	bh=K+8L7To15g6uf7QnFPmvIz30yre9yoDmEj3EDuREX6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3j5LMvsZqoIYMxW/63o+sN6LlvZ0a6bp3HLphqrE0WulaBaHhV3jLeafsL4f/A5qG/+vUEN6t1QQWJfDDc9tkIsnPCeTlYCYMBJXLQoFuC8kpNp3B/5O9Qsg37GdfWLmelwslztWldULT/Kc2TCL6sFslJdGiB2c+UN330tg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhTJSnqA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhTJSnqA"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so5494046b3a.1
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 22:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760504709; x=1761109509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZ45WaG+2bM1SqoGq0T1oxci7/BWTScEXoxVWTyU4v4=;
        b=MhTJSnqADZB6/3EO78QQfkpLyew5FYlI8Ll5Kuiw0MYJHDDBFCQmiTUP9IjldzYHlH
         otIxU0enjeVs1TopKAkxjNDdKExZ0HTghHH0GG/TWCqwss1RTSM17c27z9etaDX3qwMx
         4mfT4ku8/LI2tM20sR+14ZKNLnmRIKX0VUhhJPPnDzAuPvbnIPpZ9Q5/d4syUshomN7z
         P6uY3iKbB3KDI9kz5HjtcCY3Ud54m6fzHGdnsVr4UB9UFzKRSjoY+zb5k4T6+6Mq/Quj
         Z0id+Oy5R3Fngr3esuVgnv8ikyDQ2jf2/ouUKJw5n0KswTJ0om32pAGONIy5A+2Ancam
         4mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760504709; x=1761109509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ45WaG+2bM1SqoGq0T1oxci7/BWTScEXoxVWTyU4v4=;
        b=muS2HJqoWPUUnugM/7jiCo/B/5lXgdCZGPybf83Osy+y4/2IZQmfPaehnvJV3jbqtK
         jdp4dSNC1YgjMzyuHRUlUsuHA1+ulGCaJlkLnKwYI9W68HYsMoVIXEX/jacumeXxd1yS
         xoZBrroCaJuRnh9YsiICDRrSZylB10FRDJSCTlIqkOVgnjKVG9c2NoEB6bR7RzpaXkSV
         OuY/lPy/4FLuvH/6c3kJZWmY6aG6TvFgF11i5R0ARKdcGGxnMJ73KSLfTuT1/PJrRaBa
         mCU52JvPexpDFLvzKbgWhuY9LzmYFaaljCeiAkWF1xL0TZBlkaxDiTRi6joiC38sUJax
         HYKg==
X-Gm-Message-State: AOJu0YxVAT4jtWIv60HURbLgsKt0q4uwnzwa+m8AP3h0L4PdLps5D0eN
	JCIVbileeHBMwjfGFXP4r3TIlSPnXANc/7blYz/iqrTOLjlvnCPVpiwi
X-Gm-Gg: ASbGnctk+9Odpe4yfk6iEHPQyi4C2lIfy5u28D1qpIgSDqSOwGm980vE8kZM2Cj9z20
	xl5mhspfS+X2/8djf5tzd2/QVrfM4w3FhtpUifLYCqk+EToFQwJZHwJgh4opVUKkU+bSXQRj69W
	ScZZ4o7ICb0rRIVTng1esVOmMOqq9bpOCb2n0yctlu4EaN33VLH51+myOyk7eMSvOyj0vitX0FP
	Q3aTExMm7YH6JqPMenemaRSXScZcfOZ107C12pZIjQpuyV2f6UGNZNFUH1eGNxfTwW2d9F7zzUA
	JrX1SkW6BZsaoWuPAMbeXNUYOH5UzwsIuUct+AdXL8xwzfdOuYu1Hc/OrnXp44I9i2uzZd7c344
	ue5decPnJYbWN/15tqy73ogQQxUMUEfIlr8NnpxxJaOSetzSyH5F73CEAWeAV7TiTzbHrNSUlDd
	uXQykFDQLtAbYJo9OBAQE6h0aeytwzCKRgq8Q+sRSu7CeKgGB0I1pJKcF/ChFTtYDjrpqCE7xKP
	iK+smakq/mk9sxc3MrJ8Z3UKEXu0h6xzw==
X-Google-Smtp-Source: AGHT+IGdVgpKmrnU29mvz6vQsvpyNxxfiCi/DvRY30eh2Dn8G5b/3LNk4nOUiaKH6FUQgjhkC4L7JA==
X-Received: by 2002:a05:6a00:1491:b0:780:ed4f:e191 with SMTP id d2e1a72fcca58-79387c18f99mr26333862b3a.23.1760504708958;
        Tue, 14 Oct 2025 22:05:08 -0700 (PDT)
Received: from ?IPV6:2401:4900:4bc5:7e6f:8524:7259:99ff:16ed? ([2401:4900:4bc5:7e6f:8524:7259:99ff:16ed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b63a03dsm16958567b3a.19.2025.10.14.22.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 22:05:08 -0700 (PDT)
Message-ID: <92f9bdec-28ba-45ba-a111-24963d0a300a@gmail.com>
Date: Wed, 15 Oct 2025 10:35:02 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] replay: make atomic ref updates the default
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251013182530.33041-1-siddharthasthana31@gmail.com>
 <xmqqtt01w5jh.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqtt01w5jh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 15/10/25 02:43, Junio C Hamano wrote:
> When merged to 'seen', this breaks t0450; from the way the test
> breaks, I suspect that it has the same breakage if the topic gets
> tested standalone.
>
>      $ make
>      $ cd t
>      $ sh t0450-txt-doc-vs-help.sh -i -v
>      ...
>      --- adoc        2025-10-14 21:02:48.680184914 +0000
>      +++ help        2025-10-14 21:02:48.688184867 +0000
>      @@ -1,2 +1 @@
>      -(EXPERIMENTAL!) git replay ([--contained] --onto <newbase> | --advance <branch>)
>      -           [--update-refs[=<mode>]] <revision-range>...
>      +(EXPERIMENTAL!) git replay ([--contained] --onto <newbase> | --advance <branch>) [--update-refs[=<mode>]] <revision-range>...
>      not ok ...
>
> In short, "git replay -h" and the initial part of "git replay --help"
> must match.


Thanks for catching this! I actually noticed the CI was failing on 
documentation
checks while testing on GitLab before sending v3 to the list. I 
initially thought
it was an AsciiDoc line continuation issue and suggested adding a `+` at 
the end
of the line, but Christian pointed out that the real issue was likely 
the mismatch
between the synopsis and the help output from the command itself.

I split the SYNOPSIS across two lines in the documentation for readability:

     (EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | 
--advance <branch>)
             [--update-refs[=<mode>]] <revision-range>...

But didn't update the usage string in builtin/replay.c to match. Your 
patch adding
"\n" and the proper indentation is exactly what's needed:

     "(EXPERIMENTAL!) git replay ([--contained] --onto <newbase> | 
--advance <branch>)\n"
     "\t\t[--update-refs[=<mode>]] <revision-range>..."

I will squash this into the next version. I should have run t0450 
locally after
Christian's hint about the synopsis check - I was focused on t3650 and the
functional tests but missed this formatting requirement.

Thanks,
Siddharth


>
> Minimally you'd need to squash in something like the following
> patch.  Alternatively, you could match the documentation page (which
> is shown by "git replay --help") to match what "git replay -h" gives.
>
>
>   builtin/replay.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git i/builtin/replay.c w/builtin/replay.c
> index 3c618bf100..d0f0492790 100644
> --- i/builtin/replay.c
> +++ w/builtin/replay.c
> @@ -330,7 +330,7 @@ int cmd_replay(int argc,
>   
>   	const char *const replay_usage[] = {
>   		N_("(EXPERIMENTAL!) git replay "
> -		   "([--contained] --onto <newbase> | --advance <branch>) "
> +		   "([--contained] --onto <newbase> | --advance <branch>)\n"
>   		   "[--update-refs[=<mode>]] <revision-range>..."),
>   		NULL
>   	};
