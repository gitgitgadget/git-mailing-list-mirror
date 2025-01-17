Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40121F91E4
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737104219; cv=none; b=u9m8vJEO1dEGOv4MpMHamgxe+M/fZAL3fOR4tJKkuaXNbcZV/LC9L2dgGQfU5T9U7FIoC/sShP7zbYpS2rIFebq+/ct0Wuc+z0p7YF2/m551AyFnvAgTcNHJzWk8ZEloUr1UntzcLpHYbFOx9usSfmxyOtppZg6rFd9MVWewA18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737104219; c=relaxed/simple;
	bh=wz1pU+QXfxDL6mYjfjtq3EjF7ocFYugZCro4G+ju8pc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9QRn2WKPN/yGxDfN8sUbT+Bg2ljljmwbgZVqLX/FYg2lrKuupJZ6GHokeO+sm+0lk2t2K2B3G6FPYJMBbqInLXeNe2a2c1P4QtBv5A0I0oBlCQAlZBRe93xxfoVTkghiDNu4QOGeFqZeEV/IVWGMsF40OWpjBTBMIcNd5ulYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlG/bTha; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlG/bTha"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4afe4f1ce18so471609137.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 00:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737104216; x=1737709016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oRA57OSpZqHJrgvLNeVO0zreA56Gp8NIlJ0Ds0vak4=;
        b=SlG/bThaW+xg1XM0EYGIuXAYb+UB0SWhjWnzZbI0gRH0KWTCUC75Mzwdgn84wcoBK3
         tqoMZTCIMuIzGNVpkUEVqhqAs7cD/fYlhBaNOdYsRTpec+WWtfqqqOeybT7ar1b3Rvy6
         VXU31vfqG2TeDtYEBm8oW8//qIyQFI56trLNtUgtpIcJmht7wGCqd79uVOSu8ledT0Ok
         7nDqkMhQ5sLFLpFgs1wFfZtA8NTPXwFPI4U/xzaVR2MKCctwkr+b74dARzxNOoxhnnoi
         xrIf693eCGwHphwX6fvwwUH7NwhM4+i5gL/c0V5QR4ZWfETnZPnAX94isofYC48eQcQe
         Hzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737104216; x=1737709016;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oRA57OSpZqHJrgvLNeVO0zreA56Gp8NIlJ0Ds0vak4=;
        b=s6/Un9AJYM1QSaTTlUpr4BuXI4fyZyo7QmYr4Ac2roLlXEuCmZxELSnEHMHf4rj+CJ
         VMU6JCGSXWnOUNwNRi32U4G8NjmmkPl/S7NDIzhZxUgObFBQKX2qmvRSeS3rm54wS8Mg
         4M17a9XxpB5PleGmhN1ZGVp9bWdU5AcjlH6h+3UEOWk6/eF64ufyK2gvmaHD8BWt3C6X
         y+0t2nDnACnpEd4mt6lupgPUFZuw6wkR7LP4I3iD7jdpfrX/zuPzuRLbSF64TnubBzcm
         nV4o1BHETlO8g6UrkA7IEDKICfczfeBistrlAeGhj8tH3NE6y+d07KSMzIZ/ZE1A4gF7
         jUqw==
X-Gm-Message-State: AOJu0Yxae8pSYwfGrkOK/qTHs10iBvixaRtN0sriJ2yxsdVBMyrv0dAq
	YAz7igSi8ASWcB6JnaDHSCY97ooae/i4bjjmdSou+74tijdxYRVnA6D/Xcucnk1PUWvGsf25jU3
	skteU+kqwoBZb1enw13RKAPumeSM=
X-Gm-Gg: ASbGncsvgc54nzJlPduvrLQFYHljTW6dsBFkZTyTzgxxMMph5ZZGddMP13YfSVugriX
	6ChOxAlDt8lUBnBWK47wzPcCwnYs2JzfFma2y1Cs=
