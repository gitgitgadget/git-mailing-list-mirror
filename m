Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792521132;
	b=hXHdbiTYe3LzgwHO6eUhCsY0N1HJEpMEen5KAcK0NfCU/tLbAWzWC9zaKrg2nvdkorIB
	 WSkEEoMsC0+uJZzZ6qfAhiLnXSIE9AqV+RRZAttVt6ET/gMz2fRDTm0CFvY8hpteLssHm
	 sxc969buovajmwedUU8VibI5p61oR9yd5QMYWwTZ/BWUtnOuu3N2GoHQW3MdRsrr9WihJ
	 cZVBQCeW5naU06/z9/0zf+Natq+pCRxWx+tH03ARIrFavFf16CNtCpiI4ODkkCrpIsA27
	 BaIxDwacyDOgAjFly8nWCNWo9VSc0tgGHPSMUjPcYi2Ah/2Tf4dfDiGdpGbA21hLSbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=0M2ntfEcNoIXZQH+7lI78HTPwFL1/ljOLIe1KwJc9bc=;
	b=PFpGv5JKinNW3Bhuyg8DtmI1TFWW8FeJWhS3xGa1LkqZzx0wS8LUJzotqqgPE9QQpOET
	 5kLtQY80CxPiB0B0fxcATnIUWy94YcL1AuPcZPBinTTna56jIGQw1uQCFZVkQKAvPPsDN
	 TBegxLqIteNwiOLQSz5rAh0SsTVIDuz4JHP6xXeTYhakSeJFURjDj6f/gwcN+/IN3Cz0I
	 3pVd6ocbsf0WsdJs9LkDZKieVp+/+SKxgQ5i/9v1WqcP5iKBidG9HcZe7pNJT66La7Qre
	 lZj8AmZsptlOERW5e+aD4GlvxLESWRfDvdstjFCtyJ6ewjoRNE7MMgLVFCypAgS1xYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="YouBWQf/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C7606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB2C7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YouBWQf/
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-988bb309c2bso1864875241.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792521130; cv=none;
        d=google.com; s=arc-20260327;
        b=jhOPAbw5kW4pG9sBy/3fcSZR784xj9LaqjNzSkmOdfnP6qOScPJTSPNBWX1w+m+F8a
         7YDuz80iYrlkBVligdQ/G+XgjZxJtdreSrx3cgZ6kDYxSjj1mdPkgtWD7dw0oSQgYqaB
         rlMnFW2LNU1CcAeBmDtAHzFT2cx3qM7QYW6fKIrspmqn59c3aN/OSQXPjeAC1vJr3cqJ
         +OBS0SgJkYkf+Oyv0FRyMfwoRFUB/GDpSS/Fd39ZOVuFNTa3IC0L9+7KrzIMC3YY3LX3
         KN4zytzXlpiMbXuOIpTg+f50BYYAXA42Bkk0WRz6WKGm8N+TLBl1rBzUBgkDx8eHWKCQ
         9fvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=0M2ntfEcNoIXZQH+7lI78HTPwFL1/ljOLIe1KwJc9bc=;
        fh=X/BdMCukH8roScMVdgPpBc+A2YB9HkS6mamRbzxQWMI=;
        b=WhuPijLahgTcFACeEcOX9ZiQHwOA7DBHDYcx9/4NFz2wOq7eQoIgSPnr+Eg0ieem4u
         9HXcVJdB+2e1VFgtl/LIAo2RDEdPaGu6/9ErT9A9RdcYhiXprFQJHHhCM6yRYgwDlU5h
         LL5x6u8YMrt8Lf4NgMpL2XmbNsYSL5HHbZY55Mlk0X/+fL/SKxyMuyB7wtVbxQ9XBccl
         tn0wLQyhYENfaW4zhGP0d84WgSUtChDxXX7U/lgL+7dRTgOQKV8JXkZBFM353WilmBmO
         9L4V0Ju9dNOfNKJmFKBxlBWgmGw0ynCehgh5UTT0nkoR9n6DSFnT2hAezHpZxbHF55T5
         e6Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792521130; x=1793125930; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0M2ntfEcNoIXZQH+7lI78HTPwFL1/ljOLIe1KwJc9bc=;
        b=YouBWQf/MxjX+pc0hJi0YLffq3VWHoPxS5b0L8OyLCp+PZwfJPxnakLFGPIbReZmcC
         SeHsnNM4jQXAFECQz2J0q0JEKCbsrOwB5K4TGKTh7YO1gbCxTEwSp+zIaPua9lEQ8rNz
         K4CWPb2w8X0LjTJ2dISDQ2VCj6nnQVTbQtwr3uLSTP/9qXGBC7gD+JYGCrakzqf1+XFY
         KIucuaqj+2UEtewXEkYenq0REFfhppa36T0lcPYyycVU95B+rzubC8nXByKlaZNgjA/h
         Bm+RfJqsgWbBbjusRIMDmpvX2uhGWIJlKV2bLi8eNZwICzrNRR/jgrypsxG6ivc0S6cf
         gTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521130; x=1793125930;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0M2ntfEcNoIXZQH+7lI78HTPwFL1/ljOLIe1KwJc9bc=;
        b=KT4EDjefcFKBXrv5Z7n8tCf+7JzUbE92HOGZxejaTz9BlmnqJfsgjIXPfPsfbths+m
         45nlI8e8qYgDcTBDszYC1YREgeSbieCk9hn7D5xAyNGrm6wx5UFG40yIVsOWzRFN3t3A
         1xzC8UlQ6tE9vGZTP6xKQczvlWFocy8/olUrSxo841ACy5vjWdTSD+VCwY0AhnzEHPQq
         LLjQmPFT+SIbKRsAgZFJZADGRkwX7VY7eVyTnxMLcuXOWzlbGj1MDoSUtxOVoAuw18/u
         E0Wgh+CAMA/nzUk3APz+Xb5+NOpW/VEde6dR1bwoU0PLR5VGgB7rt8TKjZfa1AVecQoh
         2YpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdUfW5PosFQh/6gMJePfA4+joDlhwauFDJbxhMI5w2e23RiLy85fya3Hl6YsAZ6JIp1Y8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmOazjLaxoFEC341Frf/ET/kTL4OoTyiERuFLzhTdg1b/B/mPU
	6xqmvv2+fu03Gb4+fxvU4UPydHtGT1Wrd5lNcbRGlBG34cxGvhRxUXM4Wl//qco/EsBWwNcVcGG
	VN/rqROm21bbjr8wmQ450MRh7mt4DlM0=
