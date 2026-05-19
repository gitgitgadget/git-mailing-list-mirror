Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD723126C2
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205116; cv=none; b=oyBYvRUlLU21Vre05BL2knRjcsV9HsD6D9BK5Y7A8U6LV9R/s60YSKD6Z2PprNHsW/LlPYAPwf9XEENP2QQZlpTXxyHReXXQylMQY/DTv1uZ1HvKKruzWWRungvLb5VADscv1ew0gxKFedUK8635LTjbwdEc5Mnhe9ZBjw9jIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205116; c=relaxed/simple;
	bh=VTw8SUiuqJ1s0G6/zEjD0A6qx+/Ctd7YCm92qZw9UmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7meSVrWd0Zbd6xIsSt6XbvCuosdGQ7FgL7NxVaX2IExenSz8aEdZux1RsSOT1va04dm9m01bilwQKHwcJq/StDs6cyt2Brur+yUVdPm7OB9izNG8XIijFhjFMC6H3hFui7t6sPzyjrYJ6yV6INW1QNx9DICaOEHhcUGZsPLd9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/bblsV2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/bblsV2"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso7737833a12.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205113; x=1779809913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mkr/WcSBdq1VnVYTATlTqUc8CYqX5+Ts6OChSh7XJOA=;
        b=H/bblsV2rP8pqX8sIA7y4hf68Vf7Uxe0MvLAYck/fDy21+/mpwCGSZYcwGOLTP/9KV
         WemgKBsSm802nxGuupH1K1Fy8Lp5GT876xUqrIIl1TAd6Meg/wawpS+4imrr6a6RV9hB
         MzyCCo2bfw29CSHb861WtutrS9XmV/WbLk/YEAOLXeRImF4y7dbc5bYduKRzLbwZN8ib
         vUVKZ2DgOi7X6kHWNwlJkBpLFUWa6SG7ogaCnVm94G0LJnOtPon0pvx2QXClgg8kgI2m
         cpCVEaCjfLhHGPOjgVAVm4jxnreu/KoS4WFRfkMVcbWEvL4fXeS9hg2QPNSRwjLO8XqT
         gjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205113; x=1779809913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mkr/WcSBdq1VnVYTATlTqUc8CYqX5+Ts6OChSh7XJOA=;
        b=Sqd+UmKnDKmHq78szdQR17uRqybRFBvp2saiTZs3d7KvyD3x10+EJ/ydJ/BXWf3wi0
         FHG1yh/MPuGwQsEcpJuDXe7rg4e6G40WUc63ELFlPsUnGokf9XLhpVakChDl4kUtpXjx
         8Obj2iJ1a4y/xRwgoToEK7hWYZMtwLemSvIwN6NWKJl0SpXFxA0Rxv/phsgNKpM9hiXE
         6y0wp1C/iewfFJNRHsH9cEP5P/RA/6nZKrz+qoZPj1FAMtb3TAQSM0JrDxbs3EzMrEAt
         Ef4o5noInpX3eWyOvRA2hX78mpxaGFF7Mny6klIp8O3hcWLsSJ9R1DuRRK3b4RPDR/WA
         Tp4A==
X-Gm-Message-State: AOJu0YyH2I78CQIima48E7xKABTLBqzRZLZ6dnzgt8sAxgQVHH5h+DLj
	aMXl70elZf26k3gXB8WsPnX3CnCduwVZwKX6J4IfhBeqxutCSf4z3emdX+KfXg==
X-Gm-Gg: Acq92OGQ8MFpHLqV4lt7cuYhjAgCR/2jSnzjsOyQ98Cd7phSAjVPXUvtX0aHlet1aW8
	RgjhjVCshll1qHQ6nAE8TPA/vzm5tjdzQ8aw68BgXb6y8+mBkPXJwFJ+RHfOY8Imm62b2B+V+3U
	DivQGn3YWUc9FJzhSzvtAoFLI/JxRgz8fG+6xh464aMzmetiJ4ullacfnnp4ZeiF8WBRZkOVVJ1
	yFu3ovpZt8jQtNfzFmO10H5y/igHsQ7LyLnzvSCM8A5p9VTqsGU/Fveq9Yssn0ZumxdX6cMTxzr
	NymQSK6tycBLCMEKnxz+pYnN1peQLp2cyw9cXkYmVW6qEjobK7PQqzXDkiWWkJJge5OyQMI0g/X
	2LOhEJNns4EgARyd+RfxgDSGXxNJ6Y0KzOYUjkGiTbMV6XfDWYUtmPiLql4dT5hZbZazwISIefq
	lRPbx0ppkDzqRlas7DM4NsbhGejYuG3zDqk1GyBQSD7m42mxsnnI1I7WjdD9gwHTDERF7k5G4TP
	ou+NxidNCrY4jEfhERIiTN2pd222IwaNS63ng4=
