Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793491221;
	b=Mrr/tDIpi4OpnNFAVlBVgIg/4PSgEpTjJZoi+3/6eSU/6B0+LC33t9gmUH5gcaCESFea
	 NKNfr3mr6SdtqQymKQ9TyHp9SkZrHVxPmGMamfoaK6agzUM28EiHFmAIuFzGaVuNIRnhr
	 re5Sp5VgLOW7ZZYqWJ92BmB9CbtmofWYacayfa+hP7Wv0Ora+alnOEO0/gB1uMeWoX8fG
	 hxcHQS///s221iFk4v5XTHEKO0v56gZzDVLndPCWypEjRTT+D5mRFx+uNF4n+BF7IxW4p
	 o/0NL4Zy979KobEb5h1g5GxpkCan5Er59y4k7uCP+eau7mpK+E32CYXi2ferH09uJTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793491221;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To;
	bh=tI8HDrU9llZWAQ7I4Bv1pGlzw+vGSkFTUK4QGXfRG2k=;
	b=NXXEw6JY8Qeb4qiAzGRwGxFC36JZnu02qzYhTEqVdcl1yvQ1TAQojf3pPR4+yoM0hcpq
	 k1pWHGQ0xNQLwVWL1tx0/OfMA7Cz3zPudoIZsuVizPps2swaqnsf85zHbTJhGoEoX5kke
	 xfXeE6H/7WVN8BlhmMkcq05aMXLlzDoKFgsyYJSE0f9AMZHkcxtw1t1WLK66+/z6pDwyB
	 IyWrCbhZch64EN/pz9zpJR5jaInePq55xh1N2v+ff88O8tVJFCpUJCttw+SYrm/SKJoDG
	 Yj6TlopM5iz/WcOlrcLN/kVlhFbvH2hbkHAY6AIk7rZI/tW54TmH5BDL2LKL4Q0Y6mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=i99kBhJ6;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E7606A320
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 00:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D93E7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=i99kBhJ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1793491213; bh=TRkc7yRePeZaTRZo7TOZl63JR7qEPkM4w1K1RKy2Zmw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=i99kBhJ6pGL4J7FNgCzGqN2bZndszKPm1+pLfBR3Tp342OTbfeac+t/0hBejfYupd
	 f8R/yrMzexB0WuTQ5wm7xZ/wPxlnWcIuBWJ0iefPruYqKshcz0apGAgEa1myDTWBWy
	 /tCUVbLYaKYw24EhSZW8dQA5DoKiuX4+YzC2snCE=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id B3C3D61512;
	Sun,  1 Nov 2026 00:00:13 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 20:00:00 -0400
Message-Id: <DMJFKJCI5DLL.12R7AMFO4DK2Y@lfurio.us>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
Cc: "Colin Hinton" <colinlewishinton@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261018235508.848-1-colinlewishinton@gmail.com>
 <20261023185007.21642-1-colinlewishinton@gmail.com>
 <xmqqecdezfr1.fsf@gitster.g>
 <CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
 <xmqqmrrxdhox.fsf@gitster.g> <DMHZCS9LOW3N.ZJ3947HUCXZ8@lfurio.us>
 <xmqq33tnz0hb.fsf@gitster.g>
In-Reply-To: <xmqq33tnz0hb.fsf@gitster.g>

On Fri Oct 30, 2026 at 11:12 AM EDT, Junio C Hamano wrote:
> "Matt Hunter" <m@lfurio.us> writes:
>> ...
>> I wonder if it makes sense to incorporate such a new helper function
>> into the existing 'get_follow_remote_head()', since it would be the only
>> place using it.
>
> I am not sure what being the only place has to do with avoiding to
> split a helper function out to clarify the main logic flow, though.
> And simultaneously, another topic wants to have this piece of logic
> twice.

I should explain myself better.  I don't mean Colin should avoid
splitting out logic from the main flow in do_fetch.  But the end result
can be reached without introducing a new function.  I find needing to
hold fewer functions in my head makes the code easier to reason about,
though that is a subjective point.

