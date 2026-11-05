Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837040;
	b=X9YE2+T1GBwBI4Ka2+O9624Z3z7mXgI2m782WudFIwt1rwJDerV4U0KGeE5DTMOqSF+3
	 gpfUedmHi+LvdTuV1xpVV6xRNLJoYG7xQFx9UmhDK93z4Vx4KvxwSOAiWujsPgQL+wFb3
	 4sFBEga8bX+WXXjVbh/czePZyJXF9hfbZJ1tCiQCGHj4d0puuGNt2zSm9kOv0pigOlgtD
	 soihW3CECve/MJB8RCtkCLtu2m0PA+KtaMyWiff0/gh/WsezodbfxgUcQznRSwxDF3B+L
	 ObFXsmmZ8/o1nGpu2bXHJ4IzpOz4oUMmeaC0vJrlsqdveFiJqYkV8Q6jS+DltnkSrmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=hJAfSkGpM4+0rI+yo0oIysIq52FFw3rVryYKt8OmRns=;
	b=fj1F4AKbYwQREFuk8H64FW/+vhKTjNSzxb/ziR/RHIZqHamedkHfgVWOa6k0TgOCJPLX
	 2iZi7swKx7fMyqU0bSdm2B2wLUf9vwMzcNWE5aiVVU9X1IEdDpuHi330P4kPTio124DwN
	 wziqtSJhsznqW2O3ktrKQFVhpgG7bQ4AFkEb7rh+eyTS+yrTrbWRBBp5bWrov65DHd/Io
	 LYYdAAzH/PNTwPafiMhDOL7tjMwWtrLbVCOSuDAPJ3HLHJwnVBdsB/O7RMsLPFBbl6zTK
	 MbnBv1tmHb/Jt98U/VVOlZ+JnL9st77/jbbpuc3C6cWObK8Tp+WczqggAP9DUqvC2eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEp1gY3m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8B606A334
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A8B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEp1gY3m
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4697404c2bso181417566b.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 16:03:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793837038; cv=none;
        d=google.com; s=arc-20260327;
        b=FWg59k2yOY6loRmV7z0KDEb9hj84mvokIpsUAH13hvX4potL95p93MHBS79aKpBQ3v
         DC+PJ9XL55ThbvJ3Wl+tab5V1Bt5ci0PWjiJ+4wVWsDkI7JEpCC1sQ6rNSqkQ+/fRYI/
         XeW1phaCenUn2Rzj87Igr7N+AXEAifdHKVscKS43ANmYpg28LgwhDmFDe6YIysTN45Qo
         yGrLa/EnwUQ/5SfLe2pgYmtWmdGekfH3ZCWI4aCR6yYCWAuiYhoRjSp5o6tnOUhqzVzh
         Hv0bu7xd1f/d6glQE4WhU/Slm1lOhMm2FiI6mn5Dhv6VZEpziEtgamU4Iu/WkzE7tHnu
         +L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hJAfSkGpM4+0rI+yo0oIysIq52FFw3rVryYKt8OmRns=;
        fh=VtxyItWCrMG9iJc4s5MuY9FooxqPG6L28lcCw3ORqUM=;
        b=Ay/Ll6HeJ7F5MQ8vPbYhWGv8gjTMU2H7n0AW6V7Po7Xn/2lh8u8L5XB3lS7SGQzomE
         nSYyPIaU6YlbYkQYhIQoGmT+SATcJ1flVgViLJ90ENdRMBPwjEWiwTqNxTVyoVkrYnhj
         aSo/NkNHsvMh3cq3KUdKYE+mleKjzHQhzHxuUShMz+ZJI2p6x8quLmSUjaDWzgoCC0+B
         LLlEmar40hKeXZV8moEJCkkeKBvjxpH0i1PeoGXgD3WQzz/MUqg9DroL6N5XrYLMWbG6
         yKdegEWIMsQu0mD76+Gh/5A42FQ67c8t8xTMnssco72oLO0b/3HaAbQnkeQrk3WDxUvg
         s/oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837038; x=1794441838; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJAfSkGpM4+0rI+yo0oIysIq52FFw3rVryYKt8OmRns=;
        b=BEp1gY3mclj/ZraWCouzEEwCUJrvVA1ZqIdghiW1zlF6j1hgkMG3NjsXZZgt1N62Ax
         F8WqwY9MHSLUi5uUOFXwwyzTdFNv7AuGcx8uDezyU4Blqw+wlE51d3umybMhmaZbZFy6
         +hxGgd+ovRdcRreVAuQKMwYIzgRyn94zfVRiqi5rMeqRDkH6ynyoLV2nH1PBMyPhEXDO
         a62sVpeQlUuVUY1wSvMNRzcdzn0N/8tOkk30NhRaU7zibuP3RPXI1gLVlmuZrpUJ31Bg
         B2RP4gpyilwvtiYQlQcAwDmg36d03Mg05gABZz1fTdoWLBWtNPVtGRO7msvGa58du9Dd
         rHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837038; x=1794441838;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hJAfSkGpM4+0rI+yo0oIysIq52FFw3rVryYKt8OmRns=;
        b=i3oqm2oftGb5QRVJic3UyOttnbZiE2FSkWKVml1xsz2I3EWOoWHLnFyZh8uyQiEOE2
         GnZpkWjIg55XjjrF3muVr8LT5LzFAqVIBIBOO7dUQy7bEjNxk3wberKQoH/UCCziB6zX
         1em2BF2JxBCAD7E+J9YKVz1lkSaY4A7f2OcoF5JpqWp0NOOW5w97PN7KC5FTYcypes3O
         Dy3KoANsKs0EDZlDGyQM+GHymcqgrOJPb2IjUfrm9HG+PDL+Osf54FFLnHGZBf934sJz
         1J+PbMDiohbEMXIb5iEyEpi44zcqH4uyaGGmwsxgXqmnDQA+5NMO8WU/KZqB2vxEAxg4
         L0YA==
