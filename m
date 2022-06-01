Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D58C433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 01:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348958AbiFABQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 21:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242700AbiFABQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 21:16:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2367095A3A
        for <git@vger.kernel.org>; Tue, 31 May 2022 18:16:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso231121wma.1
        for <git@vger.kernel.org>; Tue, 31 May 2022 18:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9eK8PZg8l3NFpr8IrakVwLNX+pYFHen6iIQPixLIBKI=;
        b=bHyn7wot9zEhAtfnrN+hMclCGbEs2PstNdCLJXsNR/FWsW2Nx5hQNt4e8rS1L15PXm
         veE7nBenS7iFRkkutlhIQE9J51ywJXFpwivRmo0GXAtSmbr/znuuBnsnae6qKsRjLp0E
         anOnAY40Tet1gR4PHXdFhAJJ3ihUYqIEDpmIED6zgNVvA1LLN5dsB6PGORhxrm4UHPX/
         /qixBV9mgnTVLHeczfFTh8bHhyVB9WUCJKb7bFzDaEQGMFf9qMrUUOotb5sxjK3HnDQe
         +8CbizYw8f3xobnc56/u8yUScSwQOQcoRNsl57BE4ejOzQVj5puQsjpd+/xhbCdNKVDo
         ucwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9eK8PZg8l3NFpr8IrakVwLNX+pYFHen6iIQPixLIBKI=;
        b=IvhRZCj88dyAwyxIwSyyPj9YIUU42cHwYxyPHcwGudobLXtW57vdjqisEcTXt15xVd
         dwI+wTa1njTNwWv9dU20z77Nt+dNTZy9Z82dTQiipktohzSSgANB94IIqCJZmvWfrgnb
         QPa3stibTxT8R8x/HRVPhSbSL4MHA2OLNOFl0tIXDvxAy7/bzyT+BHv9bERA8GMt8G4j
         nKio1zw8QbVKdgEwpnumd1Gea/T2NpF4NPwOxaYfttRkH7bLJV9S1vExiR7acdJyBsTd
         Bp3w1SsvzJoFBOurb6nL3Avz3U15JK9DdkUKfxMwSC1SqIx9pF6003t7VbKrlPcPhnJa
         mqKw==
X-Gm-Message-State: AOAM533N+HMxseyq+xymHBPbRr9XCwq3OV8vZ7vmLUF9qvmOmaFqKGCC
        RpUhB+LYSMKOKwV0X89QEY60kARvY8s=
X-Google-Smtp-Source: ABdhPJxfy0m9VQGxnBK40T+WOoATQ62kp7MuwpK95ElMeeHlqhr+CrGq+CfQ+ZlUqoBvaTvm4PeHiQ==
X-Received: by 2002:a05:600c:251:b0:397:47d6:ade8 with SMTP id 17-20020a05600c025100b0039747d6ade8mr26148942wmj.50.1654046176249;
        Tue, 31 May 2022 18:16:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3-20020a7bcd83000000b0039747cf8354sm282147wmj.39.2022.05.31.18.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 18:16:15 -0700 (PDT)
Message-Id: <083a918e9b1474eff0d51c4502b6d54de9b63764.1654046173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
        <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jun 2022 01:16:12 +0000
Subject: [PATCH v3 1/2] remote: create fetch.credentialsInUrl config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Users sometimes provide a "username:password" combination in their
plaintext URLs. Since Git stores these URLs in plaintext in the
.git/config file, this is a very insecure way of storing these
credentials. Credential managers are a more secure way of storing this
information.

System administrators might want to prevent this kind of use by users on
their machines.

Create a new "fetch.credentialsInUrl" config option and teach Git to
warn or die when seeing a URL with this kind of information. The warning
anonymizes the sensitive information of the URL to be clear about the
issue.

This change currently defaults the behavior to "allow" which does
nothing with these URLs. We can consider changing this behavior to
"warn" by default if we wish. At that time, we may want to add some
advice about setting fetch.credentialsInUrl=ignore for users who still
want to follow this pattern (and not receive the warning).

An earlier version of this change injected the logic into
url_normalize() in urlmatch.c. While most code paths that parse URLs
eventually normalize the URL, that normalization does not happen early
enough in the stack to avoid attempting connections to the URL first. By
inserting a check into the remote validation, we identify the issue
before making a connection. In the old code path, this was revealed by
testing the new t5601-clone.sh test under --stress, resulting in an
instance where the return code was 13 (SIGPIPE) instead of 128 from the
die().

