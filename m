Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006F39E191
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735061; cv=pass; b=TQppQkjTsZCvLuhCvEjsXwKAg5GY3VfQoo7oBFe5tfHw3I4wpcyttQf9/ApjZyavqAP2thlsAMGV7/2TjRDFfX8HvLgEfFjsSJjtHw2C9QiDgJ85fXnDEAnPfZ7xcbml+dC/oy9c3VdBri2AqTO4r6SEUpVDxGEBl1rwmfyTJ0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735061; c=relaxed/simple;
	bh=RvRejLLumYWlnbKMT8sUGwZ5vXGXSyDd+HJmEwtNQ0E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joFo2q7K1BHye+GqqXJr+xMYAmRzDFDpCrSion83lcf+r8ksbOaWINeNrH7V/NKTJF9oJsq2lHt6tF/QZSETw/078HqKcOmU8+/Dn/Mv+0ZXBGK12W+uFGug6r7znXfaIblNubrA8TfQvTkYTVAyldUoYNNkmUwEjXTqnl5R3Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/IBgSEv; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/IBgSEv"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56d93355337so490015e0c.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 04:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775735059; cv=none;
        d=google.com; s=arc-20240605;
        b=ZY7vQ9xAGdBM2AdMouQVoyF7UgmzjvlHmlfqRC3Y//ZAsY0861Alfhhu16CdBj+cZ3
         SobuT8nb54G7khCLN171euiVYe4WwNBlZIj3AVpEGfx0TUbWHRzJr5MyEzZO6TsqKuF1
         a8RFFyy4oO8xDyjZ3urauMdp+q4R9JjyOaouFZzIke15OJMfeW0/GVXfmwj0lqREFcsA
         aQk56zAL9HI5vxyJjjU+aC74ttLMd7fML6yQ8iVcnsmqnWSpFgq6Ldl45IhKWb19WfA6
         S2raIUSmb4S9fnS9BuxnfEUaXTh2VO41kd71lsrCPqYRg+HQ+p2k7puMku7bhGDTNL+n
         jmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RvRejLLumYWlnbKMT8sUGwZ5vXGXSyDd+HJmEwtNQ0E=;
        fh=/wNvOgxPIqNmmD388hZUElOsHh9R99swrPFmJ9qbrtk=;
        b=Tk5UaQNEufYii8zN1WXYEvNrIMvSy/1zVCSfakFUK1H/JriPrxE870//odYK80HXtO
         Zh1bf/PzWmmNZUcGQezJBPtUniLlN5nVapfSNydZ3pcCVILQkTVQKAiRUKonOxI0VO8i
         yYgQNRy9HwKZI+Ba9+T6lVlh7he5JL5yBCZyaOEuyKTWR8HwGYEwga+62meZQADqSfKE
         nvKvs8ZuVSu+9AR7fOGm7WECgMmc3yJDVqgFGELCtcDzFiK/S1t+7odf0U391woOUuJT
         k/daQqnYJDTSZxc/feixsSGt4CqI/noQ8dlYE4IV7Jqiwb87FmenCdaXxTCnl9PV5rNB
         vFlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775735059; x=1776339859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RvRejLLumYWlnbKMT8sUGwZ5vXGXSyDd+HJmEwtNQ0E=;
        b=G/IBgSEveog+Y6AcAh/y5oK/lHxVek7/Igq7QAnfMwpJtr9z+hs9DoU4p0SzHcNOP/
         6vg/Cq209a6FOrVzFuIHrBxgC/n8GmeP49oyVW6gw1zS3MSJdBAUg+ywhRrp0lTM+ghq
         +ZNd3Zg0O/dSgw0HJOXtv8Jt9dI20x5iskbUoY2L2yrt2H5Mw1IISnOEWShChnSqQT1h
         5CoDsab5X5slEoRqG7alYEDV30vTC0iNRKY+pltjlhKyeLedz6iUgK6mYTai3C8Rf76i
         hA2WzA+vZJpGGQ6atmeK9xoUfIgWiCASLYi8n3sK/d1mc6OEq0UElObE5iioCxqGPrQw
         pPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775735059; x=1776339859;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvRejLLumYWlnbKMT8sUGwZ5vXGXSyDd+HJmEwtNQ0E=;
        b=iMLnUqkPZRFN+YmvuD9Evh69HDRfOFYI+W8ylcLbUsW6h62wwRZ+3HujOYUsb++Q3i
         htE68qg1iymftlywM4KBjXPuBA/RrCcyL5lMtnJalVTZ4n/kByXzYuoGCST5Z01UnM4E
         EoIpJiB8yCBllR57awFGtnEbFOCGnHCk7AhWVePHycAkvQzgmnIvjyjKy9IhiznaNcqd
         su2tITaXElyhTGR4Ww4DfKgpnhT8adrIUo/qmn/O5VYA+6AKZ+vM9xFUW5/bJb5BWv8I
         SkDn3JZbxbYl2DlOeStMO96u1+tksFI/JPSQ8+3ZEVhououFJjgonK3T2llJg9Iju8YJ
         VW9w==
