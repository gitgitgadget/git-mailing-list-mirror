Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684749;
	b=Kw7O33fXRlxdZ1FZJFveha0n8JAl39VDijue1xm3SjxM+4chh9X5d0tTySXLyroplYoF
	 gRT3X+pSW2fuVvhVIl2btAa38XKpv1QUlRZ+GztZALClckbwfiqTix2akPNle5w5WeV1L
	 dFOx2fI0n/DpE4wMPBdWu7kGbSbAaqeS5t474hxJFtHHSGzigyy/jPTtBrRo5XBgGFlY8
	 D5m95bBHkB+Plj/CIEaytdCUWU6gHhOcvDdHWv11ARTtSE65EkHEGJQEoYNWPWMJKfoyb
	 AGUkqB8W3W/4GRzsMBmNfCJHs8NFwvlSeE9jZXvbloUyqcJ6RS2eluHl4sA+e7q4IgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=cWv9T2SBf8N7lY+VvscR+MvHxK6G10GIb3I29LL7hTs=;
	b=Nd0sjaMDDO63yPo/S0PKCfFfTFGDdty7+v5r4j9OUFYcVXwE3N6Mtn74plWG0knDcyZu
	 bB+OUult3G5+JHRctIVQb5aJxnrJUPtmSjmp0T1xjDeqVmclWolJFVCQWuU7FM8yIq2Sd
	 /cMEQOo1Qv7fiZyIB3BfHzB60DcKh+0JWPHX/AJ0jGSlhfZQHjSNfytAtY9ey5H0HCwQ1
	 TWjd1q/23uivcMGa59gIhn73h+nIsWJLBZrY7dlxzDpxiDH5xFOS/IMcVXSYisXFmavFD
	 2uYmZSqHDJBPST1nqzo06W0CUF6vv0G2WayC9qxhz1dyb4RZudT0Yht+5OWrhr93dKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ay8zLdnu;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F14606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 09:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1F14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ay8zLdnu
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f02b9c1f6fso46884645ad.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 01:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795684748; x=1796289548; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cWv9T2SBf8N7lY+VvscR+MvHxK6G10GIb3I29LL7hTs=;
        b=ay8zLdnuduNIKAdBkBCvmqrMxJepCjEZrWPkcAdocZ/4igT9Nxvai75g46dwpHvaoS
         UzYTPQKNbnZVdEZi7h3fdAatAElqab0gxnD0CDUOIBSTFgqz9K4SAukssKAcLbslXncN
         fZ4gSwrVH7kSdHWa4IAogEYlZiAFQqWNu4fVoXUzTyCf4kUhQ4YvPLgoKeiyg6iWqHDR
         3PC6GQbvQFvoeQ85atxkeavmK+a0+EwHQmlVykFCnPWlEu2ar1rKIOtrb+VoBG902FPL
         /g5tpA8D9jQTqQtYNJfdQGLzegmK+Xp04EeAWfNkCXV28ZMirbJsUf4yQiZKwptIHLz2
         AIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795684748; x=1796289548;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWv9T2SBf8N7lY+VvscR+MvHxK6G10GIb3I29LL7hTs=;
        b=yISyYrXL7OGKgZqeecMsXcqywqB6ax6W/0W4ET57J6wA/aQ8Rg+cky+jt68J2AoeDX
         7Q+fnImfp2pm96hwfdLShtN0XIiVmmp5OZBrulLZW6vhfqUxvITNbJpluTEKujGnt0h7
         b+FgcZygZqKkc+KVT0p8C3pL/CnL8PVvNDdDpbY5+f1c6TN4I6J6uzy7cxAwBdJIGHkR
         /mceHEEvscHUlkSzAuON+xPmWAeL0P6JfGYnYzGPJNxNxHe3qQoJgd6/KhOT0+wZUtsE
         1WMD2ElKJWno+x90YsRJ8Falm6hB8zB3U4jjU592XKEn/BOfAIdBAZJeqPIn/hzBb9hN
         5FcQ==
X-Gm-Message-State: APuU4Z/OhN6blBNxPIuBauffxDAwXZutSr11AVjlcPIyXfEI/WyZ8A+N
	39TD8aBp8eQ2NaoRrdu7aybbUJIHGO9cZuIAB1bhGwZonXf/+xKS1V0a2JJDsw==
