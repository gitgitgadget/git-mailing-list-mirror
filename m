Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652189;
	b=NHk0jrPnACKzMJR+1u/QFi/Wh7BmSNS/7ezSvHm+P2KKMN0jZk7h1+5QEIETtVnu8jkf
	 vPQGGi20LD5/Dn/Ux2ehoN7slJkRHXKxvovJqDsj9Pky2Yofrbafd8hgIV821MJE9qOeo
	 txA3FB7dTfrUPkJVOSn7bq9u0ERR3w8PHB1lor2EvOiE4RdwkYtwv5dV4J505x1DZ1A5I
	 s2UypDK6ZM6oB1I/cNqDCEn9SfsB3I+DqFTWokpkl4yVJG/tjTfyN8iBHgyWxg3gc7TaP
	 QHwUqDSpYO2PW9pY4lWeQqbZ9UAz4lCtQaDOmNCbgoQeDPgqni8KFRDFle7ZisX4glA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=0+2mr4cK5JJ1W+0QFlmgqpj5qTuDefpXGpHCHcHoty8=;
	b=U71iM5vGk7vekZwcskdAdZyoZQ5whc00TpUsSL2gjr+xhftOB4A6b1hX0p9uQ3zmGzMB
	 I15FUN+Vl2zoDy0hxaGSh9OQvu+RIzuTs30dNMsPvSBCRm0sB2yLGHgIRNnHdrptiNUvB
	 mY/gP6OHbtEViSMuFm0kbuTrw/Xo4a8Pts4saWAFMnbudZdV90zkSlMEZxMc/00VbHAsT
	 lfv7e1F+GrwNewLqS+l54rDQr+6PyFaxuWlSVg31T1n4pKOOcgP5d2lTP1sX6iHCR/QAq
	 spLRovaQZxYg5dag1DzkiXPDFeg9dtlruhhLCe1rYl+R5yS+OIbcfUAbQWTvVLCAewg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oWndum7y;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA06606A320
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BA06606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oWndum7y
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93ead211f14so62940185a.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652188; x=1793256988; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0+2mr4cK5JJ1W+0QFlmgqpj5qTuDefpXGpHCHcHoty8=;
        b=oWndum7yhjltYTLRhD1IKwFjQdnqz9EiT3GfMFaVV62DETHMd3BNM9VTrdZllHYXGf
         iKnA7agXsd2oQBaMv9H/lqWZTxkSDhRIXsSweoSm75K4G/1sH1ei6+/5+dUzLBcsVEZz
         QXFmmzGiLHzbox4HNLf3LorFnGzSQZyG69WzxSq0hOMvV8tRwF2xMeMymcHcTCxfTbX+
         suR9PKGPbEfZn2wkWXPKoxVK2+DiV2p95Ua7smXfd7HLMM4jHLIVQtAhtbHbSbGf2KRx
         BpdlxQgMjuN8QwakWkuP90ptNb6vI3ZRqfkfD+vUyeJyDYZT9Y7ePVVTFkVSOIWKCfXS
         AqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652188; x=1793256988;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+2mr4cK5JJ1W+0QFlmgqpj5qTuDefpXGpHCHcHoty8=;
        b=g8/1s0rM4mDhWbJwHANB9lANzJ/k38E9e7QmAb/zwyV9Odkxa8zS244VwB6zVuLj6z
         jPLHqNYAwaDONyc3Xg45YZNcFbfRpJAtJN0ejKCOQpWgJZY3nnMJsyMbARYF/Y88qjY0
         qDAM/R8YgKc7luWLpTSZ44O539u1tgSFGwYHqqLRTbERVg+eMicTCRhepakbCYAPRCmR
         OApNbOsxJVUHKw3n/cDGyAsF3rLkYYyyv3W8sCUQ0+t0gkS5botGytT2sZ6JBhcHqWU5
         1deE2BieVXe0cpX8IMi5fsdzY4m1K3fAu++KWw7PvnGWNWq/8IBOmMXkZdGnJ8pgzpPS
         dKAw==
X-Gm-Message-State: AFq9FYL/T9c1/F79eUMT+PoNtyvNra8KYBP0BBT3tFD9U3SUzZgH05Uh
	4edXGDr1Pb07cHLv5TdD15KpG5OYwWz/+KtGmyc2wkaWzwU8IZ29Wehh3Xmp43em