X-Google-Smtp-Source: AGHT+IHmkvDB+jfBcsbUuE+x86vDb5PcM/G/f5ie5YyPzpIKC6Ffu5UX7gA67zEvePyqz4rTQ7731hz9/QBNnStmVos=
X-Received: by 2002:a05:6102:548f:b0:4b0:2d7c:43e1 with SMTP id
 ada2fe7eead31-4b690c8542cmr928838137.20.1737104216658; Fri, 17 Jan 2025
 00:56:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jan 2025 03:56:55 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z4kIg8ihbgPPb3C_@pks.im>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
 <20250116-kn-the-repo-cleanup-v1-3-a2f4c8e1c4c3@gmail.com> <Z4kIg8ihbgPPb3C_@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 03:56:55 -0500
X-Gm-Features: AbW1kvY8mQGIPXy0Ez9JL_dJalYSexbGovlbaROVJpM4L1-9MhSqSUV86jydgkU
Message-ID: <CAOLa=ZTGzEwKp7LtXGnHLo1cayryXouy1MCLPrNRCXPzgXk4rw@mail.gmail.com>
Subject: Re: [PATCH 3/5] pack-write: pass hash_algo to `write_idx_file()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c5b901062be31764"

--000000000000c5b901062be31764
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jan 16, 2025 at 12:35:15PM +0100, Karthik Nayak via B4 Relay wrote:
>> @@ -546,7 +547,8 @@ void rename_tmp_packfile_idx(struct strbuf *name_buffer,
>>  	rename_tmp_packfile(name_buffer, *idx_tmp_name, "idx");
>>  }
>>
>> -void stage_tmp_packfiles(struct strbuf *name_buffer,
>> +void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
>> +			 struct strbuf *name_buffer,
>>  			 const char *pack_tmp_name,
>>  			 struct pack_idx_entry **written_list,
>>  			 uint32_t nr_written,
>
> This change was somewhat unexpected to me as it wasn't mentioned, so it
> makes you wonder why it's different than `wried_idx_file()`.
>

Should've mentioned it. This was also modified since it exists in
'pack-write.c'. Will amend the commit message.

> Patrick

--000000000000c5b901062be31764
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 24e1cd118e255ae8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lS0cxUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzhTQy85MW5Nb1VCNTZZYmhPcG1xblVaU1FwaEttSQpPei9pUHBhTUsw
UUZubkgvVWhsSVRPT1JDNHBHNm1SL0ZBMDNOdWExTE1iVVQ2bUNYN0g1YTFDRks3QWdpRVViCnUz
YzJsU0VYOFlSdkpvNzFPM2w4Tnkva1U5ckI5ZVNGRHlGSU12bWRUaDM4TWRUdmRpNDdhWERwVjB1
RjJNSzAKcEJKdXlLVER1NlVaaVFNcU1ydnVZNFAxSEFubFRxazd0Q2FNdGRha0FhR3hTMXpBdk80
WnBYNUpIRXJpbkJ3dQp2ZmNxS1pxRGxMeHRtKzlOWEp6bnhGU0tZWjJ4bWxkMVpqSC9wZkNwQUZG
NU5ucnJoZFBBc0FxQk9sTDlkYUhKCjZMeXdTTkRORHVKV0FITGxMb1p6cmtoamVZeW03OG8rTjRt
WTFuTzVrazZkMnFWZUlEOC9mWTgwQWRLN1FMb20KN0lodXJHVVpzZXAzQThGbFJhVFA4UlRWSm1p
M0VjT1BBSGdQdE42a2tTbm54MFptZ010UnBtS2pwcUlES1FPawprdmxzZXBpbG1BVGpySHJlbGRm
L0YzS2M3YmxMcHhueGZaYyt2TlhrcDQ4M1J4dmVxR3N2TkcvRElVN29GdUg4Clk2bEgzMjIvblNG
YUlCbTRBSGNLV2tzWkpSUmFJZXRHa3RmaWpJTT0KPUdrUHEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c5b901062be31764--