X-Gm-Gg: AZFdTZdvZ3UxNGZepOTct6+LRD3kKnBmnyzO9AQfZE9z+yjmK7eh0v2UzfJ2S1/47N/
	zlHJ/C3tom73ZzSU8kzb+sFktDwjp5UoAYa0cxwlBBK13dx0hStXkb8JKJiF14trdD+BQfCaAiK
	4mLyAI7f4n0yXw0SHpyYx4dGmcjxPnNNw7ibk1JN2A4mmAXf6Yp0/nKM1usn0wnVtB/4LoJfIw/
	b/J5WEj2KmLr5aq66aqnXM/CP3W08FS+CNWj2GovfySTnNy//1FLp6dtYtpWPQWGfrZGOa3n66S
	ja96qW5CRS0AjH/Z0Cs97KDyNxiiAv6a2nmvPKzYPMNXtSPPIlldRzhQwTZ2TvoofDybicAkMP4
	KCpb3U8GyWL6Y2CfJXnDiI40rLFinYj/t63wD9aM2rEu2Xc23OsAnW23nSJrzA85fbX8VZ6MIZ2
	R7A2gJ3TNZ50kLsAu+M2looPQpyddvhNxTIbeguuB8FKxNrh60ZOngjukAsLjCTzYOtEJr0O2fY
	9Yvy8PSKTuoybJSgtZwAJq+MH54tK5fCtXOWcDu6KmUOggbodBdh/5igeSsTTqcNxLGR3i5jJKZ
	a6XCAAiAjAxHiR+LA6U3Yqw0k5OK58zvWWovoz36fq6IoTfXP0Yo1pQ+GH8EUKn0JjRBBP8mLWE
	tyCY5/Q==
