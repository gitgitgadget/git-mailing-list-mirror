Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8328C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E07B6103B
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhJ1WyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhJ1WyK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:54:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301FC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:51:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso2728115wmd.4
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QlEsHGap3PBHETCRH1xjqDXzwSs3OTxoiNnAsLxh+Ns=;
        b=ZZfAY/8goTII40gwpnl1/wUjATe1KR1qlT8xUtFQFb2WhmUAKFwRBr3s7/VF5vggGq
         Y2wLUgVw9zA3niD84RSmPGV2LjxvikNk1C+AGODRpIlIWTG07JD2z0swW1dWbvyVIcpV
         gKxojrEmmz1n+iygFx3OT1PFOmfKrwSlxcC6U2/wT7CGLMrbO6tAf8CYdSe8+1qDUDYD
         SwHFtl3m2r2LuS6wMNx29RqzdfJIaDLxYmW4tEB/bJD6YgC/BfS/Do9WygXzMikfbzsA
         wUktGRGOZ12P0CwjcDbx99wGboQFhHDlX7XBiGJxh80puBOlIGQ1AqfwBsDotqxXZzAh
         UIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QlEsHGap3PBHETCRH1xjqDXzwSs3OTxoiNnAsLxh+Ns=;
        b=VTOmoECzoe++RL1o1mmy6kFw/rpE+Wd/PoRWF8MDkVdjHPrCM2OfeZF/liYS9MqvcC
         Ohzx3xjz8k7RLguLiogLg7CPm9Q/dEX2QWp00Mo9RQ/IHGZN1HlHRTgtP1bqPkTmn18k
         jmBffcyV+wJnOuwfWIrjXaXRLCSXwfnZi8z7B7tuYrEHfK2ukxEC4+Y5bMJfKkAebIWb
         T+m+0/6iIO3aKjtA6HwFyYcO1pMr4T/fRz54yz6BuCSLckxqQofIciOX5SHPGqcy4pag
         Yuqjo7Nrrcvx/0Aqp/FnJ6ElyjHaTyic072hUNsF7imbhsEkDfhouAguNCPQOig1a3eD
         bB3A==
X-Gm-Message-State: AOAM530bFOeizLwYiXfYSbhTPVOdqoSp3C4huhk0mPPkAm+Q4jFu24UH
        cZbqgzT2dgXA/m7/Xyl7ocPTeGQxX5E=
X-Google-Smtp-Source: ABdhPJxMZ+WQGYu1vWIRGlncOesUD234aleupr+WSTGPlp3jVHQYZ8V7YF7hAqUnBhKUK8Ii5nG4zg==
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr4270847wmc.47.1635461501641;
        Thu, 28 Oct 2021 15:51:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm4190577wrz.65.2021.10.28.15.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 15:51:41 -0700 (PDT)
Message-Id: <pull.1052.v5.git.1635461500.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
References: <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 22:51:38 +0000
Subject: [PATCH v5 0/2] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v4:

 * Use "uri" instead of "url"
 * Look specifically for a line with packfile-uri format (instead of for a
   URL in general)
 * Limit the redacting to the packfile-uri section in do_fetch_pack_v2
 * Use "%.*s" instead of duplicating parts of the string to print

Changes since v3:

 * Enable redacting URLs for all sections
 * Redact only URL path (it was until the end of line)
 * Redact URL in die() with more friendly message
 * Update doc to mention that packfile URIs are also redacted.

Changes since v2:

 * Redact only the path of the URL
 * Test are now strict, validating the exact line expected in the log

Changes since v1:

 * Removed non-POSIX flags in tests
 * More accurate regex for the non-encrypted packfile line
 * Dropped documentation change
 * Dropped redacting the die message in http-fetch

Ivan Frade (2):
  fetch-pack: redact packfile urls in traces
  http-fetch: redact url on die() message

 Documentation/git.txt  |  5 +++--
 fetch-pack.c           |  4 ++++
 http-fetch.c           | 14 ++++++++++--
 pkt-line.c             | 39 +++++++++++++++++++++++++++++++-
 pkt-line.h             |  1 +
 t/t5702-protocol-v2.sh | 51 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 5 deletions(-)


base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1052%2Fifradeo%2Fredact-packfile-uri-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1052/ifradeo/redact-packfile-uri-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1052

