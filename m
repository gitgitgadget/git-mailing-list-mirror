Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8721258EC1
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135584; cv=none; b=t8UOspl9vweON1qqIVrLZne6a6SxpucO/i7FNimVN7j7Ri2fDLa3qcgPous4XlvEOvkC6bFZVs0WRHot9qOmfjRbq7a4aUlfszJIbUSY+q/6BVabV1ahcZZstifRPxiOt3SL4vqrWHdAxLtuM57pw8zIh+eIb0k0V1188K1CE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135584; c=relaxed/simple;
	bh=V4KijgTg0p3U42KO3UHcQBH4pIN3Vto4FhAVI7xZqSY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cLQwJm99vEsw/fHVGjxUpOl0PJScFSKszmA0VLN0CXYOE4tT/dmP7r0Znug2HbsI0S/BCUm8Yn+HaAKbCAroUCqFDWFc1xCrbQag7NL3C2TQ6CiqRjsTAW+3yx4B4i369nI73WRDz2DcWT1wYDYFgZIqT9/TY0pL4lUYzZAPlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBMzqtyH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBMzqtyH"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-910bb291688so353188885a.1
        for <git@vger.kernel.org>; Mon, 18 May 2026 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135581; x=1779740381; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rvng4ORNZbKSrwOPPkwY95QCNEzfHOiqVhwAVjBX4Y=;
        b=FBMzqtyHb+TlSf8mJAjgJJm4iwpcqLsOXVx/qY46n7k8ElsVaMFSjR4evCtnHW7Ukj
         nQI5wwv5z3CwQ2Pi0Q+peMWSztLB/heiFzx8EdRai0eSsgUalBvoAbomrXlrhbIESLAW
         V3/S1zc9c2o3iWhyA8num1kJ84qRnppvYhEzvO5DhHgmwmDu/b0n3P7a+DmDignGv04q
         ObdDrnxpgqJpc/LWBWPBrJN+YPmxQfpRZ/DGtfK9Ba1B+JHgsJvTPkDoD1mz0yspdvmM
         MIkrw5UYKzveiOsAv+q64ECS61gDR9rmzy5YtsAH+HYud55RYeKOCzLHxJRI8n3LAdsq
         KlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135581; x=1779740381;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7rvng4ORNZbKSrwOPPkwY95QCNEzfHOiqVhwAVjBX4Y=;
        b=GRxms50+ErltEI9DCx1RDcxEb1IcNL7WwN+Mph3GzOtx5WXjIsKj234s2tKD/xI4JR
         doo/LbUiX1BgcON1Vjjh9uXdokZ18ekTb+IYE0Tb2bZA5GTgxg6yilOCS9xnSrjPO+z6
         uHR2IJeS0kA4KP5YsYvQKgNE93C1PMQZw620ccQZb8AeLvTgQb2lmOC6LgiRm+QuCtVj
         b2cRgvm8sjEqy6uhujzAU91hAYtm+mBiIWfVYIggh8y2iqEKt1V9SqjkgCNlp2KOuy42
         rDIdaGrRIvg7JDUy7hNwETxnOQQ98L1Cbo9kTpP0+Y0t2/YQ6kTSUuqAzW0ffTyYzNiD
         h30g==
X-Gm-Message-State: AOJu0YxhebvQ+JJIk1wgSmRW1CqM//xgqnGBCrvhoHrlMY5h+2qIQ4K5
	5yXIEFY79atAUykmmnaj2wrLwPnJX0M9clT7waeDNbgVtLoQIuidtB0MHkbwng==
X-Gm-Gg: Acq92OE+tBKfdTJibrBDAlEzLXnOtFlSeHluphwfiM5LJC1z0z/T/9iW3Sna0CqObcG
	3ULW2F/AVcq+fvcTRe545CZ8BAe4n4zU7zRA03aVc5vRBzf4BJ75wkGxb/KX4GMu5OjRMKUQPWX
	d1mwR8my2sWXzv1Ql4ezhhShaKcf5MxfIhhS2/PzVFDEkDJAj3Kwk1zCxbyHVaFQ42JftqebJRD
	yUkpUzv+RMQEHRHg+cVx8/T643obTamphzFnUxurbpwqOH22L8GGHaapu9kufw+XFKKU1k3q5Q9
	mQSTky3rVqEFNvrNP9szSotpq0Ur8564+j2jleP7agHdxBX7U5O1SuA4Vm5q8L962VDjPrO1gtj
	Mnm8luPLH2mnbToHsD93ZaNEcxnVkNamZWgwaWMivjnzjZkh7KswplryGRKAAJSKyCwzJhJeRoB
	+ZujT4D38Tl/SNo2k0OzZX18SSr7rozuqP4+A=
