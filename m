Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830A1E8331
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313734; cv=none; b=aF9Q6gA9t7tT2WIrlsfCtYlZeO28NhWCZsax4IydY323iHCliVyhW6yUrvt3IWlqBiqJJl83xZrWPjuJBxIMYpUpw8j3KBxIZEf9vad2we4Jv7FHkAYQHqCQgXVyq+/cI5zbzEuy+Nl1zz4uLFX5oGrK0IfRqGPPnjHSN9inVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313734; c=relaxed/simple;
	bh=6rTB/ECEeWEMocZVToEXw0ia34VRaiLvBiQ7YMTLs1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekm9es7DwNkjTbwCsAtAsgQLDeVrsoQj9DtIVtTcN1u+iXAFwJFdAcWkfFGtIBP7+O6PPj733LjxC8+d2EvIHxf94C/aslnc33RzRh67Ss7jXzPeQ90a851aL04BW4yJlyHEwsblnnsCXIl4i9FgprP3I7xqWrbw3saa7OERSwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAFq4Q8J; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAFq4Q8J"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee1381b835so5878224f8f.1
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759313730; x=1759918530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjY7syn7TCiT7JjIZAy9X0xyaJi7yQyRerENNneiHCQ=;
        b=JAFq4Q8JLFTJxRUnETGHdP6nd0gWlaezKn0JOCUh8I/0pdpkyGfjbrF5rYFYqxjaCS
         J8850lD2HpVxsziy/hAO7aOce1fvEQKPNYUeTRw2QlF3eI+Gs44b/LFPzbpKfhxWstXA
         yZZMpNzoEhIkqjvtE6OaCBXlv+mYNQEXf6UgBU+uoy9L0bHxU0K0zNTiosg4KAzFw423
         FT0awf0t8izFZFTDkiQQgoQ5vJz5addstntpZdUfPfE6BUeZ4ISqa0jmOucz4KLAsV/G
         6d92wWzPs1pJSahK57AFAaBAoxHu9mr5tMVx+CBINeHbF0dJCzlvL7rBo7APF5MMJDKg
         ljnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759313730; x=1759918530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjY7syn7TCiT7JjIZAy9X0xyaJi7yQyRerENNneiHCQ=;
        b=b8AS07iwRtJ5rb4sRQH3nzx1mHgQqUC8aTvvljrYOub3ZW+6OyBU36Gk7bHxOl0WAr
         fmWr9irnyTKR/qsT80nyBmbBVfkPbrJnysvMkCN5NH5FFM5MwCcfyoHSG6mIJYj/pAni
         9dhJpseQgPyF8vGtNBlysiqrZHmocFYb/uVD5N6FxO22Q0CDhjW3LCjUaUQzH2VgY4Sc
         yIorH8Fx/bzwLQPCU6ogGoHWumDUp3YLvIue1OdQfllF+ypGcogrvsteOCmt2ubfx1W/
         upkGhyE7rGGy2g35MXLZqFHvBfUXahT/RFrFjHTYU3DHi0+nsL7V+LDpNkV3wK8CI/tK
         N66w==
X-Forwarded-Encrypted: i=1; AJvYcCVNV1VlXvuBXf0c8L2/pr++rOdVuaHrPoZo2DM8+0MfPaKCuvQS3+ylxSMdkifJhx95tMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3irNXKHy1gygRaYjgnMEY7vP5wfvSNG5QMs7iVhKYQkKCj+j
	zSl6gmv7O2K5S9RWXICN3qqGestAfQVYGaWKdQfOtCvc9hm3B/EObun6
