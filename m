Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759854;
	b=5LKv1qj6jPOSmObMopaVhjAaCSHasZkv7b75ARZ/yWJFg/+3tM+UuZhY8V+x3ESxrg4x
	 cqgutU8C5JWvkqXMWv64+zM/Cdr5+3oPxKuFtTrB7LH/JOxcl2DmJK8EP4U2zx2Ic04VB
	 i6Bf6qEw545aJri3kshL+vrnRdYYafrqU41ZHXERlTssePfRy+YtgKesG3IuNF4VFFK2N
	 Md7nCFa5Z5nq2iCP5DrvelQbq7+7OQ9Vf/AWeCF2aRNw/uYK1Q1Wek13BNgGomaTfxiIL
	 9DJ2aCCKfBZkZLTWKESmhi3N2fMnIogu1oM3bXWW9sBUMlcSvTDE/Zl0jyPaiNRtVoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759854;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=mKc8N+zg+4g6loJ7FuCSipr6rtiFXNUCM0NICBfePJg=;
	b=dzMfl+oJEp4+t9mV7EIbja8Y+osRDsOPYRxV9Drz8ksai3P3KQoAd5vaZwD+OkwdTlNv
	 C1JXAz6JWTNwKUkPr8pksvjr0XPXkKA2pKrPfTi8q0OJ8e2+pnF5tfrI6indeFKbDxJgx
	 NXyVvTqGaZqIDAP7Hn+stODPdzk/ihX051X5an9O3ZS8PPFyZjYgIVFku6rox0OcE3Xun
	 Cc7O9BEkSN5NRDsvmUfC+hok4ZoJoHYKNSZ1ThJnZhcMnfbFx3sj5jDzGszLD69qd0SPk
	 mzmXibPuBEmngu/el3UkK6SCn/gdMNj70rCcPu6QcPle4yQT74VTdcgznpPasDyUCHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=GPCnqmbI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=G+DuMAzz;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BD606A31F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 680BD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=GPCnqmbI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=G+DuMAzz
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EA9FE1D00154
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 08:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759853;
	 x=1792846253; bh=mKc8N+zg+4g6loJ7FuCSipr6rtiFXNUCM0NICBfePJg=; b=
	GPCnqmbIItIgPOX4KW20Vdgs4FzpeVRyOZs505giP6IxoodbCgI7d3zn370FRqug
	KX7CFd5teHMrHtje2O0MzGstwIHPUgbYFtuuG6mQRfyC9rLgtKCxO8ltWHbb91ra
	U8DRyThJ+q55K72bWkqGqZ2j9fcNXqqZVKy4c9O80jL/fPMTTWghjr0pbwE1VsxL
	GrpJlEGoyWfUCBXZFUbhN8b6YG6YC5vgYbhczleLA4FOXE+Eqrb5uUtBuopNQMXU
	aUfA6/D783DMwwgpJ4WmULwHTc7cNI/D0+wC1S+nXHKEu09/ClcDnfg2iRqZedDM
	hzuZa5kQ7+mJ/wKhN/EZeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759853; x=
	1792846253; bh=mKc8N+zg+4g6loJ7FuCSipr6rtiFXNUCM0NICBfePJg=; b=G
	+DuMAzznBZpKmww+aO+eIlPmPi7Jsi8+i+Qk/HmbZKOrLotQBR++35lVWCAxWYZU
	Yen+vqOaWt9xcAPHsLfnG6vH73VkYPxq1iujbHkEClD3B/sTTFGlcRYF6ItutmE4
	0AiiXDV86TSQaUo60TcQ+3u1Gg2vhzxNIdho/PTsdUAg/OF1QhsW2WeK85pVPm+c
	zGP1oHp1lZ8J8IVnMGw9+PRd7ZKii2EkyhoxFX82NxuUEIwP3k2ADgLwMER04hBR
	Rzk2qpO71sKsRWG8p836oUDhAAoIBfzGYm3izHTLe4GXBuOqTNPkm2SmsO7MRdRQ
	oHZiRuNPXmKEOLrLlaMWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759853; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LPGeAjJaaEENkuWDE8E3xHoSYN2mreZET6KANhJgMpG0nQh
	LfjSCDZzS7xXgZaddJSx1jqDBIuzBExATqIR786lgIEUrfmupkeiIrE1tFJAx+0X
	CjF5NDWZ32oqoHoeSoA+qeJKOiAmi398wkqYh3AA/A2KM/P7EmTh1pg5hBiwo12C
	+fX32kXStUgIgrUDzYOpalXEX8moB0jUZAvoN/KKScwsNzlq/Xcb2rt9QnVcGpUN
	6/zH4mf5+1cw++Vvz4NGYJuUv4NKpWynzP9yibPK1xTKolQ32zullNjMy7mwIwR1
	McHH58mMMcvXYl87T2WSnBsawVtGiFMHaKYGFCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Jd1mzWc28PYOTUo17JN+9DWCjKJ9LuRy0PYbmOIFFOU=:WbQc0lHniLH+VWhGEQ5+mHmRp0H95LAPxoRt2hCeAC4=;
