Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861165C8EF
	for <git@vger.kernel.org>; Thu,  2 May 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648207; cv=none; b=Q2XVRrJJWRJx/fvImJ5Z7Tz3FnShxI1OLlH2gTcvh1kr0ONwxC7AmW9Bsme1DOqXyGmc8Gw4xZL7bzVNVGIGPIqw6Krv01NXAdT0JY0injGO4j8fg5GWETItgRzmQM/5Nr8TPd1F7fUlUDK8uT+j8uqIFw7Ow/K8KqwK/QNigzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648207; c=relaxed/simple;
	bh=dlnZNfv7Wtz4TBrw7JDjqz8hy0/wOi2diSuklzzvgdE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6V7wD+ogtnsEa9e84LyiLhWp8l1vzLKkxn9aypHd+IyTDtybMlH+uJolPciNS1Z7K4YG95y9YS891Pf4UzpEo2XxkBWw+G3Gk2Gh62RwU1Sg+u6W2/d1i78WYAWEapZrYb08T6WBioSnbjif6zUhgoS6/fAFudAshrq4q1NOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWqGEoO8; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWqGEoO8"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23cd15209fdso1975811fac.3
        for <git@vger.kernel.org>; Thu, 02 May 2024 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714648204; x=1715253004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ8oI6It1Qey1tJVfBLcOdC9ez9VezudaEOM37D0Oug=;
        b=SWqGEoO81wwjRm5wy8II8lqzoLi5fhRREP98QQcKF+L1edkPChVznUOGSaE/ag73nM
         bxxxdB+IG5LbT9Gtoin4Kch+JOShkkdRJV7SxHdcCUVs2e+Ly+1grmp6NvtygEasF6Xf
         e7AnQRDhYZy1LPudbvcXDGLNdhqoJkEC32vITbjPZ1ZAhSoIuBXAx11Mmp6ZXG3ulYOW
         XIm0y59qtHCpIHcJOCCCs4oXYR3jd3OsAQuKfi2QllkwvH1aTOEwkwWuFuS+fycVVklw
         YjwkmtHli02C7HdRF6xI0HeC8b3VWK58c2o0KbsrlXe9F6BHWWmHPA8g5ZT33xPFJyjb
         wkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714648204; x=1715253004;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ8oI6It1Qey1tJVfBLcOdC9ez9VezudaEOM37D0Oug=;
        b=GvnsLgeGd562AbCvsstM1gE69CcMqlQ1j7hELX6d6UYfmhzR89Fk1c8OUYKKXK6ITB
         E3wck74LXelYIncYOaya2B4QitZO1uEhQSl/G/HjR6U8vPnmqPr52Ttoy4YNhA+/Zlq5
         zp46wtmlbbUpRxPXByCVp1K4gD/PiJXvY5NunWx4r8qMc5GUfFrp8pT0Ui67R0DxMu3W
         BYNRv7QnNLbXM6z5ReqfEhkP5RH02Ckorbz6YZNcLVMub+71cKO9eCYwzE7E64306gFn
         Igkrnu7syIsxxRWyMnvIdP/voOgx8nub56l6d7K+AO/XukQURV6kktp9KoFSW02QceGx
         bMgw==
X-Forwarded-Encrypted: i=1; AJvYcCWk/VsTMz9SrWmuUtaQjpSSl2Y3AT0sukG6+GN1+Q9U7S2xltH9SpreeMh0PZv7YXlhxyCdJkpXp9P2ZYliwTm5xKjn
X-Gm-Message-State: AOJu0Yx0rNtG17ggjFQuzLjyuwptOIe2ub6OdailIxiJZuRFtxxH5Nnb
	QRfy2leTgO9nH1IXQXCZ6PJ6fvbD/2x4FW1yRQjuoaMDoncJ0mN/kGX0CKfMeGtGLHNZzWzvI8b
	lAYw7eXhkoN8kEe6cy9NTZAngIjc=
X-Google-Smtp-Source: AGHT+IFUZ8TnHjCvpznpAnNSJn+Mp0JTy8KBf3uja4FJyhIUkPPCKCF0HHQXn5snlAdap7CewkBrN24YboiS8m9jHYM=
X-Received: by 2002:a05:6871:5228:b0:23c:89e9:5bf2 with SMTP id
 ht40-20020a056871522800b0023c89e95bf2mr5962707oac.45.1714648204556; Thu, 02
 May 2024 04:10:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 May 2024 04:10:03 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZjNFC6A5j5hMQ5VA@tanuki>
References: <20240426152449.228860-1-knayak@gitlab.com> <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-5-knayak@gitlab.com> <xmqqbk5pgke0.fsf@gitster.g>
 <CAOLa=ZQkTM26wmGgj3=Pz9p7-nFAWQdxCA=RjaJVSm2m8zn7jQ@mail.gmail.com> <ZjNFC6A5j5hMQ5VA@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 May 2024 04:10:03 -0700
