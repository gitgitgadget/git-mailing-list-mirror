Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176173;
	b=nRac0w4YbXpQe0zrewHGa1jmsgHvHjl/u3ygJxkY43mfTh/e7TtzOF9pJTHzrM+2bPEj
	 c1HR5XMY42NnxS9th0hjZe8b5UJWVMmBSL2qmJD54wZkXWpXYVLlaH5cyaN2ZPhs98O0n
	 /fBewn131uvrn6vjQugrFcHJ1W6T7HV1zFEcUSrq/InswYr/V39W26MvZfPCcPQUyqj4O
	 2O/Tg43psN2GvQbkR7dmkqyieXmC4+g4CxTYjHamYCk7BXqyrQ74jTY0SU8C8JEDJlELJ
	 ga32nNk2wElNG0zLLnQqVbnGScNTrmmvCifRfEL2CvcwCHwobdIPevjgN79nI4R+bfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176173;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=tYGFc8UXGt8nfHwZbHRD2GT5loa1KKlH/S+CA6fsaSY=;
	b=FnumgW6LqlgpWdWNehB5FcqDl4V4bHnN+H9Kje4a/+OMEGml+mKV+frC4qbwS7sWMWzc
	 75bV3a7LDE/SQEolOmdFDsPlWjVek1WhU1bCV6ESGIC7PyixwU7tmNe2ninY2IgEukX8j
	 xdTi/oc7O3tj9u5CAhINlV7zdBcd+eve5FVlylw9N9PTLCGJx+4sdxA7NciSiaTWP5y7r
	 ZMmftmemsEkstFZgRbUoXbGnznOEqEqRpTbEqSqCBhDGc9AkgfnWnhvcPDnn0jH1gxvjV
	 kibqGsCwKxaz9FROj373KleUKg6+x9XEcJaagEUd57M92Bi1R6vA+6auXl9aYvqb1WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=CY9wPSgY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Iog0KDnS;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04A606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F04A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=CY9wPSgY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Iog0KDnS
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C5847EC0594
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 07:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795176171;
	 x=1795262571; bh=tYGFc8UXGt8nfHwZbHRD2GT5loa1KKlH/S+CA6fsaSY=; b=
	CY9wPSgYx/lsVPEo8U9YKEyOhNp0erRNHQsVYllpHL0lBf/Z/hzpWmII7Wu7v46F
	giXg5Lo3ErAdw/Zh6qGZzwTzxL2arGIpkTYPv7q/5RKQDzDcbUSFeXuLP680QNZo
	yT+WlD1lpRVoxcP2uHS581dT2x6PjF1J0z3Zf7AGZ02dHd+3eZfU4ra0JnJV15Wl
	N8FYPphez0ft8SQ4AEqFRYreCWZZc326nfKQZx2DRbRAYr7zEYSNqnsUu7AippAs
	QIsAu2/zcQoM/+LFYOBt46j9jegd9THqsHQ+MnZ+QyOwE830gDmHh5jWdbdLJtVT
	nk2fw1iuHgsxgrABlLxHAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795176171; x=
	1795262571; bh=tYGFc8UXGt8nfHwZbHRD2GT5loa1KKlH/S+CA6fsaSY=; b=I
	og0KDnSJwb3TX2bsc1BwTnzgj/IpUZ+IbV7Plc5MF+fAW2HD4ir8LwFgAbsoluFX
	2JMSXnp76UT/YBuLnmWKiFwxA+JW/XtKpN4ZOFUBIR0tl3cA/fgCkmUv3HILqEC5
	wqP4uBb0jJySu76JqGeu/ViUJGzNDZzUubHJI3r27thFLpF23pztZBeG75+jPFlD
	LbuqJRyvK5SV5J3iCWq/gSUuE69LcIbOptnb5pA9ibVolTLBW6wWuIy3BnUPPV1J
	Ey3JK8YC07d5Lt7Ra3YbrzhzcuM0NsRwgDga5yPX4wuPq0dQDYrsgkqlSCdD1WDQ
	XRc3QLs1XYEI/OoSXDSVQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795176171; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:eW+F0qy2dZj3G4vdVEgt39FPu7sdfAZtrvFEWJ+x2YwhXCN
	FywL/bexOqhW5Ylopr4i+pE/rx3X/YC5p3wj8psm8j+ERjnL1A+7Nn6T53/+K34Z
	ydPCW7PAquhIG1QJVV9gkZVflc2kAHxWWjtxovOeSlIfbJ5/S231lI4blHuwNW8l
	jPmCXmqT/7If76ziYrRvMXMPs+DoDXaNiIzsCJe4tMYtA5tBA9Ditjj+jeQ9tJ/s
	t+rWZ8qQ97Idgp9wlQfG0FjeLaCe+KBvCAPWM6lRc2QuJ8+L4fG0lAOZurrBQ3VK
	A0mK6/Y7wOJOuc9lmyVZytGi341MM+QxKlZmOww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bDnRDk6egGkiCaLGeB4n1Tf4XVpBGhmPV4Aefu9AVVA=:fW1ifbpKZUp9xY4dJezmsQcPnA5ScTFwPaQwZCpLKLA=;
