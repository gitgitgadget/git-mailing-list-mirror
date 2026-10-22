Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662437;
	b=oB8it82DV7oVENjBTSOlTx5QT+dQovEwF8pcmS9vZ9HsL1xGb+LhGfyxx2GH+F70CC28
	 T0VkbF8bQ7Zups1KTDevytta0PM14qEh3iC9anv1jsAZQNOFyTFgOM4OX0xwRX4Hv5Njg
	 odq/GRrhLhNtDGNVM1zd34jGlsOhaKE10siiwMzBq255LTUIp0Cbk+EwDJmkIGiMarcl9
	 Pd2qx/xUGUvpoIBcgYjbRDa2bukf3rpupI0uTaumTCKIVjSL70xLymRePy1APCbi4ZaaM
	 z+JBStKglNeH34oyGHS4QK9i/nlOKotMrX1PfVNB5mbIMy+MUcdQmq4zZ9qxu1q6ZAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=mDua5qIOygNoPCOjEvvUizki4/rdpdGSQjX6JKBb4ac=;
	b=3UGgogOxV9DcEUOKVcNJScZ1/BwmrmKmhsCMSA63hH7HknfFRXf52TRkh8B81+cO2COX
	 I+m70afuTOPIck1BYeGWG8NQ2qHfSegf11j9EuUXx5kO9U5Nqqrlxb9xtsEau5eLQBid5
	 VMqU8nWhaHTeZdK8dAu9Vj2Y+Y5yIoQtg3b97QVIxNUzIhsPKBVXLKtX8sEDFHOWLQymX
	 RlAQ8hFwaHP+NyIyI5vjrs5ctajULysDNzw95MNBn+JFQ4mtk9wifFvX9gVBZKT3m57a7
	 ZMOnMHf1UTYjHAqj/sj030F1O3asWfX1V4BL5dVNfu8J0vwutmG8y3sqN/hFxaDZFBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q1IIOrnn;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9D8606A32E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 09:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F9D8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q1IIOrnn
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35f036b17easo1147862eec.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662436; x=1793267236; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mDua5qIOygNoPCOjEvvUizki4/rdpdGSQjX6JKBb4ac=;
        b=Q1IIOrnnwfPN3khy1UiEDImwn6YKwIAsYe5ff/G4iPNTUguZRRMWfAbjapUZE/OmGn
         98cN3EY51tfUfDspe8YkPlzTwyi4uE/WTcuPzHmsVnQYFjcrWwtVq1EmJ6QH6b29GVMN
         vExX8Xhw14zxUKK4jtQLuuSJ51/jN4fSBr928DKCyR/uIRWF24s03uBhGqscqzk7KTjp
         2LaxL2Z804BIjXex0JM3InKTvALRvNAvsgGjxIuZudZ1950/48cu+YbUyTILS0v4eB84
         AhNb4egdkq8dtBo1ovYIrRIHa+vMmhXuG2x1HHcbeBE+WlhBjyrpQ3SbTvxTOEcLpnsA
         Aziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662436; x=1793267236;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDua5qIOygNoPCOjEvvUizki4/rdpdGSQjX6JKBb4ac=;
        b=DCLn+F0R/oIm08fuDXpML7ak1+O/H8dP4fbNofeUK/s5DRA0aJrJhW2G7eeFay1UlH
         9zFdqM35Z8dS9QO+JmV2StP5YTlPvV3EEK5xbsOF7qzZ62YyqzggIgiIzMEjPX2fUsWV
         A1kbcryG6+Gbv+xXyGEq6myTlwbPPQSGIfr8hRUBbrsbZ0G0ZMSBnx4gBdMNGPsZGN6x
         1Z8uD6d11IZ4uE6b+UbwVSFsEHrhF2GAmWgdWy5x/XI/Ld3PWODnuuaChaUYTta0tLyL
         CS2tlxEge/SwGjhBJeOcln/WyJBSUSsLmAie1ETkmWMh7502dx+UXudmYqQaERnu24e2
         w09Q==
X-Gm-Message-State: AFq9FYJLy1c5Rg7M6V3MI2yOER2cZfKa5C4k7Dh3LnamsTW5C6x1tdVb
	tcNrVsCSFoQVtK1nlrwR0xJz+65ABU5BjWZ60h1ffLNTQJtnE4a0ZAfxmepSJyPq
