Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296223;
	b=nJgI9oVup/PRwHtqnEEdIrm2uCkS8kgZPwQDxRUdgqapoxjiWvO5xxNdFZt3qPpOcDsf
	 NYmig8XM5xi+R/mI4I8P311F8fJQ+qB0+VX5CCh+4ArefGnvmmZ8nPuaeaSQKwGnWcrQX
	 g8qoznNKOdINM34nATkF9DXFxnvujuc6n+M2vBvWh9qdOI0OG9toaNBJax7Ynoo6c9CDW
	 SXOCKS2OD008HxsQiUuN1VHWgeswPwOH6j2WCq1LVQStyeYFFBNiCKozVRpnKUD9XWwYA
	 6TAOPiUbDoTTXKKCyXz9jnBXf/tZSwu3S8oue7cZBcNaHUnTj3ho7zG5RSKLFN1TcTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=FI675Eq3kAqyufGgyL+ae1aSnWyYNoA134Y0rEAj5Ds=;
	b=3ne1h/UtYhdtVMRIM9qz9siiL9yl0aRo+w6V4UQd2aNrSj8dSTFHvIXKJxljByg+khfr
	 R/p2AjHfAkI645Y6O37AnylBck8k0nmNj6AANRysGz7G0CutDPzPk787aIG5CmXi/R4y/
	 SQQM9dY5Jr0Uz0eYxm8MJoewpfX9u4YoFf1YD6My3wIS6i8bZ+NrP8jMFRl1LyEYW4c1G
	 8v7EtIGoHc3E+xRzOOlclNGMl6MYx+XYzutpvFgm2kqURjKs+j1WnweUtywn2uLrOmrOr
	 OqSWzQrHYbIX9TE6o2ppix6h8h+idKNV1g8d32sBNx2WFe9BYnvFBMvMbTdSjiKvGyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoTnVb4t;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D660A2607
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E5D660A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoTnVb4t
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8451a619da7so1069758a34.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296222; x=1794901022; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FI675Eq3kAqyufGgyL+ae1aSnWyYNoA134Y0rEAj5Ds=;
        b=hoTnVb4t/d/Nj1biNPCxyxoUFxvidE1+4GJHvlAaUjKTHyvXDtVk+S5cybL10hu/Dr
         Lajv+jXgBzJ4NiUk6HEP3ePem8r6l6M5XlDEQVun8RmtJsWCNNBTUR6GOGInswZm3Wlv
         oobql7+L1bREt5UPQAKTVuMcpmQ0/foHZhlhe1tqJx1a/80EbtOCNK3cIZ9IxrpEumii
         XFb7rDjXZDsMTv0y2R9WyuAXeCE//Ox1+g3UAtPoBwJtyxTfY03attj3rSHjkqfWd9BB
         MN3xplHVLriDqyJRW+y4g23y9wzRljatDWuaeA51s2NInQPaYE1lww90TOeAmOEcSCsC
         XHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296222; x=1794901022;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FI675Eq3kAqyufGgyL+ae1aSnWyYNoA134Y0rEAj5Ds=;
        b=i98Dv5QHBuk2OluhttCJvRCnFyomQfB95uH0A4cfoRaCbZSVKXNzJMvzINMGdPjqJn
         iMf+Cv+Kl11rl//XLo58zgkJPmAgRZD0wOFvnwIlPjKNlGJQDb3/eYWaAryLIazBGJax
         GF76bYo9Y2gjWSniH7I0olopJvusy7llcRiBDT8KZcgaeaSZOwYzjAe0oPNPwGfsL0HN
         hjNIq8XiZ3X++/izkV+9utpXKDAuocBHjmJ291A87AYw5XboOvFi3Vdn3i5UU4+9jBd5
         lv5HNZDaXWkLsdy9WiP3ihnyU+cQ0D+YCb+VR+vmwi8M8VanAdaj3qs4vsGP8g0YvKDe
         UKbA==
X-Gm-Message-State: APuU4Z8g9J2k3n0ESiEEg3xQhdN9edvwWyYgr492LrXHdusawfD9MFHR
	//afVdlBP+KHqAIKzUoHPIlw07kc0iEERu+P/z6e/pCHKVA7dtUPt1uAkW/DeV9h
X-Gm-Gg: AYBFou0hMwbwc8U4Lb9LN4rTKluoGzljFdtjssQkmjzciOQbMd6hv/fQjmIxhItv6J9
	xgUbDHUqX+lkfB7Q7xNjF/ur+gMfCrnjtfLpoSej+K3UqCyeVTnWhfRbNUba20Ff5NZk9DFEpkN
	dQbMcc1WYyz/lUP4ThbRvzEVgLnYeDNRR8RmlqoSEsmVdpIaZYrYV5fgd8zS6RGtYMchIKontA2
	XOVPpGHDGXyoHkaIFjVFWlvnNYgvSNXfuDZ6G/lUM/ygGSLUf9GkfraHdqqHTngpYD8Hvh7s/t8
	JzhDhuzQlRqwN4LE0PEsjxzB/ZP1JWkKAzCLnGWBov6Iknal/XRc55tTiq3lUipJbrS+RLyRKNA
	nVQ/TEnvlK1CXGmE60RvJPIQJNI3CHE4q+VhD2zOMwzjzQtyhHLFOdxwWIC0Qx6fOZDImDQMJ3+
	0GqzMjxLh1HUmT+EbIqIzXQC6AqX0oqPNuwiF+avsxArj+1q71i15xSU05nkaIMVH6mhSq62IDq
	Lovi2ZyNG2Pje9RD4n5yfyKU+DKdHYkW09NC7wVO5TwxFMn4tzEdK94C2Cq7B+PcN6zFZqVfPhK
	Y/LLvAGVCZSNYi1sI27kWENG8yD5NREVtUA=
X-Received: by 2002:a05:6830:2707:b0:85f:31f:7643 with SMTP id 46e09a7af769-860dc70cfd4mr1331426a34.7.1794296222051;
        Mon, 09 Nov 2026 23:37:02 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860e5978892sm226934a34.12.2026.11.09.23.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:00 -0800 (PST)
Message-Id: <6c2a671a9270133fe6a0ddeefea92ef55a9c62a8.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:35 +0000
Subject: [PATCH v2 05/15] grep: handle NULL value for grep.patternType
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A grep.patternType without a value makes "git grep", "git log" and
"git show" segfault: grep_config(), which all three use, passes the
NULL value to parse_pattern_type_arg(), which hands it to strcmp().

Reject a missing value with config_error_nonbool(), as grep_config()
already does for the color.grep.* slots.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 grep.c          | 2 ++
 t/t7810-grep.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/grep.c b/grep.c
index 1d75d31421..ab082f963e 100644
--- a/grep.c
+++ b/grep.c
@@ -71,6 +71,8 @@ int grep_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "grep.patterntype")) {
+		if (!value)
+			return config_error_nonbool(var);
 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
 		return 0;
 	}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index ac7ea9cf8d..d323927e54 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1551,6 +1551,11 @@ test_expect_success PCRE 'grep invalidpattern properly dies with grep.patternTyp
 	test_must_fail git -c grep.patterntype=perl grep "a["
 '
 
+test_expect_success 'grep.patternType without a value is rejected' '
+	test_must_fail git -c grep.patternType grep "a" 2>err &&
+	test_grep "missing value for .grep.patterntype." err
+'
+
 test_expect_success 'grep -G -E -F pattern' '
 	echo "ab:a+b*c" >expected &&
 	git grep -G -E -F "a+b*c" ab >actual &&
-- 
gitgitgadget

