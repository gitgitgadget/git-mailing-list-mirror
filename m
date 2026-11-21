Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282440;
	b=3qoLOABwvpq8ceNR0oB6LNL+bVA88VzITleGv9PZm8/kDHR7dWUMr0kMupFp2nQy9aa5
	 zZwKTJmixRTC49YC/Bg4rGzCULez2MTpBaHsuWiE94NwKieJ+RcuAtkGPCKq0JR6ESrB9
	 O08hfsgK5fRPBNhOWA0MVeOFyFmTt1hR+7SsYdIdTq5YVYRBkVzc2txheOQQEhFPavUn4
	 GNdHMywbf2vqREqtf6kLRTzWicPNO02RubznMsQRkaU/tXtbK8v/RLKjWU2GRfePLwXHL
	 x7K/RwhJtFOeGB5jCML9i8pbQ+9FVb2ScqLm0uwmQmRz7+CLHYdprug47dC9Kf+ra6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=dWUxyYWgRu0OIoVNCXlFmCqHl6luCTJW/hki0yYuQYg=;
	b=zdQ57bBcvcNz2EQ3B2cFrhIf3RRNFko1H1vYAWFL9QnfaXTRWF7+MEMQt3iWdn+9g7SW
	 GembuyNItADGheAQbxSm7Ygi4qKxTVeXdjc2+clpZAamz8V/3lsK4IH7NWheS+2XmALlz
	 NuZUT0q448IQQhSfuADWC06bti3sx4Blu2WklDeVnqXH/B2rG+FqOqyYSLnnVN2052iPz
	 ET3U2PzKr9yT29QpSQpsKBRj2PBknvzssWXUR0jrpriH9MGLRxCtKZK80z5GkOip+cCaT
	 KQ+AHvq/ZH0FKanm0AOBejYE29lVHrpEom1lblMTOkDj7X+1rJzB21JBAtk71uf3Uxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QpSUpufZ;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D8606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 17:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 561D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QpSUpufZ
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b2d14968c9so18528617b3.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 09:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795282439; x=1795887239; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dWUxyYWgRu0OIoVNCXlFmCqHl6luCTJW/hki0yYuQYg=;
        b=QpSUpufZoSY5tMJ4tqo/+2qenJzWtSYHXLgf/xLfJx1L/ARZUGgYNzY8+6elUhgZNx
         wW6AUlwemtxvMate0Dg6wgW0+FRWQFRXZ7IjZC5V726u/7y1oNSsSuZU6Ahvv+UlSmoW
         jb6NT1VQ3HC/jhrY0lJ1yUnHOwPJhpjTGp1zDocAsZd7vxcJBkohwfiP/KiIj3XDIY68
         H4uKYQAGJTOhvKz9PAhW21Kp6n+5L2KG/ywbv0nxqXKGsmvmwrKwr1MstrkzeSi1XD4F
         ZnJnHkLNd4Jo5agy695lG4mPjvL5DszYMRZELE0xE95MB0CA3GU7Jnd/THME3QWPSW6I
         HvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282439; x=1795887239;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWUxyYWgRu0OIoVNCXlFmCqHl6luCTJW/hki0yYuQYg=;
        b=FS8hFS5BcPy/T5ScEpyAd9hmMcz9QIV80oACKWpmZii69wnw5lOChCT73ks4MSjPMj
         tIuM/xJEFh+LUY7sF/z6eagKwlLkUGukvFZnQWD9f1d7WegHYGpHDPpvy0FNrEkgZSBw
         C2UFlpPcWkr3kXJyLhg1VObrRSMWxlJApEQRXevEDLqP3WX9BEJKyve9NgqGGziUUnJM
         fAmmHIBkc9AoS5LHpEUF12eRecO+e1p2NOxTE/mgr42OsEFi8KT4xRZjkeEra4bgaL1N
         mWsLTC80wp5qbvP98B37CbwAUTds/g5u5R2l3OI4jGBoTUJVk//DzCpu17Aq+AtQcAeu
         CHWQ==
