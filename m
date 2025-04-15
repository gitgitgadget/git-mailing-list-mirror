Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F829A3C7
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723704; cv=none; b=FHhwxaG+JTFjmaisMyXgqvYLF/jnC7BuRHnpG3tf/2s9FD76+7izodtwLciFkCTRJi8/hG1s6wI8a2PnG4jhABKnXq5dEq7mRbhD6X9C/i0ytMWi7JvPtcMQZfXDS2iHmAt0CDXy1JvGG8TLXS/ff3ez1VkvCpspjlRM2hOiOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723704; c=relaxed/simple;
	bh=By2pSj6Y2Aa3crWn60FykkSkjaIE1mxHf+lxdGzzkbg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p12BewvMvRFaF0aa+8GSLanAgefk4nHfPKnYaBtJ9tpJQkP+mLzC1XjPbvdnQiNNEfXX8aW+LfA0+U91WIdOpT3pR19QKdf/DqFcQ1JoxXfPz3Tmqh5rpN5DWrzcwM8IL1CXrP2HN7PE2L5zlzVndjIQWgedHDwCivDkksOqv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILZnNGXW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILZnNGXW"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ac9aea656so5582708f8f.3
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744723701; x=1745328501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZgidngpIwiIZx/yNfJnT7B4UW42E1knZigIW33u+KY=;
        b=ILZnNGXWnNy0tnLwWxYhQkHtj1LGSBScq5vSpbP5WLnN6b79UbOeZHAflEWbywAmlN
         /pckD8RLl8JqyIFPfXONAZx6n4v/+vXxAoV+ZEOMDrIWNrBIHFMxIDCvPQ5unCaCJrBc
         j6DzvvCynB9AtzhI4JfIsWCgFtSoxgay6R1Mf8qIyYv2vG1Ff+3C1q3kvWUBZa3EUswY
         N/tGIJbrtfQcGun0n6hA02RWkSMg3XWdhgIZ1O7TU+pt7wPLkrhjrs09jpXMjugN4oLt
         FA0279TAasgVsnS7BUTrTb40qoIoGPE59bNMvHWhMpC4Yv+l79w2jAgNufv8LwSDpp/c
         7Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744723701; x=1745328501;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZgidngpIwiIZx/yNfJnT7B4UW42E1knZigIW33u+KY=;
        b=A2qS5ge+NFdrbwseNAYA/jTRBx14pjyxagFVm/Wy5HZBVF0Zh3Uf1uDw+P4Y7ThBkX
         UV1MeljW0zLFH6GNGoous1MqLjBsz5yRfiHE57WtjcqrcoL4pKTn01oMd5JFhncQctXX
         2MBja5SkyD0UqZYZ7LrZQInBhJ5XoI/I31TfOWrZAUUomot/PStE+EnMcpe6mp4HA97q
         oQosEVOXkOAc30zwn4/zQcAcaP0/8QPS0Ww4gKCfVv6lqH+F7POuJFi6Hc8W/9+chWYj
         jH7DZhFwn2aziNyge0YAjy0Ol3fcK5oFu3bITuw6BbO4Hc2IFHTjAbR83Q1Uo/Km020T
         Xz5w==
X-Forwarded-Encrypted: i=1; AJvYcCVf6nntufV+AcNdOflZm6xh8WpMJXCh/e9tLMwop9cOCyUga5cgdKH9oB+Ze2JB8R2t0y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIOyi6WLzBocY/oQOqyoD3u5AAZIY9wcbPjSV/0fk7vrIQOBV
	B64Sk5lfSJvyL5OB99mOg5QmPWAtttKBuQkhrvRT0iXTxrQ7gI+DvXviuA==
X-Gm-Gg: ASbGncsGE2MWWe7MobXwNse4LYzumrPZjcLDdAP5Tz2ZDqHI7hHiJMMA9loUSmsYg3P
	mCK8yxar7RrXeRkwbQNGxfUkuTrcfLTlXdvvicA9JPZXCZ7ZYJhlPWYdeVLZDE3e0RVGbR+3EPk
	EJoF4/gL8bYLq8J4B6VOSlHBUvqkWTPhvpA1huVmf+QVn4awYgpS6C7GbwD4M2piYiJZzV42aOS
	6zUYBCViXRJHxlTsXFMqsT2e2lLjPCWZoPbniOS3YWG9dWT2pw37VsxLnkaPWeN4NjAJeMi6IN4
	3h3JxiIyIu8pbOGb6EJ5Zl7UYNvvgHL/IpH1Bgxrqf/m+FXyZJ53PvkbLGFR9j2qM9E9DhrAa+j
	8ZVcxA2vbqWKXmKv2
X-Google-Smtp-Source: AGHT+IHu5lnblS0RG9kv+2erLc3XXhCm1UbiJ4x05wfURKfCxBbVuOyi5zpDE+aCikQ8AGCBHCmbQQ==
X-Received: by 2002:a05:6000:18ac:b0:39a:e71d:ee34 with SMTP id ffacd0b85a97d-39eaaed21c8mr11426512f8f.37.1744723700737;
        Tue, 15 Apr 2025 06:28:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf4456fdsm13997133f8f.86.2025.04.15.06.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 06:28:20 -0700 (PDT)
Message-ID: <23493ec4-fd9f-44ae-a81a-8851e495b427@gmail.com>
Date: Tue, 15 Apr 2025 14:28:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/4] meson: move headers definition from
 'contrib/coccinelle'
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
 <20250414-505-wire-up-sparse-via-meson-v3-2-edc6e7f26745@gmail.com>
Content-Language: en-US
In-Reply-To: <20250414-505-wire-up-sparse-via-meson-v3-2-edc6e7f26745@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 14/04/2025 22:16, Karthik Nayak wrote:
> diff --git a/meson.build b/meson.build
> index e98cfa4909..3ca5d01071 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -633,6 +633,28 @@ builtin_sources = [
>     'builtin/write-tree.c',
>   ]
>   
> +third_party_sources = [

This is not the fault of this patch but I found this name rather 
confusing as it is not a list of sources but a list of exclude patterns. 
Calling it "third_party_excludes" would be clearer to me at least.

> +  ':!contrib',
> +  ':!compat/inet_ntop.c',
> +  ':!compat/inet_pton.c',
> +  ':!compat/nedmalloc',
> +  ':!compat/obstack.*',
> +  ':!compat/poll',
> +  ':!compat/regex',
> +  ':!sha1collisiondetection',
> +  ':!sha1dc',
> +  ':!t/unit-tests/clar',
> +  ':!t/unit-tests/clar',

Again not a new problem but this line is a duplicate

> +  ':!t/t[0-9][0-9][0-9][0-9]*',
> +]
> +
> +if git.found()
> +  headers = []

This is called "headers" but it is only really the subset of our headers 
that we want to run static analysis on. Maybe we could call it 
"headers_to_check" or something that makes it clearer what the list is for.

Best Wishes

Phillip

> +  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
> +    headers += header
> +  endforeach
> +endif
> +
>   if not get_option('breaking_changes')
>     builtin_sources += 'builtin/pack-redundant.c'
>   endif
> 
