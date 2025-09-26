Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69672608
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880689; cv=none; b=Oj9fLHMIasDADrdxH98QwyAMC+VnBqEwHbw+3SVTdCIhCIKB4GememjsxTStOtUfw5BxhjfqjKl0UYWJ0V004t7ZgGhK81WsGZo5UCSDovCUNiJ0iq5mqgst1oByTU18TD6BpmCcx9ToRMNuWLcOFihSd4aqT/6g/InaVOxmmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880689; c=relaxed/simple;
	bh=yMOQ0EJPG2wqZYLVQfv0trqLjmaQqx+Ty5LTEMNsJOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3i4LG14uoDPQ5DdYvbcQF+t2NFAT+qOH0uxGZXhllX09XiPAkngndW1u9g/5A4iJmoAkgSZ3JCAUBJ3d1I5DdGZGjnKhZPSO2Sa607Fn+UNzELNlzUYbUK/fm2PEhIkaGxBrIT268zujh8IZf7JRRgzZK+KgFZlUuj92S9yvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwK0var9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwK0var9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so16619495e9.2
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758880686; x=1759485486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpAyE/+ebG6WsMGkgZqPltlc+yKpqcqvomwaR3iVqn4=;
        b=RwK0var9ynNcfcigIvMH+F9YPPDBKVRJN3vmldtJbGCSUbmgVZDZeefPltnJ+xwESs
         bdrpL81+/i3silbanoBt0URgH3LU7msXPdVWPbA2JbN9Q8tldcbovcc12NRBxmlQP3KM
         QDX03xJN5aOXTBpLZwcyUnjBEM8byb3j9hgdYMRoKtxx0NfTGk7vWWEJIfV3Pbj4kR4H
         K5/VwCKDpt3Z7pUsililTHurhCDM5QUIpomaDUGaCcLhSRLRHfR/56V3dgOPgl59WDHK
         Cp9LA/pwfkppol8bHAgGHrd7yNqBqv4qBP0U/hvQlp+Dg8ri+uq0K6p6bE7Gv6XUaRn/
         YCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758880686; x=1759485486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpAyE/+ebG6WsMGkgZqPltlc+yKpqcqvomwaR3iVqn4=;
        b=Uf+eAyivfeP3MjFTDQi4li5pv6VM9HeNSwSjzw38lmKV1PLMyZyty6fy9vCcOx61il
         K2km12jHbRDZ255EZr/cmSW//nyVhX8waOKq/wTZ8x4hulXbCSqzM4yeqeTFNTxproHR
         r6h1esc0zviRxnAkYjmjLevjTl2/nPScLXY9pu5hEILXFLUuZCVu/Mcd37KNDRZeQoAz
         pg4wXPDNWKLIUnPfFzLxWV+3chZhmmnjXU8EbWE1AKSitZ0Nnh6GiE039IFUTzJM5hnG
         PQTtJr+1hBdyiKSGpXtPaZ6ilprn2UpZOssuOZHvMaQ7kYLHICIU7ND1IVYVfjrwNxgC
         EIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOqkYF/iC2+z5rc7/+nQ75/TABq/H7hoUIB2A1v6PJ2xdXjD471FOovOkJYpcf2Bimzzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxczlo5fk+C9qdI2ywXxpxpoP66IYft2TMBTAxozSbrIVoj0Wxv
	o3BbilXhfN6/EwkY2u1O8zL50+IY4r2PqhZFKNwBtMZefteuzT9SV7bV
X-Gm-Gg: ASbGncv6FAjZgH4KBoyXD2329ZX+2zGU/D+5cIzGeJjywM4t0xBp9M296t3GO//bsYu
	U8StDww2ca5NWqpTMbfS3i1QTPXltSDG9for5KUe8W6dlq8oJG3H0GHxUK3UFuL5TyaWHt6r8s0
	EibBg4CL1XcKZa1CtmStgxUDG5QFfoj2oCUz36vucZzoWTrNm3g0NEhQSlSXyeUtzAzB/jI6AVW
	KY/fBPSosYyk1OGsnMG9XVHwtCOQjg4+nai0DD3Bh0Z6hkVkmtOAq2LhNd0qUHuHI2r6GquLaPa
	clwc4ztoeCvzYtm85oSncI8OVDVzls3G20+R3S6swA0Wsicpa7K/Hf2Q4qXi7GdBY+BwB1mlw+8
	YyLjq+MZn63OSTCyyfumB1XqiFtuNF0qCeNspY9V87YG+8kPjBStvbKw10YRRMHl64pMJJNZxFC
	WI2c09
