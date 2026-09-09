Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644A492E2D
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981446; cv=none; b=jysD+ZFE+9SaKksPYg4b1fEXtxqeM3rC1p8YzonwS2hEkq0cmuV4RSlTlIarbhwmqEYxcmYSTEi5iv0Xv/fgn3jQrqSkE8YQIkP+kg/rVNIdd5ZSl7w9jv38tklBEgTkEjzw3l7qTVFp5F99yvhhVw4iMNKf/9tD6SvdAJMZLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981446; c=relaxed/simple;
	bh=E5TAcKaEOCi7ReHacavmPN3FxQB+iBTnP9fH3OdfmNU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EekkfCJeUvgzGYWE+AUHWZufhVSDJr0eryFLTETFBwcn+nVnztHKXG9FBOEKkCTv8Pzn8WvFKyXFHFAnb8ih6K3epOwKqQlAu++Mg8kf027KjsSffXgUj4rLgsdyGz4l40WHWFByrDvstGZEOmFJMox3LQkQesEtstQaEGnlEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO5YpM7Z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO5YpM7Z"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so6734194a91.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981445; x=1789586245; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bnTtnwxcdY7RASz7pb7KoB8/awq+9cPpOpxZ/RWp49s=;
        b=TO5YpM7ZpDYxejFSg1F4BrZct/UB1meisgByVkYmpHVe7pLADz9w8RS0Q6UY6tBC/Y
         8lHDX0HHSxGMBDkNZHb0UBIJcyLp4YWe/OILwlrLesvLz52PfmEVIqakOo7+A4Q+eRVX
         XXmPrt+guoneT2HOPlaXal57OTIzlHIaM7c3/H+9icdwb54wZe9cOEP7F25iPJv8DCfr
         hYuNgb/LewroZmFEm51KKgxGHyCv8cxnezUUvJ8CXMz+F1f8O628GjKmQqJQSncCuzv+
         z6O4VwQhh+t+1g88k/n3FBHbqz4D0qeSGfMjlyMwb0w8gulvQF53dmk7zm+4hUbDmPks
         Tgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981445; x=1789586245;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bnTtnwxcdY7RASz7pb7KoB8/awq+9cPpOpxZ/RWp49s=;
        b=MoNUHp6025GSIthBwiXPIIg6wV4w4RzWUAXxVbaqYQb7jLyU70qc4BcDZ8DsqcKVrm
         8V7NtJ1sd5+zTtzxmc7ef386koDRrMB9UhBVGWZ7iWDBeNa4P4Mhn0tTR9VfbkGAEkJW
         dV6BPhoXeG5KJPlxW3vACFWfONQ2DER0xEZo3YBftTLxxldx9mXwKMJtfFTidf53nk75
         ATgB1bynKjPSwas1lfxL3uD4swyZN0f6sOvTm663szKkzmNys3ZQKb/+z6DUIf+uDiOn
         zYxQm57sPOg+6CbouMP4uTF10ra7P96VprPbp5zFD2TvJnYRk1EbCL0TIEnhdnbNI7Ea
         mJJA==
X-Gm-Message-State: AFuF++mv3B31RutwsViGIn8NwPuVQonGSncEPljfaJwR8O+AnH5avSpO
	YCruVc3qCU3vhGTAfP+cHK+3A8VrQq1IfPosE+rtF439G6hmwyddYMSnkBWnDg==
X-Gm-Gg: AYBFou1EkeSC6dfDwhhEIWoBcTnba4SRlxJnV2SbjLKy52dCjAckqzA6ZNtFdol+9cf
	vdIw1PUaR44njIkc/WljDaVIcBE/OmCn1gaokVqL7tLBCaRrsJp3UfRcbgVZup0Q7Qw9+ZwKeqy
	9FrQAEo8idqyt2r/GgcLcjZpN8KIrvzKvXidFZEexHGaE2cQ7M5HL/r/jPX5ejz4/qbq+XFzITK
	BAQid1wrBBzhF/aoZmX9isPpN3XNDakIWwYKzWvIh5fkNK1c8OxtQ3U9FQTg1bylbFlhGMUgHbc
	jahdflXnxHnccBy74n16H6GZ9ZU0NraUrHlUD1PBPnzh5nxxagjn5TDfD0Hm6alfCu+eheTepcN
	Nd5dawnxQl6Ev097Bbad8nR48/vsN9o3+WR8xv8L4ei4joDWtnLBOsWtQUbk/Ua3oI7OgQRpzoF
	ROKq2hyBIpu7buVEGlV24wRIujZcKVRyLYpwRZ38lYXL5z9WEq2ivjooXGRh3bLll6k6j3UAH+
X-Received: by 2002:a17:90b:5106:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-39b260feb03mr53328154a91.4.1788981444800;
        Wed, 09 Sep 2026 12:17:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm46548584eec.26.2026.09.09.12.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:24 -0700 (PDT)
Message-Id: <ad96aedda6a2b22b80200a035b714ca111b97cdc.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:08 +0000
Subject: [PATCH v3 04/12] mingw: only use -Wl,--large-address-aware for 32-bit
 builds
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

That option only matters there, and is in fact only really understood in
those builds; UCRT64 versions of GCC, for example, do not know what to
do with that option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index cc0ed63af3..b667c693ec 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -757,9 +757,8 @@ ifeq ($(uname_S),MINGW)
         ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
 		HOST_CPU = i686
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
-        endif
-        ifeq (MINGW64,$(MSYSTEM))
+		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup -Wl,--large-address-aware
+        else ifeq (MINGW64,$(MSYSTEM))
 		prefix = /mingw64
 		HOST_CPU = x86_64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
@@ -768,7 +767,6 @@ ifeq ($(uname_S),MINGW)
 		HOST_CPU = aarch64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
         else
-		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
-- 
gitgitgadget

