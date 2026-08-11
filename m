Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830338B7DC
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434195; cv=pass; b=rhxgcR+iTt1uDqFAjzPNmGINBExPrWgzIu0ZkJjVQXPeUG75TT3tbevrR9FaPfo7ikL/Om18SVxrVxczw9FxQfdtWqXyuIzE/ms/fXMAFFpxBmjcIlUToHUOO6KxVg/hJG3DZ4SyVeHCEXq3A1/Um80vHl4+52LFXTivaIqAxDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434195; c=relaxed/simple;
	bh=swdXb21JvVRlJG9c7kQAQ/rUTkXd6XeIUko9oAi/ZRM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0jTaIOm9FLsw9r/TUI6zIZMxXl18rClwUVuTYSYbXu7/2/gMNeLulaauVnovrJPNOepPmg5d44X9VAdtneSgwhk3d8gjZP6p2Td3hIWHNXIDS6bvdzuvdD1BJccasVNWVwfJoGa/i0GbTixFTpcgeoOAkNEAs0nuhtyNsdSk/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amn3UqCj; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amn3UqCj"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c2c0df0b45so138534e0c.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 00:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786434193; cv=none;
        d=google.com; s=arc-20260327;
        b=hM3+GQxefX0zlmRberd35THVV1CML+JCcjUm98bW9C4jmuUomG4aTgTvS7BklADTWO
         MQWb3ZVnrvRA+0nf/ud/2Q7crJpLaOAzWsG2i5qr/km4L03G4vzw+87PUq+HQRvRQczt
         bTbAJeBxQVMSrGt48AYOon8Job+/hSsI5LRGX+0qv3tJXX4+XN7aIZjnKEgvrif1GFXK
         +S2HTP6rv32JkSdKPEJA8Co/CktzMG3EugXCqW3jncR4FTWPWKlkP4LymPqpkUZDyfV+
         o8H4DoEL7HLL829l736+yRVIciu/kBxz5r19C0LMiM5dJYXbNgJztATk083cja3qZWlJ
         qnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=swdXb21JvVRlJG9c7kQAQ/rUTkXd6XeIUko9oAi/ZRM=;
        fh=MxtPRp44vRwMzl/tDueRpRdFl5yTY2vDLf3uXCpGbK8=;
        b=QFxfgRqbcpVdrsMVrhOWXgThfX3Hh5oWcn+pb5soPKPPajkpWIMY/NC4VuVPszPT/C
         5QOGYaGlx9GuL5ud0Pf85QuyvDqp1sGjMIo+Y0SI/Lg7XjpWyGV/NM/SCgtQDmYkLgsG
         XV0qGeA4FNnbv36nR+vhSQt4nZmRWxNkDhq4Z+l/S5iSoRExOfvXpvAI9iChPwY37vuQ
         ImeRBo/uvi9fA0tjfnV2/w4YRvL+SPdHJdYyXd9eJNgOPouLVTlZ51NCkqbKN6V0th4b
         Djln7C2fWSpHQHBQZdk9A45ybmxtIWL6+/7Y4/TEuz9GkP9ecgFKgY+Zc6yiS4pU+/bs
         fyMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786434193; x=1787038993; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=swdXb21JvVRlJG9c7kQAQ/rUTkXd6XeIUko9oAi/ZRM=;
        b=Amn3UqCjVDxoZNLsAUN1Sii66pwiTbNAHjOfmiXMK4zsoTT5iU5rcNkx9loHzp+KWm
         qUNZdQP94qm2bk5cmSw6pxlikbvW9JSkTzPE8j4QtfENgzwy0GVrO68IJ4SOmGwLG2Jc
         mT+3PBhXw21nAXE6P2bxdCJn2+iKSUzASIrU5CBm5/0jckqnA5zgbQ8No3SF4VRbtEU+
         vgwaQzRkATL4u5u2pGbDYBMbDpwzcdTMbqQBKeJQZyBYIaZMUTa6fHeE7cbPLDE49gtS
         1KL5uOC7vkkEeNqCAt5LuNhuA5zwmvD0J7FitwhZccqWftpognxv55tD2PfFIsTYqqpK
         peug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786434193; x=1787038993;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=swdXb21JvVRlJG9c7kQAQ/rUTkXd6XeIUko9oAi/ZRM=;
        b=DGItPU+TFEchb+Ob1qejcCatwVtjZs3t3SD8qr7ELM7H6JPZFgZCVx0HFmEW4hgipI
         oP7pIAq4hQhfwdkK+IvmU5PxNoFXzqW/x0wL1SoWs6e6rCQWbKje3vkYOnb6wZfvWiNN
         fqBFmlT5VNmZv5jcODf9I9sp980MNLydOsgKvH65nb5tTJH+Pzvop30sdIfqRQK48iTZ
         wZSl6vdhJzSTPS9/GZXfzjLCkHcUjk1vNoBshb8Al8ukZR+mFjNvJgAb7amRwyGEarVM
         cPyLOOaP0s4Av1cUgq0DPR8M9/J37OAzRySaDj9QC32ikVzirHQvL8agfFruzJStqBSy
         JkMw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+HTiF3kjvGdpWFgYR9MIs5b+OptDVAKfpBrpGipjD1+6tUN8perD91ymzhfb3ASpYsRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3VhbjR1KWm07IEoan8/Rnb4GMvIbaqckowci9ZSztjBjLLTw
	OOih7G02QsuQMY7uGElpV3sRKBmoxkcxkggzDY5MOCviyzOvq8FAGo02Z6K0gJugcMhkb9jfJEr
	8IHDYoxyqdHZSTRnuiWD1Mse20lbyHX0=
