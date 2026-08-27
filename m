Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485733DC4D7
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828096; cv=pass; b=lqiV+Br0UjH9A2Tar3JSRQAH04kFT3LiurbciaDUmy8fn9NYhvntBpRRHweRKu4T16MgRo+grnp3dbD9EZ8LjEQ5OKNjNBlDsHIld3kGobu2wHWjcL+IKwo34mXhLeyhPzvy0TG1L2+GE8Nz9GPMhFDx0aEphKLL1NgSqP2PLjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828096; c=relaxed/simple;
	bh=Trkey3at87yZ5WCcFvThN2UGvJC8Z7A5ThefQVyzW2g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=OVhwrMAZnV/gNSBqc1UejVE8CNj4qdrI4gx73iuqzAmeSTgQ09qaFg/h2WDi7u3JC7u17yQXBKo+AL2WZyUi7WlxDJL7MXAOhnObtm9Jh9SyfDYd3j2Dqv6kQNnw4Ke1ekCMIj3RV60s/IjsByCH/yLA7MMqxY9Ck0pL3f8TYfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNk7AQfp; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNk7AQfp"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bf9466867cso834926e0c.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 03:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787828094; cv=none;
        d=google.com; s=arc-20260327;
        b=UnSwaMdQmC/LTM64ftm2eBbu9hzjHUl/ZBt5im4CqWIMhAsQs/3YWHuzKGIqNNLavW
         6w2x5Np4dmHIGvpq/W6EfsXfJh727R1rMvd8TRjdAqGKYTiMX7nWBeXQD4/IQT5DH1iK
         cGC1Zos0URiEwVEKX+llB5zM3L12exVhhmC9lrNdqjW0So8ThtMGmbKhjLLa0UlhcVb3
         XpZ3NWHtY3rSqMXtbYZXIFMxxMps/FquVA4oSqxpy4rVwkSWSHl22N/zsMtOFtlzbDRU
         7LjksJcHw4DsB1zGWXkFyksCrLf66DS6oMOwFapd+gCNMr4ds4jMDLkdOIs2zgbcNFov
         O3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=Trkey3at87yZ5WCcFvThN2UGvJC8Z7A5ThefQVyzW2g=;
        fh=5ud2vC9LZ83DzfYcOX8K4/q9H9AttmJrkOdv96YevgA=;
        b=aGqqza5Q9thMgSkZPL26JfPBDHui2IJfHhlGYYY5k6/SiaMSG+5Jm0etdXO8Kj6ekF
         u5UWopD7k14LWRMkJEUOZ96ToGjWNcLjS5Fy8P3BC1ree/4kt8EB2ozZLwZsafgBt8tT
         2pkVglu+Abz8i7/lc1i2JO2ZVej4TEBXzM7UYK7SZGS9BPveVDI3o9mIUhfbMxGoqq4s
         RCJeuMdz2+nhDgvQfvIU6V3qShlBSdQjQr8hoPGb3KWTjRBL2rATzRi6vUiMjGMUcDQL
         MEgWhadbDRXdAft0xtMo6WVJKzdWwK+pY3ex8ut0TA8uBJ2jIIQKScClQQNJ4L6Pdw0Y
         7pfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787828094; x=1788432894; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Trkey3at87yZ5WCcFvThN2UGvJC8Z7A5ThefQVyzW2g=;
        b=VNk7AQfpxeNj374XazywfRb//SUwjUiAA+IVwj02GD/L4SdO8sY9OTp5EHgU9zbxkC
         wzj0SFOziVn0zTt4vC2QcfniD3Z1EgPg/b7ONQ1J9MDVJjTPgHDX1LucKSNC6LzMNiKc
         y/eXojbD00ALuOc65xc1UmKKH+9kBRZ4xizBG0Y+ujA0f7V6555HOAEh+9ePjWkqRYfC
         CpfmZQ4j7ca1VqTwEVTEiYdpabcFiiIZHWxCeCg3W7nxJ7ayum0rg9YSID/FZKNpqogx
         DVUhX8w/UiX/09I4EmHRO/gsK1scHniUOKJziEFOnDKHQOzdg5bkTZfeu5Gyke6HPBda
         UtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787828094; x=1788432894;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Trkey3at87yZ5WCcFvThN2UGvJC8Z7A5ThefQVyzW2g=;
        b=BeOP3IJ4igAs3jVHjuXdkcPafApm4tEuEvnfgUP8bvJNiaqn7e8FE7YmIlKDaQ1zd7
         pSu/oC2lBZ64GF1WQCGepsIZZWbD3Nc1OF4H669jJPP4aV7Lr0brRNSdL1lVMMK+QYXC
         DfqyvJoWE/D7ORMT4CJea1Pd1s9wuj6+o4sWAURcwskaRG/jS8ZJURL+ayM1bKDg5Qqe
         VeneNCIPM7YBo3q44cLI512TWuyHIUUoRSIr5jiq1Zdhb1+l85GVc2zZ5jq1/IOrQUVR
         yrCKzDZL5ycSUdVq2WQZwxEOqvyyQo44pGrMvtsX5W9DY/beKxzmqNPEN3rMqzNdn1+M
         EeOA==
