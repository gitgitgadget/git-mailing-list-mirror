Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480D13B19D1
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981448; cv=none; b=kgDHJeZlYuyftcWj5ryLU7YeJFxD4vKH5GV5mSskzIUhhr9aBjBPIzh7636kofluaPgIfQCx8CQcpndM8E0e5MQwwyKuBkTGPfHVbj9GlmUndQ+R/htpKaMHZAfcWh0f2CnxP/s4tjcshuU3DlgNtCxpRw9zBBsZZH/ftn7ueNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981448; c=relaxed/simple;
	bh=T2gc4X7ZZRpun11O9hyf1XCi3A6a+rsn+E8Qx1Vrtd8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lVa/Vx+zl7G5tZfOKAnqW3ZvdgIQwCBXLWez0TilZ1KJOZZe0h0qtLO+rWDYpQpfg/yQZ0Hl8n/8gpIxqBygk/G7oVCSQmMM3XfUuxjs/Pg575GU+AYWcaMqZiUiUOvXIypoEe0bB4v7gpN2bndO6+ouOdZYGUUhD3YjHkkoc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqbhN/Z8; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqbhN/Z8"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so585520a91.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981446; x=1789586246; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ILyrVVd08nn+N9cu/FXvgcHG6hzZpAgakTjwOtMYuNY=;
        b=NqbhN/Z8yAjP3H6sl+Ic/I+oKrIpIhQ0s03AMmbQ0FZwGBxkha9hpXODJOqhf5Dd3b
         ovgqyoh8RkPT2ZYh1OSz/MI9RtrLz9WDF68bFB7EZZmppvwXrjtXtKyXJTPf1Hfqm22f
         feb+/sD1UwKKTo8dXivbvCSRAZhThhBJR8T/Oek2twZ889j4Uv4eHTw3zZpEbn8Zb8KA
         0mHK69FA/MCBoL1qx84U2DfGszaJi24zJ89PCk5kF53wDZHFZkTSJN7Fu8wMt16IWlZX
         lDd/Hto9vAjVm2cCN0RZmcrdUMAarmM+IFwtZBkYcdlyRo/D4nLzJEodwyRRYYGyDfdB
         D0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981446; x=1789586246;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ILyrVVd08nn+N9cu/FXvgcHG6hzZpAgakTjwOtMYuNY=;
        b=nbz6ZXD+2Z3i0co9q5KWEdngSUHXjGSVXrlAjq1hLJg/vKtNeXATmkAmC2LWr/bAyP
         DndSOPw41uo8/b4HgCw7ARmOVduCp56T6DwUMH4K235naLyXAWPiamlKSWt588PTfNqP
         +AssakcLjLhg3x2vkkImeq45LqSsZ+iilPx09MaStzeu/VSglH29RrTFyS/BkQEeQNU9
         zQnMirXIry9R8KDiGtYyJLf3QXwdlyRnqsZk6Oa0XrevWZLmPfngc2oTlcx19G5+uqXl
         3GwvsgW5Hg3bwR1sAiJy7TABZG1z8O9RENQAAMV+JKgi1rlqxy40aSRMoiZRH9WoJnko
         WxiA==
X-Gm-Message-State: AFuF++nMcKbcgFDo51RP/w9Kwpe46g0sjCdjuAjzMx0wi/TZHs/2M1LY
	Te7Uh5V9iHDJ2IKOuwnyV6WVRN8AA/5+1gJDaPHXGr3Zm9m2J3SW99Wc7b01gg==
X-Gm-Gg: AYBFou0I5f9t06SbXpTXKSvTqJqJ89oIVhTzWQnvbyYsKdlMY14qVooNdfufpWJmvWD
	IG3LPG6J0n51wefTGi31/LPDw1KiwDUSHaPhgxJ0eby9DU3uijHDpbBgvoDWl5fo52lQuughlUW
	eIUnY8w4K4Ci4wXeKOLn9DXENjgz0c6hv2wuk/w754nm4wgJzYBHbOSZDJfU53E+5ZImRBIhJFg
	lgWg7/9sgbdlfrtHFZl7So27jY2toQLq2fvC0JyvtNs7JqLqAdEQbxN7DteOS/mlYHKCO3mLgwZ
	4C3YVN7gLYzAZ+p9HXf3IHfyod5m5zOiP6cJm4zZMgC6Ql5cEEnBUhRY2KlPMLLNMcV6t5Mp/0Y
	+95Pi8MJhQZWdtry4DiuQTzsiOJtdhx+bs06TIQOeoar61mvSWfc69R6joYmCpp2bbyZ1Y1bTzf
	iaIJg1FBKXfqUWjViUpKdHIxBNrP3kfLIj/Os6/6NpZ9t+CpaftCpB/P3VoOu/gtoHTpLxY/lv
X-Received: by 2002:a17:90a:da8d:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39d709c049fmr3736838a91.7.1788981446434;
        Wed, 09 Sep 2026 12:17:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397d6d1becsm8358814eec.22.2026.09.09.12.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:25 -0700 (PDT)
Message-Id: <d67201f9b3ad288373fcbb73fed15356b7a795d8.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:09 +0000
Subject: [PATCH v3 05/12] mingw: avoid over-specifying `--pic-executable`
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

In bf2d5d8239e (Don't let ld strip relocations, 2016-01-16) (picked from
https://github.com/git-for-windows/git/pull/612/commits/6a237925bf10),
Git for Windows introduced the `-Wl,-pic-executable` flag, specifying
the exact entry point via `-e`. This required discerning between i686
and x86_64 code because the former required the symbol to be prefixed
with an underscore, the latter did not.

As per https://sourceware.org/bugzilla/show_bug.cgi?id=10865, the
specified symbols are already the default, though.

So let's drop the overly-specific definition.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index b667c693ec..f6387f4c7b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -757,15 +757,15 @@ ifeq ($(uname_S),MINGW)
         ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
 		HOST_CPU = i686
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup -Wl,--large-address-aware
+		BASIC_LDFLAGS += -Wl,--pic-executable -Wl,--large-address-aware
         else ifeq (MINGW64,$(MSYSTEM))
 		prefix = /mingw64
 		HOST_CPU = x86_64
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+		BASIC_LDFLAGS += -Wl,--pic-executable
         else ifeq (CLANGARM64,$(MSYSTEM))
 		prefix = /clangarm64
 		HOST_CPU = aarch64
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+		BASIC_LDFLAGS += -Wl,--pic-executable
         else
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-- 
gitgitgadget

