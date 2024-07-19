Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C20839ACC
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378004; cv=none; b=mCPMKl/QDoELrsLIet2MTULNzIqMDazej++U6S8ojdjif9JbyDJ3w7FfWSvcr5Y1hV+rwJPqKsPNYHI2+Foi2Ye6Jn6yasbIdwuodnLKqRzWMxvLwxTssnPZuqiiSTm6XX5DwY7m5kjXKsB4Ft408w5vnJXNJYS/cix6jEKUMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378004; c=relaxed/simple;
	bh=lqTMOawQ9cvFiePggsT3RkX7Iw7hvc1bKaOGO5QvJJk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVt5AsX9CQLiQKm/mxYSOaJTHVwv7iEPd2Oy/rJsslaNBZ1PK9pr+cNEToLABeqbxcNwQ6iMEQPL5C+RNf5MwzuuOiH3GvPjgAsfsNODw7PKGwntsIlQMhOw1kMzbjx4pZ1EO9mchejBPIYFpLkZ+ClgEQ2arvqWaeORZr4yPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ02NIWJ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ02NIWJ"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25e3d388580so868818fac.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378002; x=1721982802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AvBaAyFbm0VJ3HXTsDQFbB0aTQZS+e4BUkRxuDGdt/Y=;
        b=eQ02NIWJjutGTI4bgswTbPrB/f50xzy485XqYsGe+aNPpiIR00AG4w3B/uNGRXA0ij
         4ZW6yjGGuide8vgEA5cW8eC4OPK7Y54ZQWro0zjmWGYH2TxEFXq332Kz1lePjE6Mk+vK
         7mGW6rXkohKGtVt4uFCgzzLTq2X4YoAe4ZrlxqXSKETTzh1DLvyX/p2l8rmEEFcix6Gv
         pWeYtNf7BUVCM+oDCcELJzrZfdN5of0NEPTk1kUbINQJT1f58s+ht6PeNMAn3r4uNmal
         /+0IYOX40HAtL/MBU0syFeFgSjBJ+DG0J18n5a7N+6/CO6KvnUp8p2yQFABu1nf/3M8V
         4osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378002; x=1721982802;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvBaAyFbm0VJ3HXTsDQFbB0aTQZS+e4BUkRxuDGdt/Y=;
        b=HPVAkXonAJS02mJMg1JZX7meff+y/8RESSoqfjZlLfSwYlsppZfORSlXHbvOS74J/k
         n/GeBCCRpAtWCrbWlHfduZIgLQ842DKFxGDD/ZyW2DdNIM7+VogBnHomYaf03PFAspUN
         R1unQOgANJeB1Z8AQjTD3iDv175CI7fM7OC6nM3aECqXt+o9hWHIyW64gp58THQSEnT8
         LPhCzBia/+GfKg0p28k8/nUUUt/w/2hf18hYV/4l11+bo4tHdrHzJ3mwJK9ddm7+xHQc
         hhi5iqbjzTa3pFmQKmyqld6QrOIbw/p2em0mGTHQ6Gxd8ShX7o38cBuYJclJiKYMFFaC
         ju+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9CBBQoUkPdHZHePzhFJ3e1r1RfaYT+oTCKd/qh9hFjISfZD12VCR6lhvbvgmpzgVyD0q+EOfs27ToWfViMpIHIvbl
X-Gm-Message-State: AOJu0YxbnHGpnv986tQrNE7vedkBio6h+Fo1bFKeG7bJwvdzk8T6uEV9
	yhlKYAl4X+6H24t+Oc//q7OjdqE6pG9xYGsmlcaNKDccYq8uvNLKPnbLB/eHAY/CfdyA8c8B8Nk
	IQBBdcoo93w0Dm98YCR7O4MrQPFk=