X-Google-Smtp-Source: AGHT+IHbTlO1P4OckT8bBmkDfh9khe6EhNno/7BtdYZ16h6nOGZIrp/6rnwhnI8dZ/2KuskapXRCmw==
X-Received: by 2002:a05:600c:4ec6:b0:46d:d6f0:76d8 with SMTP id 5b1f17b1804b1-46e32a56d59mr59878575e9.35.1758880685885;
        Fri, 26 Sep 2025 02:58:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:8237:372f:a3d9:7aa3? ([2a0a:ef40:62a:101:8237:372f:a3d9:7aa3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab838b6sm109634615e9.24.2025.09.26.02.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:58:04 -0700 (PDT)
Message-ID: <9e53f617-1b17-4d36-9c35-fc86c0ddfb19@gmail.com>
Date: Fri, 26 Sep 2025 10:58:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] libgit-rs: add get_bool() method to ConfigSet
To: ionnss via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: ions <zara.leonardo@gmail.com>, Josh Steadmon <steadmon@google.com>
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
 <a5904a2ac00ea6de142344272b45f6b4697b4f98.1758800669.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a5904a2ac00ea6de142344272b45f6b4697b4f98.1758800669.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2025 12:44, ionnss via GitGitGadget wrote:
> From: ionnss <zara.leonardo@gmail.com>
> 
> Add support for parsing boolean configuration values in the Rust
> ConfigSet API. The method follows Git's standard boolean parsing
> rules, accepting true/yes/on/1 as true and false/no/off/0 as false.
> 
> The implementation reuses the existing get_string() infrastructure
> and adds case-insensitive boolean parsing logic.

It's nice to know that someone is using the rust bindings. The code in 
contrib/libgit-rs is intended to be safe wrappers around the unsafe 
functions in contrib/libgit-sys which wrap git's C code. I think what we 
need to do here is add a binding for git_configset_get_bool() to 
libgit-sys and then wrap that in libgit-rs. We don't want to start 
implementing the parsing separately as they'll inevitably end up 
behaving differently to git. For example what you have here parses "00" 
or "100" differently to git.

Thanks

Phillip

> Signed-off-by: ionnss <zara.leonardo@gmail.com>
> ---
>   contrib/libgit-rs/src/config.rs    | 24 ++++++++++++++++++++++++
>   contrib/libgit-rs/testdata/config3 |  2 ++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
> index 6bf04845c8..3f4a32c72d 100644
> --- a/contrib/libgit-rs/src/config.rs
> +++ b/contrib/libgit-rs/src/config.rs
> @@ -68,6 +68,26 @@ impl ConfigSet {
>               Some(owned_str)
>           }
>       }
> +
> +    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
> +        let key = CString::new(key).expect("Couldn't convert key to CString");
> +        let mut val: *mut c_char = std::ptr::null_mut();
> +        unsafe {
> +            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
> +            {
> +                return None;
> +            }
> +            let borrowed_str = CStr::from_ptr(val);
> +            let owned_str =
> +                String::from(borrowed_str.to_str().expect("Couldn't convert val to str"));
> +            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
> +            match owned_str.to_lowercase().as_str() {
> +                "true" | "yes" | "on" | "1" => Some(true),
> +                "false" | "no" | "off" | "0" => Some(false),
> +                _ => None,
> +            }
> +        }
> +    }
>   }
>   
>   impl Default for ConfigSet {
> @@ -102,5 +122,9 @@ mod tests {
>           assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
>           // ConfigSet returns None for missing key
>           assert_eq!(cs.get_string("foo.bar"), None);
> +        // Test boolean parsing
> +        assert_eq!(cs.get_bool("test.booleanValue"), Some(true));
> +        // Test missing boolean key
> +        assert_eq!(cs.get_bool("missing.boolean"), None);
>       }
>   }
> diff --git a/contrib/libgit-rs/testdata/config3 b/contrib/libgit-rs/testdata/config3
> index ca7b9a7c38..83a474ccef 100644
> --- a/contrib/libgit-rs/testdata/config3
> +++ b/contrib/libgit-rs/testdata/config3
> @@ -1,2 +1,4 @@
>   [trace2]
>   	eventNesting = 3
> +[test]
> +	booleanValue = true

