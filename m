Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEF2C237E
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516376; cv=none; b=RXVEkHThPyZWMraUOFvipKUQp+BSrYr3ziNAf3OcZQcoSx2QsXTK6h/t4ZAFRS8iA0Fxwaah9/qPeXcEwfo2DjhVoszCW/JVCwXLqJD9DQoLV+muBD5W3nSAmUKUxFC8ORIH4rU4S4LtCn6T7VFwkKiWoXjsfNgY7qb0tTAM6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516376; c=relaxed/simple;
	bh=bvuXaXkRESqUgsSNpmIHmI6An9JKZQ9cVQXq07XGAYA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFoQpSsTnCXV1rbeOOeVEu1hXDMJy4NjW9NVOZ8Z2HO+hFXVKF1yyCJS3JNdj0+3uTyvqFDEcyRc7oiCNu1MiKntjWnUQ18ERqkHvSkFTmJZQXSUDNTsr30Hf4r3DHz/Utxw5zeYwoPpOQmEzsxayx6mJofvUQgDfTl9W7cxnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGTnaTAG; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGTnaTAG"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-59d576379b9so2457528137.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760516374; x=1761121174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2EtYke8OCROBgKxHC1Zs/YM7nOK5cEoGCN5P/CHZPXA=;
        b=aGTnaTAGXoIxCiOIp4PUByJCzUtgKxHtfDfItNIxkf15+Js4oxhw3Q2U32DT/Z/7Rd
         PlwSTO4v68TP9uac8qZb8Y1J+ZOgWBV2c/lzPDC/2W1+aKXaUc/Lyp7RpYX99gkDabKT
         IkgUS4D3ZzBibFSR3HpTbM4P2hnlZj3WL2UtQrRVOPtZQK2besIxEkTwFhRk+Qm+PjAk
         B7KVlpglXz598JeRt6Vtn+UqIgNi1dgjbkN/K5ssxJ46e0f4qpuZETgqF7Q4rO3ju+Mi
         QEWjuXsM5DBlteShlfid0Chsj7C/vbejOYGXRxATrxPbH1YJWm/DXLdQmeGgIBz6esxP
         yfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516374; x=1761121174;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EtYke8OCROBgKxHC1Zs/YM7nOK5cEoGCN5P/CHZPXA=;
        b=QZWT1ouDTy4sVLD0GI+DV2VrF58uk9SYWO2xfPlGXAypRMtRn5iFOF7iSH2ZctB64j
         ytU0dp1Dn07P47MZWT3gQFGg6nfhsDcABSioDkNh/jaJ6RF5PpUr/XbmehPtamDCZFUp
         70JvytC2KesQ0c8m320pHaWX0hfSak4YmJ/933rYtVY3Vq/g1VGPcXk0Zhq55FcQ4Cx5
         dXpOE1E6WWa70Z93ge3+Ry0z9cfh5d1GY9XBCHD5MOQdpE6lfna7QTA4FDSM82ghF+WE
         TPvWYxtWcqtSUmhdPEQgcMG+5MhkuyTl3FS6evIWXx4ip0Q7qhojmFiIwTQwn0G9oG2L
         6zsg==
X-Forwarded-Encrypted: i=1; AJvYcCVbSDy99YF5ZbWNKubNe+HEEQwwdeu3kU5F4vjIGe8YnyXfHjZDKaVC86feUkI4RfIYMRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYI7TP5tz+MDdeiBIcY02Qb5xY425WaJOdVfDoY6xjqhb+pv+
	ytasjY605WpwtO8XCldHsWMqSLETQbU4GraPHF6xeSEz8zgO3AdjDe7JZ48GZBaIxMG5lbCTaT9
	Ak4lBJqYKZCWKjnX6QDyAfPnc2YqN2hxugkGv
X-Gm-Gg: ASbGncsniSjWOTFCtyhmW4qZ25cSeqtP/Z2Irg6bzMQIqZZtOXw7dNX0E0etXHqyLbZ
	s16WflNMX8ShaXUfwxAN6+GACBqtOCLlNHGGvuOSB1OiDRj8ioyxmZuqoc3AhaHDwxIeiowfJ+K
	fZAjarBlpe00QQ1zo3o1m1IfRlBFR53XLNWVK1Es7U5lpVBzKJr2ETzxhoC+xmp+DBWyiC/CoEW
	ICUh3WZ/1w7GkZRO9w30d7kOUE=
