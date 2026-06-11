Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E11344DA8
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191587; cv=none; b=GN92igoPeOfabZIxUuwhrPVicH9AEGxk7xrG7wIs1lgWtWPYKUbJIOxIAVDyfAiwFA5Nyf0cwOE8+c9NcmXM550IJsdtjNpezA3CC6+QLqXwVlV++TxfgEn0ya7cFBnzYmyHcJ4RAAQccFZFGQmtny5kKPalnRGOIVqrfJpGD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191587; c=relaxed/simple;
	bh=bpS59GHeSwzvaIt9KQMoRj7mppsu5L+BUi2J3IMg3RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E2UXxeFcdGqKt4ZirhZ1WbAvgsQ9nokk4i82oxbhQWBT7cWgPYAL8kOK5tsTq0iAPNTYDeU7SQ7m322qoEGQD22nON9bnBfAdvAsasblu5n5Ofqaf6X9bwohNoVA1Gs/mqfgK/qDIW9/M02ax+iqfp90D8PdQTm+ztWmuMEt6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEClHzhQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEClHzhQ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so10816945e9.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781191584; x=1781796384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eiUW+/4t3yZarjCpHP5qhpnwa72tGv1PaMAkN4QWdbs=;
        b=VEClHzhQDZuwa8T8pqO5sSE072kAXptipKQwyRUBQZMS1CAiaGe8oK+kmE7d4gGz3B
         0Halk9GGAfhNLTdE4KNsUQ8gn4634sI+ZtcYpVa97OASUNXoMgjBVNisE7dn6lsTGoz1
         zgZV7JJOYByH0qKyfkNXgq6kq9281N+Zu1NW3BNk7Z7v5R4qvMHO3Zaviyms8S8IwUa1
         D52EBXC2E9sMctS5Kj52UG62XicrM9vK0KA1UQ2x8Skn8X2eijqn4VRIDfy08hj+kWH3
         7Sbj6xP+KZqv4JgdScPCrPBJUxxOgPzw964KuN90+jPBmH2Uf4fRqVUCdCCtRTVPPFHP
         1aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781191584; x=1781796384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiUW+/4t3yZarjCpHP5qhpnwa72tGv1PaMAkN4QWdbs=;
        b=XbjD39lwsgXq9p3CFV2WZN+NSZABsO+5Ip3XCuiLkk7UkcVma5vZWP9Dy3rJK+D5lg
         7M5GPcknXfsf5iL5qSOAZw80vtef9sLO5D3LXLE4GBIKayv/n7XIfUAUKA/DFqelM7ct
         lOxK9pMs9kC6+a9C7ZdE4seeD7aEhGMVyOkS/9IZTuypN1kytOAEXt3S6601ih7rZqeX
         IxyzIN/mg3UTtEGcGIznqt8po8uHdaEH4D4H/qPiPoSKbx3bxUq3IKY/aZdnvO616asB
         /4aRB5vNP5lGYHiPYW63nRdFgh1kALL6jDSnr0iyH5jft6QPg9FK+qIv+rlhDIWmgCtj
         J+0g==
X-Forwarded-Encrypted: i=1; AFNElJ+0UFMzfmQKtnxb4QbJZ7BZeb53TaHw3DKrbcYLGlJPzG2GFHOSW6KeuBBmTnJl0jRDf20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8v3rD03o0yXlRF9FzpB92TYgatLlFIZx3yUuZ4FkcVqNQWCf
	pjfX9Y6VOmCLCvT6RVR7RoWC0jxJlg2rRpwq/8ub0LdJc3LPZAzYTE2m
X-Gm-Gg: Acq92OGT1ko64UEW6JAANjKW7JacsjjVR7nyUHwGQlasUjMRCx5nXlY+f32hv1ASEWk
	RJtYFlBRBRAl2Uhg1jBro7GFCXr4dyRY9irV5VoyyyvH5QSKTstVPA8qywE7HNijGViYyXKh/9U
	r5XEEuFqYJK/M2B7shykOl3KK6sUDytUejZlIhWzAziNHQS18xJjpmZKbxfJL/EKoB4yKvArcg3
	DLBcGuLN62B5rbL0v2FrtQ6buLW29cTIW/9Jp69wWCwHuuIYUw3uIhjjv9CSpP/hgy/GlhEguUY
	Y8DPpbnDfZYkx7vJIkRk0x+xohHrjshLU69jq+K1bXT3EZrxNSSAQmbMQ3hk35YQT5/pTKc6i48
	nc1gdyajPpxF4OmR6mlH+gWaUZFgeyVpQtDYOfNOHUBuCpXt13qPaaN/qhPUShquTEt1K736Sse
	HFGD9f50y8qd0EIm3wmoJrOGDDHup4P/wgYzBUluJqplY1tLovUhMpJUy7T8P54C6IVYmq1D+vq
	8Y7fBRaBxfd90WH
X-Received: by 2002:a05:600c:b93:b0:490:ad1e:1846 with SMTP id 5b1f17b1804b1-490e52e5240mr40419855e9.9.1781191583744;
        Thu, 11 Jun 2026 08:26:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c7ea21sm75653545e9.1.2026.06.11.08.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 08:26:23 -0700 (PDT)
Message-ID: <3f10ac4d-45d1-4ae1-9079-17d7b52cc7e1@gmail.com>
Date: Thu, 11 Jun 2026 16:26:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jun 2026, #03)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqzf14tttx.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqzf14tttx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 09/06/2026 01:56, Junio C Hamano wrote:
> 
> * pw/status-rebase-todo (2026-05-01) 2 commits
>   - status: improve rebase todo list parsing
>   - sequencer: factor out parsing of todo commands
> 
>   The display of the rebase todo list in "git status" has been
>   improved to correctly abbreviate object IDs for more commands and
>   avoid misinterpreting refs as object IDs.
> 
>   Waiting for response(s) to review comment(s).
>   cf. <xmqqbjdwcsno.fsf@gitster.g>

I replied to that message with 
<4fafee2c-4151-45f4-a842-17d6b77d951c@gmail.com> I'm waiting to hear 
whether you agree that the unambiguous label case is unlikely enough to 
happen that we can ignore it.

Thanks

Phillip