X-Received: by 2002:a17:902:ea03:b0:2f0:7e65:befa with SMTP id d9443c01a7336-2f07e65c110mr106835075ad.1.1795684748230;
        Thu, 26 Nov 2026 01:19:08 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-91.us-west-2.compute.amazonaws.com. [3.42.157.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f191464sm103294015ad.1.2026.11.26.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:19:07 -0800 (PST)
Message-Id: <pull.2328.v2.git.1795684746909.gitgitgadget@gmail.com>
In-Reply-To: <pull.2328.git.1795595886592.gitgitgadget@gmail.com>
References: <pull.2328.git.1795595886592.gitgitgadget@gmail.com>
From: "Julian Maurin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 09:19:06 +0000
Subject: [PATCH v2] remote-curl: honor --no-thin when pushing
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
Cc: Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Julian Maurin <julian.maurin.dev@proton.me>,
    Julian Maurin <julian.maurin.dev+github@proton.me>,
    Julian Maurin <julian.maurin.dev@proton.me>

From: Julian Maurin <julian.maurin.dev@proton.me>

"git push --no-thin" to a smart HTTP remote still sends a thin pack.
transport-helper.c does not forward the "thin" option to remote
helpers, and remote-curl always runs send-pack with --thin.

If one pushes from a shallow, treeless partial clone
(--filter=tree:0) to an HTTPS remote, a thin push lazily fetches
every advertised tip's missing tree from the promisor one by one,
and --no-thin has no effect over HTTP to avoid it.

"thin" was left out of the forwarded options of ef08ef9ea0
(remote-helpers: Support custom transport options, 2009-10-30) after
review noted that --no-thin did nothing on any transport at the time.
f7c815c3ee (push: respect --no-thin, 2013-08-12) made it work again,
but only for the native transports.

Forward "thin" to helpers and teach remote-curl to honor it. A helper
that does not know the option answers "unsupported", which push
ignores, so it keeps working as before.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Julian Maurin <julian.maurin.dev@proton.me>
---
    remote-curl: honor --no-thin when pushing
    
    Changes since v1:
    
     * Added the use case (a push from a shallow, treeless partial clone) to
       the commit message, in Junio's wording.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2328%2FJulianMaurin%2Fpush-no-thin-over-http-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2328/JulianMaurin/push-no-thin-over-http-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2328

Range-diff vs v1:

 1:  c3fb36cb75 ! 1:  8732cf64fc remote-curl: honor --no-thin when pushing
     @@ Commit message
          transport-helper.c does not forward the "thin" option to remote
          helpers, and remote-curl always runs send-pack with --thin.
      
     +    If one pushes from a shallow, treeless partial clone
     +    (--filter=tree:0) to an HTTPS remote, a thin push lazily fetches
     +    every advertised tip's missing tree from the promisor one by one,
     +    and --no-thin has no effect over HTTP to avoid it.
     +
          "thin" was left out of the forwarded options of ef08ef9ea0
          (remote-helpers: Support custom transport options, 2009-10-30) after
          review noted that --no-thin did nothing on any transport at the time.
     @@ Commit message
          that does not know the option answers "unsupported", which push
          ignores, so it keeps working as before.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Julian Maurin <julian.maurin.dev@proton.me>
      
       ## Documentation/gitremote-helpers.adoc ##


 Documentation/gitremote-helpers.adoc |  4 ++++
 remote-curl.c                        |  8 ++++++++
 t/t5541-http-push-smart.sh           | 17 +++++++++++++++++
 transport-helper.c                   |  1 -
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitremote-helpers.adoc b/Documentation/gitremote-helpers.adoc
index 39cdece16e..8203ef497c 100644
--- a/Documentation/gitremote-helpers.adoc
+++ b/Documentation/gitremote-helpers.adoc
@@ -542,6 +542,10 @@ set by Git if the remote helper has the 'option' capability.
 	transaction.  If successful, all refs will be updated, or none will.  If the
 	remote side does not support this capability, the push will fail.
 
+'option thin' {'true'|'false'}::
+	When pushing, request the helper to send a thin pack (see
+	`--thin` in linkgit:git-pack-objects[1]).
+
 'option object-format true'::
 	Indicate that the caller wants hash algorithm information
 	to be passed back from the remote.  This mode is used when fetching
diff --git a/remote-curl.c b/remote-curl.c
index 2c35dd5240..8309d9d2a4 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -184,6 +184,14 @@ static int set_option(const char *name, size_t namelen, const char *value)
 		else
 			return -1;
 		return 0;
+	} else if (!strncmp(name, TRANS_OPT_THIN, namelen)) {
+		if (!strcmp(value, "true"))
+			options.thin = 1;
+		else if (!strcmp(value, "false"))
+			options.thin = 0;
+		else
+			return -1;
+		return 0;
 	} else if (!strncmp(name, "push-option", namelen)) {
 		if (*value != '"')
 			string_list_append(&options.push_options, value);
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8c34833027..280b2d9078 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -253,6 +253,23 @@ test_expect_success 'push --atomic fails on server-side errors' '
 	test_grep "^ ! .*rejected.* atomic -> atomic .*atomic transaction failed" output
 '
 
+test_expect_success 'push --[no-]thin is passed to pack-objects' '
+	d=$HTTPD_DOCUMENT_ROOT_PATH/no-thin.git &&
+	git init --bare "$d" &&
+	test_config -C "$d" http.receivepack true &&
+	up="$HTTPD_URL"/smart/no-thin.git &&
+	git push "$up" main &&
+
+	test_commit thin-default &&
+	GIT_TRACE2_EVENT="$PWD/trace-thin" git push "$up" main &&
+	test_subcommand_flex git pack-objects --thin <trace-thin &&
+
+	test_commit thin-disabled &&
+	GIT_TRACE2_EVENT="$PWD/trace-no-thin" git push --no-thin "$up" main &&
+	test_subcommand_flex git pack-objects <trace-no-thin &&
+	test_subcommand_flex ! git pack-objects --thin <trace-no-thin
+'
+
 test_expect_success 'push --all can push to empty repo' '
 	d=$HTTPD_DOCUMENT_ROOT_PATH/empty-all.git &&
 	git init --bare "$d" &&
diff --git a/transport-helper.c b/transport-helper.c
index d5a064d386..6052407b9a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -275,7 +275,6 @@ static int disconnect_helper(struct transport *transport)
 static const char *unsupported_options[] = {
 	TRANS_OPT_UPLOADPACK,
 	TRANS_OPT_RECEIVEPACK,
-	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP
 	};
 

base-commit: 03b41523c576f26ad34085378717a0c1b287470f
-- 
gitgitgadget