X-Google-Smtp-Source: AGHT+IGdySa8pGoBDonVrrjHFT6o8acL6et37lXegfY9yWJGMH/hZFdpzjM30qfCkQgz2pTluFMl8w/mV/uUL932Ep4=
X-Received: by 2002:a05:6870:71c4:b0:260:f99a:ba39 with SMTP id
 586e51a60fabf-260f99ace90mr3198540fac.0.1721378002130; Fri, 19 Jul 2024
 01:33:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jul 2024 01:33:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqfrs6ycc3.fsf@gitster.g>
References: <20240715093047.49321-1-karthik.188@gmail.com> <20240718081605.452366-1-karthik.188@gmail.com>
 <20240718081605.452366-6-karthik.188@gmail.com> <xmqqfrs6ycc3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Jul 2024 01:33:21 -0700
Message-ID: <CAOLa=ZQhcb7O4i9E=Xn+9ZbaNhiY0gzD_a2kTqriegF2o-Eeyw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] check-whitespace: detect if no base_commit is provided
To: Junio C Hamano <gitster@pobox.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000577726061d958c3d"

--000000000000577726061d958c3d
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +    - |
>> +      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
>> +
>> +      if test -z "$R"
>> +      then
>> +        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
>> +        exit 1
>> +      fi
>
> The same comment applies as the previous step.
>
> 	R=${A-${B:?}} || exit
>
> should be sufficient.
>
> A demonstration.
>
>         $ unset A; unset B; C=${A-${B:?}} && echo "C=$C"
>         bash: B: parameter null or not set
>         $ A=a; unset B; C=${A-${B:?}} && echo "C=$C"
>         C=a
>         $ unset A; B=; C=${A-${B:?}} && echo "C=$C"
>         bash: B: parameter null or not set
>         $ unset A; B=b; C=${A-${B:?}} && echo "C=$C"
>         C=b
>         $ A=a; B=b; C=${A-${B:?}} && echo "C=$C"
>         C=a
>
> Note that the broken case we do not see C=<value> becaues the
> assignment fails with non-zero status.
>
> Thanks.

Thanks Junio for explaining with examples, really nice of you! I'm on
the fence with this, even the existing change from the previous more
verbose code. I know this is shorter, but it is always more readable to
use the longer version with 'test'. I find it hard to remember the
specifics. But I don't really care which one makes it in the end.

Let me know if you think it is worth a reroll.

Thanks

--000000000000577726061d958c3d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5de5e03a5cd24b45_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hYUpNMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0IwREFDZ2RMMGpmS3hEZTVoZjNXUHRUMERIQ3ZPMAplTDNGcXAwOFRN
SkJsUzJqWGRTcElmT3J4M2VadEtSLzBqaCtMVFU3emtweGV4MzNJUElaYzExSDJVWThuc1p5CjR6
MVNzSWhKWXRTaFhRWDJWN3F0bFZ0SUg0SnFlUWVuN1ZEUG9OVU4rMHJHalhzUU5LdHRzR3U4V1k4
cG1uMVUKZjJwUXZSY2dVRC9PSHlqbmM4cE5vaFo2TDAwcDVJL2ZOTDEzbkpldmI2eHpMUE1QczlM
SXpONnlnQzVhU0pyaQpBOGxGaldreDlMbmd2TWlROEkxaHVrd0dWaVgvb1ZtSFNYT3phajN0TStQ
VmZ0RVZKby94cmUvc1FWck5jS2JRCmJDNVFZT1BuQk1oQTdPRTBuQ3lrUHd4NGgwS2owbndRNW5v
WFRxUXUyVUhYOUN4RDlNK2FuTy96L0prSVlPT08KRGw3dzg5ekJLZG16aEY5WGNlZ2srbU5KMnFG
WlA0K2FOL1dDQUxuTFNaZE9wNXF3alZJZjFKbzJQUDgveXVOagpFamZUbUlxbjNhQXlHUTNmSjdN
ZDNJVUlSYkZUckYzNTJ1S3NQMjArSFA1eVZUK2pUZ0FZZGpWRHlBOE1ncHhMCjZFcURobSs1bklL
RzhXc3Nwelk4ck5vdXlkRmNxNmlUVk5KRUZjaz0KPXRVSUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000577726061d958c3d--