X-Google-Smtp-Source: AGHT+IGjNm45in5zt6oRiPHmydnMxFQZtrkkKeJ3jSTlXVM8GIMo3wjvZHRCB4FK9qGzl/7BwK7TmiIU4G2VhyCfUcE=
X-Received: by 2002:a05:6102:c09:b0:5a3:6a6f:21ad with SMTP id
 ada2fe7eead31-5d5e23c174amr10283319137.30.1760516373737; Wed, 15 Oct 2025
 01:19:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Oct 2025 01:19:32 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Oct 2025 01:19:32 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqldldxtoc.fsf@gitster.g>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
 <aOjsjpE1vuFUXXbh@pks.im> <xmqqwm4y538p.fsf@gitster.g> <xmqqh5w250lw.fsf@gitster.g>
 <CAOLa=ZTRG=x5PofmSSfHhJ3Lig2NjhU8buVWAXU=aKom2PDsDg@mail.gmail.com> <xmqqldldxtoc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Oct 2025 01:19:32 -0700
X-Gm-Features: AS18NWDcLv1QzvRQc603x2Eq38nMKDTJQYbX25Wv_gKW_sMt6zko0htLmTjqYBo
Message-ID: <CAOLa=ZQj20e_p99dzWjmrQ2i-RnLjsnEN9ihuDirV4iPN0QqPg@mail.gmail.com>
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000014182c06412e29f2"

--00000000000014182c06412e29f2
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Perhaps "--check-" followed by a word specific to what we are trying
>>>> to achieve (e.g., if we are trying to see if auto-compaction is
>>>> necessary, "--check-for-auto" "check for auto compaction")?  I
>>>> dunno.
>>>
>>> After reading what you did in the previou step, I am reasonably sure
>>> "required" is a wrong word to use, with or without other words like
>>> "check".  Semantically it is similar to the should_pack_refs() check
>>> that we use for pack-refs even before "optimize" came.  We expect it
>>> to answer this question cheaply: are we better off if we repacked,
>>> or can we go on without repacking for now?  It is not about "are we
>>> performing so poorly that we MUST optimize now?"
>>
>> I agree '--required' isn't the best name, and like we discussed
>> '--dry-run' wouldn't be either since that would imply that the work is
>> being done but not persisted.
>>
>> I was leaning towards '--check', which is simple. But It might be nicer
>> to be verbose here and simply add something like '--is-worthwhile'.
>>
>> Being verbose here is okay, since it will only be used sparingly and
>> specifically by those who require such a use case.
>
> Nah, "worthwhile" is relative and it would be less meaningful
> without expressing for what goal we are judging how it is worthwhile
> to do.
>

I see what you mean.

> Choosing a phrase around "check" is better, I would think.

How about simply `--check`. Since the flag can be used with other
existing flags, it would make more sense to do

  git refs optimize --all --auto --check
  git refs optimize --check
  git refs optimize --all --check

I will send in a new version around this and we can discuss further on
top of that!

--00000000000014182c06412e29f2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1579c37b254947fe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdldSSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHl3Qy85QlRXZTNudjZqMTI0VkcyL0VVYUpiN2UyZApMTWpiVWZURHFW
eTU1Wkc3cmwwNnVVSEQreDB4a0ZMN0dnTXFReWZud2o0ZWhhVUdMNEdCQ25nb1hQVG5VY0JUCnZ3
WHVGN01waWpwYmo3WHJlNjJFWExTVkI5ZVFESnlRQzUySmZJZXhQejFMWnlRWTNYNWpoTmZDMVQ5
ZFd4SDgKSTFLMGx5K3YyZ3cwM0E2UG1ybS9BYWRtREh2OXd3RFZmT3VRV2VGK1dJbnp3L1NyOVNv
V25YK3AweEVETDF1QQo2VmZRbDdZck5Pd1JDQmNkdXdva2JucDUyVDVsSDM3cTlGK1BnZEJocUln
a05DNzVTNVRnWXZWVGUrMUtyOVNJClg1SW90cE9Ra1hubkpOYXRUaVNKMCs0YUUxdUkwc2FBN09i
TldJemhUdHg1UEZiT2h0aWJiOVc5akdKRHdkQVgKZTZVL3B1RmErMG83Z05OcXlwYnhRbUM2bHJq
MzVxMytFTlVnMW5mcktWMVBES0dNRHNnRlU3TDRkN1k0SDZPawpOYjVTNGxDYVN0Y2xRL2ZVMUNZ
em9GVUFDbUZCSWlHeU9yK2VQYy9sYTRiQXlxejFJZXhxRGZJWDROVEk4aGFBCjg5MkZlZzdkQkc3
K2p4QjgrNmdVQUwxYlJ0eGlWWHF5YXdOcnUvST0KPVBWSE0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000014182c06412e29f2--