X-Gm-Gg: AR+sD12PnBLJJ5L9wNScu8k7RkKYr64iQS6GAvRCGB2QLsTTkVCJN5tkke+s+irLg+D
	+5EQgUqRxo6zqn0WtAmmuBf77olcjwieBL+9RlLqJgH4fnJNFHeB4cakcLpmNuQyhgC/4gqgatD
	HS2FeUnYKib0+kB8cMoiqprSA60XOfALwYaUvj7svQ0Ro88ovrd4Kz5B0FPtYOPc7yGwZ/tpLgh
	yyyuP6Eksmd/itFKGrngBzSDPO8/7gnbh5lEaR+gZQDcjxj4dYohKHCgYi/w8cXGhH4n8ymlSaG
	7a+7yalMHcN0S79FAgDclJr1nhDU59hxiZ6VNS85Kh/lfKkYIihdnMso938bRcubUxM3AtFWKun
	iQaoUGR6bHWva/ebEVZF+gAKFPgzt/2sHIw==
X-Received: by 2002:a05:6102:1614:b0:739:918a:16c5 with SMTP id
 ada2fe7eead31-76b5527d158mr347445137.3.1786434193466; Tue, 11 Aug 2026
 00:43:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 00:43:12 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 00:43:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+J6zkR5ZkUc8c=xiXgKiAYmbgcoyGfwpgm6aaG0Gog8OVmOjw@mail.gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
 <20260808-objecttype-support-v6-6-e5cdaf27a49c@gmail.com> <xmqqmruwbn21.fsf@gitster.g>
 <CA+J6zkR5ZkUc8c=xiXgKiAYmbgcoyGfwpgm6aaG0Gog8OVmOjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 00:43:12 -0700
X-Gm-Features: AUfX_mzFrl4_-Bc4bHdk7ZxiGoLLoiTTl9nLSG3bOhdYDtJCbW58mJHLpGzQjmA
Message-ID: <CAOLa=ZTrf_WHiRHTjBGAus+YbRsUkbR3dzsW=fgCK0jit6fYzQ@mail.gmail.com>
Subject: Re: [PATCH GSoC v6 06/10] transport: drop remote object-info fields
 from transport struct
To: Chandra Pratap <chandrapratap3519@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008442740658c09f52"

--0000000000008442740658c09f52
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> On Sat, 8 Aug 2026 at 21:51, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>>
>> > Rather than take these as function parameters, we take only the
>> > transport object, and expect the caller to have placed the other two
>> > into special fields in the transport struct. But this doesn't make much
>> > sense. The set of oids and results are really only valid for one
>> > request. There is no reason the transport would need to hang on to them
>> > outside of the single function call.
>>
>> Thanks for injecting some sanity into the mix.
>>
>> With this fixed, are we happy with the entire series by now?
>
> Just went through the series and everything looks good to me, but I've had
> the same opinion for the last couple of iterations as well.
>
> Thanks,
> Chandra.

Same. This version looks good to me too :)

--0000000000008442740658c09f52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 285080545ac1e6d6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wNjBvMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0dKQy80eTFGTVZWTy9VWnBlS21NdEZ4dHdZR0F4VwpOWG9jaG95bUdU
Tk5YenZ1cUNkcUpCd3ZmRnp5c2huMFI4Q25KeTVwbC9hSllzVW5mWURVOFBuV0c3NEllT2FDCmk2
MUpDZ2I3bDQvbzg4cW9FVXdzMW11T3RCMmxzU0RYSmFTa2NmMXNLaGdUbTVkRStoZXlLSWlkbDBr
VHM3WUcKcFloOTRtV3FoaUhRQ3R6ZTdvVk52M0NKZEpOQ1FnY2lGazExS1k0V2lWSnRoVUpUaUpS
TlBFK2RWY1JUc0JMYwo0blBuYmpSWlJIMGlaL0tEdStNVG9MNFQzdW5QYk1ZNUdFWGg4T2tXNHdY
R1dnR2xxSWQ4cG9tQlR4N2ZqYy85CjBMdkhUVVpPSU9pNE5yQ0toL3Frajl5TmpXSTUzUXh6aXJx
RjRVRzc3Q2ZRdWN2enh0d2lna0ZjTXFYOWpXOTIKY0FyTzBjL2lYTG5SajhYWEc1dGxkK0VjTDhW
bVN2S204U2E1QTh6R3RDdG9xQVBsL0NBQ3R2RjhwT3hDZHpMUgp2eXd4QThXMG1IY2tyTzNJR2JH
S214NElIMC9KT2dsKzFqYjI4b2Y4aEVHUFgwd3JibzV6WWptVjRHWXNJZklzCjlrZW9WeC9vNTVC
T3BhVGhqT2czVEUvN2N5Tlc1akRyaEJlV2Vobz0KPXRoaWIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008442740658c09f52--
