Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575772;
	b=l92m7DHmDmKIuePn+fffU8tPiCB0Eg6fX5i7cWRRz3rnR1vWGw8UCL7dN7VcO9MJTbjC
	 ziAH9M/nZuWd97lNLJB3AEvE/SS+8kpZzlsFiVE/jWWxgAEpQDjm9pXrFXi8RHU57C0Ie
	 X+HUG5PQ6AlWrTQ24a/UlMIxaWisNywIKVIx4zMT3kllyENp08bWhaWAS9nXM9hSMUo1e
	 l7MbF7oYtNn3X3vR8Cn3JYXkPXnCK2VEaJRhHeK0IVc+waGO+iGec/Ra3tVPdC4gMKCbq
	 nFNilQFuiryyObp9BXJk/qhcc91qz/20nSd2c1A+0mLQDW3ijbEnthP/hH+N9Cwf3Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=PFdKUqeczDjuq0Caek3TqRcg/mtLPbJevkQUdjo2Fgk=;
	b=nh/abOVQ6B5Rmy4Z6e99BJhYm+ZE+/Rlbad8gvNGB1NfZP+Ucsxqc3dwcbq+f8YhXTKr
	 LqkLWoA3zIyVAkfX9bG2X99xfjvxkjFLfoSirHRrNKScosON2wE/ifhMz3aRc9KJF3YX4
	 Kvhsx6dndouIwtuX+RIEyX/gZhei1h/m02CmYhxmHGpTJaNBlHu/jiGgviYcEvck/uvPK
	 Qh60gvT3Ti3VKPxEVPnrYlW6ZCTp4zUVGzU2Xhuo0H4QihJIUKBTWeiMrcMazhnSwRYXR
	 vkVLLJ3oLTJSFpKYqDflI/kuJjcm0xo97d/JrVkP9S/MXgCiy7SlNyYpZhSaGjy5k2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qr2brWKf;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064D606A32C
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6064D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qr2brWKf
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a1947498bso1796703eec.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793575771; x=1794180571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PFdKUqeczDjuq0Caek3TqRcg/mtLPbJevkQUdjo2Fgk=;
        b=qr2brWKf3c/ztg4AWGjkaTHPKIpipHb7JniAP48kv5oS8S0jevFswU/LjRQw+I93WJ
         yfWN7/ppkWalWZp/uV/CDllx7VWo5bpKl0ResWcQF1L4Lu5Fe8wEAVR+DhbehYZ5PS0A
         OxXf4XpMCbCtB+78XyVMQq2bI+a3XMAx3uBaG+rUWKXztozbjCDNK9KEErwTM/JLAQRH
         Hqvlc6qrHBXgG5FJuhqpUpW92OiFm/50GkYdgMxSGUn5EEc9FiGOzqShJYQha163wt86
         k/Lvy6KQMiGqBfTbcgo/IWbEYDYAMt90zW0zC6wuY08gXsCB0dgba9Cx25TZ7d+KePGv
         bpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793575771; x=1794180571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFdKUqeczDjuq0Caek3TqRcg/mtLPbJevkQUdjo2Fgk=;
        b=mccjQQyQ0uwcaicTSA+mX3d+FRmhQtfizGCIP+OwRwkM21wiu0kLBqkILKjh16pOeO
         X7ovMkicCQEyWu7AV+Y7Z9yog7vsyAYsxekXMkJSo/Opi1u+y63x8Q0q+bxtKtVMVIZg
         s7GTGVQFneMDhplRJZ5RjNOJdqaR8S2pTcIhCd1B/hZeUgOUlJxnjoXXxGAkcG3U2ztR
         jH7PNx+d5TTsL8WwzA2S3cd9DVH3AOTZvNlGIvQDB4ff7WTi3KbBOQMZiL0hXNoYV9Nj
         RjRh1SbrRUOyorSr6rG57pkpUIgD8J+dXzwQHX37jnSCEmaIhogDU3ebEQsE7OxJU0K7
         7Leg==
