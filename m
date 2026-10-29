Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267847;
	b=aASrdKHlN/c0T26+PsmdTV0j7U6e8CzwqX1C7miI4zjLNjFUSAPTv8KZS/MJWaRCSGub
	 aKkK5A2rXoXEJfKG5DsHq8SJhb0NcKxCnd3mBewycULEFhv2RhcR1EjxAQAptSVv/ZbX8
	 ngDKiJb0AMeg8Iai71elPWSANazNqdinj4clUO3UXqfnKB5k95DdGwG5Kl637HvA6THbG
	 SVyS2GPsosas3sU8S8I8C/dAVqcGGgkdhkyidWNuQjhSfLv+Rd+KXb8hErvF3qNgQI73x
	 cM2uQxHeCka5feTCCbh9t/kID/mDqSxaiSIsdUWBPdJVHa7SW9cXvnrH0GFpxevRD5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267847;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=wxgaF3uqdPVERcQUy08MxBI12YZ/JX8u6RwH6LEbs3g=;
	b=tfixLTAZQW3lLFb6Ga573F8bPBb4QR6SbrZ+ttTtBipyPwJZzPW62qsDilBjwpUOfNVa
	 Om6iahZ0Aotc016zK9S2CBQaDaz8brD64M0DzOuglySQhRPdcYrvjxR1D9MJtt6XLgWoi
	 c86yr1VUcaVpIIRIQJXiqstaqHF/0F9IGFrMSSgFa+PoXF0Rtw/qoystKKx6m72RfDIRX
	 WHkI/N0XBDaGi7LxFbKR08jZTwsCjJXRwHwEJccHFkypp45WtF+5UrMLga+sh4vQg5VJ5
	 w5OyxV463OR+1hHReYKCXXEjmvS4Wjy/wASZJfOUuY7JucFxYr0oIBIHOP21l3xrzNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VPaaS8QK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vFqw1+KO;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BFC606A55E
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13BFC606A55E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VPaaS8QK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vFqw1+KO
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6AA161D00087
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 05:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267846;
	 x=1793354246; bh=wxgaF3uqdPVERcQUy08MxBI12YZ/JX8u6RwH6LEbs3g=; b=
	VPaaS8QKalqJPoiQVGT58Ub7JpiNFjCHFugOP/LjW8dJhNOM9qnASeWws10PDLHj
	WJW3m28yRI8b3whvVLEwSyv16XHQATldVGoijd8Xz2mPXK51Szq2hvjcp3Og1Ani
	dIWtNu2eO+XTWBaOpRe3XurTT0lS5Gnj+G3twlm7KqYElxNf6sTq16NwaoosWuou
	b37QSPzOhBLYEvBtFA/V9WR1r/rFgV7ijBxFhiY0YXGgCNVEW4JsDL3RgfgVmBSz
	0MPN/w9lx37G4UgLL1WlbmU5L7MBOFxau0IhWUXb/rZnV1Qpr1fT03swJsgMXTne
	pD776HXPBIZUOpHVlMpOJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267846; x=
	1793354246; bh=wxgaF3uqdPVERcQUy08MxBI12YZ/JX8u6RwH6LEbs3g=; b=v
	Fqw1+KOW2nKgxdqxC0plJyMI7vij6SFOAFWPApWA8PT+CSAwUtE3ZujMLT19vxlu
	c3CRs0ydNyDesEjws6S1m6vVqct0Bl0P3rEGYzAzCrTwszAe2Pnx/kgjLb5xUqdu
	11UEpCrewjMQU66kutFSxDaGT7SpEtTlLDo65YcIiss7o8LUmYe1QdiS7Hvv7VG7
	Ms+kTYvEqW2mM5TC7eKVfA5UKG6pnZW/BcH6Ngy9RHJA/Dn1mY3w0pr8lw2c3kHu
	Shq+woJ6KxdvpLDvarSBpydUTpQpetvFIg7lDujZJKovBe3DqGtP3IYvJ3SX5RsX
	NIApEFtRhYvwOSMy/Q3Kw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267846; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AYhqMvpX4kzSxwFrCWPwaw/kUtq6rNsP/LByQnXyafmcW+k
	9rEnMJrVh//EcY2T8hTg5DyKCg5aTEmvWkQU7VIffApE71k8041GBshrxpN5+5lO
	v/JHbT2W1tvqDNiM7RHjxlo/n5OyKkzAHgHtMPlv3vw8AIrK4MzD60niJHgAfeiB
	035tzq+ISYDBD3DUi5u/TKTcDtSgU5suoHVTQd1Df6G2BWad16CyG61bEsuQWl0f
	b6nGZiD8GM3C6P50rf0Jy+wmClnzU195VjDr6yWL1zZi9TWtWJr4Tdo+Vqapq+b7
	8EL+rF90supiuDa8PMECpMDeif0idSa3mTe2CDw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:y0LsLtzRrCeYyt5c94jresXIDDHESXhD10r32Lmpd3c=:QvMw2ZslCIsZgq5SShX0nlKoRYu7iE6vy8KY58MUW+A=;
