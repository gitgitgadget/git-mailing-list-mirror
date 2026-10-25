Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894598;
	b=e1KavkHfDENru3ehMwl3KHAm6Y658j3ek07eSVHLaEgAbea4GQ/TICfaXJNCppHr5KpG
	 3P64NrTj4RqMw9HBINnURS1/lCIzlICKVQQNgHI75vLQo5V6zFOax8XMSSld/sXNhPzSV
	 B1eb5mEMMfkSlmDVVBd31zVUSQCmX3BgjxVfrxqGITvhE2P/tlmyFJC6Rfaxx8bC37Z3F
	 ou7KvfHqLo/nFnpMuM7zpJjFT3VWz4bt4EPpDsvG4T+ah8U4uqvJ8LHqHOBacCgW/aIMy
	 xJdVFQMytsRwY2SdDGx0Ol3+AdTa4V+hQc2X3wd3rHqGJNv+x3zhsIGhVddFTkb7+Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894598;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ngUAYHsjZkUfjPFeR4N0jr/eFTkUp7v13JMgsUv+OIk=;
	b=Ar9ZrRowrLVyo70V6yd5PbyOto5GBgGKBHHCGAZRqCBMUo96W5Wo6YLVPM1lQiE7eEvg
	 8xRT9IntSDlZEi7Uomcj3ypd2ZASIIRB+VOQVYnYaQr2ZeC8UskLZeYuOjDQxtwOvWdP6
	 CaJxs8ur9xxqbZuNwfFsVDJtmU5LZqYGCuKAvW0Hkx5mnb8SA1H4PydcCIVU2mufYQn1T
	 QRT24SIxztl7MURT5b9bUM4F2RgNmnK7xOWNz/BdnErA57AMIIaA8pICY5/nha79yfsFS
	 0+excUYGgJWbPZSYo5f/lJj9iEE26o2ak/ku+Xa4xGBGKwC6P8rQKBxlv8bskn94SIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=I8xUvzkz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NLfo4sa0;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80518606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 02:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80518606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=I8xUvzkz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NLfo4sa0
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6964B7A0089
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 22:16:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 24 Oct 2026 22:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792894596; x=1792980996; bh=ngUAYHsjZk
	UfjPFeR4N0jr/eFTkUp7v13JMgsUv+OIk=; b=I8xUvzkzF7MWaiDNW2gw1bMxr6
	BtXkQurxjTwU05gPHk1rK1zv29w48G1CjXebbFerj43XGf2mSoJwKJzp9WF3A50N
	DlU2We9xNYrQ6GJLw2wtWYaWTF3L3dRbESxb/jbCe1H1p0i4Iq1XZobmtL0WCb6F
	jDkmr8BAX/P0YFCJ5IlEV9EzzJV0yLhfG5LnROqEYEo9feNi6mppR2y2pLmqYlQU
	x51s+hzQ9Yb/Yx+l4PyKg8rj3D1nfA99FlQtHJJTyQETlHfEeNpnkkDwCu88pizt
	NIgI1663eS9BZIAPc1gUyUq7MspmHbyufINm+TSepRzh3WM6kjaHnJgXqE3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792894596; x=1792980996; bh=ngUAYHsjZkUfjPFeR4N0jr/eFTkUp7v13JM
	gsUv+OIk=; b=NLfo4sa0wxUrDUuxoTBWquJKxDpySV2rAT38oG6L32XQvQfPt1p
	c40Ww/1mYZIwST7mSfA7hHlMGlELyZWA9LepmSYDBXTi7bwu5zn/cC56ntcMpsqM
	MuDiB+felsVTkU+M2fs76LU/Qw9/Os9Cw3w+bPALRwLVjgzwBX6S4IzO8liW0SH+
	ttxSnERq+3N5mwV97Qg6BKgPNt+PfmO4gGopw1qf564nyA9nBJv4AXd+Hs+/CLEV
	eC7wbreMFUHowF5cth5PXlm1lr+anQMJcczRvQd/EboNi9WigWkHNHZWj6SZGzEP
	ObDEscnSeKDetqdCIOkYMFT67dCShmhZscg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792894596; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:H6UFTaSZR7jaOW8VP3ZXduO+Z2TDMQBWXsC+d6bVj6Akwj/
	oxhnCHiQu9aOOENlbjjyuclFuCkDN6yp8wZYvGbRDzH9dlMTlbIzEDxuabJEHJPn
	0y6LJyVjJmf0qFH5OmCi2Wba7qQqXuoVErdbtvLfUljcH8zcn7QWzcc0rGbuX6VT
	bfblxhQ0EH925GDveITDPLrpFPSFK/OrLGvJX6YevKYen8rID0KxpqZP4soHXgus
	MFPyRt75s11ArqMRT0rtAA/yZtWLJHhi4axD/hFY75+Wge2OZP8uVSSVOdNOmgNh
	gx6JFi+McVJYUv+BlOicP71JfS88h5zrEiYVRug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jfTQIyH/gx1mKTWgsyOvtE2B2XaQS49MeUpOP0juyaM=:1CWZaQ/JFfsEVbBBNsTfQ9kkjgIjF405N4y1qlzMehY=;