X-Gm-Message-State: APuU4Z9Q15t5fxVfH/0+VUSLYItA2AVy8B0TNZRESOBmkvT7uDSB48PW
	Kc1Nw+mupSAPJ5FzgAnChkFW9K7dCAm63JKjfh3/fe8nUeY0TR8H2RYN
X-Gm-Gg: AYBFou0N2+ax/cJNW7jq+H/mzN4MjhYDWmFUHC3uBodNwnBa4kvXRyqpbZb9WRLmP8A
	TGG/UWoOY35bH3Ab3fzpCnDJZYiQRNbYaXH9o9JXPrEFCXu7+NXy7lDjQlU6zrC/vsWfrL79c09
	Tbdj387mJl0NmnojLHNSyNN0Ye77k9IgJoxp25uMvP8NMiSGTv87qCNucsyqlQ/m+dNSUcSIgqr
	wYGkkMlaQUr2PyPjUDgPp0ln2eiJRZHXMS+eKwfvkqXuQdj3E7yRq63g+Va84gvxFO4y0kDlFku
	TUIWprYNJshIw0hipl6vXW4DJ9Co7dzoC5B/QNHNHe8KGJDOL6L/h+MqIfqBe3+N8zvusmhtney
	uOnT+W0+f9o1ZS5dhvsfH/yGdge+wcFubTzLuimXhmw7U6h2CM8Qg2o6RcnEEm9lV8Myz8KAPRo
	a3gJ1xt+oXwL1WoEesyo7KlM9jaVBHKSQBPohOGD1bS3sRFysTeNprQZ8SSL2qlNbNtGZln0ZUf
	/1fWdGQDYGz/X4hkiZRVT0Exk27m+IphImFK78mdRzl9ztmGwBgBMlBoRD56tHhDFLxWzI9WhuU
	Ap1sAtlypcU7AVj3DxIEbIc+cE65oz1E8NU=
X-Received: by 2002:a05:7300:c00f:10b0:36a:5207:e58b with SMTP id 5a478bee46e88-36a5207e70fmr10146605eec.27.1793575771278;
        Sun, 01 Nov 2026 15:29:31 -0800 (PST)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a98f65sm30367724eec.28.2026.11.01.15.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:29:30 -0800 (PST)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Sun, 01 Nov 2026 15:29:25 -0800
Subject: [PATCH 1/2] credential-cache--daemon: allow a concurrently created
 socket dir
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-fz-credential-cache-race-v1-1-28f0bac51e11@gmail.com>
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
In-Reply-To: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Patrick Steinhardt <ps@pks.im>, M Hickford <mirth.hickford@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Jeff Hostetler <jeffhostetler@github.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

When no daemon is running, two "git credential-cache store" run at the
same time each try to start one. If the socket directory does not exist
yet, both daemons try to create it. The one that comes second dies:

    fatal: unable to mkdir '<home>/.cache/git/credential': File exists

That client then fails with "cache daemon did not start".

The fix is to ignore EEXIST from mkdir(), and check the directory's
permissions the same way as for one that already existed.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
 builtin/credential-cache--daemon.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 65cc619bec..0dfa11e2ec 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -273,8 +273,18 @@ static void init_socket_directory(const char *path)
 		 */
 		if (safe_create_leading_directories_const(the_repository, dir) < 0)
 			die_errno("unable to create directories for '%s'", dir);
-		if (mkdir(dir, 0700) < 0)
-			die_errno("unable to mkdir '%s'", dir);
+		if (mkdir(dir, 0700) < 0) {
+			if (errno != EEXIST)
+				die_errno("unable to mkdir '%s'", dir);
+			/*
+			 * Another daemon created it first; check it like one
+			 * that already existed.
+			 */
+			if (stat(dir, &st))
+				die_errno("unable to stat '%s'", dir);
+			if (st.st_mode & 077)
+				die(_(permissions_advice), dir);
+		}
 	}
 
 	if (chdir(dir))

-- 
2.55.0