X-ME-Sender: <xms:hhjjag9LX3x-VxcwetOH0Bac62FJVMt5plwrnzZXO1YHa_fTwyRl2Q>
    <xme:hhjjagJnqHcre7OOhA6gTGyj5AC9opeMhZP7wYtO-SCo5iUdXmQfXxBdRNcdySjUo
    XybnPYuRT1XlhdOrwhGEJzApdw8AMEK5bQ6527TqSA0dkbNKd1Ek_U>
X-ME-Received: <xmr:hhjjajawlSWLdUNbXhrCs_RRmm6yTcz3Hm5J-jdYeNhVjpA8CTMbHQ>
X-ME-Proxy-Cause: dmFkZTGN6oeJR7otfSSVvdw42gSnuM/vOiOuTFBIRXaaTX+WyfNptir2dKNLWXae0Ccg/H
    Dw0kdIlCEIriHaB/16Z4yhETxZy9WpWVbCV5No/000ftN4GNucPScoQ5KkAWUzjoZWT0y/
    4K+z8cN8RbbwmEbCVA2o3dxUR234Pvg7fa8zCjVDYwZ4a88+TvOSFTJqaXKepL5aLugymQ
    94eqDXIHH+KgCM/ysQAVHXtzWZ+jp+UH8ANfqy8XQANds0O69Nn3IcrRQjn65hWQ4o24gk
    +sSNI7PSlqQEftXcXQKG4q+6scpPc+oCvIFhg4XMKrhkbLuMtLc2NHSNJl7zBq44s+shkT
    3/bZ0qU6U43sI4q1bSSc6eOhJUaYQpj3Ex8HlQ1Z7RGyhaBBoCgIcH1b9vXtFHjlndoYTD
    NS1F/NB6i16FgEHGwU9vSYjhAL53A1Qk8j8UJu42psFiQJF2NWG4QInWjPSWTa2Yw2fJ7Z
    XxkkJqzIgqZfqtDTp0yD+y11L//20wd/6UehaYTV7CW1cL50pv4o1T1qJnO9zt8hgtg1W1
    pofzJv62Xlk+HnvAirnOgtUqScveNwB2+xXg4si5QUji/cgpmKtV775y/4bpZVUeBKkgec
    bca/DoS3zyy6f19yO7fPaw/bK8/u7cNbPn3fM8gaCKu6sxEhrt+dTAxsUv0Q
X-ME-Proxy: <xmx:hhjjaqIOn6tE2J9XAvNQgYbhaOb6bdOP5mYLwMVJE5We3m3UDy3SBg>
    <xmx:hhjjapBCmF1Zc_HiGi0joaFwcS7MftPqHibq3aeMh5PHyWD038evOw>
    <xmx:hhjjano48-ykkeO5vW8Z9re84jJuU4enIyqPt39W20aAfsHZRD9PYg>
    <xmx:hhjjasixl7KLeRd1XngvDDMbvD5nrULgWX2XwAygsqI2DMi7eUlx_Q>
    <xmx:hhjjagR-_QiuOEUtczRUfUfNmr_ahYhNWSNI5Xg_BRImE045fMHJOZRv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69af4cc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:11 +0100
