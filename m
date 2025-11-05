Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BE22424E
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 06:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762323586; cv=none; b=CEfqkwdTW8iDk6rwUqiJnC6hKlvbKSEGQcizAW2QTNvyOrIP+0z0eBNhxyXymswghw3whqW+uozUnpaAWdzLON1aXFXrWz4bx+TF48kbusf63Bb8e+C9H+Ul9Ks1Bqn6n1o1p1lKPonUFd98yIJWJTzXhyh6+HNU/FCrJcfnC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762323586; c=relaxed/simple;
	bh=YNSzV/V8bu9TdsFg7R3lKaFF3olp+CgeEIMvsNjWQTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dworhrP6hRcKd9cnzwntLm5Kmn0iGeOWaMoApBzzbVCJRQKEPZA7X0V8f7d/4u6NgzS6A/IQR7/uNXANzE4/enPM/qVFSs/SsPxTIOSm9yi+TvK27n47aQUCdnWNx17HRGtGgctIti4rRUXCA9siCA6FxZEiOsexQkPp7jdqzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLtxaXey; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLtxaXey"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4298b865f84so2990981f8f.3
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 22:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762323582; x=1762928382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/XyRdfwlu/E55LWCL9gAHeUNEqyds+MQxzcPhdM+Rk=;
        b=DLtxaXeywf0wdSSRTDyGVOSNJcuKCxxclQKiWSVM8a/2LelbNhIDdoB7/sjQRMaRwM
         m6jt7r937E1jshKelTBlGu/uyo2rRPoxM6UM01wZAsYHNe300k/U2oh4M9gjXnU7Ca4N
         h+MZEbXUtYcq+3lR9yW6n2CzMaNgZt24wbvfFIGGu51YD1nhepczYynn3YueVShPsvEd
         tV1fqw5xuEokfUW2+y4pPK8S87Vg9F3tEMar4+1uCw/YFQ5/vK6oTaVO5oyVZw37rbFH
         Enf+l0GcJLacGcyLdM78kTeP1b9jJkezlCi6knCvyFmR53Vweb43u3ZU9isMqqwmj7CJ
         92Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762323582; x=1762928382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/XyRdfwlu/E55LWCL9gAHeUNEqyds+MQxzcPhdM+Rk=;
        b=fCyazglRYWvBczUxbD11j+rLhan8V/R2dAJwFGNhBQR4dDoBQLjGdcpmrgc5Q+mhPT
         1ey4ao0Iodi/Eezf3X7NJMHYQCVJTK8MJheaH33kIGe6wqub6ORYQvs0DLLqqnIfKSsq
         1QOP8Yb6WWuGvjr0TWtEudPYwKn+6jNLdHQvdaq2IxVm4qZSSECgM86xT4TQ6XRmCemi
         HUrLxOUTJZ8KvddrYh3e9cgiDofuZkJnbrL/+fgseQcNgFGjxKrtL7oEAee5Mus0shk7
         W2n6tHt0Ok1S3w2N2qJBkY5+LQDljHdxmN9mKuVnQkTQpAUwMB/TN2nJNOIAOZaco7HV
         hSnA==
X-Gm-Message-State: AOJu0YwOVSnjn4UxwTzh28/FdXmU83dNsnD31ywp/GtXLWFHaJavsQw4
	qr0l4Gb0X2xkNOiqAPmGQ9NxgVBqqU2jBxBDsX0N9FVBpuUFduxAZBgjvkHdVA==
X-Gm-Gg: ASbGncvgu87qc11kDJcBf0fIe/TZ267ERAO0H0dyK2Zi4kkQzQvG9wgiOejHtTLleQ1
	J7jFanXbenNpdG2Q5eOA+wac6y0bIkhCvGw4tS4UlvJTAwhesHnaxOQevNa+tRs7GWIyo4Tkxv2
	VnTvU2RsCyB3J8jqOm6B4tckqeN+UfjWxAAwv6I+QtSMlb2za79XoZniwtUuXLpEH80Vt9N+XeU
	7f4Egjbuxf+vknVCefWapKuCovgCnF4j4UIFxH/apX30zXTwYi2lfDVFAio/FYNIQ03VNGlt4OR
	lwAcHiewz5TCgZg32TC8BMUlZk9fkBTMs4150iP6TS15h0FMT9PR4/zsDdQYt6+pW6cj2NZm3+F
	mSET0l3TIY8QkBPwmywkwm80M9u0HuPC5t8+6bDVr22DEKflEyzUQTVpU2P/EiFc84zdrF3fmlF
	GL8g7/HblaA4/ntdRhv8LC+DK9RycG8rrumvJtmw==
X-Google-Smtp-Source: AGHT+IGxk9kMc/QYEliUTtX+bO/19BjODOclygN8N4TOtv84OUuaRDfxy4aRoXtVjH1UhNFI/hRNWg==
X-Received: by 2002:a05:6000:4112:b0:425:7e38:a09e with SMTP id ffacd0b85a97d-429e32c4b26mr975272f8f.2.1762323581904;
        Tue, 04 Nov 2025 22:19:41 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5f8csm8225944f8f.23.2025.11.04.22.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:19:41 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] fast-import: refactor finalize_commit_buffer()
Date: Wed,  5 Nov 2025 07:19:16 +0100
Message-ID: <20251105061918.3688870-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.3.gf264cd25e5
In-Reply-To: <20251105061918.3688870-1-christian.couder@gmail.com>
References: <20251105061918.3688870-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit we are going to finalize commit buffers with or
without signatures in order to check the signatures and possibly drop
them.

To do so easily and without duplication, let's refactor the current
code that finalizes commit buffers into a new finalize_commit_buffer()
function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-import.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 54d3e592c6..493de57ef6 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2815,6 +2815,18 @@ static void import_one_signature(struct signature_data *sig_sha1,
 		die(_("parse_one_signature() returned unknown hash algo"));
 }
 
+static void finalize_commit_buffer(struct strbuf *new_data,
+				   struct signature_data *sig_sha1,
+				   struct signature_data *sig_sha256,
+				   struct strbuf *msg)
+{
+	add_gpgsig_to_commit(new_data, "gpgsig ", sig_sha1);
+	add_gpgsig_to_commit(new_data, "gpgsig-sha256 ", sig_sha256);
+
+	strbuf_addch(new_data, '\n');
+	strbuf_addbuf(new_data, msg);
+}
+
 static void parse_new_commit(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
@@ -2950,11 +2962,8 @@ static void parse_new_commit(const char *arg)
 			"encoding %s\n",
 			encoding);
 
-	add_gpgsig_to_commit(&new_data, "gpgsig ", &sig_sha1);
-	add_gpgsig_to_commit(&new_data, "gpgsig-sha256 ", &sig_sha256);
+	finalize_commit_buffer(&new_data, &sig_sha1, &sig_sha256, &msg);
 
-	strbuf_addch(&new_data, '\n');
-	strbuf_addbuf(&new_data, &msg);
 	free(author);
 	free(committer);
 	free(encoding);
-- 
2.52.0.rc0.3.gf264cd25e5

