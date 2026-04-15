Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7ED3D88F4
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266074; cv=none; b=VWoD95RmH+xYqGW/7JTEFMtL++KKVcLksJQhP7KFpWBsQ+ufJFEyoHlgc77oIYB0tLJpNcyOhTQMH9gCsrNjDivw0VUhn+7eKHRFP5DVXb4c78WnyfZEhXbJ/IR2z9t1GhAwzpSZ/PKItZ/OBwK260T9+31G84K3U2/2/9NJxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266074; c=relaxed/simple;
	bh=OKoo5GFj86C0RT+X4oI0dSpuDJRKHGnJdU2kc+bIHGQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WIfqSep9DCKvN+Je8/BaAfIFil2EwDK4mviFC9U9pDLErLPF315pvUy6F0eifXgww0AeMfheLWdeAvRALkkEB5WMG9BixPjgILuHYRhrxJJ8RQiHsxFPNgQtv2yii2ZnhzjxtROMHWKo163Wa+fO36XWISvu9GnsxaHihECw6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuV3hM5U; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuV3hM5U"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94dd01deb53so1620372241.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266071; x=1776870871; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwaVoZRt7FXjTqva70aT3epp82SQuxOlvMSViMhqC/I=;
        b=QuV3hM5U/gkTfuw8WtTlF/hYg/ZZD7zWWtaZVYU9Xq8JXM0ItMt+JrDVQHD01NuXhp
         Iicpn6BHLKmBynkVmQnXY7JK+ztYHWnnAZk5ayoX6Ao8w0DUZdNmwHXAi/YRrl1EzPpS
         cCbgmJ3UMk6HK4mmRZJQ6xL6cxT3/DRMLsfVEq8wQKWkynoAz7BhO9XmjmJhdF6b5vDS
         5jBbIUU6s7RruPifRU+tduJto8r243v83tQRymd8z5gRi+JmhjNkjG2gxIBNZ/gt28gr
         m7t1dvP7ZJYKKR23U0Uhlk5QRwe2Ev9aleifWUpWtT4FJzxsBxG3DjUcT7a4hQGEFAXT
         iguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266071; x=1776870871;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwaVoZRt7FXjTqva70aT3epp82SQuxOlvMSViMhqC/I=;
        b=QYIANu5iVJ9aXZBAW8XlBiSzXlI5LZyP9L3hNlXmH4RgEnrmOJlDRAO2vjxH7JBhHm
         /srr5lisRRIXho38UzM9iTPNp7VFgqB/rY09kY1EWBbcFV8fOGlTPcg9XvvxMd0LYFY6
         2c+1V921jtyG+cfOc/fRjGSQR007EFD6u3DGETGZFBJWvORHnb+vKVqvBNr4X7e2qsoP
         jpAM6xTZ0Qcyei1dupLbOuHz1QiKQOM0ARMHA0DTj/QdL7wzfqh02PylkQgCdJvJlOy4
         +//497qZu8bNbAsynLBVehq3/Bv/cFbIpZmOBemMcsx8AsVKGrBsRToZr0MnY9yTzzo3
         383w==
X-Gm-Message-State: AOJu0YzeqzDgOi4JWQF3+8oOhFyekOGffmQswjUNm6qKSGci21N10Y9k
	UNkHkX2SnAuuIF7zi9Cde5dlVOVizSeyQSQ8pMOtenP82WOlvjFYqHCUbP1LYw==
X-Gm-Gg: AeBDieux0rA1AyKIOs4BvW4BtILBgw2lHy0LhR1ggvxp2e9AzTJg76EozmBSiUZlYP3
	IixnzaCMPCPpGcwjj/gZFwOJzBxJEHimwPl7TEUOi4DpNMuJvDZAbC4VbfJCroV0qsVzLq+FoFn
	/tjoMEXHlsOmdwU4R42K5bwQmbm6frPidBe+NPfDbotzNWIyWJFwIxQ8Bs/ENwqAqxaLCjMKt8/
	UYsDYEQj7EIpovzH+xsZXGdlp1ZTjW6104GdnjFvhsSSEeFFFA8ZWNkO20cTpzVm0x2wsj8C0/E
	simoNGmZKQAcWcozhoXV/QzcpdofqywC6c/D04U4FousLYaQpo78Mi0itVZ0lMa7nEPOX2VKHmN
	rDQB4mCKz8gmTI2Sl4ZI8pRVb5aH6xgNSs9GCGOaEFSELB5r3Vt8ktx9KBCJ8ALm9meSuYmqLmb
	vgSsWcn5QErvuebM9mdmnXCq5hi/31ZeMVTL0=
