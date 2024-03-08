Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601151DFDE
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914429; cv=none; b=qLTWfZ/yFnuIj1mI70CG+FRJ9K/wQVm3RTt+CmAHrA6asUbHrNpMXT3MYgc3o5XKpHYmrCgrSfgWGTna3G1S27MdT0DVGDfhqIrDmynRSNxgjp/5zI0+wst3vqrGs3KkjW6IBenFyyaydDKPsCFCiHxYExD4XukXpnGwEY5hJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914429; c=relaxed/simple;
	bh=xFXNTaYMYVNmUW76ZgUXZ2MBi9mD/wQdLPlc2vFGbpQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tRXluQtd7JoyZt3i5v72dHVnWPt/B4FiHSi2A3RLTFXYbcR8H+/yNYCYFeH2PT0BFu1BNZSpwvp8P9oSgVhI+Ra3xnWwb5A+Fk72Uxs5OGYsMFhEiXQe7vbiqPL0swJ7fEz76+nOq98f9dULpo5aDiVpPkLX1DUH/2b1oUzy8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZXePI5D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZXePI5D"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41316512055so8395105e9.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 08:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709914426; x=1710519226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JpQqd3qY/F87CkyM2csekeUXyRJ5A+Q0jl0VW/B0MvU=;
        b=bZXePI5DnW0z3g2cJaGD41sKCZGX5PsdwuXieM0JbkrtcOk+Z90RxhqKfB0LxPtKo+
         wSwTWGW4pR46wwV56YGhqmK6HvmiyNwC4krZPnveW2nZX54DyQfiBi6LRcQ6PA6keLXh
         94KwQn1jmViBsM03dXLW64naHEUJa0c73qRMmkgmuuCh8dRqmZpPvaX0wNU9MWX4JSGq
         0L7BLOvJN5+uVptCC35pygDWVkwucZIw7EtkgziDXNWNITpSGeIwFiKXQa5cvORSGI/y
         T8qwr3RM3soeQWcUbntBDS9J4AveRKRqU07wv7QTCEPWylJBB5yscfC3ZLKmIfaXW6nF
         yytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709914426; x=1710519226;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpQqd3qY/F87CkyM2csekeUXyRJ5A+Q0jl0VW/B0MvU=;
        b=NtpqHRaLZKdAA9rSazum1S2cWH85xDsw6IabH6uZ/Zlci0ULSKKtR11r3bVCSMvpT2
         Ig+qJkDwoQEqTBes6rtCfxpzM0LHevva9N1rKtsz7rybGWfc8LFFz3V8pFs75AwoyRyU
         cukU+DAe/q64m1WmSaiJdFx0NZcZUiYEfydE63ODAwqfFwsrxtyL/e/6oWDUCSoYTQra
         N9AzkWabII+jqSZJQXvwiQt1PNaChGgHfBz/KMZqB6ToplPeU7uY97KUks1m5owFRuVn
         kEfC+NRJcbj4S8pBLUuwfIFwLL9oWHZVkdJcnVDYri9Hd+khLKBLEsnWQomdAw12AKTR
         8NFA==
X-Gm-Message-State: AOJu0YzeNSJ4KH45np4SJgE2BgL+UjuoPemMmfXtKM5/JVDXwN3q0guK
	+r4U0Q0wQlCeuao6QzIMBIdakRIIG88RvaF0pCy7ZY3PuoVEWbzL
X-Google-Smtp-Source: AGHT+IH87+o8iNQ8Dm/jmeVcR9RykxoSxGamIHF3pmy7/DwTz42zno5mtwYyW8yUPLzhlTETZ7fjMw==
X-Received: by 2002:a05:600c:3515:b0:412:eff3:8497 with SMTP id h21-20020a05600c351500b00412eff38497mr7669463wmq.1.1709914425358;
        Fri, 08 Mar 2024 08:13:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00413177c3f1dsm2657390wmq.18.2024.03.08.08.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:13:45 -0800 (PST)
Message-ID: <48b2d5b1-a59f-44c3-94ba-e7f81913b7f5@gmail.com>
Date: Fri, 8 Mar 2024 16:13:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] merge options: add a conflict style member
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
 <c0d7bafd43823ef9df5a73bc80b90cf003988bc9.1709907271.git.gitgitgadget@gmail.com>
 <xmqqle6shgkw.fsf@gitster.g>
In-Reply-To: <xmqqle6shgkw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 08/03/2024 15:46, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/merge-ll.c b/merge-ll.c
>> index 6570707297d..bf1077ae092 100644
>> --- a/merge-ll.c
>> +++ b/merge-ll.c
>> ..
>> -#define LL_MERGE_OPTIONS_INIT {0}
>> +#define LL_MERGE_OPTIONS_INIT { .conflict_style = -1 }
> 
> Makes sense, and this obviously makes the previous step worth doing.
> 
> It looks quite wrong that low-level merge options definition is
> hosted in a file whose name is merge low-level.  Is it too late to
> rename the file to fix this, by the way?

I agree it is confusing, Elijah renamed it from ll-merge.c relatively
recently 6723899932e (merge-ll: rename from ll-merge, 2023-05-16). It
looks like the idea was to group it with the other merge* files:

     merge-ll: rename from ll-merge
     
     A long term (but rather minor) pet-peeve of mine was the name
     ll-merge.[ch].  I thought it made it harder to realize what stuff was
     related to merging when I was working on the merge machinery and trying
     to improve it.
     
     Further, back in d1cbe1e6d8a ("hash-ll.h: split out of hash.h to remove
     dependency on repository.h", 2023-04-22), we have split the portions of
     hash.h that do not depend upon repository.h into a "hash-ll.h" (due to
     the recommendation to use "ll" for "low-level" in its name[1], but which
     I used as a suffix precisely because of my distaste for "ll-merge").
     When we discussed adding additional "*-ll.h" files, a request was made
     that we use "ll" consistently as either a prefix or a suffix.  Since it
     is already in use as both a prefix and a suffix, the only way to do so
     is to rename some files.
     
     Besides my distaste for the ll-merge.[ch] name, let me also note that
     the files
       ll-fsmonitor.h, ll-hash.h, ll-merge.h, ll-object-store.h, ll-read-cache.h
     would have essentially nothing to do with each other and make no sense
     to group.  But giving them the common "ll-" prefix would group them.  Using
     "-ll" as a suffix thus seems just much more logical to me.  Rename
     ll-merge.[ch] to merge-ll.[ch] to achieve this consistency, and to
     ensure we get a more logical grouping of files.
     
     [1] https://lore.kernel.org/git/kl6lsfcu1g8w.fsf@chooglen-macbookpro.roam.corp.google.com/


Best Wishes

Phillip
