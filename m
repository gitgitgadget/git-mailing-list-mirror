Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA515E5DB
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742036; cv=none; b=mAqjpc2y3ZoAl6V8h9ufq4bAfJW5T+HTWN0DRdkWQhZSrY2uHaEFFdS8jaLNsU7hE0tXpwwW6Q9BUwqFID342UcbmYahIiD7Kp0m28GivnQfNRG1BO2nL2akO6Bz/SPiQCzRAgP8AqDgJWAFEUylVHEa8TG18w3xNYpB2ZaUVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742036; c=relaxed/simple;
	bh=PuuSwfdOKGdzzz1sgWu9iUQxnHwqFvVIOnLymsqpc3I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oasbn+2JLB9dzeWVeQaRFB64KNRTA1mMaulVrkvNeomf0LGde8/VRErx8KuXiSE1Z2L5s/UFtTYuvkABttk41j7b1WwKfgmsHcWUMZ4TO4OVjm/FqKNMTfFR6gNrGzZJ4gV/vTtuq7upDWTkWDcl7ZE93O+kwvNR2Pi1/MNYc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAEgG5pT; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAEgG5pT"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-254efc9ca45so3698465fac.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718742034; x=1719346834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfblkyRYh8WSshEZOKPuaRURKPD7bRE6BZScMPBG/2o=;
        b=CAEgG5pTvATCAE8wMreSehafxvkraCWT9Bz0D5BugFOaPZl2kBJ1/vMOHN+dSsz77P
         1pnUCb+yruwS9wMZpXqdGEJH7jfd9dcBTf4bnxOltg2sPazsMnqAgtu2eRWWkUH4ANLE
         wR5mrLje59eNQP/RD/zJYed/Pgjmmh9jRs7AJYLO5CWbx+8bygLl+u33OJX0eC1tSIsM
         RTSsjxiVNjKnyaXNQJU4zmXKL2WfvufqJ8+RUKkOefqchB8Q4ZimxSAfajhUunN1BWDS
         0cQfJbUs23/WIe+s7WtmKoN2DVI/HTOFB1FYvh14HrxrcpSaY2aVH5kmHkCUczPdz+NP
         eMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742034; x=1719346834;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfblkyRYh8WSshEZOKPuaRURKPD7bRE6BZScMPBG/2o=;
        b=ceSPM3zSsjDjU1Tn0PpBbQr99AdFqlgYIP8XAUivbxYqDQL/tCRfHkG9g9Fz5zLkif
         qNiAAKXiNE3IO2evVl2smoVjTakaRTEkgnBzxcK9pX0+PZynUcxiKZw4CAGtJLYe8ifC
         oAL0dcssDxH1RLntPlkIgm1RUJ6rTLdNE0z+LDqmRClK1lH4zhhciafL4KV5baOExvRC
         qrwRlTd5pP8ocb9qqpdruDpJk6yz7n1VNHeZih2TAeoW/U3NRW0SQuur0o47sa3EdR/o
         BCHZsD+dt/oWsmeFLUtED2eygIfJPj7VSiV0CIWVNtUPaDc1L4mIrhpxDq6wVNtVBFrd
         Cvbg==
X-Forwarded-Encrypted: i=1; AJvYcCWmJ5McUhvjWrseYw77lvoS6mIUyJgBCJC/N0iKqCHPVmFguqC9r5xu8kaIe9FCsIXsPGhfSZ1rLoykTZ8rNLeTIfow
X-Gm-Message-State: AOJu0YzSbSQRqWwKhFockgPaX78lwMpOiMf3WFmzaS4ao5NPAcNcBIwe
	isUmijImFTwefvyn+2Y+U4l1J2TIuh0TNoV/pKTjcM67WtWqaNAQWZhsqFY0OnEyLzm1QXDKljX
	DxOqtXtgbchucle2vw0rskyBP4AM=
X-Google-Smtp-Source: AGHT+IE3+ArEr5TRz/y6kVH6nHWWdHCWSkM3Iy2ugKHtTAaRmNBT4ye4c7ulTpzUsnDa36t7Em9FoA0aIBA94GU1Z7M=
X-Received: by 2002:a05:6870:d0c9:b0:254:a57e:1aed with SMTP id
 586e51a60fabf-25c94a005fdmr1003506fac.26.1718742033885; Tue, 18 Jun 2024
 13:20:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 16:20:32 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwmmm1bw6.fsf@gitster.g>
References: <cover.1718106284.git.ps@pks.im> <cover.1718347699.git.ps@pks.im>
 <7e023a335f500658b09a0037aee48eff06c668f8.1718347699.git.ps@pks.im>
 <CAOLa=ZTq+sQAtSiQm9xmdLyn=T=u8Ck0oXEBFLnJvH+54O+AHA@mail.gmail.com>
 <ZnEYNzLue3OIK-Ul@framework> <CAOLa=ZRA6QDojbvP6btOGX5q1Pa0DivBZA_J1gojF1gJu9aENw@mail.gmail.com>
 <xmqqwmmm1bw6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Jun 2024 16:20:32 -0400