The idea in my head is below and is
Signed-off-by: Matt Hunter <m@lfurio.us>
Feel free to run with this or not.

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb59e70865ff..844ff5105f91 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -196,23 +196,44 @@ static int git_fetch_config(const char *k, const char=
 *v,
 	return git_default_config(k, v, ctx, cb);
 }
=20
-static enum follow_remote_head_settings get_follow_remote_head(const char =
*setting,
-    const char *key, const char **no_warn_branch)
+static enum follow_remote_head_settings get_follow_remote_head(
+		const struct transport *transport, const struct fetch_config *config,
+		const char **no_warn_branch)
 {
-	if (!setting)
-		die(_("missing value for '%s'"), key);
-	else if (!strcmp(setting, "never"))
-		return FOLLOW_REMOTE_NEVER;
-	else if (!strcmp(setting, "create"))
-		return FOLLOW_REMOTE_CREATE;
-	else if (!strcmp(setting, "warn"))
-		return FOLLOW_REMOTE_WARN;
-	else if (no_warn_branch && skip_prefix(setting, "warn-if-not-", no_warn_b=
ranch))
-		return FOLLOW_REMOTE_WARN;
-	else if (!strcmp(setting, "always"))
-		return FOLLOW_REMOTE_ALWAYS;
-	warning(_("unrecognized %s value '%s' ignored"), key, setting);
-	return BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+	int ret =3D BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+	char *key =3D NULL;
+	const char *setting =3D NULL;
+
+	if (transport->remote->follow_remote_head_seen) {
+		key =3D xstrfmt("remote.%s.followRemoteHEAD", transport->remote->name);
+		setting =3D transport->remote->follow_remote_head_raw;
+	} else if (config->follow_remote_head_seen) {
+		key =3D xstrdup("fetch.followRemoteHEAD");
+		setting =3D config->follow_remote_head_raw;
+		no_warn_branch =3D NULL;
+	}
+
+	if (key) {
+		if (!setting)
+			die(_("missing value for '%s'"), key);
+		else if (!strcmp(setting, "never"))
+			ret =3D FOLLOW_REMOTE_NEVER;
+		else if (!strcmp(setting, "create"))
+			ret =3D FOLLOW_REMOTE_CREATE;
+		else if (!strcmp(setting, "warn"))
+			ret =3D FOLLOW_REMOTE_WARN;
+		else if (no_warn_branch &&
+				skip_prefix(setting, "warn-if-not-", no_warn_branch))
+			ret =3D FOLLOW_REMOTE_WARN;
+		else if (!strcmp(setting, "always"))
+			ret =3D FOLLOW_REMOTE_ALWAYS;
+		else
+			warning(_("unrecognized %s value '%s' ignored"), key, setting);
+
+		free(key);
+	}
+
+	return ret;
 }
=20
 static int parse_refmap_arg(const struct option *opt, const char *arg, int=
 unset)
@@ -1990,19 +2011,9 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			if (transport->remote->follow_remote_head_seen) {
-				char *key =3D xstrfmt("remote.%s.followRemoteHEAD", transport->remote-=
>name);
-				follow_remote_head =3D get_follow_remote_head(
-					transport->remote->follow_remote_head_raw,
-					key, &no_warn_branch);
-				free(key);
-			} else if (config->follow_remote_head_seen) {
-				follow_remote_head =3D get_follow_remote_head(
-					config->follow_remote_head_raw,
-					"fetch.followRemoteHEAD", NULL);
-			} else {
-				follow_remote_head =3D BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
-			}
+			follow_remote_head =3D
+				get_follow_remote_head(transport, config,
+						&no_warn_branch);
 		}
 		if (branch && branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {


Admittedly, I haven't been following Harald's hn/fetch-refmap topic
closely, but am more familiar with the affected areas now.
