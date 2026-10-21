Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792617993;
	b=kxFE9yi+pQzPCPfvM+9FRurof9BSh8VPYZA6oy9zHs0dxt5Vth+XUytjtXQm+2EN9dEU
	 GPtSgDBb9mWl1d1KqjUHUDZXpFI36AwaLfB4y3ljtESCze73rJwfcgatMY16FQDueoJT1
	 s3zb3ZVH9ScLckHxDyI26Xc9LGcWcNUQ8fKofRM80wu58kSvMSuE8HXaStKZMd2jmYCDF
	 FQnxsp5L/sqIRH3PFEKnHKzPAgaMepC+Uoixwzyi1+jd0DPxvkoAhTiwfCfOVV8m6LVPB
	 xG8dgJMSH7pZ5Lbj87kE7IKStQx4MkLkQlZAtSyHGZk6TzZau8qR46l6LQ4z7EAp3cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=LOcMUC0KCrD2L2mJsisl3qnb5exuBC3EjgvyVNvcXus=;
	b=NsFRItYR33mqnFksWjuEEnVRMJR8CXnAeADiHw8QXTcJNXWv3l6H+zDCDBV6nDlSqRqO
	 2uWW9uS7DlqDScljPIITBAhtE2t9u0dnldnBzLNVrhyVsc0p5pUTPb7Qihu/i0vF0sQFy
	 4t4w6HTuPgB4YkLXxWA78sxhwKHyap68wGw8RoCyC8z/kDtDYz8N+4abf/hibzcmowMgs
	 vQpkMFoxccziVVko5oXUZ7aV3o+c36zFuVkbcDjZX57ZNhWHaRM8tx+IFsfFVb98t/kks
	 gnA7WjdDOXeFbgefsvCQNPdFYvrw5Xo8Oy1L+AvmqB5B5vNVubj39PYnh7I3IYs/75Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JAYReQTu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECE606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EECE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JAYReQTu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso9919306d6.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792617991; cv=none;
        d=google.com; s=arc-20260327;
        b=Wyzja9SzJC1iyM4bvB6B2bWXVsqhfp+yfEOLDU+rga2hJeJKmhXy+S0XlWyjOHPUSg
         u9rc5vA3Eg60+AOSR/qzsdV9FZVYNrxpqxTP+xsPueGTqnNWqp6i9ufW5fee0XT3k0I3
         NEzqxnE0WrbjhKIirkzOv6pQTpufMg58Rhy3KLyZR2+eUgd5TlYwJC+wNFyMCe4QGmFL
         7EVcAX+8XX3lqWu+GJM2GLC8T2UVk9VykXStBryAOUpPp1LMMKtmRCmqtRV4SHYqplzy
         oobMhbaMWIl92WxpDRNY0/5wRS65dBwsLvzXHL7cpPQvvEncZbZUE58a7tn7peEwc1a1
         1kZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=LOcMUC0KCrD2L2mJsisl3qnb5exuBC3EjgvyVNvcXus=;
        fh=lHey586lqR/iK38PVUaxWbUNGN+1GrGoWUJJ41G/OHg=;
        b=Nh4qYuC0Q2N9/cVwASjod2O5GWR+1qHFsnMXZSM/NE4Zmhlv090LFR8RuQZIOrR2ro
         qa1+vjeg1Ns9sP3yyzaF1ufVBohJYZAIII84IFe0XWYRyfXJIGosmvkSBE4FNDhfzygX
         pvff/JKVQuj3BEj5+KiLi2/GvGRPTMXa2GQXh0KmWfEsXMATM9K3/r5Ba5nWmTpu1+rP
         lY4x2TsjlimzUBTpHlhVAu8cs7W6qkSZlnfema+43fr4JKUfIO3dvow42aeUaqw3AQDl
         x66MvxRlGt5mxelS8i0b1cdmYBpqIu6GUXMJFFw/kTDg+X3aJFxu7oY2+NhLBC325O96
         EeWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792617991; x=1793222791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOcMUC0KCrD2L2mJsisl3qnb5exuBC3EjgvyVNvcXus=;
        b=JAYReQTuqt7q0oOYbbQkRXUZ5MW3oiGTtKpm/M301ECVX6EAxXaGZq1e8MeD0zMSKN
         PSHOkIuJ2jvdE8G4dVffymf7mNi4yVVjJd27dD2OKEenMmcI/I+ZjliKJEx/qvT/mDgy
         fWarelV1ZuJUFlpBnMT79mH5Ihuth4IbcgWHr20EHPI2WJGaoaFteeGL7C5cSBJAPIMo
         dnDqTRIZw9vN2Y4suZ936M3ZFxQ+gnojLfbP/60klXlkpXp28+ufpKdsa3CrgR820MWI
         W8Cv8X2w+T/z+btb0bsYYO6CfgGT19tB5jtvRf7pYYPXnf0VJsFsvMnFVOhinbXOU9YN
         lzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617991; x=1793222791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LOcMUC0KCrD2L2mJsisl3qnb5exuBC3EjgvyVNvcXus=;
        b=xiJfkbRR5CbVllo+PAPaXUOlHBcAYAsEgW+FW+CCfq52NOKUjEUUni8cRkZQqYmVTV
         bJE+wJ01SlVlIOJ/J1ziyZs3l8L8U6x23peKQEn/wipzB2I+y0FQ2Zh1Ec9p/VFZ5yJz
         6kzNOlNw3ytLAuSMe3ljd9CiJvZTK1DddKXQQ3DxKFMFYR8E9FwJDWGAAu12F7Zt47sr
         N+VD9eikJUWGvW3r+pxdVH5Z2lw6dUtQzEOCaq+fsjOxxRYX2WP5uAm5MRUrT2T07190
         9zXls9qIze/XpmckC2BvGaOkoiazuFvR77BDifSk4DP2mlNFV0ZtEJueDjyLqhVlTWpC
         qTtA==