Message-ID: <CAOLa=ZT2iTRve+LbPDYMrZim4_tiL7rCofetThBhzH_2ae-u_g@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] global: introduce `USE_THE_REPOSITORY_VARIABLE` macro
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000064097d061b2fd036"

--00000000000064097d061b2fd036
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> s/# define/#define/
>>>
>>> This is in fact intentional. We aren't strictly following this in our
>>> codebase, but when nesting preprocessor macros into ifdefs then we often
>>> indent the inner macros with spaces.
>>>
>>> Patrick
>>
>> That's something I didn't know. Thanks.
>
> Unlike borrowed sources in compat/, in our codebase, such
> indentation is minority.  IOW "often indent" -> "sometimes indent".
>
> A quick look at an early part of git-compat-util.h would show that
> even within a single file we are not consistent at all.
>
> #if __STDC_VERSION__ - 0 < 199901L
> #error "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."
> #endif
>
> #ifdef USE_MSVC_CRTDBG
> #include <stdlib.h>
> #include <crtdbg.h>
> #endif
>
> #define _FILE_OFFSET_BITS 64
>
> #if defined(__GNUC__) && defined(__GNUC_MINOR__)
> # define GIT_GNUC_PREREQ(maj, min) \
> 	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
> #else
>  #define GIT_GNUC_PREREQ(maj, min) 0
> #endif
>
> #ifndef FLEX_ARRAY
> #if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
> #elif defined(__GNUC__)
> # if (__GNUC__ >= 3)
> #  define FLEX_ARRAY /* empty */
> # else
> #  define FLEX_ARRAY 0 /* older GNU extension */
> # endif
> #elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
> # define FLEX_ARRAY /* empty */
> #endif
> ...
>
>
> We may want to eventually fix this, but we need to decide what the
> desirable layout is.  I am not sure if the indented version is
> easier to read and maintain, but one thing that is sure is that a
> mixed mess is harder than either.  In the above excerpt, you cannot
> tell if I quoted everything related to FLEX_ARRAY (in other words,
> if "#ifndef FLEX_ARRAY" is already closed in the excerpt) without
> carefully looking.

Perhaps putting the options next to each other is good way to think of
about the _desired layout_.

#ifndef FLEX_ARRAY
#if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
#elif defined(__GNUC__)
# if (__GNUC__ >= 3)
#  define FLEX_ARRAY /* empty */
# else
#  define FLEX_ARRAY 0 /* older GNU extension */
# endif
#elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
# define FLEX_ARRAY /* empty */
#endif

#ifndef FLEX_ARRAY
#if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
#elif defined(__GNUC__)
  #if (__GNUC__ >= 3)
    #define FLEX_ARRAY /* empty */
  #else
    #define FLEX_ARRAY 0 /* older GNU extension */
  #endif
#elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
  #define FLEX_ARRAY /* empty */
#endif

Somehow I feel the latter makes it a bit easier to grasp blocks, but
overall I think its more important that we pick one and perhaps add it
to 'Documentation/CodingGuidelines'.

Also, I did look at your response patch, but will leave it for someone
with perl experience to review.

--00000000000064097d061b2fd036
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 460d8191d638428_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aeDdBOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0NRQy80bG5xZHBZK1dlQVdIbnNGSnVWSHR5MUUyQgpkZ1E0bnhCYlJ3
OEZHMFpRWW1qTFdPV1V0QXZPTHZ3b1dxZHpKT1ZTUWlzUHppL2QvY1RRTytuaFVPOFEva050CmtX
b3o2SU8yQ29iSTVJOTFvM2piVmJiQjdrWTJMVkZ2VXFuVlFtY25LNTVJTmRIaXprOHpFNEUxaExw
dVN3OXAKZVY0aWlJOXEwQUw0Zm8xTm5vSyswUXJCWElZOXlTQUxkaVo2M1NIb0ZHM3ZSaDdpdEhs
cVMwUGs0U2pRMWp3SQpFUEkwRUtqazExZ3cvcDVJbTVibkw4Q0xoQ0lvYW4rRzhxeW9FbzJmSkJ3
M2ZOVXVHKzFCMHRmQlFLTTd1LzBOCjJzK1VTZ01ITGhxS3c4T2R6TGZVUk1QbzQrSFhVZHJKbjdX
a0d1SUF5MzQrNGpqZzdPc2VRR2JQYVN1SVlHbGsKT2ZacUNGOVhBdWdLUzdXU042eERtd0tLTlpq
OVdGV2NQNTYwR0NqL0ZFWm5mSk1CYlFNdFl6VEVsYkVYU1VBaQp4eHhMaDc4Y0ZKU09HVEljSFE3
d3NCOEhtdCswRVZ4K1dmOE9iMDRuN0FVTnEyRHhNcXREcHdnSC9BZ0N0TGo0CjAwdHQ1cjg0UXY1
bG9pYUppZDVrRjVFYzk0QWJqUmZiVllOenhHcz0KPWMxOWkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000064097d061b2fd036--