X-Received: by 2002:a05:6102:c48:b0:608:cd24:354c with SMTP id ada2fe7eead31-609fe9b0d22mr10310592137.3.1776266071338;
        Wed, 15 Apr 2026 08:14:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cba0b33sm13531396d6.27.2026.04.15.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:14:30 -0700 (PDT)
Message-Id: <0f89665aee679636d1c6ea801e54b2b53161d4df.1776266066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 15:14:22 +0000
Subject: [PATCH v2 3/7] transport: rename negotiation_tips
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change added the --negotiation-restrict synonym for the
--negotiation-tips option for 'git fetch'. In anticipation of adding a
new option that behaves similarly but with distinct changes to its
behavior, rename the internal representation of this data from
'negotiation_tips' to 'negotiation_restrict_tips'.

The 'tips' part is kept because this is an oid_array in the transport
layer. This requires the builtin to handle parsing refs into collections
of oids so the transport layer can handle this cleaner form of the data.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/fetch.c    |  6 +++---
 fetch-pack.c       | 18 +++++++++---------
 fetch-pack.h       |  4 ++--
 transport-helper.c |  2 +-
 transport.c        | 10 +++++-----
 transport.h        |  4 ++--
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3bcb0c9686..4c3c5f2faa 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1534,7 +1534,7 @@ static int add_oid(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static void add_negotiation_tips(struct git_transport_options *smart_options)
+static void add_negotiation_restrict_tips(struct git_transport_options *smart_options)
 {
 	struct oid_array *oids = xcalloc(1, sizeof(*oids));
 	int i;
@@ -1561,7 +1561,7 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 			warning(_("ignoring %s=%s because it does not match any refs"),
 				"--negotiation-restrict", s);
 	}
-	smart_options->negotiation_tips = oids;
+	smart_options->negotiation_restrict_tips = oids;
 }
 
 static struct transport *prepare_transport(struct remote *remote, int deepen,
@@ -1597,7 +1597,7 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 	}
 	if (negotiation_tip.nr) {
 		if (transport->smart_options)
-			add_negotiation_tips(transport->smart_options);
+			add_negotiation_restrict_tips(transport->smart_options);
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-restrict");
diff --git a/fetch-pack.c b/fetch-pack.c
index 6ecd468ef7..baf239adf9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -291,21 +291,21 @@ static int next_flush(int stateless_rpc, int count)
 }
 
 static void mark_tips(struct fetch_negotiator *negotiator,
-		      const struct oid_array *negotiation_tips)
+		      const struct oid_array *negotiation_restrict_tips)
 {
 	struct refs_for_each_ref_options opts = {
 		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
 	};
 	int i;
 
-	if (!negotiation_tips) {
+	if (!negotiation_restrict_tips) {
 		refs_for_each_ref_ext(get_main_ref_store(the_repository),
 				      rev_list_insert_ref_oid, negotiator, &opts);
 		return;
 	}
 
-	for (i = 0; i < negotiation_tips->nr; i++)
-		rev_list_insert_ref(negotiator, &negotiation_tips->oid[i]);
+	for (i = 0; i < negotiation_restrict_tips->nr; i++)
+		rev_list_insert_ref(negotiator, &negotiation_restrict_tips->oid[i]);
 	return;
 }
 
@@ -355,7 +355,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	mark_tips(negotiator, args->negotiation_tips);
+	mark_tips(negotiator, args->negotiation_restrict_tips);
 	for_each_cached_alternate(negotiator, insert_one_alternate_object);
 
 	fetching = 0;
@@ -1728,7 +1728,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			else
 				state = FETCH_SEND_REQUEST;
 
-			mark_tips(negotiator, args->negotiation_tips);
+			mark_tips(negotiator, args->negotiation_restrict_tips);
 			for_each_cached_alternate(negotiator,
 						  insert_one_alternate_object);
 			break;
@@ -2177,7 +2177,7 @@ static void clear_common_flag(struct oidset *s)
 	}
 }
 
