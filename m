Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB3E26B966
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396147; cv=none; b=lp7AJoYw3Oy4syFG1Oq7ZO/IlundwlG9fbSKH1Df4Q+4ipXfck/IyJiIRkPni6Dnf/ZyWq+QUYZLf8i0qlOpdDDkKwnua8oJu6R+X82b8P7yEJ/m5/RZEIjTwvxHStuDYICk7w2a6xUS01I2TRIIotRac4hwQcZAP5bpp7Df23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396147; c=relaxed/simple;
	bh=6pDEqCeCXNLX2oIL5ZtQjXBSkS+hdSn39LsQ2eJ9eG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dmm8CfN9UZuTrF4PZdmJ/aUVX0Biu7lmbAHfrrVXnFO7trHoaqqBnsx65Peo5yYaZ8Js8FWT0f6MEVk6T7uh4YVERdPOZhnLIMm+36ifB+RhyxRKDe6LOBQ9CaUIv0F0YCyBSHmtttMUzQv0ThMPaRhpcCVmrJF6pD9fvgJXhIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1A26In6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1A26In6"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso8498559a12.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745396144; x=1746000944; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSiGAZ/ajXlSh9vbx2ZgLpaMDag8/bIhO5yog4HgF7I=;
        b=j1A26In62h97p4CkmE53tOgU61gQ3XezHm/P+k5CBEJ73lqToEGCyvgiO3vek7HmLY
         gniIRll2ePsPF27aFL+PRM22DJC2f6oYM1YLa9jiT9DjT5hv7BcbQ68eFutyApCss5O2
         5jM5YdIb9ccDnJDvA43yEmVaxtVrPacz3gahb9A/vq9jLw8DGVRUgZMQLz0oi0AqPPLM
         MANq1tFJrZbDMgMAXB7IU3g8jvtLS6QAe0GAvl8VSXqrAaHKj5NtY6yobQe1vEfKDLir
         h7O4m1bp6aUW9Hnyus3vhrHuB1x8Q7KpVJcysxnqt4utj0+3uGGeQGDmswy8efK9WKCE
         erZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396144; x=1746000944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSiGAZ/ajXlSh9vbx2ZgLpaMDag8/bIhO5yog4HgF7I=;
        b=Vyf9RZRzriNWHMrXVx02tlGzEuO2hSga62j07CoyNN4mwtUG759uEUl4BV+2dmKYCT
         MBFby6uh1FyY/J9P3SowkjGgppWd0DOw3xfn4NXTYelrr8WuSvrxhnxzvnS3lynQHphX
         HbaE6p/dpzTy8lt0Q5Yoa4sC1XpDXy/DUdJ/ru3fZwCMjPG6Mx+rb3cB58104K6r/aA8
         YTbsW53qiAj/5nD6hZMjSqaw5sACtF0nAHxRldXC367+GXdL+MXqyB5N//By7yLl728d
         mF7EimffM66EklNVH0T9XerDiN0y03q/FdU5EfJ1A4kGsccHSghGT7/d0kM920ipeIyL
         N5EQ==
X-Gm-Message-State: AOJu0Yx42GNl9J+Q5cGRUw0rplSlgL3R0beDGXZyzNGa/226Z/7Y4q4x
	fUR3DBpbrdPVq3fSICzK4INlk2hsweLyHJHnS6/GN924YHT4PQ8w
X-Gm-Gg: ASbGncsUx79Lh2XhGwyWjdTjPEJdEScdWQ6U2cvh3FdSt1ihEyl5jGfgrbDdWVEhDL5
	cv9zfCSjhMyaRmvheph+N8sQsiQKggDVArmYM+x5TPaAGSpCFClwroYxWR7N7Ze/m319Bu7psI+
	8KhO7y6y1Yiurn0jRhRgzTUxan7RWlfjBrg+zHxsdd2xfhfBUYTl80xKQGmw29P9UtSDw3C3MAq
	cz88Ahv9HZi48eybDUzNWrNhOWlbyNjHWG9gxy/oCvA9xEVzSYhDnxz7bgUl2hAP8ZfX1PwwDA+
	7qzg2oqu1/HFFk5YggsPZhOeRcGrUIjqiw/ZO3t0DcnGYUPhjQq+1xW+Tg==