Subject: [PATCH v2 02/12] rerere: convert flags into an enum
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
Message-Id: <20261029-pks-rerere-subcommands-v2-2-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Our modern coding guidelines say that flags should typically be passed
around as enums so that it becomes trivial to see what kind of flags are
expected. Adapt the rerere flags accordingly and document them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c |  7 ++++---
 rerere.h | 30 +++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/rerere.c b/rerere.c
index 47a4a325bf5..3652b7ac2d5 100644
--- a/rerere.c
+++ b/rerere.c
@@ -908,7 +908,7 @@ static int is_rerere_enabled(struct repository *r)
 int rerere_cache_setup(struct rerere_cache *cache,
 		       struct repository *r,
 		       struct string_list *merge_rr,
-		       int flags)
+		       enum rerere_flags flags)
 {
 	int lock_timeout_ms = 1000;
 	int fd;
@@ -951,7 +951,7 @@ int rerere_cache_setup(struct rerere_cache *cache,
 	return fd;
 }
 
-int rerere(struct repository *r, int flags)
+int rerere(struct repository *r, enum rerere_flags flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct rerere_cache cache;
@@ -1336,7 +1336,8 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 	return needed;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr, int flags)
+void rerere_gc(struct repository *r, struct string_list *rr,
+	       enum rerere_flags flags)
 {
 	struct rerere_cache cache;
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
diff --git a/rerere.h b/rerere.h
index dd9da03d6db..f13790c5dcd 100644
--- a/rerere.h
+++ b/rerere.h
@@ -9,12 +9,6 @@
 struct pathspec;
 struct repository;
 
-#define RERERE_AUTOUPDATE   01
-#define RERERE_NOAUTOUPDATE 02
-#define RERERE_READONLY     04
-/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
-#define RERERE_NOWAIT       010
-
 /*
  * Marks paths that have been hand-resolved and added to the
  * index. Set in the util field of such paths after calling
@@ -39,10 +33,27 @@ struct rerere_id {
 	int variant;
 };
 
+enum rerere_flags {
+	/*
+	 * Auto-update the index with previously recorded resolutions. This can
+	 * be used to explicitly override "rerere.autoUpdate".
+	 */
+	RERERE_AUTOUPDATE = (1 << 0),
+
+	/* Reverse of RERERE_AUTOUPDATE. */
+	RERERE_NOAUTOUPDATE = (1 << 1),
+
+	/* Skip acquiring the MERGE_RR.lock for a read-only operation. */
+	RERERE_READONLY = (1 << 2),
+
+	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled. */
+	RERERE_NOWAIT = (1 << 3),
+};
+
 int rerere_cache_setup(struct rerere_cache *cache,
 		       struct repository *r,
 		       struct string_list *merge_rr,
-		       int flags);
+		       enum rerere_flags flags);
 void rerere_cache_release(struct rerere_cache *cache);
 
 /*
@@ -51,7 +62,7 @@ void rerere_cache_release(struct rerere_cache *cache);
  * and working tree files. It records (and optionally updates) resolved
  * conflicts and reuses recorded resolutions for unresolved conflicts.
  */
-int rerere(struct repository *r, int flags);
+int rerere(struct repository *r, enum rerere_flags flags);
 
 /*
  * Given the conflict ID and the name of a "file" used for replaying
@@ -65,7 +76,8 @@ const char *rerere_path(struct repository *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
-void rerere_gc(struct repository *, struct string_list *, int);
+void rerere_gc(struct repository *, struct string_list *,
+	       enum rerere_flags flags);
 
 /*
  * Check whether garbage collection for rerere entries is needed, which is

-- 
2.56.0.341.g393f52fd96.dirty