X-Forwarded-Encrypted: i=1; AHgh+RoJRAdgpLpY3iKs9wTlyRrKrXN0ZJIhI8AUaOCBnQwIK0Cjizdl81EeZDysSs5u8DsJ1CY=@vger.kernel.org
X-Gm-Message-State: AFuF++kGSzXXMJc2Tt12xbLVIjtd2XS8Ow1U7U9ykCWiddNgvOfgiI8E
	Tq8/1x57gQaaUvsEz1VxITj+8B91y4GPucZFb+B44DoB+YPcVGd+hQctwVzmXgbKZx1GhqUL9AL
	n1ABXtduk9zjGSilWGOBJvTnQhnUpKRWJIF7P
X-Gm-Gg: AR+sD10aw82mNvR8zSh/SHHBSqCQgtijqIHghAKWJ2WMQl/Z9a6GTfZiDv4YNnagCfz
	tembVfUkEC9+rprEQXSECCIjTtI5+uTi2INsOR5/uAYbYd1ZDKvHrW/+7XkvX9rpDmLcANBxl1U
	FidBxhXcHStQVlMoLKHQ3oG7JOX+aXRaNS+C09uVFSWJVdPEXqKw1nR66oltW6emKRoVv0VMXdh
	G+9nzHeq9h2n50w5NGen6bj/57ULaH8tw9eYKu6Sw4qaSNSuG3k9XW+AQL5jTM21g8pkCNegnEC
	ugUG3hHqF3rz+1OzUFQsRDWr1ZHx9eItSwbYQ1T6Wvxr4GUP7O4gYE2QXYvJhnuV6yJgFRwE6SV
	pjoZHktqGjlomIuzuVjVjQoeqp2i3uVh51Nw2qEHEuvqJMg==
X-Received: by 2002:a05:6122:8c8:b0:5bf:a181:d46d with SMTP id
 71dfb90a1353d-5c65c1937acmr5877045e0c.3.1787828093870; Thu, 27 Aug 2026
 03:54:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:54:51 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:54:51 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-8-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im> <20260825-pks-odb-source-fsck-v1-8-b756de0bf24f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 06:54:51 -0400
X-Gm-Features: AcwNN1UZXGHBLktCfJU2XyESbD62MY4ksa_TFW_OM9KZ96GinT_ePiizEQGO-Fs
Message-ID: <CAOLa=ZQwhpPMrgeLW8W0pezH8VFrqDiiAfet3G_jDRQDu_KQUg@mail.gmail.com>
Subject: Re: [PATCH 08/10] builtin/fsck: move bitmap verification into the
 packed source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000074871b065a052a65"

--00000000000074871b065a052a65
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The checks for bitmaps live in `verify_bitmap_files()`, which is called
> by "builtin/fsck.c". These checks are obviously specific to the "packed"
> backend.
>
> Move the logic into `odb_source_packed_fsck()`. As in preceding commits,
> this means that we now properly honor both "--connectivity-only" and
> "--no-full". Furthermore, we drop the dedicated `ERROR_BITMAP` bit and
> instead use the generic `ERROR_OBJECT` bit.
>
> Note that this change also adapts `verify_bitmap_files()` to be
> focussed on a single "packed" source instead of verifying bitmaps from

nit: s/focussed/focused

> all sources. This change is required as we already know to loop around
> the sources in `odb_fsck()` itself.
>

[snip]

changes look good

--00000000000074871b065a052a65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d0281032578cc1c7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xUUYza1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHJxREFDUVZpT0psbjE0UTNFczBnMG5oMWZ3U0RXSQp6S0VsYzAxU0d3
YkNnaCt6blQzVENkUTFHZmQzUTV0MVovSmc4UDYwTm9JRjl4ek8rU2VPZ05MSkRKV1JQemxYCk9n
MWczdUg1MEwzeHVRa1BZbk1kQkFXMzlibVFuNGp6UHRDalEyeG1Kakhrc0pMdmZCakF3MitUR2NE
M3duZGgKY1Y5WXdHUzNoT0ZvZUM1cGQ0RTJ1RlczNGpmU1pDZUp1dTV4MDQ4V3pXRzRXM2tiWW1u
d3QwYkdneG9NZEY4YgpyR3ZmRit1cHV0UDFraXlEcElJUDNhd1RVSk1uM29nYS9LYzZnRmFxVFR0
VGVqTnpPbWZjSGpEWFFpUDFUZE1vCkg3cUFSMTEzbWRpV1ljV2x1Q3UzKzNPRjB2azhmOE85Y1VP
cmZERUtUQmJpOXZ6MTNRamJTc2N6cFU3eUZpTFEKT0JPWE9VRGFhZWtjc2d1N1dicGJRa0xqdDUr
ZXRkZkhPTVBwS1NjSWlBUlhkdUNEdklKUTRIV2tyT1NCeTh6OQowWGhnaW9BOGFneVBJV3hVeGNv
Q2JUQkJrWHlBQ09zbGlSb2ZuSXUxdlJHeit4MU1DTndsZi8wNDJyVjRrZ0NUCjk5aTc4SVFpbjI3
VjRpMU9CWW5TU1N2YnZHZld4djJIZ21HdTFMMD0KPS91QUEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000074871b065a052a65--
