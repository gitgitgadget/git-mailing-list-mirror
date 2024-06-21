Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F809174EC3
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964746; cv=none; b=Yn8bXmJJdD6l4Dt+xB2Dyb40ivQ+wFAhDfui5iY0bD8VDnOACZlebCpnqjDys7bONivDs8O/DOfngi4VIWYW3BWTMOOCTCGqCJLX4Y1ecVc2x+LNFqiDeBGp0P2q47ae1+l+uXzrwLC5qwPyed85tH4MjKwIXBN4EUZNvErT1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964746; c=relaxed/simple;
	bh=guWzhm6e258mafNdrqaNSigWDGac4rcUrdtzx+Mz3Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGjKxk+FCiNITGjsltKKbkfOy8bqDIcbJAp+ac2kQk0P+7CgVw5QLI37B0aJrY2VM3i9KZ99svDwKLRMK3WvIH5n1InawWRNhGWS0jpHouzgBLCZmNaJ2iki2wX+IVOwVHjISDiNF055JvK1LGFpJx68aoQywHHD9qWbCkCIVq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHJ8B8Bo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHJ8B8Bo"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6fd7bee2feso11313366b.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718964743; x=1719569543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oplGsNQYmyP8+YrT6yM8OlRIRh9RD7cuZJFBEQhgxAg=;
        b=GHJ8B8Bo/wD6CZ8/2+IuJS8lPNcq4Pc9Wma0CTLhk1SLPBngI/BwCyJJDClxX67FVy
         Xu7UtHBQDqAj4BUsU70bgFNOmbDRoIMVOSEUWOLT2/D9nbulbOqxBTcYxnMZFC/g5H2H
         A17QrJ8ilepTxmemudfdTUjGZ0zF+9ePAfKH+zlb8O2wmtIM2qAv1FUGc0D4WZPmCuAA
         nWl1YowSDSgfjCO1nIDvBLlOPI9Ct3yPvhg2+tjNIt5GILdidaSRX6K+k3IqBenELykR
         CPAlg5GvtMwTM/KAGZdFhZD6HhjdRAA0b6onSJPPLdxoSWxFWDDs6hi2A316IVRXOKcl
         3aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718964743; x=1719569543;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oplGsNQYmyP8+YrT6yM8OlRIRh9RD7cuZJFBEQhgxAg=;
        b=cZhWHKOBAXf84Ptgioiq8+/lVuZWTkZMJ9IVzgCzugiepPrECQ7IoERuuc5FC8YaAL
         ihdFp0MMWivpPzT6rIS5h+23TQ3JsrIBwALcJFz5CTc6/Nf9F3pEqjhToaG+veL15sk5
         wd/gA+0t7Vpw4din7gla0YJKN2bldT2EIqbxkYvShxcIk850fT5lH9ML0D+ak7Z4NInn
         NBPOFJrVgoWxQYQJHM3VpHc9ZnwwjOyOlEIN8oKUGJWufama9m4udRKTiErP4HWj5hG/
         IZ/cn+2udwlW76Zm/ZDMbBP0o8clhKiuLnSMfqEeZJSMUg9112RW67I/MvEmo+eeUf9C
         raAA==
X-Gm-Message-State: AOJu0YzcYHF4tosfSyG1APjGIX91sJXyWgLs6xJjZHuEwWiFBU2N0+ul
	ggUoIXEqK21DdkYggFGJHWKvWXFoWM0O3saMq9ACa4x32Czp72UR
X-Google-Smtp-Source: AGHT+IEPQ1wf6teTkEmteKUaY9nnx5yE9yjI7AlgyuQC+Ba6Zaso+0vdFZTigzrdG149nds1BppXXA==
X-Received: by 2002:a17:906:c416:b0:a6f:1111:bd8 with SMTP id a640c23a62f3a-a6fab648728mr478531366b.46.1718964743164;
        Fri, 21 Jun 2024 03:12:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6fcf48a1f2sm67153766b.58.2024.06.21.03.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 03:12:22 -0700 (PDT)
Message-ID: <919b40c6-9497-4646-b7ba-62c2236a4c79@gmail.com>
Date: Fri, 21 Jun 2024 11:12:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Thoughts about the -m option of cherry-pick and revert
To: Junio C Hamano <gitster@pobox.com>, Stefan Haller <lists@haller-berlin.de>
Cc: Git <git@vger.kernel.org>
References: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de>
 <xmqqa5jfoxvh.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqa5jfoxvh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/06/2024 03:03, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
>
> Given that the current behaviour was chosen to make sure that the
> user is aware that the commit being reverted/cherry-picked is a
> merge and has a chance to choose the right parent (as opposed to
> blindly picking the first parent that happened to be the right one
> by accident), I am not sure if it is prudent to change the
> behaviour.


FWIW I agree with this, for me the main benefit of the current behavior 
is stopping when I'm not expecting to cherry-pick a merge.

Best Wishes

Phillip

> If I were simplifying this, I would probably
> 
>   (1) disallow cherry-picking a merge (and suggest redoing the same
>       merge, possibly after rebasing the copy of the merged history
>       to an appropriate base as needed), and
>   (2) allowing reverting a merge only wrt the first parent,
> 
> but that is a different story.
> 