X-ME-Sender: <xms:LVjbapL7WQIClQ75mt43KjNqsYftNFDqGNBW4Lf_Yp_Na47h58nvhQ>
    <xme:LVjbasFdjQV4qTMnEKtgLhSHs9qBfvCFKXTf2MVK1iWXwqkYAEReDnQv_VaFaFcg5
    EQf3ufm2bsa9VvTdbMRTPOsnme_8zi9qgqe2lG_Ms0JZsxZCygmdA>
X-ME-Received: <xmr:LVjbanW8eqfZ2QJbI5gG9dVLdjGrLuC79hsYAo8miuszvg4bcQkuttYUmiuX7oE2_pQtQw>
X-ME-Proxy-Cause: dmFkZTEULBe8RAlpP2ZtTbAoqQi0+Zd71ZU/8ok9/tQcmFVCK7qn/P6h7sYuEz98YdD6zb
    EGwUeqTCkWcm60BLl2bU8LGFB1KUQ24d7Cb4+EJYvuK/p1YZRP4+zT0njrM2HM3z+eq2mw
    vaPBpZMRUO0aXLsMYeWb6MsGZ9qOI0yBLwhI9NC0QQXz2V7Zuaodkt7pYFmMkFN0uMQXGy
    0/PqA0kteTjct1G0s5dVsPIx6KnQEdjxCk5ssypQibFMIixOA1dQPhKUAVSkvh69JhiZPK
    myQVfwho2v2r+R7p8DHNbLL4TFqbSnt5vFWBwzmYfgm9ffWnfFvAD6pGCqOkR+l+e88Qqe
    HKja+eihWrBJUiDdtoZ37t3pqtn6mzauUbGGloIdfWzX9x5aXMKUQfBaerl10n6bCb47Hw
    5h0hBZTdtqK4lAUwfufqEL7F80y2KMLNRkaA/MK2eg2KF3yEstuGOPtdESyqq2zYW63Q3J
    rCyPwNrZVgTNtW5UbCGBhsrP8h+/oBpmyygcr3iAgtJwXtgxnx22Jm8mw7dC9ilEUjekCA
    KWMeRXfFkqEMIMsr6CsRE5cVxv5U2vZ9FK+Rh2gTVWzDB/MlB3nUuRUYvu7ANmMZ/1um/g
    9pXnmPcydd69TTAEtHaL3zTgj2oeZdIpCfFQdg0Mrk8rDqvLvPQfPMXDoViw
X-ME-Proxy: <xmx:LVjbavjc5C7uhWkQTycGKNwg6bzMudNH9vH2ceZaSAirVH7Dnvg04Q>
    <xmx:LVjbagTbvfv7Xmx2AJ-9RLoFxBlProLkEOHF38gEu_AUL7FaklD4dw>
    <xmx:LVjbaqHF9uO26Om1Yw2sZYrzNNU1dJP4bqzBrK6rLmfaVh-o4e5ZZg>
    <xmx:LVjbagnVC6OeVkYe2dzBk2uhdmsS25qLWZu739Yv1U2VV4Pi_1iynA>
    <xmx:LVjbampaKjSsXzm5X8ViZ-npJEA9lwokZtq8nnUFcHTQrUrblia7PrwX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab570ef2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 23 Oct 2026 12:50:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:50:23 +0200
Subject: [PATCH 6/7] rerere: bundle global state into a struct
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
Message-Id: <20261023-pks-rerere-wo-the-repository-v1-6-b6ac0c2e4b81@pks.im>
References: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
In-Reply-To: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The state of the rerere subsystem is tracked across several global
variables. Move them into a struct so that we can easily de-globalize
the state.

Note that the lock timeout is only ever used in `setup_rerere()`. So
instead of moving it into the new struct, we just keep it as a local
variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c | 44 +++++++++++++++++++-------------------------
 rerere.h | 11 +++++++++++
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/rerere.c b/rerere.c
index 366797ab7e..23bcb8bc31 100644
--- a/rerere.c
+++ b/rerere.c
@@ -21,17 +21,15 @@
 #include "odb.h"
 #include "strmap.h"
 
+static struct rerere_cache cache = {
+	.dirs = STRMAP_INIT,
+};
+
 #define RESOLVED 0
 #define PUNTED 1
 #define THREE_STAGED 2
 void *RERERE_RESOLVED = &RERERE_RESOLVED;
 
