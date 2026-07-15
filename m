Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF5387361
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109158; cv=none; b=mrLMzU/62f8C2zyMs2MjGcBTpGvVjqqNdzS0SEWHMLQiBxXLo2rTN9U3cC1h/76snolTzpChL6ZILf8pDYnJwpKpGvmRvcTOg4jCmVIjOGcBzqpLNZSLfIvypi71vmz+1uGOIW5QJYNd9V9OqdJcMKJzaFv1jmCYsqYFhwmOX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109158; c=relaxed/simple;
	bh=Bnee36W2p94XD3UYp9ZZBSfOSPequOU8Ss5DlFucYpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzMY21ToigpZN9MdGWqfvytk6Y3CAaxhmWNITWrYBVt2UR3uRykGDe3ctgRTNVTLxCLJ7UFKOwIVbjAK0LRVe17Nzj0UY2CwSEwRCKktCCHWqZqEtDBeo4asGR5ohOdBTYy1g1PZXZrR1PX+CswEZR1+PQYZj0Ybs+XPLXJ+iUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0iQhrep; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0iQhrep"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso2762122f8f.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109155; x=1784713955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gkAmkM6JVkhy385xVgrQ7ee8ZA94lGvMaX2peGSZup0=;
        b=k0iQhrepiaxi2giGwxaVjnr9kd+pfIlSVifba6DCH2t4dIM2iJjTb/TlhOwOXgnilv
         iMAG9ujZpM6BZU6dtGtG/rjhP+L4Vhuk5N2pvs9MiQ9/2nXSwFzCJ/LfUXJiPLksgXDj
         ommaGv0/b26MkSfN4C8LeYLqk49YwyBiCuO4slErjGpmso0rFPlq3yrWIz8yaUpgyzWh
         RFnRx4OBRvMzbfEMjP34Mxh+CID39UKFf5+2nLKulkzxFhdpuKky4pE6bXXXKRuChm7o
         J4lL4WUSylsQBbB/EIiHOIJCM+wjtBUn0lYuAIkhI8QUuriYHQVlr21hEV1FU6QO0Ui7
         rBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109155; x=1784713955;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gkAmkM6JVkhy385xVgrQ7ee8ZA94lGvMaX2peGSZup0=;
        b=eLqIGRfkFRMKyzqLq8cy73BApbmyNz6qFJ/kj1xKd8wH6T+tNRS7eQM9xMCn2yIVjT
         VvDpnlwnLVYnxWXFqk9en+zZnWsGW3w+M5QecNiuvr1JfNGABF/pEl3KbeUej5jes+x7
         pteGwNVHakSISNSWqVuT6upxf1EF/04fErvP4h5iMlpXxiGyYs7X2XdhlUn1E1LG+n3c
         HpWYgwQsVD8TW/gMSIGTp8S0pfYSiyZX2t7fYV4TwPht7UrcRICRlOR2+JFiOl+z/oKd
         i1j0lbtrxBq3gYyI/vWqriDhoQwuDMT49nMHx2JfeQvpVR25IHu++tYUYsF8D/IVA1ya
         fP5Q==
X-Gm-Message-State: AOJu0YzxnTJ0KN0qZ6cAfHZ4iqTbjA3jteku74fyTvG17Z1a+c56ihN2
	Twq8mvgQ0TWUs+FUDnaIcF0U7MW5W6WaD9V1AV7oT0YfxgDHrfXBcfwNPuH4mBgk
X-Gm-Gg: AfdE7clp0/Dn404Aytph9dguLKpQns5ONlfUUKn8Q5cxpVRI7jGe/hHr9gafxYzvlPH
	usBQfRO9gWk1sfKi1pe7j//DWgAZm8Ne+NvFYXySMTb+91R++KS8mH874wouVqgLGgYMeBUhK9O
	Tstn/JDZbnlQEWcU+OOT9A/W92KbCMGHKqzbPYUyO7miJpAM2T7xo7iY+UQoM82evB6RnbefkS+
	9hnTyKkZ15M2GBXVLAF3jI0qf9iV1A9tHsrGFfB+bXVISoGekresgRg81XQGO3bSesUwKnd8drr
	Chm2gZVJQFGziQZyw+nf+ReIoTFTStHpY48MGWRvtz5fnLeFJ4S+3x29CzfwwFIHc0i+JrLtNqr
	mXINFF0es9eJjtG79iG1MHEakATSERo/oqktJy9BeyJbCQ+fDtbpq8EP7if95kIaM54PnigN3m4
	N3TM5eLOaJzeGdX4d4g3ni7qzYjKZX/wyDF4Rf4jSBSzXl6aMXjO7IdnSTvrFx/I4luGI7+6RUf
	7WYABGu1Vc8MY8vH7chwGdfTl9xh1L8gqOW9gFqHGiVlFq7ni4NAOs1VgF4X06KXsyzE2md/f6R
	/K3KEBeSvmAEP6rAgWIHLvzmtHL6LYHBY6gbfkx6dwAq6nldvdse9Fn+EM4JoeRjtgOF1U3H+dv
	ilulsVdsvIw==
X-Received: by 2002:a05:6000:4602:b0:47e:8e1b:3319 with SMTP id ffacd0b85a97d-47f48856796mr6404668f8f.15.1784109155464;
        Wed, 15 Jul 2026 02:52:35 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:34 -0700 (PDT)
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
Subject: [PATCH GSoC v18 07/13] connect: make write_fetch_command_and_capabilities() more generic
Date: Wed, 15 Jul 2026 11:52:15 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-7-34d7adb051bb@gmail.com>
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

Refactor write_fetch_command_and_capabilities(), enabling it to serve
both fetch and additional commands.

In this context, "command" refers to the "operations" supported by
Git's wire protocol https://git-scm.com/docs/protocol-v2, such as a Git
subcommand (e.g., git-fetch(1)) or a server-side operation like
"object-info" as implemented in commit a2ba162
(object-info: support for retrieving object info, 2021-04-20).

Refactor the function signature to accept a command instead of the
hardcoded "fetch".

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 connect.c    | 8 ++++----
 connect.h    | 8 ++++++--
 fetch-pack.c | 4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index c09947cc56..127ed4a2e6 100644
--- a/connect.c
+++ b/connect.c
@@ -700,16 +700,16 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options)
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options)
 {
 	const char *hash_name;
 	int advertise_sid = 0;
 
 	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
-	ensure_server_supports_v2("fetch");
-	packet_buf_write(req_buf, "command=fetch");
+	ensure_server_supports_v2(command);
+	packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent"))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id"))
diff --git a/connect.h b/connect.h
index c4f6ea4b0a..c2bf492ed9 100644
--- a/connect.h
+++ b/connect.h
@@ -35,7 +35,11 @@ void check_stateless_delimiter(int stateless_rpc,
 			       const char *error);
 
 struct string_list;
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options);
+/*
+ * Writes a command along with the requested server capabilities/features into a
+ * request buffer.
+ */
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 5e7c4f1d46..783e3474a6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1386,7 +1386,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2253,7 +2253,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 

-- 
2.54.0