X-ME-Sender: <xms:hGbdaqoA8zaH2cWNZBfzixhwlZzAWudU2ylKKstcxbp_xgkEjwFdsA>
    <xme:hGbdavrE9iOWdgAf3v4pXJ_yR9gnkoTC1cWOL2a9XyYf1cw6ZdqQaGNXAv7Z58yUz
    gtiNAz1xKrIuRre5LxR1DtqRWVU61KBjGStmjY2BJOc7OsFz2B4S3U>
X-ME-Received: <xmr:hGbdakOIbNVDIxb5KVuid_moJ_bY_dHKETXF6X1hcqc2TL15YSippQeFEsYhDmLvuDG30IWJ0bLGDH4REXNqEQ4dZP0A0NFNHcFR>
X-ME-Proxy-Cause: dmFkZTEnycJBqTARO/+zjCeh7AOBVd8YfCquxA+Z75TwlIkcXkAHsk84keFbkQjhoHiUUB
    gMAWZDglpxhdR0XN8qRrV8GaEJ3WuVlmSI2bfPJLhBG7nWM0WcjKZlzi/QGwggZuB44wNB
    IgivmWxTeHayAUzeL2nZTbsgPo737gvqj0x4POiwn6oiKFPgStCVKNRXMzN1eNTftC/saT
    bpAXocfxcxUw8wvY50xBv8IIOJvrA4j9x+qJN2Sa3FhDSkO5+uONcmsNEU1aI3EmaoOVbo
    03pGz0/sgn9EhTstgCW8zyBxSUtvD147quEO45vxvO3zzcHH9kQ39/VrsZFzP8XBTBbZnU
    iGN0lyXjPNLWG7ht0Z1m4ZIUL/1pu6AoHnDQaqtv3VzZpLleja/6E9/1Ewg1X4JanXejvk
    STA3fZ0jD+SwiMqe6PItGwkQO08s/7pZXU2g2Nflm6MwMVIn2/aylUuyf6qmaMFI2nKlQD
    FSf4DuMcD9NXrqIgWyRUZHZE44n5I1ZN9fH5JTl2g65Txjl21w/CpOMXmlZaYOkY+BJre0
    Q8aYfc8M4+zi27cwdH6KKWqB2ZFHRZLooqw4fx5dnoXMPtYewW1dR+N81lWnSobKprg+ws
    RgJRngE9kJEIe82SAHHqenfLnh2BGkOz7fsdPcDkWMunkZrOjYdAOYTqIDQQ