-/* automatically update cleanly resolved paths to the index */
-static int rerere_autoupdate;
-
-/* how long to wait for MERGE_RR.lock, in milliseconds */
-static int rerere_lock_timeout_ms = 1000;
-
 #define RR_HAS_POSTIMAGE 1
 #define RR_HAS_PREIMAGE 2
 struct rerere_dir {
@@ -40,19 +38,17 @@ struct rerere_dir {
 	char name[FLEX_ARRAY];
 };
 
-static struct strmap rerere_dirs = STRMAP_INIT;
-
 static void free_rerere_dirs(void)
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *ent;
 
-	strmap_for_each_entry(&rerere_dirs, &iter, ent) {
+	strmap_for_each_entry(&cache.dirs, &iter, ent) {
 		struct rerere_dir *rr_dir = ent->value;
 		free(rr_dir->status);
 		free(rr_dir);
 	}
-	strmap_clear(&rerere_dirs, 0);
+	strmap_clear(&cache.dirs, 0);
 }
 
 static void free_rerere_id(struct string_list_item *item)
@@ -154,13 +150,13 @@ static struct rerere_dir *find_rerere_dir(struct repository *r, const char *hex)
 {
 	struct rerere_dir *rr_dir;
 
-	rr_dir = strmap_get(&rerere_dirs, hex);
+	rr_dir = strmap_get(&cache.dirs, hex);
 	if (!rr_dir) {
 		FLEX_ALLOC_STR(rr_dir, name, hex);
 		rr_dir->status = NULL;
 		rr_dir->status_nr = 0;
 		rr_dir->status_alloc = 0;
-		strmap_put(&rerere_dirs, hex, rr_dir);
+		strmap_put(&cache.dirs, hex, rr_dir);
 
 		scan_rerere_dir(r, rr_dir);
 	}
@@ -241,8 +237,6 @@ static void read_rr(struct repository *r, struct string_list *rr)
 	fclose(in);
 }
 
-static struct lock_file write_lock;
-
 static int write_rr(struct string_list *rr, int out_fd)
 {
 	int i;
@@ -270,7 +264,7 @@ static int write_rr(struct string_list *rr, int out_fd)
 
 		strbuf_release(&buf);
 	}
-	if (commit_lock_file(&write_lock) != 0)
+	if (commit_lock_file(&cache.write_lock) != 0)
 		die(_("unable to write rerere record"));
 	return 0;
 }
@@ -785,7 +779,7 @@ static void do_rerere_one_path(struct index_state *istate,
 		if (0 <= id->variant && id->variant != variant)
 			remove_variant(istate->repo, id);
 
-		if (rerere_autoupdate)
+		if (cache.autoupdate)
 			string_list_insert(update, path);
 		else
 			fprintf_ln(stderr,
@@ -902,27 +896,27 @@ static int is_rerere_enabled(struct repository *r)
 
 int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 {
+	int lock_timeout_ms = 1000;
 	int fd;
 
 	if (!is_rerere_enabled(r))
 		return -1;
 
-	repo_config_get_bool(r, "rerere.autoupdate", &rerere_autoupdate);
-	repo_config_get_int(r, "rerere.locktimeout", &rerere_lock_timeout_ms);
+	repo_config_get_bool(r, "rerere.autoupdate", &cache.autoupdate);
+	repo_config_get_int(r, "rerere.locktimeout", &lock_timeout_ms);
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
-		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
+		cache.autoupdate = !!(flags & RERERE_AUTOUPDATE);
 	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
 		BUG("RERERE_NOWAIT does not apply with RERERE_READONLY");
 	if (flags & RERERE_READONLY) {
 		fd = 0;
 	} else {
 		int lock_flags = LOCK_DIE_ON_ERROR;
-		int timeout_ms = rerere_lock_timeout_ms;
 
 		if (flags & RERERE_NOWAIT) {
 			lock_flags = 0;
-			timeout_ms = 0;
+			lock_timeout_ms = 0;
 		}
 
 		/*
@@ -930,9 +924,9 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 		 * "git rerere gc" while it prunes rr-cache, so by default
 		 * wait for it instead of dying right away.
 		 */
-		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
+		fd = repo_hold_lock_file_for_update_timeout(r, &cache.write_lock,
 							    git_path_merge_rr(r),
-							    lock_flags, timeout_ms);
+							    lock_flags, lock_timeout_ms);
 		if (fd < 0)
 			return -1;
 	}
@@ -1369,7 +1363,7 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 					    "rr-cache/%s", to_remove.items[i].string));
 
 	string_list_clear(&to_remove, 0);
-	rollback_lock_file(&write_lock);
+	rollback_lock_file(&cache.write_lock);
 	strbuf_release(&buf);
 }
 
@@ -1399,5 +1393,5 @@ void rerere_clear(struct repository *r, struct string_list *merge_rr)
 		strbuf_release(&buf);
 	}
 	unlink_or_warn(git_path_merge_rr(r));
-	rollback_lock_file(&write_lock);
+	rollback_lock_file(&cache.write_lock);
 }
diff --git a/rerere.h b/rerere.h
index ee8d97917d..570667d866 100644
--- a/rerere.h
+++ b/rerere.h
@@ -2,7 +2,9 @@
 #define RERERE_H
 
 #include "gettext.h"
+#include "lockfile.h"
 #include "string-list.h"
+#include "strmap.h"
 
 struct pathspec;
 struct repository;
@@ -20,6 +22,15 @@ struct repository;
  */
 extern void *RERERE_RESOLVED;
 
+struct rerere_cache {
+	/* Automatically update cleanly resolved paths to the index. */
+	int autoupdate;
+
+	struct strmap dirs;
+
+	struct lock_file write_lock;
+};
+
 struct rerere_dir;
 struct rerere_id {
 	struct rerere_dir *collection;

-- 
2.56.0.307.g5fe7bd680c.dirty

