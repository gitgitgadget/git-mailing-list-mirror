Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933672BEC21
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770244; cv=none; b=tYLwcXoAL4MlJzubfRIxlK1smdmuRBgRvBO7ZQbqmgOSgvWrATh6fE/m1NVa3yBJkGjj7h/0oSw3yJ49lB4AIqylw1DSpWVpLULWFovj3pS9JgrD8RGqzmQxYulw0nPjYGPIcAN3MNhXP9h+vAeiI27ySUFdPYOv84nkGBNSqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770244; c=relaxed/simple;
	bh=PGPlq108A5u/NLNcfT04A9S/VwxTDydD6ykVmHl9MJc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zou8foUBsN8bP6psJrHP5LY4MzcgbdfMmhrA5dC8JYx+MC9gYfVz7zhS3gUlB9La0tl4sRohp0bKrzgd9xstOrrpPKXQ7u4CJtdlOTF5l0mL0bhgsf6RxsbMsvA5mzQ5O6mNTGl+HxOblQ+303bWFSDyl4VacXfodEOv2bj3jNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImBxXDQP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImBxXDQP"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so403365f8f.0
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750770241; x=1751375041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6qkSBhrdsuGsN9DKALSFQQoG/INk+SCtvx/yfF9tVU=;
        b=ImBxXDQP7E7zKuq2oUS/KDWOB1aPZIrWMd3mq086VF8pcn8SJ/zVyz+t870/Xczflp
         Q7pD/efPs/0EkiJvf0WzZpsMyoIagwB+EkReYMxERHX1+0BrFTlX18KJP5FUU4E39IV8
         qGAfFBaWuUGRe/+WZPQYxMSLwwCh+sOLA0YeMnwL0Xp1bbPCkiPt0TDHanMcSO/BWyrh
         hewuzTctp2LA3LyJQ0OSSPmtLuYEAjhl/WDx+phUZz2Oe2+tpLJIK5tYKOFijmRe5Kc5
         H6/gJ7nGCWsifq4fEhfiBAJctTPUOs8NHSlwaJxQJuYV/KZVeFpdLIC+v3edmi50cmcC
         mg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770241; x=1751375041;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6qkSBhrdsuGsN9DKALSFQQoG/INk+SCtvx/yfF9tVU=;
        b=jHtlQc2mW4g6F3E0hzgoA/iznWLJcCiKf2pXEcKxstLbiEx5VsxnraA416U+XmajOg
         eZPnvwpTBC3iuPILbNTlrtFI34RNj7IkekSgm5rCuK7vg6fRSzXP1Evw4z6FF6YKgtOC
         37UC8wqdOy3Fgiqt42hACdEu4gBZyM7S6VZ2EI1C5iMMvHeoUouX1xRcc1paE1feLa8g
         GCtPn8sKwa88ffZMQlZidFLbdzlR4cEBfXI+wQucXDRxB/txcaxYeiIz+WNpxtHM6qph
         g5ugTPOl6y7qM4dkZX2M2zBFHc1pb1zLz0WgRSIiR3glheQoSkGrNhMe9CLxNeU+rreN
         cJBA==
X-Gm-Message-State: AOJu0YxJDn+uXa8WmUV7tDtUvpIKaB0o0vZoF3oL4/NX7ZfiB0aN/Ujs
	uINu3lEKdeIdRsFZlZUr3xe2jfmPzppfsgCrp11WjvXv7uBcO8N9Z3Wp
X-Gm-Gg: ASbGnctUp8LQ65yYU/cJejAm9xjUwdgCCJXfEHDK2zUcGx3tLma+b/q0JTp8iVL5hnK
	KgRAml9ECnMzd7YSQ6IlsY1aNfy9BtW6scdBG0+PGRuMyxXRy0aQ5cCyMm5edNIPiO3Sh+unD4m
	dimUWlk/83Nao6VDeJe6czNhNhxjjlsYfNP7h6Xab759SPLwUVYVGiQHTyzt9M6tXFymi7+XWGo
	TZjr6x06eA5LGHNb5zdEkojzQUS4miaYeDljDx86kApzzE9ofvkcDX/Jun4s443ByFHtlbEf+Hy
	lXR8hliJ2EmqAZbS8g45DFFa6sTToxKcDKHjOv5N0w/vaL1EvKZ0nkrtkVntEfr+fSVX5q191BV
	EtKnfdPFe3Qwhm5KSoLkL23CDcU1moOmpRIFfdaLionr8QUHF9yW/FveVbw==