Message-ID: <CAOLa=ZQfm0xgOBuOi8__SKqcj4DnTBoPLgvBtArv4asuZ7UUcw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] refs: add support for transactional symref updates
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000025df17061776a5e6"

--00000000000025df17061776a5e6
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 02, 2024 at 05:50:47AM +0000, Karthik Nayak wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> > Karthik Nayak <karthik.188@gmail.com> writes:
>> >> From: Karthik Nayak <karthik.188@gmail.com>
>> >> We do not add reflog for dangling symref updates, because currently
>> >> 'git-symbolic-ref' doesn't add reflog for dangling symref updates and it
>> >> would be best to keep this behavior consistent as we would move it to
>> >> start using transaction based updates in the following commit.
>> >
>> > If we are not changing the behaviour, does it deserve a four-line
>> > paragraph?  It is not like we describe every no changes (i.e. "we
>> > could break the behaviour by introducing this and that bugs, but we
>> > did not" is not something we usually say in proposed log messages).
>> >
>> > At most, if you want to highlight that behaviour, I would expect a
>> > brief mention like:
>> >
>> >     Note that a dangling symref update does not record a new reflog
>> >     entry, which is unchanged before and after this commit.
>> >
>> > As a reflog entry records name of the object that is pointed by the
>> > ref (either directly or indirectly) before and after an operation,
>> > an operation that involve a dangling reflog that does not point at
>> > any object cannot be expressed in a reflog, no?  It is way too late
>> > to change this, but it would have been interesting if the design of
>> > reflog had a room to log the change of symbolic ref target as well
>> > as object names.  It would have allowed us to say "HEAD at time T
>> > pointed at refs/heads/main (which did not exist)", "HEAD at time T+1
>> > directly pointed at commit X (detached)", "HEAD at time T+2 pointed
>> > at refs/heads/next", etc. and allowed us to much more cleanly
>> > support "previous branch".
>> >
>>
>> While I agree that four lines may seem excessive, I think it is indeed
>> an important point to note. Mostly because this shows that when doing
>> dangling symref updates, there is no record of this update. The best
>> situation would be like you mentioned, to record the symref target
>> changes. But even with the current design, it would have been nice to at
>> least acknowledge that there was some update done to the symref. By
>> having zero-oid for the new and old value in the reflog. But seems like
>> we can't do that either.
>
> I wouldn't say we can't do that. We already do log when symrefs become
> dangling when updating references via HEAD by logging a zero OID as new
> OID. That is, if we have "HEAD -> refs/heads/foo" and you delete the
> latter, then we create a new reflog message for "HEAD" with zero OID as
> new OID.
>
> I would claim that the current behaviour where we don't create a reflog
> entry when updating a ref to become dangling is a mere bug. I think it's
> fair to declare this a #leftoverbit and handle it in a follow-up patch
> series. But it would be nice to say so in an in-code comment.
>

I think _can't_ wasn't the best terminology. My previous series actually
added a reflog, but I noticed a bunch of tests were failing and I think
it made sense to keep the existing behaviour.

But addressing it as a bug would definitely be a good way to go and fix
this, I'll add a comment in the code for now.

--00000000000025df17061776a5e6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b94a91539d7a7015_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZemRJb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnh6Qy85SDc2aWVOUlRHTGpoaFE1bFByZXp3QndCWgpReFdRQXZSYWpr
U0x1aEZBQTJONVNVQXpBa2N4Q3dZRHFodDJlb0lEeDFrN1RjWlhYalNLWnRxVlh2N0E2WmtqCjc0
RWt2elc0aDYyUFd0THRBSnNQUjZRUVY0dU4xeS9KMjFnVFZSeXVNd3RpY0ZvUkdCZExUc21ESXEw
Q1lsYVIKNW5uYkE5ZU15OFRpQ0VLTHdzbUd6blNmcUFFVUhlcjJqNDZaTnJwamFvcG5ocXBEd3NX
eHp1dVV2ZTcyUkJqOQp3ekQrWmt2aVhQaXNBWWxpa2lXK1paWUs4N1VGL0RScTMyWUp0UzN1RW83
ZmJ1VnBNWEt0WXdkOUJJSWxFV1JpCklNQkpBckhxRWNhdndzUElDejl5UHY5ZmUrOHlWWFpDWG50
aU9TWEhvOVFkdTlkcitEaEdTM0NHRmFGNlp2U0IKbzJLeDF5SlBpblBmZHg0MGFTVXVRZ2F0UjJq
alhBalpoc3FKYTFieU9IMEt6dmtnZjRoRytBRS9RS2FZNzA1YQoyRlhVTTlzb05QejN2ZVVlYXp2
enUySDhOMzFpRTVYdTRJL1pGWHhEdEtxZktURjRDRXpMSGgzMExUa3NFdWtZCm8zRVJzMjVIVVJS
S09XcGFwcndlK0lMdzlLS2hyUHpjQlNndS9pVT0KPVd1N0cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000025df17061776a5e6--
