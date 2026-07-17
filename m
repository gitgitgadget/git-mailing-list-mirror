Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9E3064A9
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300742; cv=none; b=Czau7nMbqB7NJrv/vePEmraNZalq6Lo9HdCrn5VsHUW91A122Py+TviGeX06HMzcbM1eqGLSiwEWXxlbCaQLhGPZpKmtQ5SL9EmEQj5Nq+/agUq4epv/f0Lix/OMd9XoZ1XrQAp7yamTXiSqM3xu8JjcqPiI5NzzTOuJMHSWAEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300742; c=relaxed/simple;
	bh=Xpz/gWkgxXqWwmr0E7ukCF9AUfrougib6MMg7TPM7A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOzMjQPIVLBcVLXwoGRihOxDKNd8587Dtd7qAuPSl2DDmSr89HyfmltzQZR8HjKJpCza7/7ipUQVaH8GomNzyceZNAyENZNX2ohHrBoT8cEgcqOUIUWB57m9l0kqba+2aj5p7+AtACjvVDJgJGYdZ8LQX66ByGfDELNrkbU7PdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6EaL2Pd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6EaL2Pd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so4065046f8f.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300734; x=1784905534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QOkJx3ugz5N9zJ8XaZJ2Od8TyKPVP0/tsmC+V5aQhWg=;
        b=V6EaL2Pd+9zhmIKAeJiv5OrCsc3hgSSAIZpmvvq0DvIOTdB54xSiwI+3pL0iOvnqap
         A6zZ3BR5d1W0SwTUQUe1KK18TMZzNQB2M8bAKG0lWGZe0Veub58bHE+hFNpD88ad7bhH
         PxUmT6D0hiaLDy7NYpPF9LiEz+rBe/BuivcW24MQQpxHwXEvf0+vuEqtMIgBLcggAn72
         EH7NQHtsgzYdAxlBabTHjLcpsU8UWJ9LXR7F9plWFOEvrNSTxySqGnEwyL6BcH+Xmj13
         djdjwgZeUtyIPsPb3dl1csjnu+hF8OgXAE7nwgQEEYghzYS4Bi082nfSTvLXZjOOcywg
         oXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300734; x=1784905534;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOkJx3ugz5N9zJ8XaZJ2Od8TyKPVP0/tsmC+V5aQhWg=;
        b=qDhHAWw4bOusthfP43TzB2G8ijgVtiykQrUk9Nn+hUEh0M8hsihWouzmzp4u/jmTX/
         SVDkAW7cxKcfeMMEdSM+kSs87V6T5eY0uoOmLgN3BEmtDUsrqa67/FgkJOWfjklqSez2
         67ZjcQ9QjIvmDpnX9lvYmZH6XESd5Zg/b+smhCN8EmONVnRQY0Q5XvbSXq4UL2FVlhrM
         Uv4vEuVU3VhqGvotkRnDJzPa1i8fn6VsBLrt9uAGP2MAAWIF95mJF7/61FuZKaF+9v5a
         4JW+ZhzsWm/kCNqfxiyq5N2OUmJkya5zkgcNwGYWeh6Wl/KgHtGzMgE7G7PtDRdXnmfT
         fcng==
X-Gm-Message-State: AOJu0YyXIdGfR0X+2blgRD5OTO6goK4i8PtUnwRKyrexEAVMIsP/8ce7
	is4ivLzrAMd0urLdJPEftDbqPKwhj3P2rS9XxOtRCTJPtUWD06H4KlCyYTVy1+HA
X-Gm-Gg: AfdE7clvYHiq2dNUTMP5SV1XzUmmmG6EdZNyKk1Iywn/zIwqXP7MwH5BvwT/w0dOOR3
	1IVcnMFTQt7UZ6r7lgCWBGFZTwfUgYMcdrdNOu9+y/IqqBR/W6afMnMSkfrj97fGfkIgIvw8c9T
	aazdwqAPeKfGR5XPOyND74Sicy0/Wx1n+dtSkT1taDqAmECYTQOabqmgpNw79r0kyu7HPOve/z/
	EZWr7QAIjyZd6S8z2vBAdfxnxZsngYBbcaIep7dpmUo2VWCKixubrLpg2GkKVhwQ8fbBY/sbo5U
	YDF8FN/7PtoD30NtXAehdDe7ThB34ubdSS9G6piB5wJZ2zag9xCQsD1GgaRDRuVE+YqzOu02MKE
	WY5sm5+CgofbcaFb7uqzBZZHasqwtbdB+OOd4lgLnGhmAt6S+LGCBENPBxuTAgEtOQTgCwvD4EQ
	482DqH8yrnTX9XSTaBiTE2DKOKagNnCcyvEA03RAYvS/9GZvVM9/ei1Gk0V9n6YbFS8FkRw2Va+
	VgYBWoL2lRP+p9ZX+zlcTG3tvEdHsn98A3tfMnfh4kij8X24UZLRIfS6J67vhYjdTbwfq9YgWCD
	WS+Z/E93wSXDvnLtp34svyxOEEGwxkqy
X-Received: by 2002:a05:600c:3b19:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-4954a3db76amr35339925e9.11.1784300733942;
        Fri, 17 Jul 2026 08:05:33 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:33 -0700 (PDT)
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
	toon@iotcl.com
Subject: [PATCH GSoC v19 04/13] fetch-pack: drop the static advertise_sid variable
Date: Fri, 17 Jul 2026 17:05:14 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-4-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
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