X-ME-Proxy: <xmx:hGbdaoxEhvJQt2QdYTm7j7GykhxexUEFll4YW5ec62hxwocY0EmYFg>
    <xmx:hGbdalstEishuHPKpHyJ-ArWzYfiQ3SID6zvyX2GHyVR3wOp2cqKWA>
    <xmx:hGbdap5f97Ne3vaj-8Py5QSYp1Bed9W7bbBaI6KI1C0_l-UKIhwt1g>
    <xmx:hGbdasS9zpGLMHcvzK_egeGWECEgP9tDAqny9FbnJQ9zq-E8e9etlg>
    <xmx:hGbdaiei5N3tGQCUceGKtMD7FGo0wO9_0eG4UzYwqELchC-X7lprtnba>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 22:16:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org,  m@lfurio.us
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
In-Reply-To: <20261023185007.21642-1-colinlewishinton@gmail.com> (Colin
	Hinton's message of "Fri, 23 Oct 2026 11:50:07 -0700")
References: <20261018235508.848-1-colinlewishinton@gmail.com>
	<20261023185007.21642-1-colinlewishinton@gmail.com>
Date: Sat, 24 Oct 2026 19:16:34 -0700
Message-ID: <xmqqecdezfr1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Colin Hinton <colinlewishinton@gmail.com> writes:

One more thing.

> @@ -1978,16 +1990,19 @@ static int do_fetch(struct transport *transport,
>  		if (transport->remote->fetch.nr) {
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
> -			/*
> -			 * See remote.c's handling of remote.<name>.followRemoteHEAD
> -			 * for the analogous, still-unresolved case.
> -			 */
> -			if (transport->remote->follow_remote_head)
> -				follow_remote_head = transport->remote->follow_remote_head;
> -			else if (config->follow_remote_head_seen)
> -				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
> -			else
> +			if (transport->remote->follow_remote_head_seen) {
> +				char *key = xstrfmt("remote.%s.followRemoteHEAD", transport->remote->name);
> +				follow_remote_head = get_follow_remote_head(
> +					transport->remote->follow_remote_head_raw,
> +					key, &no_warn_branch);
> +				free(key);
> +			} else if (config->follow_remote_head_seen) {
> +				follow_remote_head = get_follow_remote_head(
> +					config->follow_remote_head_raw,
> +					"fetch.followRemoteHEAD", NULL);
> +			} else {
>  				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
> +			}
>  		}

This part of the code becomes overly deeply indented, and more
importantly, the outer conditional around here has been reworked by
another topic and the code that learns follow_remote_head will have
to be reused elsewhere, which would lead to a nasty merge conflict.

I'd like to see this part refactored into a separate helper
function, by squashing something like this on top of this patch.

Thanks.

 builtin/fetch.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git c/builtin/fetch.c w/builtin/fetch.c
index bb59e70865..77e3276cc4 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -1946,6 +1946,28 @@ static void collect_updated_tips(struct oidset *tips, struct ref *ref_map)
 	}
 }
 
+static int lazy_follow_remote_head(const struct transport *transport,
+				   const struct fetch_config *config,
+				   const char **no_warn_branch)
+{
+	int ret = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+
+	if (transport->remote->follow_remote_head_seen) {
+		char *key = xstrfmt("remote.%s.followRemoteHEAD",
+				    transport->remote->name);
+		ret = get_follow_remote_head(
+			transport->remote->follow_remote_head_raw,
+			key, no_warn_branch);
+		free(key);
+	} else if (config->follow_remote_head_seen) {
+		ret = get_follow_remote_head(
+			config->follow_remote_head_raw,
+			"fetch.followRemoteHEAD", NULL);
+	}
+
+	return ret;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config,
@@ -1990,19 +2012,9 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			if (transport->remote->follow_remote_head_seen) {
-				char *key = xstrfmt("remote.%s.followRemoteHEAD", transport->remote->name);
-				follow_remote_head = get_follow_remote_head(
-					transport->remote->follow_remote_head_raw,
-					key, &no_warn_branch);
-				free(key);
-			} else if (config->follow_remote_head_seen) {
-				follow_remote_head = get_follow_remote_head(
-					config->follow_remote_head_raw,
-					"fetch.followRemoteHEAD", NULL);
-			} else {
-				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
-			}
+			follow_remote_head =
+				lazy_follow_remote_head(transport, config,
+							&no_warn_branch);
 		}
 		if (branch && branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {




