Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259F1B3954
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767740; cv=none; b=aAF257SWChNqbMgHTbXmUi/zRKs0j+WZDRebkQANEvIK+qS+t6lM0xzdFYVjsXWo4EzATSz8n3fbnlkNxutM+XiSY1df/b8zePRoXJcFs8yM/eKnZJ4mM+SiaT6a0gtglKy2qD/NT5GdHx4TqogLBl71N27nN0NYgsMTaqD2tmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767740; c=relaxed/simple;
	bh=0sCymY1arof6YlFNCRVwreLh2JPPHW7T/reBVJ94H6M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 Cc:Content-Type; b=psTWTYc+ioG9Gvz0pG9BHKGb5YnZyQr8EzkZnI823VUQvhWQiB1hqZ8+mkvWmUATTX/7tZ4soGtnwKsqBm0YhWY2Ezfz44r20KUzcNok4zJl183Goo5EspspZixLFJLS1Fm7MAXX5ZmbGeXoUfd7/lFZvasfLCqoxk6C4LhOTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCjeMbca; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCjeMbca"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so622011a91.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729767737; x=1730372537; darn=vger.kernel.org;
        h=cc:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sCymY1arof6YlFNCRVwreLh2JPPHW7T/reBVJ94H6M=;
        b=aCjeMbcaPiyHufvID/Kfl4nnyOrUpdSV7ilx8eKiFyDrBVi/6cMT5IqT9N2of7R71b
         Dp3Yx/84G7FfK79UV60285vx8AsmFC0m5KOQlKLCMQsofKV+MdwDts1IdrpKKGpiqj+0
         kBfwh20ZGqiOSyQf/9Iy07gio6LVhivoSjw3ZDI+Qwh9nPrnpQVLlXTOhIvQAKtRJFR3
         eKIMGtbs+6FCdyUf46WtBJo7WTPnQ2VDX89Qij2+ZZVeISKoyA/mNm61hWETJcFoTKrp
         0OTYH24mVY0TF9y/0OsvVVeLtejRg6h7gWalMr9XK6WTD75VLE7q5w0aW16KGFvTkyZ+
         qdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767737; x=1730372537;
        h=cc:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sCymY1arof6YlFNCRVwreLh2JPPHW7T/reBVJ94H6M=;
        b=Err8qpouk413S3vuNoLPe8nyVrKV20q5VSh7wm90lW58M3ED0r09aizCqdcsnJjram
         W6PCC/lNO+rYLAVeX4CfmWKGSoLbgm052Jv9smdnrHLC4E7xOk67iJkq823tkA6WLGlD
         DFWSc/mDs+obL8jWUUw0fU6jpwVe2ZN0zgD8Jj70pMaKxRqCZ3slHjx3+YyO37jvsSI0
         cPCJPsAkxsNw4Jc9QYmF7eAZTeIwOiBfiBBvIYyLabK99ZFyprmG7IQDSthCg8RekwLt
         lZVolp7NOtDGboTji4LeZ9P/3Dj1QMk5eEj13l9SXGu5lBQM6E4RPOFNTHLlIyGjM4WW
         luJA==
X-Gm-Message-State: AOJu0YzsEi/UtbyhhM+rDyQlIimxZJ8HFDuc5RepBqhyXIz6gbwjl4QT
	PjZazBfw+xW1Jki3Wmx0sA0xyJQ85Vl5Pu0rMJ3c2ULO/xH9VF6HiWNzQrcTuScPsoAxk5SiUty
	wXWTRfsYwvnmg+KHtJLqF4bGxmB8OUGvv
X-Received: by 2002:a17:90a:5e4d:b0:2e2:d16e:8769 with SMTP id
 98e67ed59e1d1-2e77f480426mt1434514a91.15.1729767736941; Thu, 24 Oct 2024
 04:02:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Oct 2024 04:02:15 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241024105357.2605168-1-karthik.188@gmail.com>
References: <https://lore.kernel.org/r/20241021124145.636561-1-karthik.188@gmail.com>
 <20241024105357.2605168-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 04:02:15 -0700
Message-ID: <CAOLa=ZTJoUCMJhnak-tRpftN+3Txuz-B1_+pF6s8xtZ2BP3A5g@mail.gmail.com>
Subject: Re: [PATCH v3] CodingGuidelines: discourage arbitrary suffixes in
 function names
Cc: git@vger.kernel.org, ps@pks.im, me@ttaylorr.com, 
	kristofferhaugsbakk@fastmail.com, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000830d79062536ef4d"

--000000000000830d79062536ef4d
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> We often name functions with arbitrary suffixes like `_1` as an
> extension of another existing function. This creates confusion and
> doesn't provide good clarity into the functions purpose. Let's document
> good function naming etiquette in our CodingGuidelines.
>

I replied to the wrong ID, the previous versions can be found here:
https://lore.kernel.org/git/20241021124145.636561-1-karthik.188@gmail.com/#t

--000000000000830d79062536ef4d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ea0006e9fc22a3b4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jYUtUTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnpqQy8wVnNLS2hmK2UrcmxFdEdkOFRzWEJXR3BkOQp3WWxMK0drWGc0
MzRSaFZyR1NIY1FzS1FiZXNUYUppaEYyM2w3b2pUcmp1eHBTb2oxWnhicGRIZ2grYWQrazVpCkdi
MHhLUGVhWVNDbllkaGdJbEF4UVo4ZmVFbE9rV3psdERrajVKcFpYaGlDMnV4R3RIdUZWQnZqbGVh
ekxCdlQKRGhFbDFJZnU0OHFENjFXT2JlZkxMR3pnU0RpMWFKVXNLcE9JNVpRMG1kOVRKTGJRc2di
RU05TzVFTjludzdRbgplOVVzS1plUjRiV2RUVWozcnhGWUNhSWhZNXN5Y1hhTTJGMUE5cjB1L3Vt
Vkg3M3dRQS9qcWkyVmNXSTVDY04vCjVpU1M1K0FRcFhSdDJGZ0NFY2J6MFFjbS9nR3UxcE9lcCtj
WG9vRDZpcUlONW92TXYreUFtUmNYT0ZISWdUZTkKRE1DTHg0R2tQRG5OQmlteG9EVFRtbTBSTUdO
SjdYdXIyY21KVkp5LzFWRll4ck5aU2RvL3ZmaGFVR3RSZHE2YQp4Q2l2TzZwMVR5ZnFPVnhMd1dO
azhxbVF1dFIyZTllOHp2Lzdrb1dUYngwZVJzQXJrUFVKTjlnYXNtUWdFTklaCmNmK3kzckJaenFJ
b0dIRys3MzR1UWp2OStxdXg5QUtMaWxxNk1haz0KPWVZQjYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000830d79062536ef4d--
