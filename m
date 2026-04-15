Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7733A6EE8
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259674; cv=none; b=eOOyamJGgHtH1Czxy6WFyetQZjfYaycxmuT66Mtu9ICAEvAWAuy+pohFBb6U0454myEDQqcoLHiVxQFXFBFcruboTehirWkRBt1Bg7aaBhhvZ2Ea5PGYUPoT0iyMe1uoYpkSoQsBAVuriJ84/EbEYtbFMebgPb9G1m6+Yydf5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259674; c=relaxed/simple;
	bh=jcgDwukSC1DVSos1K65JQ8LumLuP+q4tiK46hKwGcgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ORtV4+UdrONNfgiFg3Rkf4kjnC4LP9KB7ary+76mNaGJi5jPxgunRtdfxYeCTAwJdvIxXpGUzcokwgiywh/I6WdkqrLyNfKeQEPkii+tLqfZlDypP9nPOVyrTONvwIDEu+zwINcuf9p+BUtlxfKcu+gz/woX8VHaMr+lYNm0wAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j89TTYR9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j89TTYR9"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50b69bf5638so73188941cf.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259672; x=1776864472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=j89TTYR9udjadVqVVF/qX72dk69/KR0vVqYzDciyjLjbmpL6AA0Jrdk05UfxIRwcEa
         SfGRi2MQ1nEXpOPPxYzWYeuKEXiQCDLdMQ77tohKoejhr4ZrkWg/ylk/8ZY4MD97lpe9
         rj9IB+lNIleZ6ciyqBJ9LQ58eojow5WirLZE5jIte5J/x/l4DWoFZWTg60THay37SDcY
         L2hqFg+lyl7CoAQvEQru8+q//m9JQDKd+/bv+jc5kxUn+yeWECCAH74rrtaWYrpL9J/v
         3m63898hYi6LQ3GCUlrtVWXYUnhxvrq97EXiHZsJUVdnd09aSMA8VBq0yWj3GJvgGaDo
         zvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259672; x=1776864472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=EutGcBlTbG0WaP5EAkK3AY+nlLYqeb0hbstR5wGx5zco6Kkt3mlkiwJS2T87uH1BQk
         qNhdAAHOXP275I02KJIgMmJhr3d1fZ1U/6/78O7AXnKCQx2kiPZaLbCjRpmh4o/CzvCC
         tBE0C7nyK775K4rxhMBU3waMqY/w6MyJ7LuizMD3kepz7vaMtJ3VMSsP3/rWapcsdiQq
         WFK5zAXd+1SNIm9yZNDKUsLy/clJQ+2ynnfdV39fiER8XX59JpN7uK9SqPb5b4WNlbS6
         /ChZ4MjQWpzouA0M/DflSRf/gXeTKtP0RhPqBD9WhlsTgx0Ae+ETW20Bb8X4Unu7sLdB
         g6PQ==
X-Gm-Message-State: AOJu0Yz/OPofNdqgX2Ve+2uqmm5h8ZicHqHixO7cYDmgHoFxLwlRx+R6
	S36DQoSykm6HcxvPQZhxlLfY9/U5akcywVWRMAlHL8M8fcz4wGNgBMPVFHQh9g==
X-Gm-Gg: AeBDiesDsI2DV7ExDoJxU9GPZVoBesVFMRnD1vxLny9RbM8+z3b4/oTeYFL9VvzLDM4
	mGqLI1vFAZkA0yy+s5KMf8ZGFYF9wXu/JCqLqlgKGpPWRbQWU8evgBYM7wv478piPBq+6bONxeJ
	VsslwznZ0ZepRMZkQGSDcOkwJLhmeeps3Z4yA9LYFz5EthQbQeD79THd9XKxOhgNdZrdlnzjADO
	9dYH/lCovkarpStdkXo85htgU0oDdL6s4Jsx6UHrJIeV4Bt64o4ERSqh+ZGeaN1MCfQXeyLSivT
	0g/yCL6XVwwadVkF/DMWRNSacFujauxDowgoqve8+VMhe6qIiLTX09k0WsyM7qHuFRRN/3WV9HI
	EKGnQZWwXh/sOnmak2wOgqLpfnul4buPKbJje8aCNQgZZ4az6lHzxU68Rfb841IIIA1C7oZNpIF
	sEkt8crlBlq0d7/d8hAj9CN1AvMg==
X-Received: by 2002:a05:622a:6792:b0:50d:6e4b:d8f4 with SMTP id d75a77b69052e-50dd5bd9bdbmr222565331cf.21.1776259671721;
        Wed, 15 Apr 2026 06:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1b012b23sm12916851cf.30.2026.04.15.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:50 -0700 (PDT)
Message-Id: <46e8c2b74f49d1624f4661f85bfbd9bc2454aa61.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:31 +0000
Subject: [PATCH v15 07/13] fsmonitor: rename fsm-settings-darwin.c to
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
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
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

