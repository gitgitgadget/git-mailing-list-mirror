Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74F378825
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411415; cv=none; b=KHFAOotvEZK0Z89WcVWE2rV+m/O30pCRp65P/2FWbAiV32Kfs8Bc/EMOLtJtUo3LwKwqC57h4eBArDJZxEPQtjYNAxXGsWUMulDoSfXVkL6BbAVm160SHuGIFLr6lp+Aze08ja8lNZ+mIBnwrPe29sFd8aQeTPWOi/6jyDdJpPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411415; c=relaxed/simple;
	bh=Xpz/gWkgxXqWwmr0E7ukCF9AUfrougib6MMg7TPM7A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xz2SIpS1k/BjAdgYJmo+s4HuHIGIfGqK7xogrD9yJoXlA+8UO2Ugoz/ZjM0rv43jNeETsQaA3JUvqHArZ2ruOwbCt7/hitcfe2lMcuwJ41SPiehZDsxs15apWqS35ekP4PLH448c8XhNvEfH2/kGJaun/oSpkrvasGwKUUprEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fdd55wSz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdd55wSz"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954df200ddso6974615e9.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411412; x=1785016212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QOkJx3ugz5N9zJ8XaZJ2Od8TyKPVP0/tsmC+V5aQhWg=;
        b=Fdd55wSzgyYKJuz81ZCBWH2KWzZTBfgAK0orFvyZIKILa8TXAxps3dm9r33aKzGOdd
         lrslVVEI1XBAZ0MKptj9twXYEy/jStdoiEPeODwl+/CvlvVX3nfWFJeGESbUvl2Ru/R6
         U9sIDP2GMLc5N1ZPyq7se0sRxz8/QOimsis+JVC4g7rK6lehcQ/5h+ocaWeQeoSGqc3c
         Mlt7ta7evLzle/KS598IOr1M+59DLRWzd4iGBqkSs3FySPbSybye02dOyc1U8EzBFjjq
         7kiVo9YM54QZJf/CJF1lbyr7s9AaJm/IR8mAfu5JlOmyAoN169MHDu46e0pcncdXxaBR
         ckeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411412; x=1785016212;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOkJx3ugz5N9zJ8XaZJ2Od8TyKPVP0/tsmC+V5aQhWg=;
        b=KoHTux7Pra/7vpejsF7Pdh6j55Idn7fsRzAn2Ko/KmQglz00JQKB+7jK1en1thYK4u
         BYzXwcYMj4aCVVqs2AQnm56Bg154XpobC3+CPdU/ZCp8BpXqggp2CXjfe27gRdygOk+U
         mahGnAWYVX2FyJbHooD2RfA6xHdMVIILQpYCthyaD1BKCBwPloQ4qUdKHh9+MsbuPKV6
         xbjqmDhrgopKzyuqeIkm98h6dAFmzazpuS70JQsJQmnlwaZ4i0A+AOw1A6rvxNszxpeR
         h5Ds/wpT45/erlKK5ELBDlsHhSpJHtzG7q3Ij+1EIXLCJWnykDTddWg/ClEuS9pKpa3i
         EUxQ==
X-Gm-Message-State: AOJu0YwelqA7AmfxQQBZNpk3psljxBzNezJHOJ264mZoNPprm981KgnI
	evYtvvsabAsOuYQKL0XBAW0UvmRxHjQvpjvrOCLKFKO5RDqK9gGwuZF50/h3qmqV