X-Received: by 2002:a05:620a:678d:b0:911:de69:ee21 with SMTP id af79cd13be357-911de69efcfmr1734967485a.11.1779135581148;
        Mon, 18 May 2026 13:19:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e68csm1602427085a.10.2026.05.18.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:19:40 -0700 (PDT)
Message-Id: <eee0543647d46ae87e9bd416995734fabe7897ec.1779135575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
References: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
	<pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 May 2026 20:19:29 +0000
Subject: [PATCH v5 3/8] transport: rename negotiation_tips
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
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change added the --negotiation-restrict synonym for the
--negotiation-tip option for 'git fetch'. In anticipation of adding a new
option that behaves similarly but with distinct changes to its behavior,
rename the internal representation of this data from 'negotiation_tips' to
'negotiation_restrict_tips'.

The 'tips' part is kept because this is an oid_array in the transport layer.
This requires the builtin to handle parsing refs into collections of oids so
the transport layer can handle this cleaner form of the data.

Also update the string_list used to store the inputs from command-line
options.

Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/fetch.c    | 18 +++++++++---------
 fetch-pack.c       | 18 +++++++++---------
 fetch-pack.h       |  4 ++--
 transport-helper.c |  2 +-
 transport.c        | 10 +++++-----
 transport.h        |  4 ++--
 6 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fc950fe35b..2ba0051d52 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -98,7 +98,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
-static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
+static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
@@ -1534,13 +1534,13 @@ static int add_oid(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static void add_negotiation_tips(struct git_transport_options *smart_options)
+static void add_negotiation_restrict_tips(struct git_transport_options *smart_options)
 {
 	struct oid_array *oids = xcalloc(1, sizeof(*oids));
 	int i;
 
-	for (i = 0; i < negotiation_tip.nr; i++) {
-		const char *s = negotiation_tip.items[i].string;
+	for (i = 0; i < negotiation_restrict.nr; i++) {
+		const char *s = negotiation_restrict.items[i].string;
 		struct refs_for_each_ref_options opts = {
 			.pattern = s,
 		};
@@ -1561,7 +1561,7 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 			warning(_("ignoring %s=%s because it does not match any refs"),
 				"--negotiation-restrict", s);
 	}
-	smart_options->negotiation_tips = oids;
+	smart_options->negotiation_restrict_tips = oids;
 }
 
 static struct transport *prepare_transport(struct remote *remote, int deepen,
@@ -1595,9 +1595,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER, spec);
 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	}
-	if (negotiation_tip.nr) {
+	if (negotiation_restrict.nr) {
 		if (transport->smart_options)
-			add_negotiation_tips(transport->smart_options);
+			add_negotiation_restrict_tips(transport->smart_options);
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-restrict");
@@ -2566,7 +2566,7 @@ int cmd_fetch(int argc,
 			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
 		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
 		OPT_IPVERSION(&family),
-		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
+		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_restrict, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
 		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
@@ -2658,7 +2658,7 @@ int cmd_fetch(int argc,
 		config.display_format = DISPLAY_FORMAT_PORCELAIN;
 	}
 
-	if (negotiate_only && !negotiation_tip.nr)
+	if (negotiate_only && !negotiation_restrict.nr)
 		die(_("%s needs one or more %s"), "--negotiate-only",
 		    "--negotiation-restrict=*");
 
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
index dd78d40668..f4388da766 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -754,7 +754,7 @@ static int fetch_refs(struct transport *transport,
 		set_helper_option(transport, "filter", spec);
 	}
 
-	if (data->transport_options.negotiation_tips)
+	if (data->transport_options.negotiation_restrict_tips)
 		warning(_("ignoring %s because the protocol does not support it."),
 			"--negotiation-restrict");
 
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