X-Gm-Gg: AYBFou3Tos1H5A52+hiQAUk7obiAvjJPnWABoD+yCQ9c8TpVJye3jq6qpYWf3SlTnuq
	cL3luaQPEy17QWGiZakF7tuFXi/lV8A2HZEGWbQUXlwJUdP+jOqGsoRj6SzD4ITX/BnCw27AIDe
	v+o9XauVxuBHNm5Qw5JOW+m8rx3leHuijhJ45VY4OYuUqZXd6RqLXYUGxE/1tboLLLbMwrHzLjF
	be67KHUgSy84S4hgovAZ9h+3x7la8xJF4kwml9JyZRrj4t6fgBndWLdje4DLt16I3e1yneGCYlr
	GkmdErkJgB02pxydohH1RRmgn7K8bpaQHWYXTC634SeWUBzd0zXi2hle+GbSfWiOYyqN3MvO0Z3
	M0mr08Xjr8xrl4VCqlyCPa9BPyiUAJbZ7SVZaP/Eeclxzzvtkl5lEN7L+FL41j929Ih03clOEwW
	0D6xR2668HZ1UaVJ9bZR45R0Ik4siNLw9z27prun4Lw9Huy86f/RCoYOG5Hw81zebccsWe2to4z
	RXrARsVNjJE90V8C3GQZEIEdkGaFyqhDyReIUG8FSP/dPwh4jpgrMzSwJs=
X-Received: by 2002:a05:620a:17a3:b0:93f:3395:53f5 with SMTP id af79cd13be357-93f627ac9b9mr253538485a.34.1792652187953;
        Wed, 21 Oct 2026 23:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.173.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c45747sm43849106d6.39.2026.10.21.23.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:56:27 -0700 (PDT)
Message-Id: <0f446c3c12aa5963259fed2617da51c31b992321.1792652185.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 06:56:22 +0000
Subject: [PATCH v3 1/4] imap-send: wait for the tunnel command to finish
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When imap.tunnel is set, git imap-send starts the tunnel command but
never waits for it to exit, and leaks the argument list it was started
with. The isync code that imap-send was derived from forked the tunnel
without ever reaping it, and c94d2dd080 (imap-send: use run-command
API for tunneling, 2009-10-19) carried that over.

Wait for the tunnel when closing the connection. By then imap-send has
closed its end of the pipes, so the tunnel sees the end of its input
and exits. No test sets imap.tunnel, so the leak checker has not
caught this.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index bf1d2cf74d..fa326c4ae2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -118,6 +118,7 @@ struct imap {
 	/* command queue */
 	int nexttag, num_in_progress, literal_pending;
 	struct imap_cmd *in_progress, **in_progress_append;
+	struct child_process tunnel;
 	struct imap_buffer buf; /* this is BIG, so put it last */
 };
 
@@ -858,6 +859,8 @@ static void imap_close_server(struct imap_store *ictx)
 		imap_exec(ictx, NULL, "LOGOUT");
 		socket_shutdown(&imap->buf.sock);
 	}
+	if (ictx->cfg->tunnel)
+		finish_command(&imap->tunnel);
 	free(imap);
 }
 
@@ -1163,19 +1166,20 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 	/* open connection to IMAP server */
 
 	if (srvc->tunnel) {
-		struct child_process tunnel = CHILD_PROCESS_INIT;
+		struct child_process *tunnel = &imap->tunnel;
 
 		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
-		strvec_push(&tunnel.args, srvc->tunnel);
-		tunnel.use_shell = 1;
-		tunnel.in = -1;
-		tunnel.out = -1;
-		if (start_command(&tunnel))
+		child_process_init(tunnel);
+		strvec_push(&tunnel->args, srvc->tunnel);
+		tunnel->use_shell = 1;
+		tunnel->in = -1;
+		tunnel->out = -1;
+		if (start_command(tunnel))
 			die("cannot start proxy %s", srvc->tunnel);
 
-		imap->buf.sock.fd[0] = tunnel.out;
-		imap->buf.sock.fd[1] = tunnel.in;
+		imap->buf.sock.fd[0] = tunnel->out;
+		imap->buf.sock.fd[1] = tunnel->in;
 
 		imap_info("OK\n");
 	} else {
-- 
gitgitgadget