X-Gm-Message-State: APuU4Z/Z5tfJ573NycWsZJHCMRjAlAa6cLdW5nt2Th0yqpKqpmHb5fjU
	k8ta6Q+uf+tbDoiuqRWrDikXS5jyBq1pY5Veowu0LPLCkd+JnHWBlxZpuLQVjZHOIrD0XJuoufe
	CMvWBWhAeq1ZYlwrjDJ3IdiiON3xAmRM=
X-Gm-Gg: AYBFou3r6QU49IF/0ttK/ZOdDjZYnwF2FVhXQl0X6e9v9fZjF9nheuj9J1JV34tHGS+
	3dZ2qcyLkkm+q3f1dFPMwJfFmbbyhjTuHlo9XGWRjmOFAw3lUnP4mCOvU90OlVJ1E3RJj8fH06S
	cyRRKMXfvWYmeFdmzZLURzuL8uKSEPbkix2SYYqUJi+WKOk8eX7ngjmmpZTIcKVtN61yNaj7Gf1
	1FmJ/3c7LFVuiiSidHxDsh0FMsfH4VeGoKaUDa0M6cxC876E4ioSGsN1cchK6SYS61PhikU9A8m
	6pIxGsauVtDC8LZXzQpitBj2iiZNUJaC/MPGxny1kMQ7ZPvRs5LCQBJhfdp3DQp2vDtM8pv7+GD
	8915ulmtyhGlARB8aRtFnm+G2SNh7JWfO0LWAn1inckBSdkMwjnbMEMRUpIH83XykJnHjlto=
X-Received: by 2002:a17:907:3e20:b0:c26:1649:47a5 with SMTP id
 a640c23a62f3a-c4ca7a9b0d6mr1614312166b.27.1793837038179; Wed, 04 Nov 2026
 16:03:58 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CANHmUQTDpwW7N7axexos32PxvPBPB10NFSpM1bUiKAbk3SMSyw@mail.gmail.com>
 <CANHmUQSBs=Mq1Y1GTY6P9FtyCQz58bDWFgJPgwv4r5rLP3C1Bg@mail.gmail.com> <CANHmUQSZqXtqXsiDQs+1unGcyEuaPhaF8__E_Cy4fWNqxapY5A@mail.gmail.com>
In-Reply-To: <CANHmUQSZqXtqXsiDQs+1unGcyEuaPhaF8__E_Cy4fWNqxapY5A@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 5 Nov 2026 01:03:46 +0100
X-Gm-Features: AclHuK8bQq9G8cSI3QctzaWjCFf5jdgx8uZmrfAgYBYhBcS5vGSJjT5-dA89ENU
Message-ID: <CAPSxiM-bqtG7-qZa3mmiBUNaWrnKF-U6XkEJ_SUk-x5dZryn1g@mail.gmail.com>
Subject: Re: [Outreachy] Project Proposal [v2] : Implement promisor remote
 fetch ordering
To: Shashank S <shashu8660@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Thank you
>
> Shashank S Mogaveera

Thanks for your proposal, do not forget to submit your application
on the Outreachy website.

Thanks.