X-Received: by 2002:a17:907:272b:b0:bd4:4593:33bb with SMTP id a640c23a62f3a-bd517ad5b94mr1162424266b.43.1779205112591;
        Tue, 19 May 2026 08:38:32 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd7bbae7a93sm281403766b.22.2026.05.19.08.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:38:31 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/8] promisor-remote: add 'local_name' to 'struct promisor_info'
Date: Tue, 19 May 2026 17:38:04 +0200
Message-ID: <20260519153808.494105-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.136.g92075d88d8
In-Reply-To: <20260519153808.494105-1-christian.couder@gmail.com>
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will store promisor remote information under
a remote name different than the one the server advertised.

To prepare for this change, let's add a new 'char *local_name' member
to 'struct promisor_info', and let's update the related functions.

While at it, let's also add a small promisor_info_internal_name()
helper that returns `local_name` when set, `name` otherwise, and let's
use this small helper in promisor_store_advertised_fields() and in the
post-loop of filter_promisor_remote() so that lookups against the local
repo configuration use the right name.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 38fa050542..7699e259eb 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -434,13 +434,14 @@ static struct string_list *fields_stored(void)
  * Struct for promisor remotes involved in the "promisor-remote"
  * protocol capability.
  *
- * Except for "name", each <member> in this struct and its <value>
- * should correspond (either on the client side or on the server side)
- * to a "remote.<name>.<member>" config variable set to <value> where
- * "<name>" is a promisor remote name.
+ * Except for "name" and "local_name", each <member> in this struct
+ * and its <value> should correspond (either on the client side or on
+ * the server side) to a "remote.<name>.<member>" config variable set
+ * to <value> where "<name>" is a promisor remote name.
  */
 struct promisor_info {
-	const char *name;
+	const char *name;	/* name the server advertised */
+	const char *local_name;	/* name used locally (may be auto-generated) */
 	const char *url;
 	const char *filter;
 	const char *token;
@@ -449,6 +450,7 @@ struct promisor_info {
 static void promisor_info_free(struct promisor_info *p)
 {
 	free((char *)p->name);
+	free((char *)p->local_name);
 	free((char *)p->url);
 	free((char *)p->filter);
 	free((char *)p->token);
@@ -462,6 +464,11 @@ static void promisor_info_list_clear(struct string_list *list)
 	string_list_clear(list, 0);
 }
 
+static const char *promisor_info_internal_name(struct promisor_info *p)
+{
+	return p->local_name ? p->local_name : p->name;
+}
+
 static void set_one_field(struct promisor_info *p,
 			  const char *field, const char *value)
 {
@@ -829,7 +836,7 @@ static bool promisor_store_advertised_fields(struct promisor_info *advertised,
 {
 	struct promisor_info *p;
 	struct string_list_item *item;
-	const char *remote_name = advertised->name;
+	const char *remote_name = promisor_info_internal_name(advertised);
 	bool reload_config = false;
 
 	if (!(store_info->store_filter || store_info->store_token))
@@ -937,7 +944,8 @@ static void filter_promisor_remote(struct repository *repo,
 	/* Apply accepted remotes to the stable repo state */
 	for_each_string_list_item(item, accepted_remotes) {
 		struct promisor_info *info = item->util;
-		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
+		const char *local = promisor_info_internal_name(info);
+		struct promisor_remote *r = repo_promisor_remote_find(repo, local);
 
 		if (r) {
 			r->accepted = 1;
-- 
2.54.0.134.gbbe8e27878.dirty