X-ME-Sender: <xms:6zYAa5s73hwiilb4Fqafy7PvYOW6LwmIdLt5DEY_Qlbb1NwIC2b0EQ>
    <xme:6zYAa5a3sPcr2SFwUD1-qk15XFKqFu5xT18RyVr4awT366q4YB15TOvYeHgkVonHD
    DRr6pEE9IZgB67HM47ZZj3oth1jCz2ZjHrz7CknDcTpI4EKeypH1Tw>
X-ME-Received: <xmr:6zYAayZamQlCfjfCHCqc_rXFRQbUPOD4AwJ1Pn9g1rb92vJpbzpp0POybFQ_a8KhP99aps4>
X-ME-Proxy-Cause: dmFkZTFKfMoyZ8OsQp9Wthl1HVhqbad1g1+0FOaTNrvwg/0Vd8GZUZgulm8uuAavm4txZm
    rO3CHbCoKwYYBbsY9QWAQ06x8eZrSeU0ua3vKZjzTEfsCFacma4xkKSA05wxdhhlOVlLsS
    ceKeJl0kUvaNeEYJ9RYdq8nkFwGnncNUCAN/DQ+m70/sQDBWWaiEw065fia2LIgNHUXYJQ
    9SR479uoFdaE+Y1cVkI7Ky/y56H5gBMNB5MYoU8ogwGsgTjsIoy/Q52Y+bAfZOXcP9bJwi
    aS3rRjTuRGQQz0YREwLmG9Ffr8hpmsvEZBGl8DenEqVkHuPRsEzB9OWIPoObsNzcc3ycnN
    YV7+L2E6TgL3GY5sW7a4EORNhjOf0CmEs+6kwKJfCcdlhgxrwjL6OMZLogXF5xXahvz38J
    aypH48wbrgza4qmiUPTjGR7vuzF43gh77AaxMtrOG2srftkxyvN1sYfozagS6rY4dthylU
    C3GzgWkOhM8zADMBoYZ6LZGiExlOSg85kKN0Ln8ArP/bhVmEsKatBh/Mz8JSZH6gJvELyT
    NKomVJFMZHcccgJuhj80Xgqea01Hhcs5zSAh2DJyOxDd23Qad7MZEaMnj6YDgXcIK4Ke7W
    r0c4taa1umhVbuopMwhlXHP5/7ET1DHuu5PrdvE1Z+n6Es1bnpBwbH+0BXgg
X-ME-Proxy: <xmx:6zYAa1UHx1R99vTxEmlGy5GpDfpv04KmR52Qx9MVKV7apF73hNuHKw>
    <xmx:6zYAa51y1QKi3rUCwA1Mx763e0JM29SdDCWRwrZ5OJPMoQDDHorM7Q>
    <xmx:6zYAa8bHQYp8wYOjsPjQ117K88r9Z2LSI60na2s5Is6W97-uCWC24w>
    <xmx:6zYAa8r8BOX3aP45_HEblXlcuraMiY2EKLjLoJ4tlPgOV0v1SYf4NA>
    <xmx:6zYAawfWD6ljo5kfyN-EoWwtmz1B_QEGw8XwNTdzZB5RuF2_3ADUzpq_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a782ebe2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Nov 2026 12:02:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:02:32 +0100
