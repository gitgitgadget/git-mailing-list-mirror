Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB419BBA
	for <git@vger.kernel.org>; Thu,  2 May 2024 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629214; cv=none; b=GmdjX6FMdVoKUeqb2JjVWOWz/EhnFaiWiOmIVtaOgGTDm9kK8vdyzWlUcejsUdUlDCXziSnhEPLKlsmAhZXBMVlNZC4o+ckhHxiWt+yOmiUZM2JPEMmAjoHmho+xR1fBbAvFMIkP7Wf2kPv3VasEaRs2Qz17srwqby/N0kP8G6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629214; c=relaxed/simple;
	bh=/oSkuHBjxxEOzMTcIS359dkyCKWNaNbmc/jgf2/lWig=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oudlII2jGftDQtJ8NUQxzlYzdyk7w5oumgASwwdByGEjhmMyTAd7eUllPD58rdmRt2qQqkMkJ2CbQ6ykVnKlx9TlWSmSqwdtc67tA/r/e5DKwbKKONaWPUjdzh32eLUKh9rLpeYaRRbqPYCmuBoXx0zwSV4ae6fHTNph8VOjMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUcZJ7Ss; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUcZJ7Ss"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ef88ce8701so1199772a34.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 22:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714629212; x=1715234012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjOWzcBZjsxQSw/LAcQMPIRl4PdTCXSqZM70Ov+NYSk=;
        b=MUcZJ7SsSiPADlGPtU2mredCncsjmRkYXmqn4QVyedb1+X3KXE53VRKVdlkEz6zBce
         n2csrDkcaJ7QYv4gWNjzZmXAX+uUXUq2CWZSCTg+p+tuKYZtr3VnHK1Kggqo/hSaouTK
         4YZhXeTNKX2Qwjk1M1vDGT23KS61L5SWgfOAy7BEJsdHzSu40+OWg2BGpwLPDs7piVBd
         pKf0BQll9M5EFBwdC3RUKqcwB2yuhSKd8eCPZW+8InP2DHXNB9ZsTC0yUstttS2UGvRu
         QsgAHOSSQg2hMgnRW8uUuRGqfygSRn7RuZ7mK1zMAWY87S+rh312MEhV3OFyRhrHzqUm
         NRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714629212; x=1715234012;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjOWzcBZjsxQSw/LAcQMPIRl4PdTCXSqZM70Ov+NYSk=;
        b=e7G5+s1hXE0vbFqN+XPkb398Y2kVX+1sJEeBaoqfTEez9aUAZcdaiOPiTj7Dzv9Sys
         ijmJq26bstQTXXWZZnAbhFVi7iXyW75Xtg9ofmHPDCI4Fb1QkADuxrSolH+57yDL8I8b
         iITXhx0XctBQV/zkYT3SDelsh2hs57yAf9QZb+q3CXFjCKysSUfVd1Qnm0IbS05YCYqe
         N/DpAYAbK308zp1tc4fBBXCjUKF6Oc+HpckKJDC0szlU54kScSeKVXqZV0Be3+wIUuhB
         SMq4+1/raHnNOIw1TF3BwOOIEwNb1TCKEMTqCJ8dET3+jiFHGLg2lyDzUDXwW5Nc2QXP
         HiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuUje3tfXmgS/9oEZWBlj5SWzqVCCWOYRdJwANuKKqMVmshUocf4vlaVAsHhqdJ3ouip3cJWiMzlgBgbbfFLC3Iyvg
X-Gm-Message-State: AOJu0Yw+I39tkStQ5Wz+qQ8jDv0HBTtzF2AQ2dbPrjkDhIzDujsx171H
	nMcpFl4NrY50Mph6Q+Myv4wWuEUrxeMgy9XA+ID+txZcZP6Gw1JjBdL1GNcZDzyrx/uizH8FhuZ
	MnNSHMbh2VIY+/IdC5F8ss0hr5zM=
