Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792824486;
	b=jl/YLmmHreVhjYFTqRxkKBLoCVKj1ODrcggRax1vRa2FJCG8ogPiEoK3UBwzS4tpEBvT
	 kZRr39FuGg+hzIqP+v+8f0/8iiWiIup9t4PPwGe/r5NK7s/mKDFH2TETeoazTh3IoXdsh
	 CSsNobWlGYKzXnmy+rddEYm05TTcsMjKga6wcFM9duuzH4l1M+YIx+ekeR5JiX/r0MJce
	 +dioCv06MpW8govVEdsVTz/zNQqRcYW046Q/9OWU1nV1yeBKGDJ091cC6tuddNXUhrNPJ
	 VHlTalHiUj9U+vTw/LLim+6Y1nm3DTAFJafrvQZUUizwuOSYVXYptrSqxMPLHKkEJ2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=zgmZYCC3IfdtHw4ED5yLgMWZaaafegMiS3wdKRm67lw=;
	b=Ghcy+pwsnMG5sF5SIijj94btLLskWhWCkZdv4KvuFhdvt09mA23xOwC/ZuEtyhqu4h3p
	 mLsxHhIOWd3elLsTgoN03GAtWJT262pM7fYUB0pXSohLgPPA4SF+L3lQAMd4N/QZ/qI4F
	 g24gZT6kpd1AaNXKEqQAYFQ42CEbwpZr9CjipRbEvihWr92pIOSBVvgLc4INaHP4Vy8lA
	 J1UczzXB/HA6fk7OfT74NW/0qgm/Pt0Q+PbmNHAmWEFxJAbNt92vxYhcZx9r4gtGioX1a
	 sRhf8nnOLfTqWYlxPg3I628/0MzZ0SQXVx1UD/RtkSwpP3sQkIf18AwpUtrlfFgYYuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qIyYpZ9x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFDE606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 06:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBFDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qIyYpZ9x
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6d7e06dbcccso849096eaf.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 23:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792824485; cv=none;
        d=google.com; s=arc-20260327;
        b=EozR3Q7hVj51TFtwv+iAFjF29XXwiTHlnkTMKfoQVsUaZVdjGPETVakMMYjMPhIrIs
         XlV8AlClVci+GllU35Q+w6hWr/PwH/q/9hVHs0zAZRnc6QN76YKp8Q0xThNQuWeSUGvp
         rgUnUdl9EDBtVe9yY4tMaYo2BPLoxD5Eams9TrGDEdPq63OovX4fcIQ8vO9AoPEH/dhg
         M8tHC0TKZj1OHqnphhBioWi+ZnZ74kHxKteYU5CVpy9QeCPBZfuVUHrune7ldgS8bKIU
         piHpmoTqa8Ck3FzpsUAm3ln6dL+S9o3IXBl/4JoXXh/NoX9331DVrvSJq1mLjHv/maJx
         f7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zgmZYCC3IfdtHw4ED5yLgMWZaaafegMiS3wdKRm67lw=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=FLrgfm5X4HkbuWNDQ1gPOs8lBp+ilHhCYqb55u8/Jvs7YiW9PSrRwSY/iHQWa2d4WK
         rphIzeSBp5i0lUGvAox/oYodUVR06zUeMrV279FSsKiQayipR5JwD80UwkWK52a7pVG2
         hz5rnopem5nI+PT2+v4FSPAcaf+s/aqID/lJh8HHY8om2c97PUVm6q0GQ2OYo4KUBIQn
         GSrqoOJGgX/7672WSTr9EWgiIBwV2QS7ZsrKD007bFW+K1cHDglrJ/1lMALDy1jeOYwL
         MhtyscDdqBljAYNeQ7f/BhCcf4XiSmF8+X4K1nn0bVrtm4hxyEVrZ5dWpp/yy7tvEZfK
         NrQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792824485; x=1793429285; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zgmZYCC3IfdtHw4ED5yLgMWZaaafegMiS3wdKRm67lw=;
        b=qIyYpZ9xhSvC3TpS7n57G9BtI9h1NBDFUSSztR+40jeu0D7IJBApYWbadaKZUQk9Zp
         g7vw55fSoPpS4OUqYJYlPtvgEbhBUhoNyc6BLJ3hrR29uQNqYv5PupGnZsiTSZ9Vueqo
         0ndhOsaGD5CL/3IKIgRz+wbDNt6BidJm3ANUGMsZ5MIB9OvQ7hr0ytHIe0sZv8fCViXw
         eRHdUhSt5BKEh1ukC7M1fEmjYOeZbFxllM3LHNzuxzTxN0mz3io0VJGApkRZ2HmScsfj
         FxOZKhfuy+h10fmk7UfSGfyuwFOT9gprxM68qTOncfl6WY9vJrLw68XCqpHF7dPkv3Cx
         5bRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792824485; x=1793429285;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgmZYCC3IfdtHw4ED5yLgMWZaaafegMiS3wdKRm67lw=;
        b=jAT/VpC5HouyZW94P91mDA/Cz6xuVR86IwNe7793rao/0AVElKFAOpih7c9lXgm85/
         We6GzQuuWHBffyg/z57XWMNz6qfS0LZFShfes2DRCmNGBUHFIAtoQuRs0i4PRh6re54J
         bWMfJv7PscPUp4FhNkIMNoYYG8mItl7Mq+ZAvfwG+JZfrkkw0RTTAywFQmxWGjpYtTRp
         uAyNCx+Imlu7GjpzDiGolxxbAR3SAsvDfuIvmcbP7eZPeXIhJ6E1TzzQPkrACN8cm0mx
         tEm4K9OLyo45+E/g8Rgp2BXNZ6EBDw7jLstSlWAxlnVh0N7pFcqQUuX30vao5BVCDJmm
         BDMg==
