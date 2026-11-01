Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530943;
	b=2d4Gw54pGT7rHgL8hcxLQ04tK3mkA1lYAjvLslOg/XAOrGGzEt6oV5l9yapXCT6MnpEG
	 Lt3at5cvsTaIrwGpt1ysdGiG3rGcCHMy4JvCHn22NEthW97Zj+LKZ7Lz0HKFtbXD5OnQ2
	 Y57MYgmpSB6O940YdzqKIBjSJ7xGHudIfKY0Z++NdMT0QIlUsFkgvWmrhxqUJjSXdDEX+
	 DEfAB5XydRkU5UiH0GTikMq930veg15t2MpvTi99ZLM5YhY3H+cx1ONdVVkd/B7X10cBw
	 UCk4TG1qSp0bKY9h4JLDXjOy1qDERy2A4lXanpT+BJhZm3GYAHsNODkyzANuEXfoJEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=N7Ted11tlpNQmL+KB6CVrLxFxm5WoAh9t/OUFaBONvI=;
	b=mJ4+l06Tftg1rn9NLnMSd0MD4Gko8/eGrdFGKw+YcQZScEWymiGeNrs8qU0d4/x86QKL
	 Bol7syZhcRzabm8SRxDE9BRSBG5OrTuircHNBr+VNqZyQ/mqFLUk9V7zAf3I4CMmxQ+p5
	 zkItQC1ZI7U7hQ+B+YddTJsRqRzh6y7ftBQLIMeR2AAI/MhN1m2yth0NHo61Y60Uvx4L7
	 Cet6u8RNFXsPU9hWp+Er5acl5evUgL8BtlvfRvZX4faxsELL+oRdrluKWODQMdKaSToNq
	 nsfTFkb9uDmLfehREcvPqw+VAkXf9Tayfty9tk1PTCVotcE7sYMuX2/ER+c7LEaPuxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Kt1ygLO;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271D606A335
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 11:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C271D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Kt1ygLO
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5364042eecfso35997601cf.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 03:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793530942; x=1794135742; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N7Ted11tlpNQmL+KB6CVrLxFxm5WoAh9t/OUFaBONvI=;
        b=0Kt1ygLOhVuofwHBYh9pbOLlSWbQSLkeiNEGT7Di7NoW2IHcIGEgOCgj7wIivOdl6U
         W7BHg6NGSX/freW4FbQ0IeDALufCY54+MtJurktNVILE6Ry39y0IQ3ZwSDdNB3JywPIW
         ZOrjdR3pk+UjJamcB+mDLSZmQrMvWpZRw0YJB7GGatjC3G9Fl9s3hyUV4Y12/YK4JSJQ
         Ms9j9jUdJR60Vbl0pKwmJKJ8TtrUYUtdHbSOiH2DajqzzsawPt4jn4ziWj+3a11DU+7S
         6HoWZtFXvHfTJhzJVUuvSbX6DzBfuZzsUZ+F3qmzJ6lyIUwg5cIsbEQwWw+6yZL6WDKw
         ShTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793530942; x=1794135742;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7Ted11tlpNQmL+KB6CVrLxFxm5WoAh9t/OUFaBONvI=;
        b=Y8oC1QaSU/2BoxCAKXQchr60f7e6QZg8WY8fJ27OkHLkdi0b7pWdTEFVw0eCO9OOAD
         UIJ///fg2TcuJpTfRkF5++Pk4zp4gef9/fMqHuv/3g6ZRiywXdSmeLsznonLv6tYvWmW
         kbsYgvXz1mxuaoF6eoQ4jIEpsT10kiIuihUns1Dwt3jQMZ41Jsv36LS0c16SpqjQFF9x
         C6WdsgEO+JfpVqOjrl3QknE/Fz+9jxvaAVLx0d6crNG1Fvo3KXfEeo/9ol1xz613lEV0
         58UHrUfvx5uybYLQcRuAFkzkg09Hj3GerTL33z9OxlDHHZDDBhFizBxWCN3btSutNlzT
         EP6A==
X-Gm-Message-State: AFq9FYJ6X7s9v9a1M0X6hdpHQ+yJEJGLtx5aM5M7ENmC1alhofALa+P5
	ELLCeLzUnEP9E/Xug+T4fdFWCaSMqPuHzD/S5+w9m0/4AOERuunIYlrYNupx80lM
X-Gm-Gg: AYBFou2KbcssPuwwgSIhYwqcpkcL51cgYt4sir6SsQYvnTfhQIXxYKomBRldBHXN2GR
	znjrPPKsaISHD0OfHtV5dMXH0UXcQVDOTp0EopmqJnycIv+VFWifGHdJHvHnp3c+Tw7lyi1mKV3
	cwRZPZmUz7Aec2Mo3Dt+Fd/jzdzIlVaFc+C4TZtFZhS8hHNY22xT16TYNn5ROL+6Clo3JHPLoi5
	an53EjaJV5I2foa/YbIKlVwvATiKJmDQBV3C2meisZ0IinY/DynyS137xKVbFD3/hiYygTF2hfn
	n7LGJvsWQnu8mwNor0tlPafxGsr+MAe6ZmKIFwyiDcYjLKMl2WbUpEJd4vHXm6uJChh71gL24JZ
	v8LeEkKz461CXYNHWE03alU8l+E7rScQTXwsnP3QkOOU6x62iodqsXUONaUPlnP6E9D0edvpSwa
	SRa02HbIjhpy12SjX5r/N7bwnQMb3B/iZ/v2tXjxkBudN10rSNt6X7a1lETJAeGNzhxYZAP9hOM
	URF1nsKDI5mflr0TrxJQG3+9tvBbRdeyO1NPpCUa4tWXc7vD8ZWfV0APZ3bhGV41cZDf1OmPEX1
	yJHD6B7Y1V2meimi+vI97ak7+7GsAw==
X-Received: by 2002:a05:622a:529a:b0:536:3d24:7b9 with SMTP id d75a77b69052e-542b62a539bmr105112721cf.15.1793530941703;
        Sun, 01 Nov 2026 03:02:21 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311995163sm58658301cf.6.2026.11.01.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 03:02:21 -0800 (PST)
Message-Id: <37e837ef88b91d3c745fb05466bf30ec1afae680.1793530936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2478.git.git.1793530936.gitgitgadget@gmail.com>
References: <pull.2478.git.git.1793530936.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 11:02:16 +0000
Subject: [PATCH 3/3] ci: pin linux32 to ubuntu-24.04 to restore networking
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The linux32 job fails DNS resolution before checkout because Docker
29.4.2's seccomp profile on Ubuntu 26.04 blocks socketcall in i386 glibc
containers. Ubuntu 24.04 avoids this host-side regression.

https://github.com/actions/runner-images/issues/14790

Based-on-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 .github/workflows/main.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index b564927e2c..d9149e9ecb 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -442,7 +442,9 @@ jobs:
       CC: ${{matrix.vector.cc}}
       CI_JOB_IMAGE: ${{matrix.vector.image}}
       CUSTOM_PATH: /custom
-    runs-on: ubuntu-latest
+    runs-on: >-
+      ${{ matrix.vector.jobname == 'linux32'
+          && 'ubuntu-24.04' || 'ubuntu-latest' }}
     container:
       image: ${{ matrix.vector.image }}
       options: ${{ github.repository_visibility == 'private' && '--pids-limit 16384 --ulimit nproc=16384:16384 --ulimit nofile=32768:32768' || '' }}
-- 
gitgitgadget
