Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967A481DD
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698955; cv=none; b=ELsAzwNM/7qqT1VGfEPeLaEXvsF4uJA0Yt4ZSX3PiToOPWNzvJZUTEMu6yopRsWD00GzghsA5bQpzGZG3RR6rdRYw6U8O62iykVQ9+WvDv7WJ/P3LaQB2WUpzHB2KdfX3E5fjWBeFK5z/6x0vaunextheT+2U40healYOWGTR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698955; c=relaxed/simple;
	bh=mpIuNqUz9NAA3XbqG+n6tNfdi8ihpmu2R0Q/Ozi4iZE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=rzMFf1I5ZMpGNyjswNST9Z9Ketu9F1akeep8VQHVDzHOd6UgbCXjIvoNaeodRmb6d/lebNcB06WUdWmDEdWu04OocUJeuk81LvoxvIddtesyQZOfxgNeuwn+QuA2RsktBMirCsvPOnw2/SXy6lI/2uTAo58mkNSOArLnKpBhYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSiNmUdm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSiNmUdm"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506251815a3so44334581cf.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770698953; x=1771303753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvsX6mlGNTkXnw8afcQqvgTF9YW7MrTigylB0IetWiA=;
        b=PSiNmUdm8RVtK55Y50UdgKUQunyMkfQha1BSP7iKN9Z41s+EDxVyPDMD6ovnFlgcVO
         HMT6+WFA95gSv3Fxk1deLEpE2iO0Mx9YUy0cwbve8zHpSF8M+gvmvBxaUlc3h0BXJyrJ
         6SDMm5V/qAQXmpgsFXJCDXzS+xV+Iov04f/Rl3r+N9EY8Zzfld9KJpcLHrbFy0YcRnnr
         /u5t6AEOisz7ftRuM2t5gaz7okngD81mG9z1UM75HSB55F0r9z0icxtvcC/j1GKyJq7a
         YZ68f2+S87mQrhheOr5iAciQN2I2nxLXehea6DRd1p6uacLBdoO2tfto8oDJzUhLNXQP
         JXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698953; x=1771303753;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvsX6mlGNTkXnw8afcQqvgTF9YW7MrTigylB0IetWiA=;
        b=AN16uadbqaemDUvO+h+BzHndfwQhhg5lIS+r0d1otiuYHYmsiXLjd8F6gBfLYUl8Rs
         vI6tTrdBT4QrZ7wqr2HSCaLI7LPmUrSuLIBA2+ihOkJ0/lQDwGO5g7ZCWAx+6dreU0ym
         DZmX5IWzGLoxo7ZC0zetgzZokG7lpoY+3l7WbrFRRUtCs/fbva9KMcLNVgNzAAwSkoAh
         8zQeK129gH+Ai6zY0qUmpqGmhOP7Clk6mMqzvtofPUcrG4yRN/l4vwzFXWui8+LgJ5UP
         rqQWVA2evGrzw6GUbjzKhGOnasQiwUTfHGqYZ5wuilFVbW5goXUAp9s6Vt9gF9ghPrO0
         ftDg==
X-Forwarded-Encrypted: i=1; AJvYcCXYi5JwSyy+DY5akZqeMtWd4qWFOvuuiFIv1XLXQv7M2SAr/oCTzL4FE6Bad3YVGKXjM1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9Op9Kyr9b/B8NauJFpV824g/zwsnj5X1OdDwRL2s+OkzLz0+
	MNsdC/AY5rrh/3ZmWfj7NrMVg4xf4u36j2mlb65uecRjlhm+q9OD/ltN
X-Gm-Gg: AZuq6aJjEeMFYaHugLmKRXGnT6cn0Mj+3IxnkiOlpF0XKHmDQfE3QtNm3Kshkrbtkc2
	FJbaMHCZlR1MYEpz9KZPoBb3AUOdZNoD+43k1C/5p1CWY9ra3haROviex/yPVIGilM77P+54Wji
	8VnRxd0iEVtUc3fPPALYSnY7PEPeq2WuGBBqEpDpfC4ez1+gWDZ4uQwG9sGDwTy1Py26LMXWaTj
	228e0EQWh/O6w7bCuSks4/sBqmUxWLImAPr8lLVuoMUsseSF6KaMBdKlXlFpglbFGnlmxOpYb8y
	MPcjTWwcsH7Au2593Ob4O3xdjOQdXoRLuELgdPsFxOH5wbFNcNYhQWV8ug/1FssDDmHG3a+h4Dg
	/b6jf3heHg4AegTpWWgeAQlCoZWZZ7LcJVmy/YLcl4hsM7LXjcFM3nYK2ri1wDpjOgv7eJVYTko
	BZ296y3qt0MgPmrY58JmkEeeu0s75uflMBhPtq8YhR567hLZZaB6hiWwoha00I4EtlWKM3sIU1g
	TU9emmv
X-Received: by 2002:a05:622a:351:b0:502:98a3:3496 with SMTP id d75a77b69052e-506399515dcmr172477421cf.45.1770698953399;
        Mon, 09 Feb 2026 20:49:13 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506392c1d4esm92502491cf.27.2026.02.09.20.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 20:49:12 -0800 (PST)
Message-ID: <34eee0c0-48e3-45ac-b187-d21580ac4c65@gmail.com>
Date: Mon, 9 Feb 2026 23:49:11 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] [RFC] config-batch: a new builtin for tools
 querying config
From: Derrick Stolee <stolee@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <aYPeiqkw41ln7De_@fruit.crustytoothpaste.net>
 <f6687192-58dd-479e-8df5-a422c01f03f4@gmail.com>
Content-Language: en-US
In-Reply-To: <f6687192-58dd-479e-8df5-a422c01f03f4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/2026 8:52 AM, Derrick Stolee wrote:
> On 2/4/2026 7:04 PM, brian m. carlson wrote:
>> On 2026-02-04 at 14:19:52, Derrick Stolee via GitGitGadget wrote:

>>>  * Is this a worthwhile feature to add to Git?
>>
>> Git LFS has the same needs, but I believe it can use `git config -l -z`
>> to do that and parse the config options itself.  If this is just config
>> fetching, I'm not sure of the additional utility that such a feature
>> would add.  If that interface _almost_ meets your needs, could we add
>> functionality there instead of a new interface?
> 
> This is a good suggestion to look into as a potentially-easier solution.
After digging into this, I realized that GCM uses Git's --type=<X>
option, which doesn't work with 'git config list'!

Please see a new RFC [1] that adds that feature, though it is a
"breaking" change from previous behavior.

[1] https://lore.kernel.org/git/pull.2044.git.1770698579.gitgitgadget@gmail.com/

There's still some awkwardness in my GCM prototype, as it can
require three commands to query all the types (no type, path, and
book) that are needed. I found that the slowest queries are using
the path type, but only because they are the most frequent ones.

This awkwardness does make me think both of these things:

1. I can get performance boosts to GCM faster by the RFC in [1].

2. Using 'git config list' isn't sufficient to minimize multiple
   processes.

For now, I'll put _this_ RFC down for a little while to pursue
those easier gains. I'll come back again and consider all of the
big-picture considerations, including:

* Make this a subcommand of 'git config'.

* Make this a server that can serve multiple client processes.

* Ensure that all "complicated" options are accounted for.

Thanks,
-Stolee