X-Gm-Message-State: AFq9FYL9O9YmjyTpDCHS1SxLLReyaRSe1cVAnRrPnhdfQbxrf7ajggMu
	gNFfXQdeZar4mVLaCf5I2yALzfAN8KsvepecfcGjneczi6DkdHPXlp2PAnDnHIHbUXnINTSDB45
	vsWjbUV41mlYzRp5rp9+sg2qRKtFzJ8Q+ICDEES3IDuGH4y8=
X-Gm-Gg: AYBFou1mbpb2aFDmQ9VXQjpMFY/Vtyd5GSyx7LU4Ru+Uxvi0QAGcn1ugrJvBMnUk+Q8
	M0k8BmT8vaGACiUa0ZrWIyqwU4Jq5CKhjaVuSIVCRTmQSk+fd5yIs0VgYE2jqe3KpfZqQTJEFTw
	vSM71BMD9ICdTBsMPZHX+vXFkGVxCtQj79kuU0A8q3jXq5ByUyxl4GKgB8zClbRGKqGxMbfCtTM
	CRh5YbU1GB8Ywvk/Cv8VO1WAVQRdTkmGsrumSfVJUwfIGGpyb0QE0ZoT2yxdgcYjvyK5GsnicrV
	BLB+YqSdm7RgSZkv2oDcJHZoNoR6lUQ1XQ7vwTbwtOh9ykRrn7NSG/tAJhEtZwpu6iPnoL7FiNl
	v7tYZm3q2lHrTiHFzraJMi3p7umRdUBJKw3tlXrOaPIlxfe6vWm4hQ6OFa16oxmLLcfw4yFLjQc
	o3FqVtNYd+lnDzAzxgsAcYt/udXzXTCg4Qgiz8DcUKsKQUycwJm88fjogYDtHhP94Wikmm+k4=
X-Received: by 2002:a05:6214:4348:b0:919:5ac7:5c7c with SMTP id
 6a1803df08f44-91c12ef30d3mr53673146d6.37.1792617991313; Wed, 21 Oct 2026
 14:26:31 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Wasswa Edson <edsonwasswa54@gmail.com>
Date: Thu, 22 Oct 2026 00:26:18 +0300
X-Gm-Features: AclHuK_MEA5_Mgks01ZHFz2V00Umk-NdEuzKuuDILpBoBRXTJrXnDumbvcEgpkU
Message-ID: <CA+ew3JuQ89JPdzYVffcvmPQ07Phrnj-9mgpLMtF7rEin1MwopA@mail.gmail.com>
Subject: Internship Tasks phase0
To: git@vger.kernel.org
Cc: majordomo@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99ve completed the build-and-test setup for Phase 0. I built Git fr=
om
source in Ubuntu on WSL2, and ./git --version reports git version
2.56.GIT. just like the doc on outreachy website

I also ran the two relevant baseline test suites.
t5710-promisor-remote-capability.sh passed all 33 tests, while
t0410-partial-clone.sh passed 36 tests with 3 skipped because the
required TTY and web server prerequisites were unavailable on my PC.
Neither suite reported any failures.

I=E2=80=99ve recorded the environment details and test outputs locally.
Best
Edson