X-Gm-Gg: AYBFou0l62fIviT3EbNH5Zf1FgisRPHyLH8kvPX3PN4sXmJMfDWm7Lcl5CzVS0MxihE
	Ut5DWWPh4hcSGmWVcqPm7fg9OJloBtSdKgATUzagTrbZ6x1kmxOeh5lsMfWzKh5a5G5rktg39qk
	EZ3Qi59h0AzuCOrVRJBOAXFXsIUoZ6Mnt0FyGnPX1Vm90DRTrxfzs3zo5lsJq3AlO3UkIMx71RW
	YD9ccCihrUxikCt0V7JuSEHy61EGrJl3KANKJsuRRlqPpHhPAlaQyc6sOShKxl9HL4ckJWK9g8c
	gdnqOQjv4MNRzOrmRfMl4uqF44gwESTQ7tMZfEezHO/2Y532FK5hdRzW/hFXvtb9dmv+hRrChUU
	bC1kn5ReqF007bw7goqvuVpNScMGYNTlC7F9w9eNSutUQ48cu1dtbjd6c
X-Received: by 2002:a05:6102:3fa6:b0:7c1:7ca9:94bf with SMTP id
 ada2fe7eead31-7cc9266ae4bmr22153137.19.1792521130629; Tue, 20 Oct 2026
 11:32:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 14:32:07 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 14:32:07 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh5ihyxd2.fsf@gitster.g>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261019-b4-pks-odb-extension-v1-2-143a5963b77f@pks.im> <CAOLa=ZQj0sZu7WRzmvgZx23ZeO1KBtOm6yWOLCzeVP_86zkTPQ@mail.gmail.com>
 <xmqqh5ihyxd2.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 14:32:07 -0400
X-Gm-Features: AclHuK9Czxzkkghnaa2eknkS3RQa_FsxR6chl384LlG_1El8tM71B7mSX4BYHi0
Message-ID: <CAOLa=ZTqy4WQv4vwJJAsyBo0n0-Pj5gXCtbwO1Ctz-E5TGE1Fw@mail.gmail.com>
Subject: Re: [PATCH 2/7] setup: introduce object storage extension
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003ea411065e49d941"

--0000000000003ea411065e49d941
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> diff --git a/odb/source.c b/odb/source.c
>>> index b25ef14df8..10abe33a26 100644
>>> --- a/odb/source.c
>>> +++ b/odb/source.c
>>> @@ -1,4 +1,5 @@
>>>  #include "git-compat-util.h"
>>> +#include "gettext.h"
>>>  #include "object-file.h"
>>>  #include "odb/source-files.h"
>>>  #include "odb/source.h"
>>
>> Do we need this import? This commit seems to compile without it.
>
> It is better to be explicit, rather than relying on an indirect
> inclusion from an unrelated header.  Since odb/source.c is more
> or less a library-like part of the system, however, the presence
> of translatable messages meant for human users is a bit of a
> curiosity.

Ah! it's for the '_()' translation, I missed that. Makes sense. Thanks

--0000000000003ea411065e49d941
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6798cf5a48569b6e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWHM2VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meG1pQy85Y0RUc0YrS1ZTZDNrNDhQRW4rL2JIWUZGdQpvSmJGSmFpcnZO
ZU9HRHU0d0NZaWxkejkybXRwaUl2b0N5S1ltRzBEaUJSemthVTNoYWtETjVBbVJsTjE5a0xkCmNN
ZXVuaTBSV1NZLy9iU3UrVEYxdnpnTmlMR3QvY01NcWdhU2ZXNXB6NzFUQmRyQkY0cGpTZFlIWmx5
cC9lT1AKRkY4aFJ6NUcyemVueHJlRkRNcmxZYnJrVGZYeVFCM0RjT2grUklUVG4xeWxXejhuaEh4
NjBGZ0JUZlpVZzNvNwpmY1B4SnIrSmFGUm14cTBRajlKb3F0TVg4VURsRHR2WS9iU2dXNkdTZDlj
bEhPSTF5aFBQNjRqa2V5SUNUUW5lCklXdk1sd1RySjdyQ2hHbXhpVzlMZlZnNjR6cjhJUUlmenl3
NzdObXlmcEJSVnR6aDU5RkZGdUlUUUw5MzBrbTAKcnpiVytPQnhqcHZ3b3owbTZMVkJQZVBxWU52
MGxtWlVBV2h1ZzNwSzUrQ0J6bjBieDdodi9sTldmcGp3dG5XawpNR1dVbkZUWklrRERkQlVQc0FC
U2pKOTFHbVlNZWxEUmpYUCsvNGI3S2RhKzRDL2o4YktDZzdhQ1MxRUtLVld6ClM1UGZLZHBQZWRY
eTJWQVRvQjZYWWtYRmxocjdhSUo3dGxRcFpvND0KPW9YS3YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003ea411065e49d941--
