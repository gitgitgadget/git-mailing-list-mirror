Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A81FBE83
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526090; cv=none; b=H3Nyc2vD3l7C3YPDE/aXuJRPSDSKIOF0YLovWR095frKkC9hNWRE7YIKId6rTNDftWVg0EsfWpz/3/a4yX1W27qBzC0JS0rPdMb1lkUGNxoTSYMcZVntwSk9Pxg0BVC6yDa4XLk5VfU6sZYEJ1K/Nu7c3LUhFNu6WTXW4bp0Of4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526090; c=relaxed/simple;
	bh=hGt7FdNsB1U418AKyaqfiPgn6HfpsrKr5EYl/nY356w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hD6BVsEJkk81aGgYADTAUWbITzr2kPSNW9I/xBUjuqiiYDQ/H7w4mXEdkVqT5Snr84feSj5hZfnnP2suKNQDJLtn/8J537Hk0rOTbDNhxSkN46o2AB8Om6s/9xqG0Nd8918ZE7U2DMcJI/5y8IRKytwn5XzoE0/074o6rnHkOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS8q/Xdp; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS8q/Xdp"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c08f9d0ef3so340329885a.2
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743526088; x=1744130888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1QX6iQ1h29850RkRU+Fb0/mQcohmVQNBXV3BtEpOpE=;
        b=MS8q/XdpDbE8qPyJBXNmQFy5ZYpF9DN2MemutQ8t9hs4TDy+pwJ0FZ2d3cyW+JQf/e
         i7mjbVcWJRCzhDlYkImNAgN3vFCIOpta7BiUVqpaLIZpxeU/jKwM7sVQGxm7ska7ZSEe
         kwJgCddknb+Bu9RhgYuhJ3DPbxf21Is/NtB7lOht+XowiHUjVHLJCc/PJ8gwWmtzF6ny
         ntVsJuq3Lr9wC+R0NBA/cuFKucpAVqcq4SR0HlsafxPS7rWUKbDM/GkZ5EM8w8vg56hL
         /9q8//EL9WQP8HbGrYghh31rrp76ducI/mQZ1wESBLEK0oP9C2I5igKrTKGe4MBpG0Yb
         n2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526088; x=1744130888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1QX6iQ1h29850RkRU+Fb0/mQcohmVQNBXV3BtEpOpE=;
        b=LEDG40iSUux5IvVuNRMZGwpkF2qbj9UHJHxj5kBdY/abJc5yAnI8K2djm8xlVlKHYd
         U1y/AOP7+qywcbSyRFAjDWvyjXMpVuBSpA6Z4WF73oODTOE147zxyfxBRr8DV/hAS0BU
         KRAow4AmNgUP/+9iG9bxS9jYh68Kkf5OipNfWFktJC03/+m2rzj1jgPXQZmCdmqAn9UQ
         HLCi0X5+1P5FsXm7rCv5qagVDXaihFodKlQjIB+x2AvItL7kH4LoNsKdLVcWuyZ4lbsZ
         q/PLJzqSkGNtKjALZOuN9ARjC04JL55hsor/SbIvcs5mS4zPjdeve9y6N74Cc0nprlo5
         nqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5hzyzG8eCmdvPm4h778g4xkyve2oAuLWPXwJ0YoxI+rKvo3MeOEAD5q2HcuaBs4vPfAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BeBAlSDDcGN/VokkOUuoVwEF9V6PJKLl0un8UGVfDAYjdXA9
	juKYPM78ERGTjEeWRBgvsP5EvXv+4Bq+Sxaye2imoI0fKvgZ1LH+e0JkITi4
X-Gm-Gg: ASbGnctIxYMIIyHVAq05iNuN+brCYHnzY2vkutjPpLW6D4e7yznQW+hL7Kkpq5enHZQ
	JboBKfTQlAfo22Nnof3s97tEi0iE1EWwoeQpDq4xs7TQwJoPcZ9Fxvl8pwunjgDSwS1TFiYkOQi
	W7t+ICHlCIu/6Smy8uaNMha16wM/JsPwoY4AzZX4rEkP/PDfDaNOyWTAjmDSEqVb1n/lDyQxLOT
	pr6F42TIc0zhWObahI77bgYtNBrHtuwvUwPy93H8IWZzRySmW8GY0RYPlYVtUaN0Vnt5rDSDPOn
	OPp6/6msRf2mR0Wk7QKIdHtjfXRYwnuUx0LaQ5LdXWcwQ8WDKkRu92s=
X-Google-Smtp-Source: AGHT+IGo9obCP8BvQcNZwvt7j4r3hu/1VYkn/woLw6QawRfVB4FecR6U6DN+71OgmcukiaG0cqummg==
X-Received: by 2002:a05:620a:394a:b0:7c5:4278:d151 with SMTP id af79cd13be357-7c69087de6amr2161550685a.43.1743526087955;
        Tue, 01 Apr 2025 09:48:07 -0700 (PDT)
Received: from ?IPV6:2600:4040:2644:5100::387? ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9627a16sm63925096d6.20.2025.04.01.09.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 09:48:07 -0700 (PDT)
Message-ID: <c16b5707-1d9e-41ba-a915-523ef7ab2689@gmail.com>
Date: Tue, 1 Apr 2025 12:48:07 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui - simplify _open_stdout_stderr
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, me@yadavpratyush.com
References: <20230922164412.130504-1-mlevedahl@gmail.com>
 <0140dfd8-f65d-34a0-2e66-44e3f696b100@gmx.de>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <0140dfd8-f65d-34a0-2e66-44e3f696b100@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/1/25 12:04 PM, Johannes Schindelin wrote:
> Hi Mark,
>
> this patch is still relevant, right? I am Cc:ing Johannes Sixt for
> awareness.

Absolutely. I have a number of commits in my tree removing compatibility 
for unsupportable Tcl/Tk and git versions, I should clean these up now 
there is a real maintainer.

Mark