X-Google-Smtp-Source: AGHT+IG9q7cBU4h0/2NUdPgjVSunL+HebFmOWa3L5w+GRNdavhhWZJMbzOvl1upIhxFuT+njrBbEPA==
X-Received: by 2002:a17:907:2cc4:b0:ac3:f1dc:f3db with SMTP id a640c23a62f3a-acb74b28a5fmr1398461766b.13.1745396143698;
        Wed, 23 Apr 2025 01:15:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8764:66c7:f630:d3a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec13a5bsm766577266b.27.2025.04.23.01.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:15:43 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 23 Apr 2025 10:15:39 +0200
Subject: [PATCH v5 6/6] makefile/meson: add 'check-headers' as alias for
 'hdr-check'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-505-wire-up-sparse-via-meson-v5-6-d1e2be4b2078@gmail.com>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=6pDEqCeCXNLX2oIL5ZtQjXBSkS+hdSn39LsQ2eJ9eG0=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGgIoamgy8LPElrO91C5OyinORPbLRUVP245ZnPnzwUyX6+oL
 okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoCKGpAAoJED7VnySORox/GLoL/1z5
 ZbDnbWGZGIWMNmO284FqFD7xCzjaFIJdVpOzvPl4wckfXKGX2aKMRVlr+k6uNdXkv/tlSq3VPw7
 pafxTC/VAkG91vEoqM/OcBLm3ePpPxtK6xwcEVv8bNs3vbwMQXiAeH/C3MO93uPz9m/yN8WVeGe
 4VddmT7BlPx6kiV3XC5cRfcwyOO7L3b8jUsDU0c0Xj/XSO4hCf15c7pD+vtiFggKv58LsUyFuKm
 uxHorGA7z1puXVShCGs9yr6+QJ5Qm+dsbbpXk8O5lf8jeXvb3tOiPQxsrF3AHIcwq9Qv+evb8rG
 AbCO176mPb/o0ZOTDUTCTpAsEyZyGdm7iSkFvAqgs4J7rlXt8Un4iGf7jKipkA/Z4e30NYm3nso
 avcZ2VRHCM1gNr5F09ZlrvpkHOr2OmmTdqcGfTiAaTlnLB5OQPTNbNYxpCFqeYlXeb2yeCmb5We
 cZdEJz0v7XRj1JTKuo6k3ZFLxsQAouHrXKSge4mD86n2wTlj7mXwAWR8QaKQ==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'hdr-check' target in Meson and makefile is used to check if headers
can be compiled individually. The naming however isn't readable as 'hdr'
is not a common shortforme for 'header', neither is it an abbreviation.

Let's introduce 'check-headers' as an alternative target for 'hdr-check'
and add a `TODO` to deprecate the latter after 2 releases. Since this
is an internal tool, we can use a shorter deprecation cycle.

Change existing usage of 'hdr-check' in 'ci/run-static-analysis.sh' to
also use 'check-headers'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Makefile                  | 4 +++-
 ci/run-static-analysis.sh | 2 +-
 meson.build               | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ac32d2d0bd..961ee508be 100644
--- a/Makefile
+++ b/Makefile
@@ -3326,8 +3326,10 @@ HCC = $(HCO:hco=hcc)
 $(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
 	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
 
-.PHONY: hdr-check $(HCO)
+# TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
+.PHONY: hdr-check check-headers $(HCO)
 hdr-check: $(HCO)
+check-headers: hdr-check
 
 .PHONY: style
 style:
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 0d51e5ce0e..60c175a094 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -26,7 +26,7 @@ then
 	exit 1
 fi
 
-make hdr-check ||
+make check-headers ||
 exit 1
 
 make check-pot
diff --git a/meson.build b/meson.build
index 22fc65ec80..569e3888fb 100644
--- a/meson.build
+++ b/meson.build
@@ -2054,7 +2054,9 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
     hco_targets += hco
   endforeach
 
-  alias_target('hdr-check', hco_targets)
+  # TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
+  hdr_check = alias_target('hdr-check', hco_targets)
+  alias_target('check-headers', hdr_check)
 endif
 
 foreach key, value : {

-- 
2.48.1