X-Google-Smtp-Source: AGHT+IFvCfacFQS9Rp18jbkrd7fSXKkNyxDWGt28861qNPPFeXdFI7/suUtypSRy5UoSiIIAUP8sJNP3JfHY5HjtcY4=
X-Received: by 2002:a05:6870:9d8c:b0:23b:360d:4549 with SMTP id
 pv12-20020a0568709d8c00b0023b360d4549mr1288610oab.38.1714629212455; Wed, 01
 May 2024 22:53:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 May 2024 22:53:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq34r1gj47.fsf@gitster.g>
References: <20240426152449.228860-1-knayak@gitlab.com> <20240501202229.2695774-1-knayak@gitlab.com>
 <xmqq34r1gj47.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 May 2024 22:53:31 -0700
Message-ID: <CAOLa=ZT+JyJQzfuQmseZSc1mzFghHriX5fRaua3V7XWJues-_g@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] refs: add support for transactional symref updates
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000021620906177239c9"

--00000000000021620906177239c9
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The patch series takes over from the existing patch series, wherein we
>> introduced symref-* commands to git-update-ref. Since there was a ton of
>> discussions on the UX of the patch series and its application, I thought it
>> would be best to shorten the series and split it into multiple smaller series.
>>
>> This series adds transactional support for symrefs in the reference db. Then
>> we switch refs_create_symref() to start using transactions for symref updates.
>> This allows us to deprecate the create_symref code in the ref_storage_be
>> interface and remove all associated code which is no longer used.
>>
>> The split was primarily done so we can merge the non-user facing parts of the
>> previous series. While pertaining the user facing components into another set
>> of patches wherein deeper discussion on the UX can be held without worrying
>> about the internal implementation.
>
> This split probably makes sense in the context of the evolution of
> this series.  If this were without any prior discussion, a change to
> the internal mechanism, without showing how the end-user facing half
> would use it fully, would have been hard to evaluate, but now that
> we know where the new mechanism wants to take us, we can fairly
> evaluate it alone without the end-user facing part.
>
> I've read only the earlier half of the series but so far the pieces
> make sense to me.

Yes I agree, I think it's also nice to see how a bunch of code can be
removed to use this generic functionality.

I'll wait for a day/two for other reviews. Thanks for your review.

--00000000000021620906177239c9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b5777044726b0636_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1Zektsa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1hEQy80MStYWmJGRmFnNXZ1MmdpUXp4SDVlU1pnNworSkUxYjQyclFC
dURyVXlhUDMvZ09CZ0h4VXNTMkJad3duQ0JKQUhleXZLTmo3bWJLTjlGVDFvN1F5bGREU0I5CmlO
T0dWNUNWUnRwZ0dkYzVYUjJGR1VUUkxkUWxTbXlpaFZPak03RkU4R1E0eWtUbld6bmJDVVc1dkZV
V05pcVUKaFJnelpzZEJFdFkzUUhqbGNCbnhsQzhDMW9BL1hnbDVaMjJnWjNMVXg4OTczbDQyb0dl
aE9NdUc5UVlvVHNBcgoxSXRlMDJHaXFuUk8vd2ZNajVZZ2dkcFhVUkl0TE5KTUNOZHNiaU80RU1l
U2J6NngvSnFNZ1drVUlRZUVrUnU4ClBKcXFMdS9CNkdJZHN4NndSU1dSV3dLTjZ2YzhiaCtwS09i
OTJpd09rblZjd0ZESlJRNnBZRDJJOGVTMGlxN1cKVFpBUUhjSXV6NzQ2VEsvamJuQlVpdUZUeEF5
TDNpMUZyRVlSUUsrc0tmSjNJanlaVll0R3JmTXVwZ1hOSHlRNwpYbm8rZFNtcyt4Z3ZrNkZwVVMz
UFR1M2wyLy85dlREbkR6S2RwYzNpejlTcW1BMC9SdlJUNTJ5azJpMCsxT29yCmc1Z0EvdXkvYlVy
UGFuNzdFWldRaVI4TFlTdGdwU3UwZ2t4ZDlQVT0KPTlFUlYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000021620906177239c9--
