Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A71155A5D
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228921; cv=none; b=GwpQlq01H9jq/DIdWR/sjL/36Rw/ZjztLRoM4zEyetY//j7qxwx+3oNVJEZVS7oFuJgI1LJ4TG0YkEFemIpJGaLiZq4+LBxRAo+td+zFceWWw1MajlnIxVhedrTGa4MwEgLsjCzNYJDeKlHbtL2Zl3/LvVJs+3JwNevC92HuNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228921; c=relaxed/simple;
	bh=FbW5OG6F80G7iuyIY9sohR3wLaDNuxoW63YDBmwRcuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASLiWeSsXUwGeATfAMsLslKkw13socB5Lfy8CGrTafY9Fz6M4HeTXlXYdIEF4PJdWZzGipKVk+yFSQPAVe/wuAyMhuhzVGN83EXnypwQO3y8VmaO7mmIwFrl0t7W64TkPzm+6K5msUE5LgTlNoclr5oi6xSJX7vOh04AVLAly90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJqVhF79; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJqVhF79"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4807068eacbso20632965e9.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772228918; x=1772833718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5VRHJYCLXwMpUbsjNhZsoM0ZDR4SP417vUWUS8Ou8o=;
        b=TJqVhF79iOmnx9FnpiseX9T2nkoTeP8sFpxP9kRJFcI9v7uJULydkU2LRblJchjVoc
         a5cj4xyGC8BU+T2YQDRz4VV1rh5NsDUasArKnCQMOiepRXt07i6vG+Ij4CZ8Juo10c4h
         AJSsp+qwGmfQ72aa39t5wjoH5wG5vWUz1TuSpn8qD8sYfZvN/SEsOzl9hwqif/EdxB4A
         oKcJ5FuKZ3sZhAkjPl0h2BWs660534OhOcQgxFgrhvmNUZHMJxYtnHRII3FScFnBe78x
         ygrUnOf/xT0xpDah1JDBJSP+C2Zi6QQaNhTxH/U8bfbTAtIijXos+9j207NAZEBzpwWp
         uP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772228918; x=1772833718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5VRHJYCLXwMpUbsjNhZsoM0ZDR4SP417vUWUS8Ou8o=;
        b=Uv3hgXqE6dIHHsEyDFrg2Ccy/+OZq1jX1TH7DNllattDsZuvKgAGeXGDD/NdY3e6tc
         3oHVN5dVgbHQQAhX6+hxAiqIxwj83J+qXFmmE7zkhdtvBOJq/AZNzj4SjPcpluSf5H66
         xw4CBCSL5SJp1ajbpxSNKfQMqSNVTGVciE7CzgjL7//4b0UrqiAOqgQh1h4ZMbqio3QS
         u1hLCczBcJO29aJXKpeV1Q3Kjd1049NCjSRnFssfaQRdBEVsWCXb6IWshZjwBB61D8Lg
         davHc0wLeQcXC98+fRVTaXQGPaPoa0b4JiS/1pT6r4H7sILDNL2gUazTj0HffKmWijMM
         q1rg==
X-Gm-Message-State: AOJu0YxtRS/lvUhfv5I5vn+yuSprc8haiptqW9nkj5v8IIut2y0DmH22
	kDCPkmaORl3Goss9bVMljdMO6LuuUKe/34Vn3REtaIaP7QVOaD+mfpsiyVYymw==