X-Gm-Gg: AfdE7cm3H/9xgMF+bUSOBhRV3JJ9NxQpt5XRlSFb8Pb5r3mXS7tFSbpWoRmblahlhrV
	dRMBvG4vpVwUTsiid9SAnV40w2HmS74waKizncE/WgAzTY+Uyo8gy99Y3igwu661iXCRRFvO00u
	vHCB6IyrJ0TAJO29rdxIXHTbkEINITV932SyxWtzPzlaQhkMvj8k4S3P0OsHJe1sawcvF+tqPue
	Jr36fxp2FuayXhnEE7KQUtiqq2saZkaxYo+0f6LPmO1YTMGyq/uSn3TlEXxqTWUFa5n4NaQdmpi
	n93UFXCG+FXQSVLKsm94S5m4gP4hjbWnj/K4dFAmKqRzwiyA2BCP2TPyHYqOjeTBTljzCbamoq4
	+h2Vz2aFliemNTR0jBqqGAbcaZtwDa8Kd7AoTx3nGVc/fF9emt/rHesbgVbmtwX7+Uc3aGWQhFJ
	4Ua5ZjpizstT94E1rOxrxIeXxn8vzrV25Nkw8trK+TXQAVR79be/Sst/pnHQdMvQWUqBYUNQric
	HjO82lRpAdB8akRnToCKxAq5dpjVrSeA2uoUSbsLYyUJbUXblHkIKE8I0mD4wbBZs38I11S7Vlm
	XrEie6eBfaX5CtDMF7c7JylfQvFaHyRc
X-Received: by 2002:a05:600c:b96:b0:493:f6f0:d66b with SMTP id 5b1f17b1804b1-4954a3ec771mr87828665e9.1.1784411411939;
        Sat, 18 Jul 2026 14:50:11 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:11 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 04/13] fetch-pack: drop the static advertise_sid variable
Date: Sat, 18 Jul 2026 23:49:53 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-4-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

write_fetch_command_and_capabilities() is moved to 'connect.c' in a
subsequent commit. To prepare for that, drop the static variable usage
of advertise_sid.

Currently advertise_sid is set in fetch_pack_config() by reading
"transfer.advertisesid". It is used in three places:

1. In do_fetch_pack(), to clear it when the server lacks support:

        if (!server_supports("session-id"))
               advertise_sid = 0;

2. In find_common(), to advertise the session id over protocol v0/v1:

        if (advertise_sid)
                strbuf_addf(&c, " session-id=%s", trace2_session_id());

3. In write_fetch_command_and_capabilities(), to advertise it over
   protocol v2:

        if (advertise_sid && server_supports_v2("session-id"))
                packet_buf_write(req_buf, "session-id=%s", trace2_session_id());

About 1, the check only guards the v0/v1 path, and the v2 path
already checks server support inline in its condition. Follow the
same pattern and fold the check into the condition in find_common().

About 2 and 3, replace the static variable with a local read via
repo_config_get_bool() in each function.

Because repo_config_get_bool() leaves advertise_sid as is if it is not
set, initialize it to 0, matching its default.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 9eb8fc5399..65ebfec09f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -49,7 +49,6 @@ static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int agent_supported;
 static int server_supports_filtering;
-static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
@@ -363,6 +362,9 @@ static int find_common(struct fetch_negotiator *negotiator,
 	size_t state_len = 0;
 	struct packet_reader reader;
 	struct oidset negotiation_include_oids = OIDSET_INIT;
+	int advertise_sid = 0;
+
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
@@ -414,7 +416,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
-			if (advertise_sid)
+			if (advertise_sid && server_supports("session-id"))
 				strbuf_addf(&c, " session-id=%s", trace2_session_id());
 			if (args->filter_options.choice)
 				strbuf_addstr(&c, " filter");
@@ -1160,9 +1162,6 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				      (int)agent_len, agent_feature);
 	}
 
-	if (!server_supports("session-id"))
-		advertise_sid = 0;
-
 	if (server_supports("shallow"))
 		print_verbose(args, _("Server supports %s"), "shallow");
 	else if (args->depth > 0 || is_repository_shallow(r))
@@ -1380,6 +1379,9 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 						 const struct string_list *server_options)
 {
 	const char *hash_name;
+	int advertise_sid = 0;
+
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
 	ensure_server_supports_v2("fetch");
 	packet_buf_write(req_buf, "command=fetch");
@@ -1998,7 +2000,6 @@ static void fetch_pack_config(void)
 	repo_config_get_bool(the_repository, "repack.usedeltabaseoffset", &prefer_ofs_delta);
 	repo_config_get_bool(the_repository, "fetch.fsckobjects", &fetch_fsck_objects);
 	repo_config_get_bool(the_repository, "transfer.fsckobjects", &transfer_fsck_objects);
-	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 	if (!uri_protocols.nr) {
 		char *str;
 

-- 
2.54.0