Subject: [PATCH 5/6] packfile: maintain process-wide limits globally
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
Message-Id: <20261120-pks-packfile-global-statistics-v1-5-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Our packfile subsystem has two limits that are supposed to apply
globally across all open packfiles:

  - `pack_max_fds` is the maximum number of open file descriptors for
    packfiles. When we exceed that limit, we close least-recently-used
    packs until we're below it again.

  - "core.packedGitLimit" is the maximum number of packfile data that
    may be mapped into memory. When we exceed that limit, we close the
    least-recently-used windows into our packfiles.

Those limits are supposed to be process-wide, so even across multiple
repositories. But our current implementation will only consider
packfiles from a given repository or object database, which may not even
have any packfiles open when the logic kicks in. Furthermore, the logic
assumes that we're using the "files" backend and thus unconditionally
downcasts the object database's backend to it.

Introduce a global list of all packfiles. This list is completely
independent of the owning repository or object database, and it is
agnostic of the actual object database backend that's in use. Use it to
maintain the above two limits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/packfile.c b/packfile.c
index 077b0395a79..0d5647c74c8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -35,6 +35,7 @@ char *odb_pack_name(struct repository *r, struct strbuf *buf,
 	return buf->buf;
 }
 
+static struct packfile_list all_packfiles;
 static unsigned int pack_used_ctr;
 static unsigned int pack_open_fds;
 static unsigned int pack_max_fds;
@@ -195,6 +196,7 @@ static struct packed_git *packfile_new(struct repository *r, int extra)
 	memset(p, 0, sizeof(*p));
 	p->pack_fd = -1;
 	p->repo = r;
+	packfile_list_append(&all_packfiles, p, 1);
 	return p;
 }
 
@@ -243,17 +245,14 @@ static void scan_windows(struct packed_git *p,
 	}
 }
 
-static int unuse_one_window(struct object_database *odb)
+static int unuse_one_window(void)
 {
-	struct odb_source_files *files = odb_source_files_downcast(odb->source);
 	struct packfile_list_entry *e;
 	struct packed_git *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
-	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		for (e = dir->packed->packs.head; e; e = e->next)
-			scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
-	}
+	for (e = all_packfiles.head; e; e = e->next)
+		scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
 
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -407,20 +406,17 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 	*accept_windows_inuse = has_windows_inuse;
 }
 
-static int close_one_pack(struct repository *r)
+static int close_one_pack(void)
 {
-	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	struct packfile_list_entry *e;
 	struct packed_git *lru_p = NULL;
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		for (e = dir->packed->packs.head; e; e = e->next) {
-			if (e->pack->pack_fd == -1)
-				continue;
-			find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
-		}
+	for (e = all_packfiles.head; e; e = e->next) {
+		if (e->pack->pack_fd == -1)
+			continue;
+		find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
 	}
 
 	if (lru_p)
@@ -505,7 +501,7 @@ static int packfile_open_pack(struct packed_git *p)
 			pack_max_fds = 1;
 	}
 
-	while (pack_max_fds <= pack_open_fds && close_one_pack(p->repo))
+	while (pack_max_fds <= pack_open_fds && close_one_pack())
 		; /* nothing */
 
 	p->pack_fd = git_open(p->pack_name);
@@ -649,7 +645,7 @@ unsigned char *use_pack(struct packed_git *p,
 			pack_mapped += win->len;
 
 			while (settings->packed_git_limit < pack_mapped &&
-			       unuse_one_window(p->repo->objects))
+			       unuse_one_window())
 				; /* nothing */
 			win->base = xmmap_gently(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,
@@ -754,6 +750,7 @@ struct packed_git *packfile_from_idx(struct repository *r, const char *path,
 
 void packfile_free(struct packed_git *p)
 {
+	packfile_list_remove(&all_packfiles, p);
 	packfile_close(p);
 	free(p);
 }

-- 
2.56.1.831.g720f3f5937.dirty

