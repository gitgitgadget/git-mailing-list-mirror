Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595889;
	b=igN5o93dcV7Ehm3UGtRw+TD8MU7nZwb5tUsZxnPYEQEJ0KEnb6xVKnkp6ddWUc2LsTGi
	 v+eY+U/KtskUyvCXb5PFkYl01WtrjDrvHyWndPRshBM+K+q7cC9tTW3hSDxFBn9k+1ogU
	 arGV4svFeoNqqzHtgvF2dhTWmRryLjaHMUKYC0LGA6UkvDsCBKJEzMxpnrLIegobalzgn
	 4B31rsin9j+IUK7vLsnhe7k3JXHlfl3oEQWw92U2cfFa2/FuyZDCIcIclpwRw4lWcJSqo
	 KVuMYmVb8kZSzHt1mWht+bk3apVDFkwN5ae6xJE1K+gKQ/b9AO8pe+CKtHSEs1Lz+FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=7ZtmMqm6Zj9eEx40WtUR2QVS/bJsDhYoYoXpiv9chVk=;
	b=GeDuH9yixB7HoDnd9/uzf4ltEIQEpSJi4wljYEMV9nS4Z7O7gNztjwv8diZlEoLR4QA7
	 iQ1rAADu7SXoHDrl81KV6iV57sq1KrEuY5UxvAOvFgXg0USxq1JHQ/NqxT1WqHLWXeJ+W
	 ulXMuHQNHeETpqiwx3Twn57MEHiqWpl+g69RkBjOUtNOJROvPjWrFX63XlKuToA1rAUTr
	 bpjjHBhR0Z0u01Vp6iQdL4nIZM7LgL/xMrG2JGGp7Ns//+2E/Gvd7n5YPB2ciAUS94Yi7
	 w4Tzz3AE5EYhg3NSUG1zPjVdxh9P6Aonp6S5ft8jOmjydzGqQah87qm+iYWDWYOEh2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLhgbjb4;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859D6606A32E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 08:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 859D6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLhgbjb4
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9212dac247aso57644106d6.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 00:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795595888; x=1796200688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7ZtmMqm6Zj9eEx40WtUR2QVS/bJsDhYoYoXpiv9chVk=;
        b=XLhgbjb4Atl7F7NFbYy03AtPpn4eANJ6CKwAw4MWeznTHvKI/r4pJmvJjlt4VZSkak
         I7KzX+tqi/Nacm9P04Y1wvKNR6jFjCrw9yq4FWJDuoHGUYs3dC0Fj6tYYoYzOstlKiwV
         AJP16k5gJyEUKsjg9VEcaDnDW4tOL5XJepZxMeckfieE4TD80SMHQCVW7lkvIfBCQ+zz
         Rm7nEUTi98VS+Og76xP7+DMK1U/Enm6pop6DBgRn/d43h04cWqYpYzgsqKgbf6YE8y5e
         nkInUMKLEX+lr00TFDdobR9k7Cbmd5fgN+wp5PMG2E1Zybzho9eSUg/MG8KquwiIELGq
         Cefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795595888; x=1796200688;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7ZtmMqm6Zj9eEx40WtUR2QVS/bJsDhYoYoXpiv9chVk=;
        b=qIcSeVH1p3m0S4jlUZjWnt8IIbmh++A4zwyVSdV9PNTiFnfB6Pvww5l1s4MmpsTBq6
         oGNSKEmARyzBhDS48EfZf0Z6evnSilZyxGcrflpa5DNjPgRNEjjsxvYuEP9Ij8Lt1qZG
         htcj2Xlp6n7ThBX2GK2dUa1RI1mjRkRSnbMAnwG0oIJDX+CavBhlxfKNxucZDeDBJA8K
         GtEAufqxkYbWFIBNHhvQZ5w17c8Vx9/2pc8NtH2AVCnIDFpZ0QxRLyfWbYjj/r5WZff5
         F57L4wApsS5NKvwSOsOXIEi6VNXT1WytCrV5RMeFcHCGKVX4Wov5OFAUIHoVpjokUc93
         pBPA==
X-Gm-Message-State: APuU4Z/ZX31yJ5D1Us5pz9ua3myddwt00aYAH7Wl4Zo/QpHSC24og2q5
	Juu5NuLH2JqUPcJ8phFM3eseFVquX6Z8qVNCuiyL7ESldN734O6OTXegHdXWAA==
