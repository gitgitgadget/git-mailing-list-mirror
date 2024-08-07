Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ABA1C9DFD
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022974; cv=none; b=Hf6PPSmHufhUUJbdEaUdUYfiRuIuqNvYbcSWvcOP471CSaK5DuG7FZ28cuSYNcH0C9JoJgE80mj2HotH8aXaRxqf+mhQ7d7hoaynPR3l2eS3KVgqq8xyV0ecB27Fo6dVz6rhOTH4beD/IqWpZbi/KI8GmnG6EsLODtx5YiHcfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022974; c=relaxed/simple;
	bh=+aN6/e3BJbiisvyAMoUnBd+HKNDd68AfuM9JY2qmzBw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JO3Yhii6MBj4+RsybBMfl+cnjIXjcGMTVZyy8AEy9MPTYzI3vNoBaWGeu5VuC6e3I6b0C78cj9OddvsMq8PcO+p4+nWC1WA7ZX3fbUx5/vaUKAlr8cIAu93SU5IR3XWjosenKNgm0MeuYSzLAkAteWzqm3LRf5uNprNWNDOv+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIclGSYi; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIclGSYi"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2611da054fbso899027fac.1
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 02:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723022972; x=1723627772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aN6/e3BJbiisvyAMoUnBd+HKNDd68AfuM9JY2qmzBw=;
        b=ZIclGSYiZ6cd/TIMKftK4BZt9I7v9hEIm/Fl3c5zU4Fla+E66isIHazdF74BICB2rk
         T78rCHo9pl7BV58CFtoRGDB10+w4Slm8RE90D0Dq8+9e4t5B/IekgfOYf+2utfCyy527
         arezo+z0+AiN+FXHqk9GUprpukIv0wzz+WUIg3PK8EZKQOwyBf0tQJ6S54rVaIU98GZL
         NBjPs/OGDs//wSUvmguMlps2rXhZR5o3S2NpFhAFN5/bvmO44AkbTB76TRnTHTjNtR5a
         MarEStW7vNu8bEGzr5FTDUhTLd5ItkF/1I5AbuSvdh7dkYOGU8c7qz1zZpfzXyL6B7pC
         iRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022972; x=1723627772;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aN6/e3BJbiisvyAMoUnBd+HKNDd68AfuM9JY2qmzBw=;
        b=S9aXZSfA2FrNfq4BfaBhyl4Og2A8w3cF9rDo8HKtqd/9boKvo79Uhvz4/wCNmocEY0
         Jlxj8D7wAw6PHccCYnur1AyEJ5yBPyF9s94FSsP2lHyrUd6FHEM3NMK3nEXZ9rPqiJP3
         VmfsxiabYq6L/KGpdV8YPt4Wihfo73WqikiI7Xoloz3rAubI3mBSVBMASwXeQeWBcyhb
         WAbujJyZXeJINA1XussnvEDSKUJZO0CK3kjUfeMaXSqpETpIt7q4hJvHHVWdVtzmrORx
         3mGFDqztTQt8SFZtwiMkumlGtxUKanCGopzPAaUB0J2AebFGIX6u6dR3xqZfsfmwqXe1
         gKaA==
X-Forwarded-Encrypted: i=1; AJvYcCVxZRgZxlwyHRFJdL3RCbBCPOQg3oeuGrFrjUHa97RvOcmwJwQd5r3/f5dovQupEblr+lJWJJ8k07SdlobeL4OGELdU
X-Gm-Message-State: AOJu0YyVG5aOlGuVtHnDsE03ctnm7f7tUZIdJ1IHTzxVxVN/ohVpl1j7
	d5jSLN4JvblUjKQfhSiCzJnRHLXWYCOThnhKC95ncBlyBq2qRLcTVbP/k66L+iiBp5ZrFeEg77z
	yEUug6B6eQMEIKxMGrzvBpdTsidc=
