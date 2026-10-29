Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237319;
	b=tmrcoDgsHXGMLrjFNo8Pi5tPtP5n015SD8kmXpe77wsgPhF90FGmf7R22zrvCQmjea3U
	 Tp0LcQBhD8M4wFqVpOBkpmsTNHslrJxq2oBHc9iZj5yiE9sachwnpIaMqiQ/PwdvTYhKv
	 G3zKE4hADX/2D8lBnnsFxefEgseZg5YAxPXnW3vsSF3aDpUvMTbV63akvZsJUeonGA6i9
	 Shf5jbKQsjJanvw4tUj2TbkhhV+YtETnGq6PlyNECkzwardGjMkco2pUGTUQ/DqJq8Y7e
	 zrc4txp5QIjoT7ilZAnwzlbhYuVxbzY6w4l3qg4qXG8/eQaaCXjWsM/Kz71XRGED7ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xv7sbkMVcbslMZLnsvxC0AhqN52qkDKxRsjdDm9QkmM=;
	b=WgfGRDsjcqkvhgVEApSU98+A4h3RkGlW+SMjAoEfsGF2a+8aXT9CfGjClDYV3MB4VuS0
	 C/PiwQbbwCyxsooduUE4TqpOLOKhzlIbYDcSxdpq0hxd6tHmxrGPBe7Q0Yug5lw3TGcso
	 kzwZtVmxziDgaPjqv5NHfq5Zgjdk7yyzVe3jjOR4z8dq2ikXThZHVYjH56NyKWcNdvveP
	 QM9qi4BohlsN9/i+cOY4wph8V15GemAF7duqk9MiB/gZuOGf+Y+HWFdwqqdkxNIi+mrDt
	 l2PeYMu3XZKYzkC73zF5oFM2Rc0tJ/E8pzQhISRP9WSGe+rgDcTWrlaPKfi9YzI2Gug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IvsVwk4w;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83886606A31E
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 01:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83886606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IvsVwk4w
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afbd2c386so941168f8f.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 18:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793237318; x=1793842118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xv7sbkMVcbslMZLnsvxC0AhqN52qkDKxRsjdDm9QkmM=;
        b=IvsVwk4wETxx0bt/ZUXTNLVFqaTTD97hG9xZmJVPfy8tOgzncOo2kcrfETvHtvfH0w
         8+6Jra8qNDQ764sP2QCMOHuxz8tLdinp2IIJwqGyS4ul4D6bb+W8v1LUd4Fo4Q76ABjM
         eX+Xvo5cxJXAD13YYESBuBt+Lnsx0F6uh43ocdO1GzwuQQ8P4y2QBiGCSVDedJU/VFmy
         I7inoEmerRKzfgcsMlP1u4/6Rmhv6bB9S/ctNGl8Mp1B03wdzGsBm1S42vV/Eq2omB4i
         91uHfLCkg6GJwYqcLvgtiZDGncBxeJcscUikjARE0gugD/owBorm+ncWdiCa2c+Uoycl
         jAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237318; x=1793842118;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xv7sbkMVcbslMZLnsvxC0AhqN52qkDKxRsjdDm9QkmM=;
        b=qu1xQ/1dP+R4Cx+G+S5/bDPzaTlsfI3qvD9RyNqAll4ekBDqLJQwCmXokXU46piKfa
         MJ45u1RwTQ4aNTOX2rh/edurtR+WO6yHzRbArKhWZ8FQ2gYKa8CNnbGE4mZM+qlN3wri
         ZhDQLK4UAPwB9Ox97grAhUIYR7vvvf8UY1UF/ogJJk+4HyoDDtby8oWap2eBiatc1hyx
         AyWHNBwxYXFFwmYTdk1vcz01uWmu4YDmauRK1d5K5qjnjl30VQ/Z/RJABq9bkLLbXxcM
         OiuD7T2kknMWpFN5i3azJO0QPzvuho7PFHRROcWqIxhOcRgSpcKB9ygJ/KTB09Q0FtUV
         8Vog==
X-Gm-Message-State: AFq9FYL1XoPYv1wIIs8F7wb49xxJhVBh4OMFohWPTacbiVqOBq/UUCyt
	N0bCAVjPOzddB0Q0w66H3CC/4w6y3rp4Ng4pZeaBa4+TG60rxLLVw//KVZRMhlpQ