X-Gm-Gg: AZFdTZffMAw+S/JO7KpfFgSpzZy3f88IpH8pVC6KZXgjhx5y2KEyinoU9aHJs/n1+pe
	vpupa7TFVOfBTxUDEHe0DV+RTspPa2KBuA2YkNW4+v0gj3udLwU0kWd+U3CM9jl2zOCaw8zcY7C
	1eFUXFvWEJemEFgqdyZfSUWrDRxdis5lZdiRZcas2YMjYRhFKgAT/mOrnOU+WVOz5+d+1FnIcK/
	P0ZIMAf0K4o9jDi/MX71xoKfJ8LiHPgB6MK9FPNrBHcn88yN8px2dDVM/oRC/K6ojdg0y5fMfsu
	7TlrcP0CZMHNvY2GAD9TC1HVyMpkIbABdUzgMBjO9hsDlvcT0Ub5kJ+QX3KROJ1l9+VzA+q1iG6
	+L/j/UAk8qkIVk6InmNs5C3DwGJxrLdV4Fwg8ZCbSz2ZLEF5kFOdyoTMCu/WhTnY5rg0d8412EY
	Tb6cfVRrgiwsQfNSZemK9jaLUf6yRrPGUtB38OZBujtVFUzAbOsk90m4OwyowIOM9W+ehnmdMdv
	EBtTx3KKiRicj87mDbm0/zMutWl/znwvq6O/V5GFRPSj4jte5rr8n1gj6SIj3z52ShPfObFuEv7
	knySc09D1n/ep5zZaCg78QLeXocchFz4UHlXF7jW9I9Zz4IoOrQYHz2qy9V8AxV840CGokbEZ6x
	DpmgGlZsApmqoWpD6jw==
X-Received: by 2002:a05:6214:1242:b0:91c:6d30:7c2c with SMTP id 6a1803df08f44-92134af091bmr295251576d6.52.1795595887486;
        Wed, 25 Nov 2026 00:38:07 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-41-210-71.compute-1.amazonaws.com. [3.41.210.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d0e35sm156687926d6.20.2026.11.25.00.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:38:06 -0800 (PST)
Message-Id: <pull.2328.git.1795595886592.gitgitgadget@gmail.com>
From: "Julian Maurin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 08:38:06 +0000
Subject: [PATCH] remote-curl: honor --no-thin when pushing
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
    Julian Maurin <julian.maurin.dev+github@proton.me>,
    Julian Maurin <julian.maurin.dev@proton.me>

From: Julian Maurin <julian.maurin.dev@proton.me>

"git push --no-thin" to a smart HTTP remote still sends a thin pack.
transport-helper.c does not forward the "thin" option to remote
helpers, and remote-curl always runs send-pack with --thin.

"thin" was left out of the forwarded options of ef08ef9ea0
(remote-helpers: Support custom transport options, 2009-10-30) after
review noted that --no-thin did nothing on any transport at the time.
f7c815c3ee (push: respect --no-thin, 2013-08-12) made it work again,
but only for the native transports.

Forward "thin" to helpers and teach remote-curl to honor it. A helper
that does not know the option answers "unsupported", which push
ignores, so it keeps working as before.

Signed-off-by: Julian Maurin <julian.maurin.dev@proton.me>
---
    remote-curl: honor --no-thin when pushing
    
    "git push --no-thin" over smart HTTP was ignored and a thin pack was
    sent anyway, which has been corrected.
    
    I ran into this in production, pushing from a shallow, treeless partial
    clone (--filter=tree:0) to an HTTPS remote. In a shallow repository a
    thin push reads the tree of every advertised tip it has locally, and
    each missing tree is lazily fetched from the promisor remote, one fetch
    per tree. --no-thin avoids that work, but has no effect over HTTP.
    
    A small reproduction with the test suite's httpd (400 commits, 40
    advertised refs, a --depth=180 --filter=tree:0 clone pushing a merge):
    
    default push:                   37 lazy fetches
    --no-thin, without this patch:  37 lazy fetches
    --no-thin, with this patch:      0 lazy fetches
    
    
    Helpers with the "connect" capability (ext::, fd::) already honor
    --no-thin, as the native transport code takes over their connection.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2328%2FJulianMaurin%2Fpush-no-thin-over-http-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2328/JulianMaurin/push-no-thin-over-http-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2328

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