X-Google-Smtp-Source: AGHT+IEf5eli96oQQ6dsgnmEyizcENzEqYss+teh3lHKLN6p4wGDQgxgzmDrhVYSNUEF46uvNgF0Y7xR0ugz7YXibzk=
X-Received: by 2002:a05:6870:224f:b0:261:86d:89e2 with SMTP id
 586e51a60fabf-26891ea4b5fmr21687238fac.36.1723022972113; Wed, 07 Aug 2024
 02:29:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Aug 2024 02:29:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux> <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 Aug 2024 02:29:31 -0700
Message-ID: <CAOLa=ZTuJC8HhSZo88PANAC4sntKWPFTprjbF5bks0tMg414pg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v15 0/9] ref consistency check infra setup
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000317c6f061f148c82"

--000000000000317c6f061f148c82
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Hi All:
>
> This version handles the following problems:
>
> 1. Patrick advices that I should not use `va_copy` in the changed
> `report` function. Actually this is a mistake, this version avoids
> redundant `ap` copy.
> 2. Patrick advices I should rebase [v14 05/11] into [v14 04/11]. I
> follow this advice in this version.
> 3. Patrick advices that we should put [v14 06/11] before we introduce
> ref-related operations. This version reorders the commit sequence. It's
> a minor change.
> 4. Patrick suggests at current we should not add `git refs verify`
> command into "git-fsck(1)". This is because we should disable this new
> check by default for the users. Many users use "git-fsck(1)" in their daily
> workflow. We should not be aggressive. However, if we provide this
> mechanism in this series, we will again make more complexity. So this
> version drop patch [v14 09/11]. Also because of dropping, change the
> test file to use "git refs verify" command instead of "git fsck"
> command.

This is the biggest change in this version and it makes sense. It can
still be added later on, but for now users can use this via `git refs
verify`.

> 5. Patrick suggests that we should use `ends_with` instead of
> `strip_suffix`, fix.
>

Apart from the minor nits, I think this version looks good.
Thanks!

--000000000000317c6f061f148c82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3834d3aacd4a4cfc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1helBuZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEl2Qy80L2RpYkoxaktqaVcxTEpHMTJoRHVnKzN1NApqZDVJUkQway9p
M1lHRUxRekNYQ3B4WWJrMmkyYUZQRGdPVzdSelg5SUxxVE9RT3I0K1Z2WFF1RDlyVlk0cGs2CnFn
dG1TaWQvbjIrZ3FwVU1XOFZOT2sxNm5aRDl3enJVbmVzamt5TzFOcnk5ZnlSbHFCdFRaVzRNL2Fz
RjNtUU0KeHhhN0RCS2pzUi8vd1RHUVhBNldoZ1hLRDNPSzZOV0lyMGw3ZDdmeCs5ZGkxLy9GZ3VO
SEFpSm5MQzZUTnRPUApkaUxWTHE1elNqaWN4YXhXZE9KQ1lVTzUzYmExbWRxS0dqdGNScTJSdStm
aHUzUlg2N0krZmtqc2NHaHljMzUwCjVlRnBBRlBLNVJxTTk0TUw0N1Nka1lJb3oxTzhya1R0N2dq
a01oT0RHVmttRklrL0Zlbm5LOW1lb1Nwb3J6ckgKOUdUNUloQ0tHNDNta1NQSXJ4K05ZNlVsQjBu
bDdHL0JCdzh3UWhPMXp1cEU4M3BQMEhxUEh0NFdab0twbGNtZwo1Q2k2ZjUyTFJud0RadFpOZGFK
empQODhLTjFLV3BDYUlhVUVkb3dFaFllb0FNV3VKcmtjam1udG9HMzRnVWd5CjEycW9jNzRFb1JM
a3hZTVNzcGlkSlU1S0tIWGFHdXAxbW5FZzROZz0KPUM1WGMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000317c6f061f148c82--