X-Gm-Message-State: AFq9FYImcHQYH9imBjmqbdw09BnW7K/Qzb/2ogYC7OKVjq4V7AQYjoOg
	46sHEf5l6vQWugb535l+RyZSCNUzSgHC+UuXJUvn/RqA8DI3ZGdHwrMhZJlnxacHvV2WED2dMT0
	ojlKkUpHY9m6K0avVG7dXCaEmBWFJHhy8pTUVJSM=
X-Gm-Gg: AYBFou0STuUfuenql6oGVxUU2OhHntr8+20GIL88sIR1bTOe7uxZ/5TFpklQ7WFdLd9
	ztTPA4ewsERLJtTpdjCEMURACtyjtoJ1fWmYR20atzB5e4IwSe5hsqctlqtVpAoYbbzQQJFlwGE
	7GiulJeAUQIBGpp0l1wsk5rT4H80PiUbTQwWq/6Acy86ZDtXPkzLBViFHzRBF/KjElOLxBJbe7E
	7mhRQGtBRWBzAY+JdSS1QM1B0nhsOw6JNxKHM6FweTM63YtuvcHA3b5GwaSF033SaE2zz09Td2N
	Kk/aKAXWBbJq/xXqDspZ1hr6YwNNTsvPh0HxtyqlSN2q4TTPvpCq4kZwgYRbfj37evCdf2x/dFH
	jwoEeT3X/4JjecU4og5HiaaLVFQeSwM/JGyAQufeP1/3a7OzDp2guPM0fVGA/
X-Received: by 2002:a05:6820:c0db:10b0:6ff:3c22:3053 with SMTP id
 006d021491bc7-70ba0e5c47cmr363852eaf.51.1792824484750; Fri, 23 Oct 2026
 23:48:04 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: jyotish kumar <jyotishkumar725015@gmail.com>
Date: Sat, 24 Oct 2026 12:17:53 +0530
X-Gm-Features: AclHuK-FrhfGDO13tnc1jpgAdSh22KqjSjHZ6b-jndX0rW_XF6YE_vucomuvhUE
Message-ID: <CAGjZMyRqv5RsLF4Vo439zy4urfr+R=CTwuDzmYjiemauuZan0Q@mail.gmail.com>
Subject: [Discussion] t1006: testing %(rest) with object names containing whitespace
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

While exploring t/t1006-cat-file.sh, I came across the test for the
%(rest) format atom in git cat-file --batch-check.

The test currently contains a FIXME explaining that %(rest) is
incompatible with object names containing whitespace, such as
HEAD:path/to/a/file with spaces. It uses test_expect_failure for that
case and mentions using the resolved object ID as input instead of the
original object name.

I investigated this test and noticed that the run_tests() helper
already has access to the resolved object ID through $oid. I tried
using $oid as the input to the %(rest) test rather than $object_name.

With this change, the focused t1006-cat-file.sh test passed all 423
tests locally.

Before preparing a patch, I wanted to ask whether this is the intended
approach for testing %(rest) here, and whether removing the
conditional expected-failure logic and using the resolved object ID
would be a worthwhile improvement.

I would appreciate your guidance on whether this is worth pursuing or
if there is a reason to retain the current test behavior.

Thanks,
