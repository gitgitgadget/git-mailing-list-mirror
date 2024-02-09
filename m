Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B631EA6E
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476918; cv=none; b=gDvqUvP7jGDPvwqPFCR2gkVslDFHTIJxZxaLRswDn6QNxav8CedugiID+N/WU/sa4y2jDzng9fUE+iHSBNzdV6MAqkAZ/y6XoNxKvofT7iXXy0SyFGMU4SOGA/S9pbHUCURdENNz+ZZBUNXLItR91XlKLAScnbX0Hwt0BPtHFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476918; c=relaxed/simple;
	bh=gs9FnAkjkFHxianppXPotwTjVdn+UhpA9d8Vi+Qxy6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFhsF9gG9hrxpUv1v9GPJWKqsYSjJFXsvuGwheEOEyNyIKb+TtFclG7ArsT2IQk6OoGX1v6Q05ymxB69Wcgefb0phy6sIm+ydqaB1WR8RRyZzCtC53XaqfejxuCxYNC/e+XxWDxUPe4TvJaZVhBcRGKun0jd6406Zk2UZncFNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5KzdFDt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5KzdFDt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-410708db221so2562185e9.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 03:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707476915; x=1708081715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6dQV7Nwtdeqgb/qz/XG7Oahusb9OkwK0BmhGvXBjzVU=;
        b=L5KzdFDt8hoG30AzGAf/XPJRGJndhnBCe+3TEhY9s7j0xa15SIAahO65OxxMt7HwH1
         V7epEICcAGATbwcf3/YeKjdpHpvKsjYexnbgdtRiDOLyNG9/ZAQUhEO4XV1Ti+Glcvjk
         5DKw/FtPHzPzfDBOoSOxVfzNi/llCTNV4mNZrJVb2IzlIkafk/kpCWWjAWzBIc9YnZXt
         ATncqZvy2fHoRFd4Jy75vvqwuySuId6Cj3ZTTpLPoGXiKYJs2ZE+r4ayjOrsFhxbKznC
         auTXYulCF90u9tqqOK0xfqKAIoddyZbnliiRNpVSEqQNS9fVlBguCyMnpYxbGpbCEjZs
         uNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476915; x=1708081715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dQV7Nwtdeqgb/qz/XG7Oahusb9OkwK0BmhGvXBjzVU=;
        b=HtCHM9SEPsqDMzTF4OE6+Q32M3fu5fXrlMqBkzqugwCuG+Xlu8udtYpm5aFl4ZT27S
         xRywTS49xvqqggHBPzDUurpWsjczSQvdWhCldTJ6rzUlmcG9+z73vytXbLhkhs/TRBpf
         8g64SXh95R53NAw4MD7ItIDHUsLUgKsQNKLpnvvXP6Kk30gYH0L4mPxBnP7MQzJpdXMt
         5Cv9MlE1/dCdtBRFQknEz20qA137f8CZ0CX0FJoOathLHbBpNfuMzAUNh872mI9QEo4O
         mTfsK6rWttTRcyGS09pto6G51h/Xx35jfIVBWb/TezNZigcSSRGCgX/qhx3yNHnMRHBB
         BhgA==
X-Gm-Message-State: AOJu0Yz6LBTBTy5bti/xs/B3GzRXrlgGgauO7ClcautHSPK2UNy2kyCN
	FfOUoCD0TtSw92bAbSM4yOgF/qYkcFhAv++DG2Nj+LYj46XTMswM
X-Google-Smtp-Source: AGHT+IFM6iLrbNQnnRly0LiDxNr0r/sylEYKJUomYSw86UA3DOv3Ix+TqI3JeaBi7zKN+6wIv/Ovyg==
X-Received: by 2002:a05:600c:3b18:b0:410:7635:407a with SMTP id m24-20020a05600c3b1800b004107635407amr637264wms.32.1707476914979;
        Fri, 09 Feb 2024 03:08:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnt3I0j2dQKj3bYSOqhCBmiH+oyTCk65DX4BYZuKd5IDlzvGQObwqSky6LAv0gXJ7pJAiEhHp+za/t4CKwUEORlaWH3Av8rOLuhb1X9ekOBOMduG6tZEnNjm6MdUR4dcLpmbVxrdaksBA+A0woKGu/W2i6bQ==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id bh14-20020a05600c3d0e00b0040fdd8f5e18sm296000wmb.34.2024.02.09.03.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 03:08:34 -0800 (PST)
Message-ID: <6ed59006-9572-460e-996b-63a1321b3db5@gmail.com>
Date: Fri, 9 Feb 2024 11:08:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] prune: mark rebase autostash and orig-head as reachable
To: Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1656.git.1707411636382.gitgitgadget@gmail.com>
 <CAPig+cRASFkTD6=YumZJKv7XJjr1asxKB-mAyBFox8tuwmNnFw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPig+cRASFkTD6=YumZJKv7XJjr1asxKB-mAyBFox8tuwmNnFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric

On 08/02/2024 17:25, Eric Sunshine wrote:
> On Thu, Feb 8, 2024 at 12:00 PM Phillip Wood via GitGitGadget

>> +static int add_one_file(const char *path, struct rev_info *revs)
>> +{
>> +       struct strbuf buf = STRBUF_INIT;
>> +
>> +       if (!read_oneliner(&buf, path, READ_ONELINER_SKIP_IF_EMPTY)) {
>> +               strbuf_release(&buf);
>> +               return 0;
>> +       }
>> +       strbuf_trim(&buf);
>> +       if (!get_oid_hex(buf.buf, &oid)) {
>> +               object = parse_object_or_die(&oid, buf.buf);
>> +               add_pending_object(revs, object, "");
>> +       }
>> +       return 0;
>> +}
> 
> Is this leaking the strbuf? Should the function instead end with:
> 
>      strbuf_release(&buf);
>      return 0;

Yes, well spotted

> Also, what is the significance of the return value of this function?
> All code paths seem to be returning 0 unconditionally, and the caller
> ignores the return value.

Good point, I think in an earlier draft it returned an error at one 
point, I'll change the return types.

>> +/* Mark objects recored in rebase state files as reachable. */
> 
> s/recored/recorded/

Sharp eyes as ever, thanks for looking at this I'll re-roll

Phillip