X-Gm-Gg: AYBFou0hUGVwr6+2Zy3sbrcjHC8kfhSv71FJE+Mc8dpJo/FUn653L97o0yVtIS/o+Tg
	eX2w4jsSIMQ7PwY1O5a7ExcYyVyiq5DLjMyRYT30qgajQiKm5SU/FxcOLuk2LJdmVN3rC9vpqAg
	uaHWJkC5c0id2XGxFOyfNPWOkEmjXJCUI3ArvPanEQh74AYb4W9LV4FNEOyRgOtDvNgOSyQAYFR
	zagr9S4JAJKGfS+anl0wJhH2lwyk20ArstYIX3EHs3J1YeuulbF0L/uzOvgLcQnIdzyogetwybG
	A+ykYjf2Eror/jMlUS03X7MVgrbXC9CUX1125zqFQ1TLZYOjANGOmBh62nXZYJtJaU1QZOtxHU+
	VQP+6oj8Ym2qx8gsLqZrE5e3x0GBqt3NyNPQrRPOkOzUZXxXHD+/TMe5/OdiSha12lxNsTCTbbe
	MoiqLalq7NsLjE3gcgW2eDAJomtnTIPkaCWaCN/frNR7vTYNKy+DFEoSNgTaEdtVi55ry+K9ADd
	9nEcuGU/0QOTCHGu6GWvKhczIoKRhD4pW/i7jSvIYkkbedMnPnCyHWC9npJ
X-Received: by 2002:a05:693c:42c3:b0:35f:2349:a574 with SMTP id 5a478bee46e88-367508e2009mr6183365eec.40.1792662436163;
        Thu, 22 Oct 2026 02:47:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.245.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bd2a6sm22609804eec.18.2026.10.22.02.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:47:15 -0700 (PDT)
Message-Id: <05ae50b5daf0caea8666b0b7c8aaeb9f5c397017.1792662432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
	<pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>
From: "Joy Gundu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 09:47:12 +0000
Subject: [PATCH v2 2/2] config: move pack size limit into repo config
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
Cc: "Patrick Steinhardt>" <ps@pks.im>,
    "Kristoffer Haugsbakk>" <kristofferhaugsbakk@fastmail.com>,
    "Christian Couder>" <christian.couder@gmail.com>,
    "Usman Akinyemi>" <usmanakinyemi202@gmail.com>,
    Joie Joie <soniqjjj@gmail.com>,
    Joy <soniqjjj@gmail.com>,
    Joy Gundu <soniqjjj@gmail.com>

From: Joy Gundu <soniqjjj@gmail.com>

The pack size limit is currently stored in a standalone global
variable, even though it is repository configuration.

Move the value into repo_config_values and update the configuration
parser and pack-writing code to read it from the repository's
configuration values.

This removes one piece of global configuration state and helps
make Git code easier to reuse as a library component.

Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 environment.c          | 3 +--
 environment.h          | 3 +--
 object-file.c          | 6 ++++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfb..1bd6b2d566 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5370,7 +5370,7 @@ int cmd_pack_objects(int argc,
 	if (!HAVE_THREADS && delta_search_threads != 1)
 		warning(_("no threads support, ignoring --threads"));
 	if (!pack_to_stdout && !pack_size_limit)
-		pack_size_limit = pack_size_limit_cfg;
+		pack_size_limit = cfg->pack_size_limit;
 	if (pack_to_stdout && pack_size_limit)
 		die(_("--max-pack-size cannot be used to build a pack for transfer"));
 	if (pack_size_limit && pack_size_limit < 1024*1024) {
diff --git a/environment.c b/environment.c
index 89af09aa40..77bbbb7649 100644
--- a/environment.c
+++ b/environment.c
@@ -57,7 +57,6 @@ char *check_roundtrip_encoding;
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
 int grafts_keep_true_parents;
-unsigned long pack_size_limit_cfg;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
@@ -728,7 +727,7 @@ int git_default_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(var, value, ctx->kvi);
+		cfg->pack_size_limit = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
diff --git a/environment.h b/environment.h
index b336459e90..070314f7ef 100644
--- a/environment.h
+++ b/environment.h
@@ -132,6 +132,7 @@ struct repo_config_values {
 	int check_stat;
 	int zlib_compression_level;
 	int pack_compression_level;
+	unsigned long pack_size_limit;
 	int precomposed_unicode;
 	int core_sparse_checkout_cone;
 	int warn_on_object_refname_ambiguity;
@@ -235,8 +236,6 @@ int have_git_dir(void);
 /* Environment bits from configuration mechanism */
 extern int minimum_abbrev, default_abbrev;
 extern int assume_unchanged;
-extern unsigned long pack_size_limit_cfg;
-
 extern int grafts_keep_true_parents;
 
 const char *get_log_output_encoding(void);
diff --git a/object-file.c b/object-file.c
index c049bf13f7..7f55e6331f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -882,6 +882,8 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 								 struct odb_transaction_files,
 								 base);
 	struct transaction_packfile *state = &transaction->packfile;
+	struct repo_config_values *cfg =
+		repo_config_values(the_repository);
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
@@ -903,8 +905,8 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	 * the difference between the inflated and on-disk size is limited
 	 * to zlib compression and is sufficient for this check.
 	 */
-	if (state->nr_written && pack_size_limit_cfg &&
-	    pack_size_limit_cfg < state->offset + stream->size) {
+	if (state->nr_written && cfg->pack_size_limit &&
+	    cfg->pack_size_limit < state->offset + stream->size) {
 		flush_packfile_transaction(transaction);
 		odb_reprepare(transaction->base.source->odb);
 	}
-- 
gitgitgadget
