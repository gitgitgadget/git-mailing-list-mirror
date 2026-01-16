Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A588134AB
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521945; cv=none; b=C0Vyf2cAJEOorxPsi2ZJ7xl2uHPGujzYpiye6OATvErjOsnhtFl5O0cvpTce7avvvlammukIJ2HcGIg//6jj4bqOOYOyWQxUlUHoIYYhGhRDG7ehSvbWsMJVaLPyA2q7hHj//XejvJYX2MMLums5or/1gLo97YoeG7BCxoYzsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521945; c=relaxed/simple;
	bh=os92YIK2u3w8yNDK5K+rqvaa7QNzc9iXBpOs+spjlU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcrlhuCmAekyMZcBk7pqpUsEGhaNpZLRXjKYOPJ/O0v9WnEf1OPhydRWYiFQnKFFzmTMZ+BvU/LgEu0YokjvfzW5LQGgvRPeoHXGlYFULmqRL5zYzmRcoXAb+MosYcjI+ElvnUmw6RXhT7SRcYcZcRIiUovgO3N/fystzk+syeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO5mxUA/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO5mxUA/"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so2544560a12.2
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768521942; x=1769126742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nl8kcPgwGwUdR9vJIjBzi+XLq77Qz5cSiakUGhXSTZE=;
        b=BO5mxUA/ACZB2rRK24xrERUG6TJAYJo9nvIOx/ZO7gJ7etMB4r9cOExl1G9UFtD6/k
         w0P8cYBrdztZWFhji7vOuSe7sfwlkJjLaaHcdCmA7aG/PFmAEKovm8DnpzgfP2vx/0Vb
         B0sm0BG/+I/k7uYdv5W0ecHXHc1AwVPd00x7+/A96WNTwrKZGGdNGi/SUr7Qy17OmBlV
         KZ3ogW7FG7eq3ud24kuhXBbLYOG9WMaYvJaX/riHzHxfgXEx1NLCVLpuoaes4x5t49Ie
         kb2IAW464MLmX3KSPEANsae9pk+BJrrxFoeWI8qeTukMT21tQXWM6N21R6Ko1s+shtpV
         eMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521942; x=1769126742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nl8kcPgwGwUdR9vJIjBzi+XLq77Qz5cSiakUGhXSTZE=;
        b=rpUyzLicQkeiVMeOA8As1UW4Pv1H0+E1pdLo4ToT77NJc9VGpsHm2zEc6N+kt/C1m7
         Ou8V0QUZljHdPV9laZeW9DSEHA+fpojf7083FQONJPtOXCXKwwAyIMOSUddNSQiqfOa5
         1DTzAMvecbYwoG3YbQm105C/HZRAjRLRK0r+ugr+cEsp/QSO6tx/GGOe6GWS7ZbVJj0U
         zgOYZWPLit8vlsBj5KX5xHENBfkirQGIdYVLZ/YWbhf+oI9qK5xEOFbU46zWEOH6Alcl
         E+XTbgBXtKQbRTZm3vppEynk/Vwa9UHwkNc6DX6mrLv65Ayj8bgLDDdOJrdyfKzrVdaP
         ctPg==
X-Gm-Message-State: AOJu0Yy5mzNRN5LDbVlLC/QfHv9H/XbG9rhfVRdrK5YEKasMVb+QvBpX
	6DeghWs7NESMqre4N/yeaMwnp1i6Vt04rx5UNP6oDE4vs8ESkwuED2IHEOPzi2Wc
X-Gm-Gg: AY/fxX7AlgK2fT+Ip+sLy08dedoGsTnGYQx+aM6sMNub/l/+HhVIBKzl11vjkVQpV3L
	b1Mpsv+BiB9Y4hllPIMUoRwk1ZNxDQDrPb/QKaCvdM8IecAqnbXkS1PsYuu4pLx6K0ykz0kmEXm
	ebwYYb37BGfkZyrFqg0SscmhM43H+7bprh92bXuAKBlfe/XHF2d8DzG5UmnU/2IlXzvcDdTwd1c
	D3DNY9eMG0nRH8GuwVf486rR0NIUkwPwHK0YQaaAGMntdd+c5jgPQhNFBefwOHxTp4mWM6/PV/j
	X/7Skx9uX0kz4NpJDFuWtOc1MBxZUySiInmWS6FBQDGnaLTv+GaYTtVed7UdFX0x7yjsBFX12XS
	p/A/UidL/hGlMD1VQt8YQJGRQgpKsXEXf0mb7chmaSMtNNxAcE1ai0RDFqPSWxU4A50jT+bY3vx
	t5j9EJaluhCLnFsmPOUhRU
