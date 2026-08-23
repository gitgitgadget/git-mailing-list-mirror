Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC571C861D
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787498899; cv=pass; b=MXXMgeUIuokQQBkJmYXhFqURH/YzA74U8xStWIu9grtmw1RdIaIICW47ztOo2yh02wCTWJm7WTV6A5FEI3IZyFDx7ywdplzJCCPQEUPITNd1KNje97Y59OR72kSJy1kRElAqlq/JJGVwtOSJkP6Zs7SyDN8vulhfKwFZ39RXb9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787498899; c=relaxed/simple;
	bh=oC6h85YWB/JHcIS7bPmFrjApt/QaPQWmVPN3OBvuvu4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwjK3QS9fRh1hD/TWd8TiXydOFbaFZw01F7sUR6lNNOta3fcWKhysx8kb4QztGzA4CY/vxLB/tgNeTAPamcTGciMClf4JjCicDg1H7BtmfCEqB3VUGM8v1SeP6una+aE9vIpQFUl6lLZhAPWaH9+TLBJxB2Rq9XtJf2AMBjmjAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ00Wf4u; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ00Wf4u"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso1067962e0c.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 08:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787498896; cv=none;
        d=google.com; s=arc-20260327;
        b=CQmuw08AziBjG60mbFnwPEGfbnr+kgxqR077eBEPkCf54bFdb5TR7Uq1Wkvgh7rIYd
         V4GZHMyAIYT5SXPUsMLbSaEW7a6IQ9pJ8zAAs0vXGmZoysg5gNhvotwGocm8wRIMgdXf
         ShV94fPVesnDVvzJwIZrMdvfIiqQepIJ1SQ02adELwU1fuAwW2VAYrdsew2qdfkgBNRN
         CaaoS7tX7ownIbZD/48yE0/mpoppZya2JwUWWlPkSkQYAoELNh3YG/axZ2f56jFnfT6v
         9LNjPaxKega2pa3qC+f+wT7vQXPWyScC0rKi5t6VmE5ujheBi6Own06oUIGpR15yMqz6
         +8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KgrEMsXUWTq6F8d53TlAq2WXPEXutCtOPm94zFWDBxs=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=fUU7GiTBEBW0PoBrjoXkwQ80FqQoGODh1JgMgOz/M7UDE3w6JgE6LThx891s7GVZcv
         qsadz2Jbf5VQW8VBw2cc8ENxO1MPvl/DdK07BmA7BrJ1eiXd3WkPUEVkGFXBPfUZbrUD
         iIh7CBGnUkcT9WYe/lVnZCDp6Bd7UhHMbfJiD9fGSoOWD6obuDjaQjC24dcT7af/BgRI
         pFy3W7P0COO4UYSuyiGqqHzBVgeJujGTOSBEN8sAAW2YD00Cj/dlcz5gv5W1lY6ofDWs
         LuIZgm0smXfoU4Yq+6S/9IsbjPNJeqCbImi7sAt/iX6hqHVzVhLVW9w2xJ7wQ4faWPE/
         xKtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787498896; x=1788103696; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgrEMsXUWTq6F8d53TlAq2WXPEXutCtOPm94zFWDBxs=;
        b=BJ00Wf4ugQUluBvsSVjjxs7sTiTK5/WTawJmBkQVz+EVNTh7lxppKcsUQzBWzKpVwp
         XXhhVPB5Zl4Ly9JgBvRlaK6pI20YwFUUUNZUT4w95LFfJE9D14BBoGk5O9lx49G8OuIV
         S+jrZHOzvdssIRuMnV2rcaDNgcexom+5Po1xpkTdskOPdb5RyMC8DqEclD0e7yl7nUTs
         pcdN1d2X+5XENuZ5BmVTtira+qVmneA/0CL4A0j6m+y4U/MsX2oDS/nn6wqKi/tcL4Vy
         gZLsZ21a8KmVrGKt7nYQ87seg5dw9YOppomcT45ZRarIP/XXZK46DuNqfzZ4rSTA+fDG
         QqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787498896; x=1788103696;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KgrEMsXUWTq6F8d53TlAq2WXPEXutCtOPm94zFWDBxs=;
        b=H3EQl6B2vW+AmUiceuPxJAZi1kqdETMnFZWG8yz+RzrmZiyl1ef4ugl8cvHMfPhLiK
         WSJrRsCzXAm/oqDiISLMCm/LJs8gHHtvsUx3WQ8Jt6c1ZVrkU7uEkejH5BBwfLhyt/eY
         JSuzdF41R658u87ahytNDA85y5cBOiZJUEpo24YnpB/cNBcApb1qpDpLxiVWSgy1F9B5
         po2QNjoOgo1okLVGj6/NYCEiS+VaA0mJ2Zop+FLZOvg1CxnIIiJ1Dx+ySyIj1K846/Jt
         UVRZ6QoJRTVZVZWlIMx9DR/bFC6quoEsITK4vxtBEFTe8OxLZIiLd1g/0Jy4SCIF+D7W
         hTgA==
X-Gm-Message-State: AFuF++lByIy4za/ZAp2tQNRH6vqCWeS8DJ3OwfUMkKsY6sZ0rM4KvBXE
	yIUiEhmt2S8jTf41EWDZ0tGeyuIwr8/zcw5zgV0BFGBvtUMYyeOmGg4xsi2z9D4UiTrJGLzUtu6
	k8KCAMqSG944NEDRZrlY8JaliskHYrCDhZN3W
