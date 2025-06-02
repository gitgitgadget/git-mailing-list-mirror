Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206A1C7008
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848665; cv=none; b=C/UA7nVavPqGQW/j76MgqXaKzYVm7cuRm2z4VSPDkmQeGKaZMmRb28i/G9Wz9vbMzs2hlL5wvcHsn/EdtY1zJgdNCFB8j57XPy2VthYoY9q84N5OedspbXocZY26ObY5dpKs95zDkwpqsGWaE9wuamlcpHY3H1rca3kTuetbPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848665; c=relaxed/simple;
	bh=YUUi7DX8Zsh0kKx8+xs2wXyCXj41VYsXaMFxTSplgRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQZrCeQpxspQ6hVWTkjcfqThC8+obt3x/mE02qevnpYw4IYM1qGwppXGcPBeYzHZdRJbG1K3tTYxFq/e02yG54XLCYmPg2WLqvprtmPj2VbWWurgPJci0AsgZWWsQjOGFPsC4c626DDghHbcps2c0FmV8hqyh8V2O4lfqeUIlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=irqVww4h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mhtI1ywi; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="irqVww4h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mhtI1ywi"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A29F025400F9;
	Mon,  2 Jun 2025 03:17:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 02 Jun 2025 03:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848662;
	 x=1748935062; bh=R9YbUwPpcic0gi6751sQK332IKPS9vuRV4FJjh7Efts=; b=
	irqVww4h3zt9cdcciBwQqhvhILtXuNNuHYG9i8Zbdm9tfjteiNNiodOOb8MaBaIh
	sk1WTtB0zFV9HFi6as2aea4wy/v0Q5JPhJ3hXL7SD7LTcHqKCv6kan7uIJPbkcsB
	4Id4HOMJmydEVhloe9ErFqhdpQgGM7lpfOuKVZ8KTGM01jSvhsfMPaWMe5e75rmi
	oBC3BWJzE4xsxxLPYVS8nsfJuPT8XDtKYve1JvQz4hUGfarCGzEhxQZdnj1JEytG
	mhL5BaLcE/vWsdlo082pWdIIA0BHpavSUambKRcwqKvdaUVU1LXk2ccChf3fE8v8
	KFvF1d1mfzseNblgNE+feQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848662; x=
	1748935062; bh=R9YbUwPpcic0gi6751sQK332IKPS9vuRV4FJjh7Efts=; b=m
	htI1ywii6vtqx9wA2cSynl+AG6eJQ/gdYIyrI+dUFT6Qu+F5L7lXhkKM4hb4i7cb
	5ln9JIF233Eq2VsP5I0kWbzfAHTbgV6Ptl4AAjqiWae6bKv2DmOyXah3kbksJQLW
	rhNq14zL6wSkXUIzBtEO+OBPEvSwLIs/vk+bCSxxWXpdw43qoC+86ijY91QZ+tnz
	B8i3d3Q9gCWOQjeY4ZwED4lKLLrsEbj08di85ufAsoIkJ95bSwRoIKlRn5m0SHAp
	/jzCy1VWzn9IWs4bzJeFUzIDONg0BDJlq5SouWMiuihmLQL//yFd98Y83d1eUugZ
	xufgFQQAxyftyyIlaECfQ==
X-ME-Sender: <xms:FlA9aGgXJTTgQJUtwIW904dH0_SdwRRnxJsKFyyuE6U4j6EwOjX7Zw>
    <xme:FlA9aHCDqJLEPkHYuzuZGLiO5IQeXmcbXTJTMr_JAGFWe2oO4fLw2JBuXujw27UeY
    IN8W_B3_3hq7gCZrg>
X-ME-Received: <xmr:FlA9aOHudhpkigWmTO2AXc6-SKqp0-Npa641ZoYQhhBrrjfBmxWilBFzt7Yg84ak7rcJ0n_hRgOhbMLjvEyTqn0calEHtvnbe3TbdM0QZH019w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdr
    tghomhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihrhho
    thhhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehrrghmsh
    grhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:FlA9aPRHkblbcY6x7JgoLoSraIq5QWKceuvf8De8HLTG8fPBXwL8WQ>
    <xmx:FlA9aDyftLJ2qLIzi6hqnNwM1gqT7LZrEygcZeXVfTt5BCA7im88IA>
    <xmx:FlA9aN5QLrJ0r83amsADMgdvC_ISS24Kf3GtVXGO_9Ra0ZPyU1qrCw>
    <xmx:FlA9aAx0pf2n4kahkOE5HuAFYsw0OTIdWHR40vUtO_HEB0QoTLTzpw>
    <xmx:FlA9aIk5Rb1aoU2MwWJefiNmtg1lQJ1-bHb2EG8am7OHEhHXbNHArCCj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c789fcf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:37 +0200
Subject: [PATCH v3 11/12] builtin/gc: avoid global state in
 `gc_before_repack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-11-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The `gc_before_repack()` should only ever run once in git-gc(1), but we
may end up calling it twice when the "--detach" flag is passed. The
duplicated call is avoided though via a static flag in this function.

This pattern is somewhat unintuitive though. Refactor it to drop the
static flag and instead guard the second call of `gc_before_repack()`
via `opts.detach`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index fdd0dd09be7..4a5c4b20442 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -816,22 +816,14 @@ static int report_last_gc_error(void)
 	return ret;
 }
 
-static void gc_before_repack(struct maintenance_run_opts *opts,
-			     struct gc_config *cfg)
+static int gc_before_repack(struct maintenance_run_opts *opts,
+			    struct gc_config *cfg)
 {
-	/*
-	 * We may be called twice, as both the pre- and
-	 * post-daemonized phases will call us, but running these
-	 * commands more than once is pointless and wasteful.
-	 */
-	static int done = 0;
-	if (done++)
-		return;
-
 	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
-		die(FAILED_RUN, "pack-refs");
+		return error(FAILED_RUN, "pack-refs");
 	if (cfg->prune_reflogs && maintenance_task_reflog_expire(opts, cfg))
-		die(FAILED_RUN, "reflog");
+		return error(FAILED_RUN, "reflog");
+	return 0;
 }
 
 int cmd_gc(int argc,
@@ -965,7 +957,8 @@ int cmd_gc(int argc,
 			goto out;
 		}
 
-		gc_before_repack(&opts, &cfg); /* dies on failure */
+		if (gc_before_repack(&opts, &cfg) < 0)
+			die(NULL);
 		delete_tempfile(&pidfile);
 
 		/*
@@ -995,7 +988,8 @@ int cmd_gc(int argc,
 		free(path);
 	}
 
-	gc_before_repack(&opts, &cfg);
+	if (opts.detach <= 0)
+		gc_before_repack(&opts, &cfg);
 
 	if (!repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