Range-diff vs v4:

 1:  973a250752c ! 1:  c95b3cafcd6 fetch-pack: redact packfile urls in traces
     @@ Documentation/git.txt: for full details.
      -	cookies, the "Authorization:" header, and the "Proxy-Authorization:"
      -	header. Set this variable to `0` to prevent this redaction.
      +	cookies, the "Authorization:" header, the "Proxy-Authorization:"
     -+	header and packfile URLs. Set this variable to `0` to prevent this
     ++	header and packfile URIs. Set this variable to `0` to prevent this
      +	redaction.
       
       `GIT_LITERAL_PATHSPECS`::
     @@ Documentation/git.txt: for full details.
      
       ## fetch-pack.c ##
      @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
     - 		reader.me = "fetch-pack";
     - 	}
     + 				receive_wanted_refs(&reader, sought, nr_sought);
       
     -+	if (git_env_bool("GIT_TRACE_REDACT", 1))
     -+		reader.options |= PACKET_READ_REDACT_URL_PATH;
     -+
     - 	while (state != FETCH_DONE) {
     - 		switch (state) {
     - 		case FETCH_CHECK_LOCAL:
     + 			/* get the pack(s) */
     ++			if (git_env_bool("GIT_TRACE_REDACT", 1))
     ++				reader.options |= PACKET_READ_REDACT_URI_PATH;
     + 			if (process_section_header(&reader, "packfile-uris", 1))
     + 				receive_packfile_uris(&reader, &packfile_uris);
     ++			reader.options &= ~PACKET_READ_REDACT_URI_PATH;
     ++
     + 			process_section_header(&reader, "packfile", 0);
     + 
     + 			/*
      
       ## pkt-line.c ##
      @@ pkt-line.c: int packet_length(const char lenbuf_hex[4])
       	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
       }
       
     -+static char *find_url_path(const char* buffer, int *path_len)
     ++static char *find_packfile_uri_path(const char *buffer)
      +{
     -+	const char *URL_MARK = "://";
     -+	char *path = strstr(buffer, URL_MARK);
     -+	if (!path)
     -+		return NULL;
     ++	const char *URI_MARK = "://";
     ++	char *path;
     ++	int len;
      +
     -+	path += strlen(URL_MARK);
     -+	while (*path && *path != '/')
     -+		path++;
     ++	/* First char is sideband mark */
     ++	buffer += 1;
      +
     -+	if (!*path || !*(path + 1))
     -+		return NULL;
     ++	len = strspn(buffer, "0123456789abcdefABCDEF");
     ++	if (!(len == 40 || len == 64) || buffer[len] != ' ')
     ++		return NULL; /* required "<hash>SP" not seen */
      +
     -+	// position after '/'
     -+	path++;
     ++	path = strstr(buffer + len + 1, URI_MARK);
     ++	if (!path)
     ++		return NULL;
      +
     -+	if (path_len) {
     -+		char *url_end = strchrnul(path, ' ');
     -+		*path_len = url_end - path;
     -+	}
     ++	path = strchr(path + strlen(URI_MARK), '/');
     ++	if (!path || !*(path + 1))
     ++		return NULL;
      +
     -+	return path;
     ++	/* position after '/' */
     ++	return ++path;
      +}
      +
       enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
     @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
       {
       	int len;
       	char linelen[4];
     -+	char *url_path_start;
     -+	int url_path_len;
     ++	char *uri_path_start;
       
       	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
       		*pktlen = -1;
     @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
       
       	buffer[len] = 0;
      -	packet_trace(buffer, len, 0);
     -+	if (options & PACKET_READ_REDACT_URL_PATH &&
     -+	    (url_path_start = find_url_path(buffer, &url_path_len))) {
     ++	if (options & PACKET_READ_REDACT_URI_PATH &&
     ++	    (uri_path_start = find_packfile_uri_path(buffer))) {
      +		const char *redacted = "<redacted>";
      +		struct strbuf tracebuf = STRBUF_INIT;
      +		strbuf_insert(&tracebuf, 0, buffer, len);
     -+		strbuf_splice(&tracebuf, url_path_start - buffer,
     -+			      url_path_len, redacted, strlen(redacted));
     ++		strbuf_splice(&tracebuf, uri_path_start - buffer,
     ++			      strlen(uri_path_start), redacted, strlen(redacted));
      +		packet_trace(tracebuf.buf, tracebuf.len, 0);
      +		strbuf_release(&tracebuf);
      +	} else {
     @@ pkt-line.h: void packet_fflush(FILE *f);
       #define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
       #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
       #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
     -+#define PACKET_READ_REDACT_URL_PATH      (1u<<4)
     ++#define PACKET_READ_REDACT_URI_PATH      (1u<<4)
       int packet_read(int fd, char *buffer, unsigned size, int options);
       
       /*
 2:  c7f0977cabd ! 2:  6912a690197 http-fetch: redact url on die() message
     @@ Commit message
          http-fetch: redact url on die() message
      
          http-fetch prints the URL after failing to fetch it. This can be
     -    confusing to users (they cannot really do anything with it) but even
     -    worse, they can share by accident a sensitive URL (e.g. with
     -    credentials) while looking for help.
     +    confusing to users (they cannot really do anything with it), and they
     +    can share by accident a sensitive URL (e.g. with credentials) while
     +    looking for help.
      
          Redact the URL unless the GIT_TRACE_REDACT variable is set to false. This
          mimics the redaction of other sensitive information in git, like the
          Authorization header in HTTP.
      
     +    Fix also capitalization of previous die() message (must start in
     +    lowercase).
     +
          Signed-off-by: Ivan Frade <ifrade@google.com>
      
       ## http-fetch.c ##
     @@ http-fetch.c: static void fetch_single_packfile(struct object_id *packfile_hash,
      -			    curl_errorstr);
      +			struct url_info url;
      +			char *nurl = url_normalize(preq->url, &url);
     -+			if (!git_env_bool("GIT_TRACE_REDACT", 1) || !nurl) {
     -+				die("Unable to get pack file %s\n%s", preq->url,
     ++			if (!nurl || !git_env_bool("GIT_TRACE_REDACT", 1)) {
     ++				die("unable to get pack file '%s'\n%s", preq->url,
      +				    curl_errorstr);
      +			} else {
     -+				char *schema = xstrndup(url.url, url.scheme_len);
     -+				char *host = xstrndup(&url.url[url.host_off], url.host_len);
     -+				die("failed to get '%s' url from '%s' "
     ++				die("failed to get '%.*s' url from '%.*s' "
      +				    "(full URL redacted due to GIT_TRACE_REDACT setting)\n%s",
     -+				    schema, host, curl_errorstr);
     ++				    (int)url.scheme_len, url.url,
     ++				    (int)url.host_len, &url.url[url.host_off], curl_errorstr);
      +			}
       		}
       	} else {

-- 
gitgitgadget