X-Received: by 2002:a05:6402:4402:b0:645:dc9d:83bc with SMTP id 4fb4d7f45d1cf-654525cc0fbmr861112a12.14.1768521941757;
        Thu, 15 Jan 2026 16:05:41 -0800 (PST)
Received: from lorenzo-VM ([84.33.162.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654534c8689sm798491a12.23.2026.01.15.16.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 16:05:41 -0800 (PST)
Date: Fri, 16 Jan 2026 01:05:38 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>,
	Niels Glodny <n.glodny@campus.lmu.de>,
	Patrick Steinhardt <ps@pks.im>
Subject: [GSoC PATCH v2 2/2] t4073: add test for diffstat paths length when
 containing UTF-8 chars
Message-ID: <ee088ea6ef91f0c349ed4940feab807d421dde66.1768520441.git.lorenzo.pegorari2002@gmail.com>
References: <aWgYRkv-YsuekdR_@lorenzo-VM>
 <cover.1768520441.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1768520441.git.lorenzo.pegorari2002@gmail.com>

Add test checking the length of filepaths containing UTF-8 chars when
generating a diffstat with various `name-width`s.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/meson.build                   |  1 +
 t/t4073-diff-stat-name-width.sh | 61 +++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100755 t/t4073-diff-stat-name-width.sh

diff --git a/t/meson.build b/t/meson.build
index 459c52a489..f2ad6d2f12 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -498,6 +498,7 @@ integration_tests = [
   't4070-diff-pairs.sh',
   't4071-diff-minimal.sh',
   't4072-diff-max-depth.sh',
+  't4073-diff-stat.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4073-diff-stat-name-width.sh b/t/t4073-diff-stat-name-width.sh
new file mode 100755
index 0000000000..ec5d3c3c1f
--- /dev/null
+++ b/t/t4073-diff-stat-name-width.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='git-diff check diffstat filepaths length when containing UTF-8 chars'
+
+. ./test-lib.sh
+
+
+create_files () {
+	mkdir -p "d你好" &&
+	touch "d你好/f再见"
+}
+
+test_expect_success 'setup' '
+	git init &&
+	git config core.quotepath off &&
+	git commit -m "Initial commit" --allow-empty &&
+	create_files &&
+	git add . &&
+	git commit -m "Added files"
+'
+
+test_expect_success 'test name-width long enough for filepath' '
+	git diff HEAD~1 HEAD --stat --stat-name-width=12 >out &&
+	grep "d你好/f再见 |" out &&
+	git diff HEAD~1 HEAD --stat --stat-name-width=11 >out &&
+	grep "d你好/f再见 |" out
+'
+
+test_expect_success 'test name-width not long enough for dir name' '
+	git diff HEAD~1 HEAD --stat --stat-name-width=10 >out &&
+	grep ".../f再见  |" out &&
+	git diff HEAD~1 HEAD --stat --stat-name-width=9 >out &&
+	grep ".../f再见 |" out
+'
+
+test_expect_success 'test name-width not long enough for slash' '
+	git diff HEAD~1 HEAD --stat --stat-name-width=8 >out &&
+	grep "...f再见 |" out
+'
+
+test_expect_success 'test name-width not long enough for file name' '
+	git diff HEAD~1 HEAD --stat --stat-name-width=7 >out &&
+	grep "...再见 |" out &&
+	git diff HEAD~1 HEAD --stat --stat-name-width=6 >out &&
+	grep "...见  |" out &&
+	git diff HEAD~1 HEAD --stat --stat-name-width=5 >out &&
+	grep "...见 |" out &&
+	git diff HEAD~1 HEAD --stat --stat-name-width=4 >out &&
+	grep "...  |" out
+'
+
+test_expect_success 'test name-width minimum length' '
+	git diff HEAD~1 HEAD --stat --stat-name-width=3 >out &&
+	grep "... |" out &&
+	git diff HEAD~1 HEAD --stat --stat-name-width=2 >out &&
+	grep "... |" out &&
+	git diff HEAD~1 HEAD --stat --stat-name-width=1 >out &&
+	grep "... |" out
+'
+
+test_done
-- 
2.43.0