Since we are not deep within url_normalize(), we need to do our own
parsing to detect if there is a "username:password@domain" section. We
begin by detecting the first '@' symbol in the URL. We then detect if
there is a scheme such as "https://" by finding the first slash. If that
slash does not exist or is after the first '@' symbol, then we consider
the scheme to be complete before the URL. Finally, we look for a colon
between the scheme and the '@' symbol, indicating a "username:password"
string. Replace the password with "<redacted>" when writing the error
message.

As an attempt to ensure the parsing logic did not catch any
unintentional cases, I modified this change locally to to use the "die"
option by default. Running the test suite succeeds except for the
explicit username:password URLs used in t5550-http-fetch-dumb.sh and
t5541-http-push-smart.sh. This means that all other tested URLs did not
trigger this logic.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/fetch.txt | 14 ++++++++++
 remote.c                       | 48 ++++++++++++++++++++++++++++++++++
 t/t5601-clone.sh               | 14 ++++++++++
 3 files changed, 76 insertions(+)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index cd65d236b43..0db7fe85bb8 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -96,3 +96,17 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
+
+fetch.credentialsInUrl::
+	A URL can contain plaintext credentials in the form
+	`<protocol>://<user>:<password>@<domain>/<path>`. Using such URLs
+	is not recommended as it exposes the password in multiple ways,
+	including Git storing the URL as plaintext in the repository config.
+	The `fetch.credentialsInUrl` option provides instruction for how Git
+	should react to seeing such a URL, with these values:
++
+* `allow` (default): Git will proceed with its activity without warning.
+* `warn`: Git will write a warning message to `stderr` when parsing a URL
+  with a plaintext credential.
+* `die`: Git will write a failure message to `stderr` when parsing a URL
+  with a plaintext credential.
diff --git a/remote.c b/remote.c
index 42a4e7106e1..accf08bf51f 100644
--- a/remote.c
+++ b/remote.c
@@ -22,8 +22,56 @@ struct counted_string {
 	const char *s;
 };
 
+/*
+ * Check if the given URL is of the following form:
+ *
+ *     scheme://username:password@domain[:port][/path]
+ *
+ * Specifically, see if the ":password@" section of the URL appears.
+ *
+ * The fetch.credentialsInUrl config indicates what to do on such a URL,
+ * either ignoring, warning, or erroring. The latter two modes write a
+ * redacted URL to stderr.
+ */
+static void check_if_creds_in_url(const char *url)
+{
+	const char *value, *scheme_ptr, *colon_ptr, *at_ptr;
+	struct strbuf redacted = STRBUF_INIT;
+
+	/* "allow" is the default behavior. */
+	if (git_config_get_string_tmp("fetch.credentialsinurl", &value) ||
+	    !strcmp("allow", value))
+		return;
+
+	if (!(at_ptr = strchr(url, '@')))
+		return;
+
+	if (!(scheme_ptr = strchr(url, '/')) ||
+	    scheme_ptr > at_ptr)
+		scheme_ptr = url;
+
+	if (!(colon_ptr = strchr(scheme_ptr, ':')))
+		return;
+
+	/* Include the colon when creating the redacted URL. */
+	colon_ptr++;
+	strbuf_addstr(&redacted, url);
+	strbuf_splice(&redacted, colon_ptr - url, at_ptr - colon_ptr,
+		      "<redacted>", 10);
+
+	if (!strcmp("warn", value))
+		warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
+	if (!strcmp("die", value))
+		die(_("URL '%s' uses plaintext credentials"), redacted.buf);
+
+	strbuf_release(&redacted);
+}
+
 static int valid_remote(const struct remote *remote)
 {
+	for (int i = 0; i < remote->url_nr; i++)
+		check_if_creds_in_url(remote->url[i]);
+
 	return (!!remote->url) || (!!remote->foreign_vcs);
 }
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4a61f2c901e..cba3553b7c4 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -71,6 +71,20 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
 
 '
 
+test_expect_success 'clone warns or fails when using username:password' '
+	test_must_fail git -c fetch.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
+	! grep "URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
+	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
+	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
+	grep "fatal: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err
+'
+
+test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
+	! grep "uses plaintext credentials" err
+'
+
 test_expect_success 'clone from hooks' '
 
 	test_create_repo r0 &&
-- 
gitgitgadget

