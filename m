Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773BA2206BD
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630026; cv=none; b=RgEE7+ucWVTh/cigKMQNXEjq9Q4QZE2z43PByc2hePOTKRNe0r+B04ptotVSNOY3QVS+T05kuWIz2xCUWc0bFFEwUdGL2lug3wp5inhXIbrak3ggt8FAFexUoOuHiQnNGeuBkGd1qXNLf/vKp1B/CJCb9vZEZ0BsuF7P16yV6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630026; c=relaxed/simple;
	bh=9YvqJnL83+j+YPO28aUA7omKJByc9fOVbH0n1Qd1GqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QV0zoZWQKE+AlIc53Y/Ov8yqoCoFyQ1FVl3o0bymp77TnviuNxkJKM6uAGVDUMVku92sBtmvP9QHysYB2x8aD4swAHDItOx4oFV7S9k3VRQwyc/0cQLYnVBBOZK2DkjGTAM8rjJQLb2SOjNpufM2Ed/w8oaWYf6hdjPepQymG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoWokNnw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoWokNnw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234e4b079cso82390885ad.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741630025; x=1742234825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yn2L/PB8nGVLa9NB5KS7DVfGJv3G9Eg3/zncgTCz2zc=;
        b=FoWokNnw9fN2B7Dwhqm9yXgAgqRAnlwVJq20qsBVhbd+daWEop2VxwBAx132KpfWU8
         Lex2zuWZdfXFLHmuDKgNwMAC1DLmbB5Klj/A+iUpoDGtCiogjbkoBbmX+xbeXEA1lmpH
         bbyIAVR6VWvh09Ov15H6Vdy5+6hD+V13xGKEMPP6chXyoupTv+ny3/SQtEUmlDRUCYVR
         H1bp0wMXijGu4dMFeGdaiLFg42epzYFxZXHGHKTDuWcuL+oBtlLPoHLFkXGD+XnQpfSs
         yF5Gc4ksGrAEztDHQ4QBtXRPr7EaD80NYYveyiNW0zsTrxjByJwSRdU7mYRi2ltMyqeF
         RHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630025; x=1742234825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn2L/PB8nGVLa9NB5KS7DVfGJv3G9Eg3/zncgTCz2zc=;
        b=PzSfTMIE6pp2fW3rmAzwKiE3kdmiAJt9OuvK9e6KIJKiyguEabOLt9UBXaQhxM3b/Z
         bm85zhWnEA4nQelWbYEZ2K5ovxA9eHCGXPPOi9UPMZdC86hQtap3S3RtF4h9S5a/yvVm
         DZeVj0ZJl8WSruZAeRQ6utK0FLfmB9HE441IyER0Opdjkis7usxkMCmoRuQDjaDVAQrB
         dtorx0omwOBRaXClqynLOyShApBDz81FCUSlPODLZyVSKzWIh5jINJ7MA57WUp/bGQ8t
         BpNrqY8H2QJQ87YoLRtJg7VWAqcNyj1UO17bW4wYseQGaKAp8guAzfbTreHUlh7pQZGh
         nlgw==
X-Gm-Message-State: AOJu0YzEsP/axlEfjz67vFL25lsS8LRtA1hPYlc+drjkofntfb3fEgmJ
	haeztr/0HSU0okVyl3VxT8y598vJ7lTuwUjzCfPdGM8LZGBE3D6C
X-Gm-Gg: ASbGnctA+f1FGghS+H/h4ZTizsUwfYUd6NmMpzYculwywwWjL40enjVRnQaPvcqBq9e
	dp7L0R7mvD1PqvGesMPZz6Jq+GrmDPm4WQlYLAFxdzzz1aexKgexWJ3x8rfSfxKkuwhpCTQgAE1
	ftS+cWIyubiNPQEzFe1qRsZWuAzBprnXkSTotxHX9M6jnFQExQuxwUzEQeO9j/8jMqYYOR2zV72
	JcmOJOCHbD67gTiz4P23RQo0GoK9QAmX0BwgiRCsl8dyyjtK7nipP3AVufV45o9YzFO3u8IQVp0
	Ny8YmiIu+DUu1HtyCBFFCf+WNEvHktG+zBiPgqpSMF48DJd82kzX20W9mOhOgMqdGEQrCyUSuH6
	Om7CHZx8Ma3xgKxJDmDPZJlHi
X-Google-Smtp-Source: AGHT+IEqkwrKMRyXOsWYRjWKbsyb94Fje4+Vysk7ZPUJAxjMbR5BUF/SDeI8/b4/O2PZCBZ3936AKA==
X-Received: by 2002:a17:902:e809:b0:223:53fb:e1dd with SMTP id d9443c01a7336-22428886811mr178467345ad.9.1741630024546;
        Mon, 10 Mar 2025 11:07:04 -0700 (PDT)
Received: from ?IPV6:2402:3a80:4163:e5a:15b1:e92d:8ad3:3f81? ([2402:3a80:4163:e5a:15b1:e92d:8ad3:3f81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e84a6sm81760095ad.55.2025.03.10.11.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 11:07:03 -0700 (PDT)
Message-ID: <d68646b7-0513-4a54-a145-cdbd0cd67a4a@gmail.com>
Date: Mon, 10 Mar 2025 23:37:07 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] decorate: fix sign comparison warnings
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <afa6b428-3190-42ae-9eac-540c95b576fd@gmail.com>
 <xmqqikog96uz.fsf@gitster.g>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <xmqqikog96uz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano <gitster@pobox.com> writes:

> A simpler fix to the first hunk may be to get rid of the
> intermediate variable altogether and always refer to n->size
> when its value is needed.  The compiler should be able to see in
> this static file-scope helper function that n->size would not change
> at all and do the right thing (i.e. allocate a register to hold its
> value at entry, if needed) without a hand-optimization we see in the
> original code.
> 
> The same can be said for the second hunk.  The intermediate variable
> is used only once, and one could argue that its presense obscures
> the condition under which grow_decoration() is called by splitting a
> logically single expression into two.
> 
> Which one is easier to grok?
> 
> 	unsigned nr = n->nr + 1;
> 	if (nr > n->size * 2 / 3)
> 		grow_decoration(n);
> 
> or
> 	
> 	if ((n->nr + 1) > n->size * 2 / 3)
> 		grow_decoration(n);

Your suggestion makes sense to me, the second one is better. I will send an
updated patch. I also found some more places in the file where a change from
int to unsigned int should happen, but where int does not cause warnings. I
will also include it in the patch.

-- 
Regards,
Arnav Bhate
(He/Him)