-void negotiate_using_fetch(const struct oid_array *negotiation_tips,
+void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
@@ -2195,13 +2195,13 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
 
 	fetch_negotiator_init(the_repository, &negotiator);
-	mark_tips(&negotiator, negotiation_tips);
+	mark_tips(&negotiator, negotiation_restrict_tips);
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	oid_array_for_each((struct oid_array *) negotiation_tips,
+	oid_array_for_each((struct oid_array *) negotiation_restrict_tips,
 			   add_to_object_array,
 			   &nt_object_array);
 
diff --git a/fetch-pack.h b/fetch-pack.h
index 9d3470366f..6c70c942c2 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -21,7 +21,7 @@ struct fetch_pack_args {
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
 	 * lines only with these tips and their ancestors.
 	 */
-	const struct oid_array *negotiation_tips;
+	const struct oid_array *negotiation_restrict_tips;
 
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
@@ -89,7 +89,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
  * In the capability advertisement that has happened prior to invoking this
  * function, the "wait-for-done" capability must be present.
  */
-void negotiate_using_fetch(const struct oid_array *negotiation_tips,
+void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
diff --git a/transport-helper.c b/transport-helper.c
index 4d95d84f9e..0e5b3b7202 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -754,7 +754,7 @@ static int fetch_refs(struct transport *transport,
 		set_helper_option(transport, "filter", spec);
 	}
 
-	if (data->transport_options.negotiation_tips)
+	if (data->transport_options.negotiation_restrict_tips)
 		warning("Ignoring --negotiation-tip because the protocol does not support it.");
 
 	if (data->fetch)
diff --git a/transport.c b/transport.c
index 107f4fa5dc..a3051f6733 100644
--- a/transport.c
+++ b/transport.c
@@ -463,7 +463,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.refetch = data->options.refetch;
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
-	args.negotiation_tips = data->options.negotiation_tips;
+	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
 
 	if (!data->finished_handshake) {
@@ -491,7 +491,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 			warning(_("server does not support wait-for-done"));
 			ret = -1;
 		} else {
-			negotiate_using_fetch(data->options.negotiation_tips,
+			negotiate_using_fetch(data->options.negotiation_restrict_tips,
 					      transport->server_options,
 					      transport->stateless_rpc,
 					      data->fd,
@@ -979,9 +979,9 @@ static int disconnect_git(struct transport *transport)
 		finish_connect(data->conn);
 	}
 
-	if (data->options.negotiation_tips) {
-		oid_array_clear(data->options.negotiation_tips);
-		free(data->options.negotiation_tips);
+	if (data->options.negotiation_restrict_tips) {
+		oid_array_clear(data->options.negotiation_restrict_tips);
+		free(data->options.negotiation_restrict_tips);
 	}
 	list_objects_filter_release(&data->options.filter_options);
 	oid_array_clear(&data->extra_have);
diff --git a/transport.h b/transport.h
index 892f19454a..cdeb33c16f 100644
--- a/transport.h
+++ b/transport.h
@@ -40,13 +40,13 @@ struct git_transport_options {
 
 	/*
 	 * This is only used during fetch. See the documentation of
-	 * negotiation_tips in struct fetch_pack_args.
+	 * negotiation_restrict_tips in struct fetch_pack_args.
 	 *
 	 * This field is only supported by transports that support connect or
 	 * stateless_connect. Set this field directly instead of using
 	 * transport_set_option().
 	 */
-	struct oid_array *negotiation_tips;
+	struct oid_array *negotiation_restrict_tips;
 
 	/*
 	 * If allocated, whenever transport_fetch_refs() is called, add known
-- 
gitgitgadget

