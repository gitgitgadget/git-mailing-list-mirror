Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59021BC58
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896421; cv=none; b=o+7NnTW9KQQyLyLYXViO5ZMzeqt6skxnTdUEWmcb1UbHV3yTB3AIFXnUE5/C6IAy3dWjNm1X4U3IQ+vTLbdMpvWbLYaZuOEOYo5CsOd9vfIQw7jaIq+AKdwhhfwjCnWeW1PHBuxzSBAsnqxYNFI7HUcRdYCG/76e4siUMee6IqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896421; c=relaxed/simple;
	bh=LRG4F4aHJ1aPth8tKRr7xzC9QRhtu/lwUVK6xrTRt0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiEt8d6U82OAkj8q/7TDlFkk2aULOyHTR8hzlg/dlxrXU1ygAC9TSZ90kzL3V9hzQQJ0eh+VnUa/6Rzq0QmZ1jT3kN21xwGNCyntqGdRdCBXO4DJMec3KxnC0gG2uc0uvxFfD/tc7eet3xtccebiAuepbv0Iv0bb+H9oh/Lq47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9ICqhUh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9ICqhUh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431137d12a5so37805075e9.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728896416; x=1729501216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hUQtuafB/hyb/RpObwGwI8/VJBeuMhz861WlFh6sAuc=;
        b=Y9ICqhUhsw1gMQV0kJZNj94my15OQsldoUxqeBd3mu5ZqfWI9xGFOk0xTKYMlMPCgn
         Kq645y/CPv6LfPjtv6WYwSlSUu6aTg7aHCRFLFhL3LlmxelMPbryDMok7piY9Xsc7y/k
         9Ths08FqALRKK10arqXMUp3DjbPCWedc72UUCQPuLnTNMpvqhUSu5DfHFM1JfwWEc0qm
         OKs12dstbiU5C6MFVoUf2zXGdrV1qF620QAfePgdY5f7FNLi0k38TNJg678dhOFz2Xpe
         pQubHC43As0wxeDX9RiL3zTrkYeBxrO3EIx4Gglv6RB4qwkVkeoU+8qkj9RniTo+A8pE
         ykwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896416; x=1729501216;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUQtuafB/hyb/RpObwGwI8/VJBeuMhz861WlFh6sAuc=;
        b=o4YmdeieukS7gz78WaxREegMMyoXKBwWBpj/aWNsXE++qvqTLZqLeKGA+eMOuO7OwN
         VYUJ1ud7fR+2An5xr0vJpQNID7tZZBwYdX8fZCW2AXLMbGaAw7BGizFYh6+XMH8kCVBY
         tctH2xvgPWSNjQ03gt5bnmgmCufLpkRKDLqPicgG6JQ43motxwfPNRU1317q200Sz8xt
         f/M8+X4sgfJjH7WHpQAqCMVZOQraJOuwNqs3QlvFVsec3E05a0Ygt1lSiw+fIgaNC50w
         nACT4Z7YV23q9zlf8dIrSty/k3fKK1LcMGiH/Bd5L5f39KQBdf58NCEhxl2ZCUWrpRsf
         mdfQ==
X-Gm-Message-State: AOJu0YzdiaKRzqqkwa81IagdfraGPIgL980JETrNY1ifc/xjsXquy8Pw
	n1F/CzwDukSws3F0j4gddNje/srPPqspMKSI6hunEpqyLlES8xJo
X-Google-Smtp-Source: AGHT+IHwsCv3aWsX+4d09sSBJ+0JVgAv16g1YYBYt0tFBZekBHldz0tPHecPnGpDFC3Ws+99BPTBww==
X-Received: by 2002:a05:600c:138a:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-4311df5c5b0mr106802545e9.32.1728896415726;
        Mon, 14 Oct 2024 02:00:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf516f7sm145129735e9.21.2024.10.14.02.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 02:00:15 -0700 (PDT)
Message-ID: <14db295a-0049-434b-8747-09f82e511bb9@gmail.com>
Date: Mon, 14 Oct 2024 10:00:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
To: Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Usman

On 13/10/2024 10:42, Usman Akinyemi wrote:
> On Sat, Oct 12, 2024 at 11:09 PM Usman Akinyemi via GitGitGadget
> 
> I also want to ask if this is the right way to send another patch as I
> noticed that it is showing my previous patch which is not related to
> this. Thank you.

When you start working on a new patch series you should create a new 
branch from origin/master with

     git switch -c my-new-branch origin/master

that way your new work will be based on Junio's master branch rather 
than your other patch series. You can use

     git branch --set-upstream-to origin/master
     git rebase HEAD^

to drop the first two patches and set the correct upstream for your branch.

Best Wishes

Phillip

