Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69229D265
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405246; cv=none; b=oQq6Qaykz1+T1bZu+qkMEUAVzZONgC8pLRCJUzXpSXqlKwnc0GDzRQrpyYF7nKCQRhjHjMd7fAZM5N6XcPmghzXLwGpBD7GdXH2HJZSAxH/ZuUK7lIhMRK53C2SjFWyNZZJ+RkHdMD1UWfaCA1XPOa4HXPCMsx+oQBVs9ZMHW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405246; c=relaxed/simple;
	bh=SKksDt5jzNRKh9dsESUCuXs/joQoGTSLGH9EGmW4ekk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv2CK6f3v3mGG1ItOgmm+MfFJbwiVreC7Sw+H7P4XQ2yD94G4nbaPYuwpcviHVj+zlNEDWleSUAAzHEg3oP4N730bHK5fvrUo0kfAzd4O7EE+Yh9lOgODpO+sKM8R4PfcvOBAVvKNkLnvpT70/HepQakn3e1DciaBCKkOmjaoHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSRdzw5S; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSRdzw5S"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bebb72b845aso441274266b.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405243; x=1781010043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=umkfncTo8aWE01Riu+/TcIlkuPsFwURil7EgODXhBXk=;
        b=fSRdzw5SfYH6Hr3pLMf3ttdcJP1mOBHMqTRNkeGlSFVM9Uddwzaqzrl8w5r3wtx15s
         Wc0bPCAir+7iN/Zx4H0xlVGiod/2ws5F83bQm3GMmz2kO7K2NLZQBaOHo1WYnxYgTWbw
         LPKe8jDCnszAb6iiIjPNG7c2y/5+8AXBg2LRul1iYtTgMmuoo0l9Lhb9okk94y+kuN+h
         2KGCqqn8I40WLyCN0U+tbsCnOy3wg8uLGy2pkEiBwVc1puk6D+AwMzJrGILmN/SajFqJ
         nZ3oRav4XVO8Eo97VMVuFMwu5+M9jTZc5yRiPW4nrPCGmf6vVH/x3oWO5hwAKjAD79us
         Cv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405243; x=1781010043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umkfncTo8aWE01Riu+/TcIlkuPsFwURil7EgODXhBXk=;
        b=IW95hDbTMTGf3mbjm0R7dRjcTgIyx400GkwgeE0M8tg1oSCXe63VyQN8M/eTYSrjxs
         WvBvmW7WXoS/zHM5PCtCarmZn04t558t4zARFJ9qsxL84dXSEtDOG6Th3DJbfe7aij1X
         oQ6BcHM+wrLOvUPeUMtzZaU3n6SeXTVbhKyo+g+i90ngpHOhZhn69EnMr4y6bP15LaBN
         B8GQfSznPrhVZHAcA7lnmaSYXXo6S9Td23JWCyyN4dRsWsXGPCoLfmd7ZfXMv3ZxIKWj
         0/ND1sLdbmG0AX0xnHa6sW63c462oBj/nyEwyhV2d8gWRl2jqctKFXiIY2Uv9tU0gg2k
         QZjg==
X-Forwarded-Encrypted: i=1; AFNElJ+PmFkyCJYA7hN+cf+RevvgUAHWRancHPShsNadXexkLoM5HPRgvnQSzVTntP3mrJ9v99g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8p4FAep10e01c0Ggg5kdQjHlJercwus2i1pO4Kew3akBb7f2
	LuUEFB4MVESM5JWlpFKNJoc5MSXU2j/7vDhkHQkks25/ycQjVBSUuctU
X-Gm-Gg: Acq92OHP6b72UK5dZM2ODvuYpnaf23cbjs8NdM4ZH/r62Q2l+GaNQt+irZs8O387Fn1
	i0wdr5q3EG+ybTJLu00N7ZNernxwNgd25nF/qU2epTjnznYTOGWjRENhPvY6XJE09aAqiXoRTaB
	2twpkEeL6AkwHctxyj8EYfJGF1sQzTbo4Qb9KXI2N0zr70ZvJu9EdYOTyM7OfEn+w4KNeKdidQP
	e9Zfpft+vrytVvOeOaQKPEuZbfAMT5gmxCh5srpG1wZW6yhWjIjx46Dj6sLw5u/+YgYCsnjp1T8
	eWLDjUPvbOGDERcaSN8y7IaNgiZv1YzxQo+DYu3wnfUuA/6lnZhrEQC5T4Ooeieq58hFC33LQjw
	IM4s6cxzS9W6NHBcEGrYmXQd41KSWvv+GcFoa+x8LE2acEDpS9lYkR5K9rigKTh12tmh5NJF7FM
	ueuBsIZxnoTc2KHbpj2cOUuufhlV1ulw2wr7IpPKsUtiDIUEN9de5olv8t0mMYL5ibjRX2Zu6Ej
	AcvvI6ARqddrA==
X-Received: by 2002:a17:907:c16:b0:bd5:7c2:7622 with SMTP id a640c23a62f3a-beab2e4c7c1mr945336766b.49.1780405242602;
        Tue, 02 Jun 2026 06:00:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb6f98f8sm3577287a12.0.2026.06.02.06.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 06:00:41 -0700 (PDT)
Message-ID: <73c1f6ee-9461-4cf3-8d51-33de05f6d070@gmail.com>
Date: Tue, 2 Jun 2026 14:00:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 1/4] path: add strbuf_add_path for formatting paths
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, lucasseikioshiro@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com, a3205153416@gmail.com
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260601151950.30686-2-jayatheerthkulkarni2005@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260601151950.30686-2-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/06/2026 16:19, K Jayatheerth wrote:
> 
> diff --git a/path.h b/path.h
> index 0434ba5e07..b9b626ce4a 100644
> --- a/path.h
> +++ b/path.h
> @@ -262,6 +262,22 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
>   int safe_create_file_with_leading_directories(struct repository *repo,
>   					      const char *path);
>   
> +enum path_format_type {
> +	PATH_FORMAT_DEFAULT,
> +	PATH_FORMAT_RELATIVE,
> +	PATH_FORMAT_CANONICAL
> +};
> +
> +enum path_default_type {
> +	PATH_DEFAULT_RELATIVE,
> +	PATH_DEFAULT_RELATIVE_IF_SHARED,
> +	PATH_DEFAULT_CANONICAL,
> +	PATH_DEFAULT_UNMODIFIED
> +};
> +
> +void strbuf_add_path(struct strbuf *buf, const char *path, const char *prefix,
> +		     enum path_format_type format, enum path_default_type def);

This API is very specific to rev-parse and to me at least it is hard to 
understand. I think it would be clearer if we had a single enum 
describing the desired format and let the rev-parse code worry about 
passing the appropriate value based on the options the user passed.

enum path_format {
	PATH_FORMAT_ABSOLUTE,
	PATH_FORMAT_CANONICAL,
	PATH_FORMAT_RELATIVE,
	PATH_FORMAT_RELATIVE_IF_SHARED	PATH_FORMAT_UNMODIFIED,
};

void format_path(struct strbuf *buf, const char *path,
		 const char *prefix, enum path_format format);

We tend to avoid adding "strbuf_" to the beginning of functions these 
days when they're adding things to a strbuf. This function also needs 
some documentation explaining what the arguments are.

Thanks

Phillip