X-Gm-Gg: ASbGncvVmosR0PwKeRHThvjH9wSKV2Kk6CIPcYkLpfiQ09/u+Lh2n1d6uBwQCmxuXN7
	o/k7NT5hQZk1lwU9kz9BZFk2QBxk4mCMGQIfpZUMfRVD6DnM0etxp/ensYL4BxlDEnVocpkLZ60
	4LxECP+LAYQhGTcKnaSo/nXy2aLGpTu6cnKx95lQ0XgeFFSpsJK6B7QXpjdHFJX3vt6zP6e+MlQ
	bHujlGDG/fr0Hreu9r+K4p/fs4G4tDV+4IUOxSaNfgIgYEdevbBS3+IXsd3VNenaq8mZUOPXW+e
	AAn1l0wmZC+vdBr3aoakRv4UBkfwwJP+jAEvqQkmaqAnYE9G1aaaIB2I9FCCjA4iPcHG78t9Plx
	ZYHL2shsuiDG0kuAzNiYdysF/W/Pcldo6sl5y6rDsrtJgtRQXocEphIy3h+1V6Qu20h0VRejYxn
	2DoqWDm2z80R9EFy20/IYon+0=
X-Google-Smtp-Source: AGHT+IFTdHRneg824VTZ/Ez7nn/cszfcKktqmHMR2kE0gFB+DqzuGt63KWspQYAPKnwigOdGMY/Ihw==
X-Received: by 2002:a05:6000:43c5:10b0:425:58d0:4834 with SMTP id ffacd0b85a97d-42558d049f0mr1269464f8f.39.1759313730241;
        Wed, 01 Oct 2025 03:15:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9d26ef7sm26663927f8f.26.2025.10.01.03.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 03:15:29 -0700 (PDT)
Message-ID: <0cb55558-a48e-42ac-a80e-a24ee2be55ee@gmail.com>
Date: Wed, 1 Oct 2025 11:15:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] libgit-rs: add get_bool(), get_ulong(), and
 get_pathname() methods
To: ions via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: ions <zara.leonardo@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
 <pull.1977.v4.git.1759221968318.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1977.v4.git.1759221968318.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[I've cc'd brian to sanity check my suggestion for handling c_ulong in 
rust 1.63 which lacks std::ffi::c_ulong]

On 30/09/2025 09:46, ions via GitGitGadget wrote:
> From: ionnss <zara.leonardo@gmail.com>
> 
> Expand ConfigSet API with three new configuration value parsers:
> 
> - get_bool(): Parse boolean values using git_configset_get_bool()
> - get_ulong(): Parse unsigned long values
> - get_pathname(): Parse file paths, returning PathBuf

I would be nice to explain in the commit message why we require paths to 
be utf-8 encoded. I've left one comment below, apart from that I think 
this looks good.
> --- a/contrib/libgit-sys/src/lib.rs
> +++ b/contrib/libgit-sys/src/lib.rs
> @@ -1,7 +1,7 @@
>   use std::ffi::c_void;
>   
>   #[cfg(has_std__ffi__c_char)]
> -use std::ffi::{c_char, c_int};
> +use std::ffi::{c_char, c_int, c_ulong};
>   
>   #[cfg(not(has_std__ffi__c_char))]
>   #[allow(non_camel_case_types)]
> @@ -11,6 +11,10 @@ pub type c_char = i8;
>   #[allow(non_camel_case_types)]
>   pub type c_int = i32;
>   
> +#[cfg(not(has_std__ffi__c_char))]
> +#[allow(non_camel_case_types)]
> +pub type c_ulong = u64;

As I said before this wont work because C's ulong type is platform 
dependent so you cannot assume it 64 bits wide. Looking at the previous 
discussion[1] the reason we have these fallback definitions is because 
std::ffi::c_int etc were only added in rust 1.64 and we want to support 
rust 1.63 as that is the version shipped by Debian oldstable. I think it 
would be better to have a separate preparatory patch that changes the 
existing fallbacks to

#[cfg(not(has_std__ff__c_char))]
use std::os::raw::{c_char, c_int};

and then this patch can add "c_ulong" to the list.

Thanks

Phillip

[1] 
https://lore.kernel.org/git/ZtivGeDZ_MZDEDB_@tapette.crustytoothpaste.net/