X-Gm-Gg: AYBFou1UmIis/dTPeCxqGmSJGEnnxvShr6VASSS8GJW6H+m2fGufD5GbZUIrmafOjld
	LRJIy97dM5L+ccjvydr4BxENV2XqP0zztVXrAGzCL7m8PPnWBRTjZdMfjjyzk17nAQuhqE3exKf
	tCnnh9YwIRqDYxeX26mMogrvkUMPKekcJcGDVP1uXv0O60qRpsS0lPpKBnBY/55hbNsLxkeYeLu
	1MlUJUhOP5wpqo+9nM1EAl0GXriqnc6lEnVzv0X0V6ZW3s/dbZ9wYkgb77kjyWlbX1vhVELq2At
	ElFwjPnehEfb3AzpycAwmo+UPseUSYsVDaK25XzKIRcYe2ZQwY1veG+0owmuFjpo/2GAT3arvQf
	/ZJYEZV3WylyrSIg2ufp+rbQKmm9wFuuwKZVV50pi8ECxOFghcjhgks49yRhVSrNH2Hk5RSSzG0
	eesPoysFm1uChfKeZcLr7jPSp01Cj7R4Jlli4eIVXHyyclCzIPD/pTP/OjWV7i4G/w/r0pt7wNK
	mhFkPTsBAEk+LfNB0Y9PqROk7Nqpkoval6jQU9cieaX6PhvJxZJjvWwBSKK4p+jf3hg/7urCDFD
	Z8GKUnb4RYKAuWe1M1xWl7Gz+sGKJKrlR8qCZxXaW7g1vphiykADNhAyO4f68ot+YV7aVZe33Rz
	c59IGK3TXkZJRlc/ldZZY6SinFw00vyQ=
X-Received: by 2002:adf:f0c6:0:b0:48c:7143:610c with SMTP id ffacd0b85a97d-48e5d5d0a49mr7758265f8f.36.1793237317847;
        Wed, 28 Oct 2026 18:28:37 -0700 (PDT)
Received: from HP ([105.163.2.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm32311325f8f.10.2026.10.28.18.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:28:37 -0700 (PDT)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v2 1/2] fast-import: handle --git-completion-helper before reading input
Date: Thu, 29 Oct 2026 04:26:15 +0300
Message-ID: <20261029012616.139783-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.291.g0b48760bf4
In-Reply-To: <20261024052449.95869-1-tangajoris@gmail.com>
References: <20261024052449.95869-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fast-import parses its options only after reading the "feature"
lines from its input, and it creates a temporary pack file before
that. So "git fast-import --git-completion-helper" waits for input,
and each run leaves a tmp_pack_* file behind.

bash completion runs the helper with the terminal as input, so
"git fast-import --<TAB>" would freeze once fast-import is no
longer marked with the NO_PARSEOPT flag.

Handle a lone --git-completion-helper or --git-completion-helper-all
right after the -h check, before creating the pack or reading input.

Reported-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
Changes since v1:
 - New patch 1/2, addressing René's observation that completion would
   block on fast-import
 - 2/2 is unchanged

 builtin/fast-import.c  | 4 ++++
 t/t9300-fast-import.sh | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9db3f83eea..f53113d5a5 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -4204,6 +4204,10 @@ int cmd_fast_import(int argc,
 	};
 
 	show_usage_with_options_if_asked(argc, argv, fast_import_usage, fast_import_options);
+	if (argc == 2 && (!strcmp(argv[1], "--git-completion-helper") ||
+			  !strcmp(argv[1], "--git-completion-helper-all")))
+		parse_options(argc, argv, prefix, fast_import_options,
+			      fast_import_usage, 0);
 
 	fast_import_state_init(&state, argc, argv, prefix, fast_import_options);
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 73c6e3d448..99d7843217 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2914,6 +2914,14 @@ test_expect_success 'R: blob appears only once' '
 	test 1 = $n
 '
 
+test_expect_success 'R: --git-completion-helper does not read from stdin' '
+	find .git/objects/pack -name "tmp_pack_*" >before &&
+	echo garbage | git fast-import --git-completion-helper >out &&
+	test_grep -e "--date-format=" out &&
+	find .git/objects/pack -name "tmp_pack_*" >after &&
+	test_cmp before after
+'
+
 ###
 ### series S (mark and path parsing)
 ###
-- 
2.56.0.291.g0b48760bf4

