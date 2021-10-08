Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B8C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 16:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE88A60F4F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 16:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhJHQFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJHQFG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 12:05:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD5C061755
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 09:03:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i12so18644779wrb.7
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ECq2nyO7lTU5+WTnAphxxRmzj4lbuyMk4pOSvbwXdvU=;
        b=RPbhNXHd66kXVdL1834DRnS7nlKRsUo5M76QpzwFoTldAfIpEbJa1gsBv7JEmwSTUQ
         rk2eb2H/avUSFN6enYIV2Uf+3+3ylzXwFP3Ghh6PLut73wJ3zFqo1RzxxmryqoBiW4vD
         y5QT7L/rnNMRqxkTatCydBPpd8fm1ZaKG9TuFyMcuhZ45SdFrWmZetz+ynX4poXb6mX8
         eGnk6ENoclYDCcwtHdOJutROWW6y8n3S4e71VWVBZZckwd99e7sSc1aRMuMm6COsXSCU
         04/aN9gx1XVKyd0Hmcq/QV3YBJpLsz/B0B67pTXeCBfwxDuqWmDIjSowGi/kLD1U1ESq
         El1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ECq2nyO7lTU5+WTnAphxxRmzj4lbuyMk4pOSvbwXdvU=;
        b=JHhWSHiuL9qP4r89Iqc/05HQDY5+idLKiejedRgH7dUNkhwehiEmtDwPQZ841GY01B
         5G0XweKxq6qszicaJ/YENwOvdvYpslzw+uOtB83d+6ucT4C5UJqHgQ+6E7WXR53UeBCP
         pV8Cub3sLRuUKEELMX9GYQfbs8IbuZjovjw2ZS/Jo2Fznaer8MuUFvyTmk/Mxjvaeshz
         VHQgVBK46+1bKud152D67bg97iYD4ng7qwqpaAX97UKaHH0ssROtP5B+5ahA82YhrtDb
         q9LWQy0wHoqcws9e9OSQdeaGIKirHpUcXWN+FIMAdn/EajEiOhBgnhe4LdmyouIuB+IG
         U1gQ==
X-Gm-Message-State: AOAM533zEdfqdsCTtJDkYMQDchG1pwbIgvgrKxwwg1QnkIEC/DOxVrLl
        w8G2yeGHvUT673ZBkcdxGAVW0xJg3xI=
X-Google-Smtp-Source: ABdhPJxCTKL6VKGw5C9oAXrDa0h4cBL+uHiGvIq0cwR6k/NKfEXioUgnQYbN+88rJPAkZx18RHQV7A==
X-Received: by 2002:adf:aa4e:: with SMTP id q14mr5169419wrd.100.1633708989238;
        Fri, 08 Oct 2021 09:03:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm2892306wro.63.2021.10.08.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:03:09 -0700 (PDT)
Message-Id: <b473f145a87a22db99734c6a21395f0d24c3da3c.1633708986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
References: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 16:03:05 +0000
Subject: [PATCH 1/2] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ivan Frade <ifrade@google.com>, Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ivan Frade <ifrade@google.com>

In some setups, packfile uris act as bearer token. It is not
recommended to expose them plainly in logs, although in special
circunstances (e.g. debug) it makes sense to write them.

Redact the packfile-uri lines by default, unless the GIT_TRACE_REDACT
variable is set to false. This mimics the redacting of the
Authorization header in HTTP.

Signed-off-by: Ivan Frade <ifrade@google.com>
---
 fetch-pack.c           | 11 +++++++++++
 http-fetch.c           |  4 +++-
 pkt-line.c             |  7 ++++++-
 pkt-line.h             |  1 +
 t/t5702-protocol-v2.sh | 43 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3e..05c85eeafa1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1518,7 +1518,16 @@ static void receive_wanted_refs(struct packet_reader *reader,
 static void receive_packfile_uris(struct packet_reader *reader,
 				  struct string_list *uris)
 {
+	int original_options;
 	process_section_header(reader, "packfile-uris", 0);
+	/*
+	 * In some setups, packfile-uris act as bearer tokens,
+	 * redact them by default.
+	 */
+	original_options = reader->options;
+	if (git_env_bool("GIT_TRACE_REDACT", 1))
+		reader->options |= PACKET_READ_REDACT_ON_TRACE;
+
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		if (reader->pktlen < the_hash_algo->hexsz ||
 		    reader->line[the_hash_algo->hexsz] != ' ')
@@ -1526,6 +1535,8 @@ static void receive_packfile_uris(struct packet_reader *reader,
 
 		string_list_append(uris, reader->line);
 	}
+	reader->options = original_options;
+
 	if (reader->status != PACKET_READ_DELIM)
 		die("expected DELIM");
 }
diff --git a/http-fetch.c b/http-fetch.c
index fa642462a9e..d35e33e4f65 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -63,7 +63,9 @@ static void fetch_single_packfile(struct object_id *packfile_hash,
 	if (start_active_slot(preq->slot)) {
 		run_active_slot(preq->slot);
 		if (results.curl_result != CURLE_OK) {
-			die("Unable to get pack file %s\n%s", preq->url,
+			int showUrl = git_env_bool("GIT_TRACE_REDACT", 1);
+			die("Unable to get offloaded pack file %s\n%s",
+			    showUrl ? preq->url : "<redacted>",
 			    curl_errorstr);
 		}
 	} else {
diff --git a/pkt-line.c b/pkt-line.c
index de4a94b437e..8da8ed88ccf 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -443,7 +443,12 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		len--;
 
 	buffer[len] = 0;
-	packet_trace(buffer, len, 0);
+	if (options & PACKET_READ_REDACT_ON_TRACE) {
+		const char *redacted = "<redacted>";
+		packet_trace(redacted, strlen(redacted), 0);
+	} else {
+		packet_trace(buffer, len, 0);
+	}
 
 	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
 	    starts_with(buffer, "ERR "))
diff --git a/pkt-line.h b/pkt-line.h
index 82b95e4bdd3..44c02f3bc6e 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -88,6 +88,7 @@ void packet_fflush(FILE *f);
 #define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
 #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
 #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
+#define PACKET_READ_REDACT_ON_TRACE      (1u<<4)
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d527cf6c49f..a620a678a56 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1107,6 +1107,49 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	test_i18ngrep "disallowed submodule name" err
 '
 
+test_expect_success 'packfile-uri redacted in trace' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	grep -A1 "clone<\ ..packfile-uris" log | grep "clone<\ <redacted>"
+'
+
+test_expect_success 'packfile-uri not redacted in trace when GIT_TRACE_REDACT=0' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	GIT_TRACE_REDACT=0 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	grep -A1 "clone<\ ..packfile-uris" log  | grep -E "clone<\ ..[[:alnum:]]{40,64}\ http"
+'
+
 test_expect_success 'http:// --negotiate-only' '
 	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
 	URI="$HTTPD_URL/smart/server" &&
-- 
gitgitgadget