X-Gm-Message-State: APuU4Z/79EKV2GV/TzjzGIOB6l9oz6UYs6ExUwR4ZrL0M7bdgfDQgUGS
	j5UgSpEQWRQyst9OSAA18Y5hkVBh+33k234Av4FU+u0j6/tt2We1XIitugxODg==
X-Gm-Gg: AZFdTZdUJHyw1FTJGK+hjBQCrEckdv3onYjUoxk4/b2a7fqeFtPTKSvpvFLka4u2/XZ
	VtMIYtWRpgYIv8jqLhyC5NGeSBEVmCIpqjnP/qKXrnMOTN47aj4WxBN5BHH4j6Me14JegclmgI2
	wZxm1vmbw7eAAbNjqvtlAVlROBwa+JatH4u8+U3FNlYgNihpB0EzwMOyAORGq/bcmGiL0meo3KT
	DdB40owyruxKIsLJiACP2guPnZbHiyHUhhg1u+cIMNoe3ZXkmho1vblTlBCAoaFjEdfVH/xe+g3
	lC7rqa2Jo8/c7zqqMFDSwUlPgSyQ64vTVvhnDi8H5NXykNEOS0hC7OlqqyCQSw4C7CAX4i6nTE6
	NtwxoD54fd4zPSkk4GTfO0MIWpgMZlAXICUg2QrTNEzVNOsT/SgBpWuENoHxFbG6jFmqxkV0zsA
	F0IoCR2dNkHtbqxngOscqAr0x64zkOimQ/9OV/zknEcRR1h0Ayzms9x442oKt7AWHTvI5SEbajy
	QpVIamCYKBDyvujP3DODhLICCXj/fApWRHAtWTQs5TWcc1l9u3x+g4mAfE9Uiyi3EgX4bWs9t0h
	1JzkD5OV/l+5agAnh/9x9IL1mbXNgIskVw==
X-Received: by 2002:a05:690c:7409:b0:8b4:d9d3:5740 with SMTP id 00721157ae682-8b52032cb00mr23234267b3.4.1795282439331;
        Sat, 21 Nov 2026 09:33:59 -0800 (PST)
Received: from [127.0.0.1] ([134.138.58.166])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202bc515sm27846357b3.19.2026.11.21.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:33:58 -0800 (PST)
Message-Id: <pull.2500.v2.git.git.1795282436976.gitgitgadget@gmail.com>
In-Reply-To: <pull.2500.git.git.1795279741855.gitgitgadget@gmail.com>
References: <pull.2500.git.git.1795279741855.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 17:33:56 +0000
Subject: [PATCH v2] setup: fix incorrect word in code comment
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
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

Fix an incorrect word problem in line 271 of setup.c:

will only complain about an inexisting file.

Change it to 'non-existent'.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    setup: fix incorrect word in code comment
    
    Changes since v1:
    
     * Update commit message from grammar to incorrect word
     * Change word to non-existent instead of non-existing

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2500%2FOphirBleicher%2Fsetup-code-typo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2500/OphirBleicher/setup-code-typo-v2
Pull-Request: https://github.com/git/git/pull/2500

Range-diff vs v1:

 1:  6cc8123ca4 ! 1:  3b7539bd5f setup: fix grammar in code comment
     @@ Metadata
      Author: Ophir Bleicher <ophirble@gmail.com>
      
       ## Commit message ##
     -    setup: fix grammar in code comment
     +    setup: fix incorrect word in code comment
      
     -    Fix a grammar problem in line 271 of setup.c:
     +    Fix an incorrect word problem in line 271 of setup.c:
      
          will only complain about an inexisting file.
      
     -    Change it to 'non-existing'.
     +    Change it to 'non-existent'.
      
          Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
      


 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index cedc031c54..140f1926c4 100644
--- a/setup.c
+++ b/setup.c
@@ -268,7 +268,7 @@ static int looks_like_pathspec(const char *arg)
  * diagnosis when dying upon finding that "name" is not a pathname.
  * If set to 1, the diagnosis will try to diagnose "name" as an
  * invalid object name (e.g. HEAD:foo). If set to 0, the diagnosis
- * will only complain about an inexisting file.
+ * will only complain about a non-existing file.
  *
  * This function is typically called to check that a "file or rev"
  * argument is unambiguous. In this case, the caller will want

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
