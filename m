Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549345;
	b=GzgV75uQ286in5mlzFEZQtAzk5Q0YqEre6BMvsztH7QehfAXSlGvxawlJFErFlcwf2Be
	 B8LfdzQ6DTnJHevEZGPoRji0EVotS5okG6iFAxsyqOqvqGDHvo5BKy9/nJaMJ8BzCuV4x
	 PG9iQuHVuVngcr+k7xvo/+oTnMHG1AH7QGN3axtQXQwJWjMKiTfYw6oi25hhmfDXsn0Xs
	 uedMB17Wm30TVj9nromoq0O1sNZcReU6EFDfuY0Fj3ZzNfe1lMSBavw5k3f59OwgPTWWs
	 W5UgCAS43469wUPxYQ4kNHH93A/NwKsPReIRgdMpP5yC49ZqRjBDRAJgKR8L82dfLdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=33fCz+KZ0GeyzH1W39CRJ+NN/paMKi5jdV6Jfq+7KZ4=;
	b=lBmJ7in0S7gpIxfFYm5pwd6y5VNVYSIcD1WxgugBK0mFGfNdSehghRZMu6HOc+fnyZ7p
	 IwP6llGK0jgD3fR14AdRCEaKKrznDrVER+KIU0y9f+UwuIoA63mwmEew1tMaNSLZv0UxV
	 WzO5oFFriRJ3seH3cjHK5Wg7UJ+WKSrwQwV7vOU3XVq7H5EJPyrsnSoZiH+hbEliccBck
	 Ute50xz0EhWseUgE8LPUrDl432PA7mLHjqsIM2ckZMDRH52VlmyvvS7bobRwmI2/rioge
	 JhoAk7QD9ZmGLyGQIkfS+YN60J8Eyf4jMw18fp8K9ZUFRrCeh5VJXrT9sKLKzVtuOsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=agiFGvg9;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89681606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 02:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89681606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=agiFGvg9
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so1438415e9.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792549344; x=1793154144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=33fCz+KZ0GeyzH1W39CRJ+NN/paMKi5jdV6Jfq+7KZ4=;
        b=agiFGvg9Su/rCLV4JnI1ZNI6HTewdpav1s73NFEUO39dA+VKCV1oiQCwcCbGICwOeh
         Kca9+NfcfBpuzxK+reekyjNWIJ9Fw1HtuxOgyeMNoyZzddhfRBNfx/GGOc2JGXcBat3h
         gkWl0jtpOo1Vtj7alvjxvpLZqQroiy0vZtowtW0YSzgx20iyKH/lCfDFPf6dqD3ETofL
         u8JUpumzBMBw2qoiWEo74VxJ0Ss07aLQ1l5xbKevWbCA9pjyJGTY5uZNChJliUEMn7RL
         tiFjiQKk7wh9iDUUYv0VV7H1UND+iHvnrgxQs94mIPcH+JcHJTXYZPwswsrG1IY1JejD
         5sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792549344; x=1793154144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33fCz+KZ0GeyzH1W39CRJ+NN/paMKi5jdV6Jfq+7KZ4=;
        b=FmwtvdX/CFFP1s5Pnw/boWR+lmj7a0es4fqnMpuWbYmBCyTWR+ss8y07PEiERoisPr
         zdres8A7s5hzjLQXByAAu6BhzPPMkBaLVAHsdza1Z2e1OH8QuNrJAUFI6JURB2pJQ0ba
         cIz1OMtdLL3fThRq46/IGcSqzjWI/3rHnpmFHrcB6OY4Hv3KWNdsJUjPAUUALhl88SHg
         ADV4y5N+1DihIXpYtP5FIQ6vL0yutsp2FlwsOzi5Ilccs9uCHu8ono998o/CbhXG03N2
         KitNLq0UUGPsha+1AqqOqiTvejX8CxpJL4EZXfmMwcBdJjVsdjfpfBPfHjgFp99w7HXa
         XbNw==
X-Gm-Message-State: AFq9FYJUFX5Uen2O7SYms5xScIN1vFPzRcXttcOy0lhAhfI64bo1LN7P
	zcs9cf7bgUd7qlL1fMbFh0CoOW5/o/inFkZKhy1tLueNULHz5jbk6u8Z29IM2V3Z
X-Gm-Gg: AYBFou2uZRuBrxNMhQeQ46vWDAHP8XNTuLIXT6gWiLEO7Ycov6m1SNoh6fkt2N5uqh8
	Z656IIfc/OWHYdVgiMEIQ7z7V7Sp/xe6uoRiWHX4zlPsf53rCsVdX9p/09xSKH21uPmcKRkBlZl
	iDq8TRRSDRfmi44S4matBhPE4j0mPfiDpQOt7xExe05U1o5uohhuZ40/76lh+6UZkVz2vnLA+/5
	bpyzt+2SN19Wx7DgtP/RsV6FPuWa+KtxVgAf+U1IkZT+aI5CiqwbTsbSlbKgaPqfEONrxpwipN1
	Mgf42G5n2tqp+phiMBZFb/UjsCV3w1CiZu6ArhucOEU4qHQOzh2ofaenFG9DEVZPyZi84oiPV4X
	i42hit9fr/A6gPclxuFINTBBjUCrd68VPtL7Gcanq9uqo3de1DobiNVwReYFEMtbUtjFVarqQxZ
	z5tFA3xHURrdlhJpUAH2ewioGb6ejIHX+P4ODWJlsR+yox3X9zV6mt8cq8ek6ZPP8cxU+E+jGX5
	ydDAyiZ6jRDbyMkfEKhlfoGcZoWvCubVxOrFgWg0JMc5FOPRbLvGn5WRRl2zJ4aI8CJMEh5etej
	yx1Ypm7tLR8ox06KpP2B+7UwOWCqHD6Oht04VgIHbSDKHXEfV6KU0+FAYaOrQAw=
X-Received: by 2002:a05:600c:4e86:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-4a1fdd3946emr9648225e9.19.1792549343644;
        Tue, 20 Oct 2026 19:22:23 -0700 (PDT)
Received: from HP ([105.163.157.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm19513185e9.4.2026.10.20.19.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:22:23 -0700 (PDT)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH] checkout: use Q_() for the "... and %d more" message
Date: Wed, 21 Oct 2026 05:21:56 +0300
Message-ID: <20261021022156.119947-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c.dirty
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When leaving orphaned commits behind, "git checkout" ends the list
with " ... and %d more." using a plain _(), so translators are unable
to give the correct plural form of the count. Use Q_() so gettext can
pick it. English string output stays the same.

Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
The count here is always 2 or more, because when only one commit is
left over, the suggest_reattach() function lists it instead of printing
this message. I still used Q_() because some languages, like Polish,
use different words for 2-4 and for 5 or more.

 builtin/checkout.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d575a4f57..49239f029f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1085,7 +1085,9 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 		if (more == 1)
 			describe_one_orphan(&sb, last);
 		else
-			strbuf_addf(&sb, _(" ... and %d more.\n"), more);
+			strbuf_addf(&sb, Q_(" ... and %d more.\n",
+					    " ... and %d more.\n",
+					    more), more);
 	}
 
 	fprintf(stderr,
-- 
2.43.0