X-Forwarded-Encrypted: i=1; AJvYcCUzHuwkEpYtOhGX/X3vLLoS4CzmNRw59r9Ra3G+j5lb+M7ZIxHy2+GSbjg5mU/24ZS/m3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgx2+dnYwj9wp+6s5ntBW9xOr+9Y94FS5dHmir3Ll2bWEaGSuO
	Y9mj1R4PFu4JbnVl8aoZMi+MqOePOdWyLgdLNZm67cvGEOwqGly0xmcc3ZIOKdOoH5QL3eYrCGs
	7Alk4QV5AB032dgyIArCS0uMphk6TpTA=
X-Gm-Gg: AeBDieub43/beaEFcZXBzdStJ875HtpZZLVoVcwJxm5BwfjdRAS2fEN+d1qKR1bTn3g
	gp4L8JMQYohzN/eBrCQ6tPXjlOxBLjlodjumEEPughySTkcxqRGFx6lTYQvoLrAGfGK48HtYHT6
	VIYwVq2FOc7bBgWs7bK5CPCL0aE+d2CMh5WBW7p3IZ3GY1e4LgopSuCYvRXlVcck0YGbKCl4mAE
	1Yd00uvHjAk+bQ0/ClNA8jQXJVkZYHfhLCaTVyh708cQiMhjtzPWvmQ5iv83RXv5PfQ27IqALp9
	t5NkxokbhPQeH/ukE9QBdyeYrea8sLSQTJLPpCeS
X-Received: by 2002:a05:6122:829b:b0:56b:1eb:d396 with SMTP id
 71dfb90a1353d-56daba2a7efmr11109766e0c.14.1775735058796; Thu, 09 Apr 2026
 04:44:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 07:44:17 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 07:44:17 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im> <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 07:44:17 -0400
X-Gm-Features: AQROBzDQv8ZvlOGd862MVnbPNeR-h-XWkmXfQAtS1DBINaYI8rUnpw88fhVxWjk
Message-ID: <CAOLa=ZTOOTqNv7j-DFdC2cMje=5MBdNBkqp9PhgUC7dQFKLz3A@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] odb: introduce "in-memory" source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000653a61064f058948"

--000000000000653a61064f058948
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series introduces the second object database source type,
> which is the "in-memory" source.
>
> This source may seem somewhat odd at first: it always starts out empty,
> and any object written into it will only exist in memory until the
> process exits. But the source already serves a purpose in our codebase,
> where some commands, for example git-blame(1), write an in-memory
> worktree commit.
>
> Furthermore, I think that going forward it can serve more purposes as we
> now have an easy way to write and read objects that will not get
> persisted. I could see that this may be useful when for example
> re-merging diffs. But eventually, once we have the object storage format
> extension wired up, callers might even want to manually set up an
> in-memory database as the primary ODB for write operations so that no
> data will be persisted in an arbitrary write.
>
> Last but not least, this patch series also serves the purpose of
> eventually getting rid of the `struct object_info::whence` member.
> Instead, we'll simply yield the ODB source a specific object has been
> read from, together with some backend-specific data, which gives
> strictly more information compared to the status quo.
>
> The series is based onb15384c06f (A bit more post -rc1, 2026-04-08)
> with jt/odb-transaction-write at ddf6aee9c6 (odb/transaction: make
> `write_object_stream()` pluggable, 2026-04-02) merged into it.
>

Was a nice read, only a few comments from me. Should be good with a
re-roll!

[snip]

--000000000000653a61064f058948
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f79340a79c1d3e3c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWGtROFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVpFREFDWG8raWVqQzlTU0J0N3JtSFpzNWVHeW5wUgozMVB0aWJDT3Qz
TEZ3bjh4L0FQOWtjWlFKWng2aFVMSDNUM1ZTeHU5SlJxUFUvZ3Vwdk9acENaenA1WGVlc3orCjdx
b3BJTENSejZYWFJBTnVnUmhXc2lha2pHWnRMUWVuRk1aenZ5MU9ZNlFkaTdtZ1NhdzRVZzBlRjhn
d0VIMGQKRDNGREtPSGFmYlpUZ21LS28yT0czNUNBc0FmNSs4b1l3SWkrYzQrU0tEWmxtTkl4dTRo
d1lkcUZBcUNjQ1JCSgpaMDZMcG1hdldBT1BhelJJQ1BHUHlqR1VjYWRHK1BReEMxMGx5ZjNpa25S
alZ0MWVzNjhEdGg2UnY2UWwyU3VKCm0zR0dqTHNLMDVJdENFMWJQSHNzUFFFVG5xOE0zN2U4Ynhl
V2NML2IwNkJPMSsvSUtTMDBOWFhBdDI0UWJDQzUKZHR1RVJjck9mYzJUUnM5d0crZHBwUnhrK2pJ
Nkk3NXppb3ZzSEhhTFNMc1BLUGdDNGlWYmptWTN1UC9Rc3p1awozYXNIUHc3SmRPYjFrNmorOEdB
VWo4bnJQSGhoVmxCRVc5akFWSUx1NkppMGZ2UXM4NWNCbWlNL1lmSUZzeTErCml6bWJkTHZRQXFp
ZVVENnhnNG1yWkxnZHpNUktNcml1ZWE0dEdYMD0KPUVDV1QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000653a61064f058948--