X-Google-Smtp-Source: AGHT+IEKnrirJbviGJWo9/a9f37khWCKmxvsX0Q2uuPLaZZHx+CZKYodIKu76KfBmJORdKk6YhIvKw==
X-Received: by 2002:a05:6000:40c9:b0:3a4:f439:e715 with SMTP id ffacd0b85a97d-3a6d12bb71bmr12205904f8f.9.1750770238818;
        Tue, 24 Jun 2025 06:03:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:64ec:8871:d108:963a? ([2a0a:ef40:700:a501:64ec:8871:d108:963a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80ff8b8sm1865680f8f.71.2025.06.24.06.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 06:03:58 -0700 (PDT)
Message-ID: <223c7cbd-610e-49e2-90e2-5914cbc0f1d7@gmail.com>
Date: Tue, 24 Jun 2025 14:03:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [GSoC RFC PATCH v2 0/7] repo-info: add new command for retrieving
 repository info
Reply-To: phillip.wood@dunelm.org.uk
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com,
 ben.knoble@gmail.com, gitster@pobox.com
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com>
 <652FDA35-C20D-4F27-A22A-025CA08EB013@gmail.com>
Content-Language: en-US
In-Reply-To: <652FDA35-C20D-4F27-A22A-025CA08EB013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 23/06/2025 19:49, Lucas Seiki Oshiro wrote:
> 
>> I think using an output format generated by 'printf("%s\n%s\0", key,
>> value)' would be easier to parse. This format matches that used by 'git
>> config --list -z'.
> 
> Thanks for your suggestion! However, this still breaks in the corner case
> mentioned by Junio in
> https://lore.kernel.org/git/xmqqikl3mtx2.fsf@gitster.g/:
> when a value contains a LF, which would be possible to have in the (yet to be
> implemented) path values.

The reason git uses NUL termination for other commands is to prevent 
breaking the output when values contain newlines. The output format I'm 
suggesting is

     <key><LF><value><NUL>

so the output for "path.git-dir" written as a C string would be

     "path.git-dir\n/home/phil/src/git/.git\0"

The value can safely contain newlines because it is terminated by '\0'. 
The reason that "git config --list -z" exists is to provide an 
unambiguous output format as config values can contain newlines.

>> I've not seen any discussion of how paths are going to be encoded in the
>> JSON output. As I understand it some JSON decoders only accept utf8 input
>> but the paths reported by git are arbitrary NUL terminated byte sequences.
>> How is one expected to parse the output for a non utf8 encoded path using
>> rust's JSON decoding for example?
> 
> [...]>
> The first solution that I can think of is to check if the sequence is a valid
> UTF-8 bytestring, aborting the entire command if it's not, which would be
> better than just guess the charset and re-encode it as UTF-8. However,
> I don't know how hard it would be to do.

I'm far from an expert but I think the normal solution is to base64 
encode bytestrings so the caller can get the original bytes back. We'd 
need to do this for all paths. Even if we could reliably guess the 
encoding (which I'm not sure we can) and re-encode it as utf-8 the 
caller wouldn't know if the path was really utf-8 or if it had been 
re-encoded and they needed to convert it back to the original encoding 
to use it.

>> On the subject of paths do you plan to support the equivalent of "git
>> rev-parse --git-path"?
> 
> Hmmmm... In the way that it works under rev-parse, no, as it may bloat this
> command with other things that aren't exactly metadata.

That's a shame as I think it we should be encouraging users to use "git 
rev-parse --git-path" rather than building their own paths using "git 
rev-parse --git-dir". The latter is easy to get wrong for example 
assuming the index resides at "$GIT_DIR/index" when "$GIT_INDEX_FILE" is 
set or running a command from a worktree and assuming the path is under 
"$GIT_DIR" when it actually resides under "$GIT_COMMON_DIR". If this 
command is going to return "$GIT_DIR" and "$GIT_WORK_TREE" then I don't 
see why it should not be able to provide other paths.

>> I'm not sure what the future plans for this command are but when I'm
>> scripting around git it would be nice to be able to a single process that I
>> could query for the things currently returned by "git rev-parse", "git var"
>> and "git config"
> 
> My concern here is that this main motivation for this new command is that
> rev-parse has too many responsibilities. Giving too many responsibilities to
> this new command may turn it into a new rev-parse and create a XKCD 927 [1]
> situation

I should have been clearer that I was talking about the path and 
repository information options of "git rev-parse". Those combined with 
"git var" and "git config" are all repository settings. Having a unified 
interface to them would be an improvement on the status quo where users 
have to know which command to call to query different settings. There 
would be a clear focus on returning repository settings, which I think 
is very different from "git rev-parse" that combines revision parsing, 
command line parsing, shell quoting and repository information. I don't 
think you necessarily need to implement them as part of this project but 
we should design the input and output formats so that the command can be 
extended in the future.

Best Wishes

Phillip
