Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886562E7F17
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710790; cv=none; b=agFXRubsZMO03sonzsWuSfEYD3TLCGtdHN7VWJcwFM0QXAqM/byBlbagKQarHMIQ2WiG7V+raAOfOMTOqphPleXlsTFN6Oe8zmsUKi7VIqiHEjctQXaiQW0o1uUH98iX4J+J4bQOa00Wo2SFWKLhZL9WABWBbn8xkw95mKX1D7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710790; c=relaxed/simple;
	bh=jcgDwukSC1DVSos1K65JQ8LumLuP+q4tiK46hKwGcgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IKTf4uIJLs5yYQgbk1Ak4vmaO9EWpWg60V3V4iQ2cgLz9e/bkM6+XAWNwJEOxKebjxFNuQsHNOmY+Bh5AW9eG6vtBygR6ChjoPzJhDe6MMRmYDqvOl3pb8CWQxy1WtwcULb1KHQXzL6kBSO0kUwy09HOY8r/bLNBoFcjtRVcmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E00sDUQP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E00sDUQP"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50b3488fb31so5243251cf.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710788; x=1776315588; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=E00sDUQPJdWEZg/Wj6uq8efA2z7I2My3LI285uihO/vBQL1HLzlXGBRDlXu+Lpe+ph
         P2He5HJkuAX43v96UUWM7yMv+X3xryruVlHbjkoIeCpFVd4XDom/YmWMYGUv+rkj6spu
         yDE9ae74I/3ZheJePjszPB5NuNj/Mrs9JYRZbp2cf1zqhrD9iLV9FGuopOSewkkxNM3c
         s/4gNAcpAj+IXymsNAIqd2utAcP+J7ePOTRCs+28GdhrMDN6v3tn+uyZTKurSg+aFeO0
         +xld19My6Fv+2XgnBFzpzz51ZiXh9DaXZxOxc5uUqz6tLMPOm8rM8xUv3pCrs/YeeJ3H
         eE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710788; x=1776315588;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=EulOTdvxUycvCPNgp++Jwl9I8Cm3Igv7jUJH2NED6nSPHFG0bmeC/CJxFjgDgCyAti
         /UxrvdQZ52EriYRlIinjsIM4hSLcZQQaD40RVRJZakdtVSyOmdD6OLiTKXq//A+GF741
         zBq11ZEJsZVu+0mFMxifOO6GCx4edDk6Pah0y9LDTAwHZGvDPbrb/qABOqxakEEKyNSJ
         p0TFwzMMnyCmepigxa6ygGTSgd7ZBuLiRMZfuJjwqTK6S5qnrIiORqOi3Eey7OKuXsFK
         yO9mCWDECf12nJdAJo2uTXZ5bwRVMvdczBwjyzBFoCeZDq+7sYk2LfgI/xLI7q3J12Hs
         lFIg==
X-Gm-Message-State: AOJu0YxC6RIbn7uzAd5/LhGCyMirbaOURGHzK0brETqAdnjDKJERZaOk
	usbkw78iILXjJKu9ijs/Ofe1JScVTiY8X5z0ChhUU/VCFOxXiJ7P9HQvrHM+Uw==
X-Gm-Gg: AeBDietiF9qAfm8NuBPp3KTimQqySURMxk+WlOM4yMaZxcuFx/l/RHv7nbciWUOthrk
	5NMhCCvJNWdrkpGoFYG1zSlBfCVt2TkACaY8TnITvpMAeBXEGBl4WhgDzMKprvac+QwuPGiwPVa
	ewOI989Zjur/s+0kEgDc6lYKVkRvM2OBWcUrxMVOTCJZlLzEpKylVlLNVvcC92rq6MMqGIkXvGE
	6uEgGIs3zBz6vraZ9r0YS/FQ6HFFsXlISU3dKk5bWwMQ0leiTW3rko7Lalciw9Wmqp1AQy763f5
	6jswKAQmBotEbBT8k1uxb1qCZZrTJIn5/G1wvyyT63IlQUj55epxax+y1XDBANlp5r3pa3hKv80
	YCB22Fk26jvr6le3VNalM39blNkS59M8ZFyiIZRJ3YpZC5LWVjNCMxafjjSag0KpWuzWF2qb2oU
	GJCAVzC/cDtkTkMaOwBUP8vmzCls0=
X-Received: by 2002:ac8:7e86:0:b0:50b:8676:3cb7 with SMTP id d75a77b69052e-50dc19b1231mr27851521cf.1.1775710787845;
        Wed, 08 Apr 2026 21:59:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d63962c30sm150408631cf.10.2026.04.08.21.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:46 -0700 (PDT)
Message-Id: <46e8c2b74f49d1624f4661f85bfbd9bc2454aa61.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:29 +0000
Subject: [PATCH v14 07/13] fsmonitor: rename fsm-settings-darwin.c to
 fsm-settings-unix.c
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The fsmonitor settings logic in fsm-settings-darwin.c is not
Darwin-specific and will be reused by the upcoming Linux
implementation.  Rename it to fsm-settings-unix.c to reflect that it
is shared by all Unix platforms.

Update the build files (meson.build and CMakeLists.txt) to use
FSMONITOR_OS_SETTINGS for fsm-settings, matching the approach already
used for fsm-ipc.

Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} | 0
 contrib/buildsystems/CMakeLists.txt                             | 2 +-
 meson.build                                                     | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-settings-darwin.c
rename to compat/fsmonitor/fsm-settings-unix.c
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6197d5729c..d613809e26 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -306,7 +306,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
 	endif()
 endif()
 
diff --git a/meson.build b/meson.build
index 86a68365a9..4f0c0a33b8 100644
--- a/meson.build
+++ b/meson.build
@@ -1338,7 +1338,7 @@ if fsmonitor_backend != ''
     'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
   ]
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
-- 
gitgitgadget