X-Gm-Gg: AR+sD12aeMS3ULxjSuNhIjb0h8+3G6hul1yLRgL1aV18jqOGOuFjol+4aYzrtU/rwkA
	85rnqwnY/N2AN6n4TKEAbyihQPC9bIx3IUa7pIjRFd+8pajaVklml5+e4Dc29KmiKEj1ANIAncs
	oiVBtlhVvNCpVMDUGLvkdonPCq5V+dN+FQUE5LHvWWsRK+2l7qhZ3orBBCLj0XdOO8xDQKRogWy
	isdxk3hBrMI9hcNrtM2o11hfBrL5QBk+Hz0gP1eq2iPUVkDhet1z2rjON/ljyHdgQHsxV5QH/WP
	nMqkpmBGz524J4BXK5peMH2lHzBgYI5EF7CJep647IlmpO3TnVjpKt9yrUKJOwXjTXPHzNoQcR8
	t7D4XNDaKmYuk0hD6aO/ISECX2OmTIh/Hz7A=
X-Received: by 2002:a05:6122:3c47:b0:5bd:86ac:a847 with SMTP id
 71dfb90a1353d-5c60de75d5dmr4653886e0c.6.1787498896482; Sun, 23 Aug 2026
 08:28:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 Aug 2026 08:28:15 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 Aug 2026 08:28:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq33wavxko.fsf@gitster.g>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-2-6bf5305d4e43@gmail.com>
 <xmqq33wavxko.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Aug 2026 08:28:15 -0700
X-Gm-Features: AcwNN1Wiwpt239OihNdl7VQws4Ezp6tE2TeaC2as3t6pG0Dyn_jy1_LNRxOrbe8
Message-ID: <CAOLa=ZR2Krkxpz_2wWygosV4NSLCuc1m33-iHqdyAXADDvyaSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] reftable/stack: move list lock to `struct reftable_stack`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c300620659b88417"

--000000000000c300620659b88417
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The struct `reftable_addition` is used to modify a given stack, as such,
>> it also includes a `struct reftable_flock` used to obtain the lock to
>> the list file. While the scope of the field lies within this struct, it
>> doesn't allow for optimizations to be made on `struct reftable_stack`
>> itself.
>>
>> Move the field to `struct reftable_stack`, allowing us to make a simple
>> optimization around avoiding a stack reload when we have already
>> obtained a lock. While this is currently possible in the write path, the
>> write path also contains multiple branches to reads which only work
>> on top of `struct reftable_stack`, and we would miss the optimization in
>> such paths.
>
> As long as nobody tries to open a nested or concurrent addition on
> the same 'struct reftable_stack', this should be safe, but do we
> give enough tools to help the API users avoid doing so?
>
> I may be misreading the code completely, but when a caller already
> holds a lock after calling reftable_stack_init_addition() on an
> instance of reftable_stack, and then adds another reftable_addition
> on the same reftable_stack, flock_acquire(add->stack->list_lock)
> would fail because the lock is per stack now, unlike the original
> code where the lock was per reftable_addition.  We jump to the
> done: label and call reftable_addition_close(), which would release
> the lock, which is now shared with other reftable_addition
> instances that work on the same stack, which in turn would get the
> holders of the lock into trouble, no?

That's a good line of thought and something I didn't think of.

With the current version, this wouldn't work, as you mentioned, the
second `reftable_addition` would free the first's lock. The only way I
can think of is each `reftable_addition` also holding it's own bit
indicating if it acquired the lock and only release the stack lock based
on this bit. This works, I will write a unit test to also validate this
behavior. But I'm wondering if there is a better design.

--000000000000c300620659b88417
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 971c25c1a1007b8a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xTEVZNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWJiQy85SUVHaTNZOG1NZm9zVmVTRlJoVTE4MlkwRQpQeUIzZ1BoU0FF
dWJqZEl5OC83eW0xZDBoOFFPaGtiektuTzhVY3BTTktwbmxVYjVJYkc0Q28ycmdUdVZ3OHIxCmtP
T2xVUW1ZME42NmVwUWh5VFBJZmF4dDZHUGo1YnQ1czZuemxmWG5mczlyZHdIN1ovRkVrMHVSTUdF
Q3l6T0kKZUg4U2pGM1VWZE9veVdRTVk5cjhsSWZYTEpndmNjRmRPTnprKzJreUQwRWt0Nkd1YnVk
V3Q3Z0kwbXhiQXJKNApTcUNlc24zYmREZml6Qm5UdEJLQU5xM1hXVENFeXhTN0J4WDNraXg0UVJT
aU5rOVNLMnBYU1dVbGxiQVRiRENjCjRwWHJDWmZZL3Z5d3F0TG9NdW1tYjJYMEJvSmg0dzRKTHBu
Y0o0YzFHdW5URjAzUUNDYTE5Sy9uRjlLOEZVeXkKK2xVVFZiVnY4bGhMdksvRXZoZ3hobXBhTW5N
bjFreUFpYW83Y2w3ekg3Qi92eVM2bjg2UHNDUmh6RlFvSC9KMwp0a1BMWjNHTUp0UWs3Z3FmOGg5
L1hyOTBwSFlETTVuZkkyZ05LUStCUzIwUjRPa3dJRlB2THhQTExrTkduQlRoCmFBc2ZBYUkwWURX
TG9ZeElmdm9zVFhlRDhFaWpOcFV3c2xLaWlOND0KPW9CTGoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c300620659b88417--
