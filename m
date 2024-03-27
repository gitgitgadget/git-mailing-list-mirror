Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528381386DC
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544698; cv=none; b=mt+bN52apf6ozTlYnUSSVQ4xs9X/s4Vll1uoRb4QnDXVQRuiBxyHMYE/aqe6ff3O0g2CRly1tDyg5EEKh4yi+JRvjOENmU7jD/+t8yn4YfSAWLtDRxQqQTLwfs+94iKQkzOQTnblGYVPRfu3QHa1D5z3Wkkwk7HQGDsHBdmDSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544698; c=relaxed/simple;
	bh=6+L2Gn9A5cziUHUHa5PYoeGlIcpz09m54iaKu5punZE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=saC4rAahoPWn0l1Kkyg+3R/4DJsIL/01njwnmIvwL46cfTY4CcV02BSi9sHIRPMA2VqvLeSCmdDGUOnep2p25V9cWyjX3yMGcC+9B1Zgu3T9Esul/TV/qh3haUss28PBSwj0LTIFXO8W4aFadpnLTNQ2uDGc+6B38ZxepD2HvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdVQE49Y; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdVQE49Y"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so32493511fa.1
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711544693; x=1712149493; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydWID5+QHYZgG7LjCCN+QEOCrg4ORxQbGyIpFBVn5Ag=;
        b=PdVQE49YohveTFfSPFUdT0ZzbOKEjvtL08w4GxmgYUKxJQWDGw7p0YUlcZQavVVIrv
         0ruse7KZBxH8GX9ArheqLokmfugqCATdDqO6qYv/ibaxv1qlaCjGzqDWFLwdLPVnv7vT
         z+mgtfKkW2/KTSYGSxv3mzw9nGEgK6iQaD7IHwpVV3VfOUEttCdZsRs4GKG5vbP0Ufei
         TuC2ch+raPC/HffNXUM/npvJtHlqTd3T+wGtG9EcrvFTTFZGaMCzs7pgYnFKD1gLZFLa
         69lhu2elVA+nLh7OnunCGePtaeBTs3TOTAGpY2UGc/2H+DiNO30qxVWiByE+UK1IasCd
         HhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711544693; x=1712149493;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydWID5+QHYZgG7LjCCN+QEOCrg4ORxQbGyIpFBVn5Ag=;
        b=WixzPygEYq2IP8HNpoove3a18da2oRG5CvdlSpArN484LGaMVrB/g1VQhRv/69ARfO
         M67FnqOtj+Wu6P6otd6P2ZwycPS6VnL+Z/nMYPLayxR8wL/gUCbGFt1BdfWGWJHeRx3v
         b4+8pP4nFU10qJkVAgb7N6pRwDgyZb1+HoIS1beW5Zfb6onOZYs0b8vj8yLRVQU7dksE
         G7uAXRBoUuuOvEaDCU8DdFX0tL/LUXbnLpEul6+c/ztZk9nVzgDt5YRf/YtdzWlKjihr
         GK5++r+NHz/3vDB+VFa/7ZcsKjWcmSjr6ns1wUV5XwWNzxPiRGpqnfN38fmzq6rZoTQl
         S5xA==
X-Gm-Message-State: AOJu0Yyk1Ry/L5Bw88OQmGtPAsRnEYJfO0BtY+UWCx8exvK7uWSYW1ez
	L4O06u4OrWd4pRdck7pzfyNRGIC7d9d0cD8ZbrK/1Y8doAx4/4nsLHC9p1mv6/VPoNonSB7BLBv
	e/ZiF14jhSmjDMWbOZZYMHFMQgXx3ddaodHmkBB+H
X-Google-Smtp-Source: AGHT+IFPtM654qHf9RVLx34I3fECIefvDN9qb4e+LBfbtZlCkclPP5zQGomzetreqCl6d0VuHFXGv4tRjqvtgdXDXjM=
X-Received: by 2002:a2e:9655:0:b0:2d4:50b2:62e9 with SMTP id
 z21-20020a2e9655000000b002d450b262e9mr3515965ljh.14.1711544692444; Wed, 27
 Mar 2024 06:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Wed, 27 Mar 2024 18:34:41 +0530
Message-ID: <CAHCXyj09EKKdBOAdQ319LGY-6GbQw+HHp9u_Mbpf4C+wF6ReSw@mail.gmail.com>
Subject: GSoC 2024 [RFC PATCH]
To: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Dear Git Organization,

I hope this email finds you well. I've prepared a patch to address an
issue related to the handling of exit codes in our test suite. The
changes ensure that the exit code of the write_utf16 and write_utf32
functions is properly captured and not suppressed, improving the
reliability of our testing process.
Below are the details of the patch:

---
 t/t0028-working-tree-encoding.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index ad151a3467..f372c14bc0 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -19,10 +19,13 @@ test_expect_success 'setup test files' '
  echo "*.utf16 text working-tree-encoding=utf-16" >.gitattributes &&
  echo "*.utf16lebom text working-tree-encoding=UTF-16LE-BOM"
>>.gitattributes &&
  printf "$text" >test.utf8.raw &&
- printf "$text" | write_utf16 >test.utf16.raw &&
- printf "$text" | write_utf32 >test.utf32.raw &&
- printf "\377\376"                         >test.utf16lebom.raw &&
- printf "$text" | iconv -f UTF-8 -t UTF-16LE >>test.utf16lebom.raw &&
+ test_utf16_raw=$(printf "$text" | write_utf16) &&
+ test_utf32_raw=$(printf "$text" | write_utf32) &&
+ test_utf16lebom_raw=$(printf "\377\376"; printf "$text" | iconv -f
UTF-8 -t UTF-16LE) &&
+ echo "$test_utf16_raw" > test.utf16.raw &&
+ echo "$test_utf32_raw" > test.utf32.raw &&
+ echo "$test_utf16lebom_raw" > test.utf16lebom.raw &&
+

  # Line ending tests
  printf "one\ntwo\nthree\n" >lf.utf8.raw &&
-- 

I kindly request your review and any remarks or changes you may have.
Please accept my apologies for any mistakes or oversights.

Thank you for your time and attention.

Best regards, Aishwarya Narayanan