X-Gm-Gg: ATEYQzwdAEi+NFk1J7bFcHCIB9in5buE/o/sXoOTRxy33ca/DG9Op1DQG+D+Qe/wnrP
	YJbwZfwXjPzxPHQIue3/OZU5SU8BcR9+iQl0UchqN2arCmEX8JOPYEM7di1HOKoBxKiKQnnA2mh
	Xl/gpRkAzmcC7Hr7Q2M1SEoQmVI6I94lffhLAzAYxXOA+cj9Z30BoLmFpd1JquiRzaDvtWgfnnl
	cwpTTZqZ+8NE/arOKslh9DhZ840qgtkK9fL/OIzFmkOB9THLZeOIW0D5IdOZDLszs8IJr0TkXfB
	b10KwGGH3mNVLUecBl5otL2wOzdbiL7wNVO9JFlTnAMAir4T0v+0TJavq2YPyHCCVT85+yrG0v2
	6eiFaukC66u819arXm2Ghjt/k0AjjxsEBUnqBd3U0/nr9xTvA9KZ+TdbVFkdgqNtz4DJdSJ60qF
	wIKRLC9MIyh2oBdNbgj2jhD/6h+6VpNGDlV4Y=
X-Received: by 2002:a05:600c:4eca:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483c9beac6cmr72185805e9.16.1772228917638;
        Fri, 27 Feb 2026 13:48:37 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf894sm67354135e9.16.2026.02.27.13.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:48:37 -0800 (PST)
Date: Fri, 27 Feb 2026 22:48:35 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v3 2/2] t4052: test for diffstat width when prefix
 contains ANSI escape codes
Message-ID: <1d55bff06ed3ec046d26ac99650d74d3c4fa50b8.1772226209.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>
 <cover.1772226209.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772226209.git.lorenzo.pegorari2002@gmail.com>

Add test checking the calculation of the diffstat display width when the
`line_prefix`, which is text that goes before the diffstat, contains
ANSI escape codes.

This situation happens, for example, when `git log --stat --graph` is
executed:
* `--stat` will create a diffstat for each commit
* `--graph` will stuff `line_prefix` with the graph portion of the log,
  which contains ANSI escape codes to color the text

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t4052-stat-output.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 740bb97091..7c749062e2 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -413,4 +413,36 @@ test_expect_success 'merge --stat respects COLUMNS with long name' '
 	test_cmp expect actual
 '
 
+# We want git-log to print only 1 commit containing a single branch graph and a
+# diffstat (the diffstat display width, when not manually set through the
+# option "--stat-width", will be automatically calculated).
+# The diffstat will be only one file, with a placeholder FILENAME, that, with
+# enough terminal display width, will contain the following line:
+#     "<RED>|<RESET>  ${FILENAME} | 0"
+# where "<RED>" and "<RESET>" are ANSI escape codes to color the text.
+# To calculate the minimium terminal display width MIN_TERM_WIDTH so that the
+# FILENAME in the diffstat will not be shortened, we take the FILENAME length
+# and add 9 to it.
+# To check if the diffstat width, when the line_prefix (the "<RED>|<RESET>" of
+# the graph) contains ANSI escape codes (the ANSI escape codes to color the
+# text), is calculated correctly, we:
+#     1. check if it contains the line defined before when using MIN_TERM_WIDTH
+#     2. check if it contains the line defined before, but with the FILENAME
+#        shortened by only one character, when using MIN_TERM_WIDTH - 1
+
+test_expect_success 'diffstat where line_prefix contains ANSI escape codes is correct width' '
+	FILENAME="placeholder-text-placeholder-text" &&
+	FILENAME_TRIMMED="...eholder-text-placeholder-text" &&
+	MIN_TERM_WIDTH=$((${#FILENAME} + 9)) &&
+	test_config color.diff always &&
+	git commit --allow-empty --allow-empty-message &&
+	>${FILENAME} &&
+	git add ${FILENAME} &&
+	git commit --allow-empty-message &&
+	COLUMNS=$((MIN_TERM_WIDTH)) git log --graph --stat -n1 | test_decode_color >out &&
+	test_grep "<RED>|<RESET>  ${FILENAME} | 0" out &&
+	COLUMNS=$((MIN_TERM_WIDTH - 1)) git log --graph --stat -n1 | test_decode_color >out &&
+	test_grep "<RED>|<RESET>  ${FILENAME_TRIMMED} | 0" out
+'
+
 test_done
-- 
2.43.0

