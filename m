Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B03C3450
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109155; cv=none; b=pPyLeKQ7Edmq16lgTvRJfsLpgS071wruBdR+V2jJcdNTXsgl7khxo5vDC4OT3NSLBl+9EGGWLvRnecq7PQNDdsgKlWCGsEWk12wNU/mZcjR0Sx6EylcUrosOOxVd5i9vRkTHMQekmzXh0c6wMdUxBPI2XgO5Jf/q9u2sUTNyreo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109155; c=relaxed/simple;
	bh=ilx7AwUVNf+HhO7O86yAgdsA5Fe2R80gYFNyUwj+uLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmXSVCjEol+JcrNm5Bbsg3m9jwYKZL8WtNDtcBuin/THn8QFFVg/a+CfP0EkY5BI09M9NmskeADjiO4k6kW6ZbR0xrxt0vdX9Hv86QBxiGHc23CULt6TMdrdnwoiwEEyZMwV+rpPS4G6iGIhVrcAu9LqWDYIAQfNa0MSZBql3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRcC5Rqk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRcC5Rqk"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47362928f65so4776362f8f.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109153; x=1784713953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQn5DFXyZPb/tfQWfzOy3G+x/Dlb/p4a8tlg+g48zos=;
        b=nRcC5Rqkb7yfXqEAu9cPxI404hAs9xFwFtwgL9Uck+19gYijqbWhd+IR6/UItEPVRS
         THD8THJ7TpuZgHCoXz+wz0l9tL7jmQ5VPIZC44UCEuUA5KWYP3yEyxRouUi+ISr7FM3W
         yK8tUnCwiFy/l2s5eYZjWXG4IvmwM+k8rxkfE7vrcmreMZVVgTLt9oV42YT6S6Mi1vCD
         CppXTbxwaDFUJx79wxiS0eXkK/RP39Yb94S9gjunZyjG+sN44BZI1TY9es03JmtXJr2m
         PqFSid5io+Q/US/DUfKWmWDnLmcF/1SoCQXFNPly3RU0Aikt3z5BBQz0zt78ueIOST6R
         a5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109153; x=1784713953;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQn5DFXyZPb/tfQWfzOy3G+x/Dlb/p4a8tlg+g48zos=;
        b=MSj1WV6JIXCUN/Jp3b9lJs/PEuhr8z/sz1XmitUBsaTe6Q9YbEDySIYK9hFZcrLEjb
         E5D5xvHyCJGki/xZCq7d4U1EVuemFvFl7L3MIk6ybVVWrL5IoqK8Sxkt2jb9QCGGuBPc
         fVBCX7vQei36W4Qui/+7mzLO2h5171gRjWUkQzRu8Yss49l/9pc+ZvFPUeEJMyPL6jvD
         GSLfmoWxQETx3fF+zfExRuQOcigwZ+yZGfc/w1CpDfw6/mvnV3LTfwC3tL/ZziudHSIE
         rEBc5+nRCP6zMFRNUoxWXw6UnjcZwmn5xR8ZOBXJS2SC7K5omT7KfIdoYv9i4H/r0gqf
         Eigg==
X-Gm-Message-State: AOJu0YwUtYDrZLtW0z1z5yAxm9WDcbhbw3UAoZvnkOHLziP0hBmJbWYn
	v79NzMseVS4CzBwDbYXwJxGSLSmCuFosn1rfREOIchE+X2nmzp0+AE/hq71TvN7+
X-Gm-Gg: AfdE7cnVDqN68nVfxYswrBUXOVlwLWiPkPxbGc1c40T638VrNo7pDxv833MSkFvdyHs
	M2WBj3nRczWrC9/3mXcgGMvMfUW6NzKLgnqIHRYWy+rgl8UjSJI4sHfRuwK4W457ZQsdkrgKgaF
	xq3vvJa4qNXCBfxnPJAaAw2xKyvKmGQTuF1jrC/MOtU6EuBJszR2Gtl5LVVlHqInTT6/7nzdk9r
	MGNymy/UPdP+38BwSZ5eJvOeg9lTFPUlBw5Yz7EJvyDe8XVGAOiBTtdCLc/2AY86Wk67Izqv7v6
	aSs4RD9Md3Oy3B+6FPARq9pv3s2K/YREvnHyX7DEQXKMjOMMXtt6x2S2Hp1oj+JSblFHvuwf90W
	oBendhzIqxWm29x0XfGXWzIkY4X06QY8MQLaBwAlg+0x9vkrwjUJ1cMKNnKvAxsE7NcE/OJFh35
	7bZHw4Yj4SNfNJ8IZS9uWKvRkReqGB5nJnySagmtHXXm57Ntk+w1OBfAgZwmWmIs244zQ0zrkw/
	Vay0+GWFwPkuTdpjAJfwC+FiQBSr6DCexAjJiepzn+n6mR3RT+ZBs1h2IvMchnLC2LCS6ohblpa
	rI1ysBQHabBNRnsXKS3YL7CU1oxYh+qvTZoZlpENDbzrrJ9aoc3/ov+0c8XbAmkrhTGWaB2CGRO
	ZmbPIPa1T1A==
X-Received: by 2002:a05:6000:288d:b0:46e:8226:96b1 with SMTP id ffacd0b85a97d-47f4889c487mr7514629f8f.42.1784109152636;
        Wed, 15 Jul 2026 02:52:32 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:32 -0700 (PDT)
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
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v18 05/13] fetch-pack: drop static advertise_sid variable
Date: Wed, 15 Jul 2026 11:52:13 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-5-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
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
of advertise_sid. Currently advertise_sid is used in two places:

1. In function do_fetch_pack():
        if (!server_supports("session-id"))
               advertise_sid = 0;

2. In function fetch_pack_config():
        repo_config_get_bool("transfer.advertisesid", &advertise_sid);

About 1, it is only relevant for v0/v1 protocol, move it into
find_common().

About 2, call repo_config_get_bool() inside of
write_fetch_command_and_capabilities() and find_common() replacing the
static variable.

Because repo_config_get_bool() leaves advertise_sid as is if it is not
set, initialize it to 0 matching its default.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index eea72b2500..8e04db8640 100644
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
