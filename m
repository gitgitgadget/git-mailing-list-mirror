Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB8CC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12ED0610A4
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhJZWw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJZWw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 18:52:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C7C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:50:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s19so859349wra.2
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZpqCsgc6Mnep8c8+3Un5QEFGreNNUHoiok6J/BiLXjw=;
        b=PhbtoXNQINy9htsxW54ugfQeUfnHSTRYhGyQ0q3R1g071V+/4v0+ITuEUzBGYnor3R
         X4B9B3vGvdJFbFRXDGbj5CGGfm8gFM6a2StPhsvkACiJMi1YQAjwsdSI6kJFZ1bs2nFX
         TpBvh5d2PmdYMEq9vS2SyWFaCXChOpIyyQ9+TPXJNDXCfaEJFBbsodiCd+ppd6Xiuc4g
         ufAH0y68wrv85FEcwjG17Cm2roUqdvNbQEmcDcYoje6CGgMbRreubVJC1UxHN94zIVRs
         gcSNmjRsRzf+BIRkRoVRJ7Kc5VzG1J6viPLtNAm8MBW38D7tODWWjvnd7roSHpd0Kimr
         q0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZpqCsgc6Mnep8c8+3Un5QEFGreNNUHoiok6J/BiLXjw=;
        b=VPlD1+YXSGqNF+opIaNHm302Bf35r723pJrPo4rZut0upyAHc7rjrfN1+5ZOSVe3oU
         l7HTqPC73scpvwNPFxPhQpuIoUi6/07o7VNM/wjMSFpzH6jvLGpp8nh90porJKOCD4Ld
         FGnYM/NAxJx8U26lbk4TK9SQ0TqfdnCcf6bwCYYPnURzvyjvYg1TTcrbC3HzHLEnFMtI
         CoBex5aTkCpwvGTlqKbOV0Gv64Fkiu/uG7t8tqTDD7ya7KU18bdiI743KgCxbprwF59l
         UmSSvvmIqpKQG6vFxBaueOjIkIgddJF0Agjfsh4s1q/1Pga2ZTdmY3rQ5EiBKtm1ntJ/
         ty0g==
X-Gm-Message-State: AOAM533+m+23+idEE+tSaRiXetEBrcbGs1KOlDeRbBFcYjqkkpdCakaU
        ogBuDtRisx4SmdmgMuVGJDhvEDs79Mo=
X-Google-Smtp-Source: ABdhPJw6aaN9H1VSma9Ur8zoNg+KUwErDkg3XXWpb0JqAvE8aWfJkEQtKeQtpuGebqL0QBS8aOyTgA==
X-Received: by 2002:adf:dd89:: with SMTP id x9mr10504214wrl.169.1635288600144;
        Tue, 26 Oct 2021 15:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm1714023wmc.21.2021.10.26.15.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:49:59 -0700 (PDT)
Message-Id: <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Oct 2021 22:49:57 +0000
Subject: [PATCH v4 0/2] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 fetch-pack.c           |  3 +++
 http-fetch.c           | 15 +++++++++++--
 pkt-line.c             | 40 ++++++++++++++++++++++++++++++++-
 pkt-line.h             |  1 +
 t/t5702-protocol-v2.sh | 51 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 110 insertions(+), 5 deletions(-)


base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1052%2Fifradeo%2Fredact-packfile-uri-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1052/ifradeo/redact-packfile-uri-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1052

Range-diff vs v3:

 1:  9afe0093af4 ! 1:  973a250752c fetch-pack: redact packfile urls in traces
     @@ Commit message
      
          Signed-off-by: Ivan Frade <ifrade@google.com>
      
     - ## fetch-pack.c ##
     -@@ fetch-pack.c: static void receive_wanted_refs(struct packet_reader *reader,
     - static void receive_packfile_uris(struct packet_reader *reader,
     - 				  struct string_list *uris)
     - {
     -+	int saved_options;
     - 	process_section_header(reader, "packfile-uris", 0);
     -+	/*
     -+	 * In some setups, packfile-uris act as bearer tokens,
     -+	 * redact them by default.
     -+	 */
     -+	saved_options = reader->options;
     -+	if (git_env_bool("GIT_TRACE_REDACT", 1))
     -+		reader->options |= PACKET_READ_REDACT_URL_PATH;
     -+
     - 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
     - 		if (reader->pktlen < the_hash_algo->hexsz ||
     - 		    reader->line[the_hash_algo->hexsz] != ' ')
     -@@ fetch-pack.c: static void receive_packfile_uris(struct packet_reader *reader,
     + ## Documentation/git.txt ##
     +@@ Documentation/git.txt: for full details.
       
     - 		string_list_append(uris, reader->line);
     + `GIT_TRACE_REDACT`::
     + 	By default, when tracing is activated, Git redacts the values of
     +-	cookies, the "Authorization:" header, and the "Proxy-Authorization:"
     +-	header. Set this variable to `0` to prevent this redaction.
     ++	cookies, the "Authorization:" header, the "Proxy-Authorization:"
     ++	header and packfile URLs. Set this variable to `0` to prevent this
     ++	redaction.
     + 
     + `GIT_LITERAL_PATHSPECS`::
     + 	Setting this variable to `1` will cause Git to treat all
     +
     + ## fetch-pack.c ##
     +@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
     + 		reader.me = "fetch-pack";
       	}
     -+	reader->options = saved_options;
     + 
     ++	if (git_env_bool("GIT_TRACE_REDACT", 1))
     ++		reader.options |= PACKET_READ_REDACT_URL_PATH;
      +
     - 	if (reader->status != PACKET_READ_DELIM)
     - 		die("expected DELIM");
     - }
     + 	while (state != FETCH_DONE) {
     + 		switch (state) {
     + 		case FETCH_CHECK_LOCAL:
      
       ## pkt-line.c ##
      @@ pkt-line.c: int packet_length(const char lenbuf_hex[4])
       	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
       }
       
     -+static int find_url_path_start(const char* buffer)
     ++static char *find_url_path(const char* buffer, int *path_len)
      +{
      +	const char *URL_MARK = "://";
     -+	char *p = strstr(buffer, URL_MARK);
     -+	if (!p) {
     -+		return -1;
     -+	}
     ++	char *path = strstr(buffer, URL_MARK);
     ++	if (!path)
     ++		return NULL;
      +
     -+	p += strlen(URL_MARK);
     -+	while (*p && *p != '/')
     -+		p++;
     ++	path += strlen(URL_MARK);
     ++	while (*path && *path != '/')
     ++		path++;
      +
     -+	// Position after '/'
     -+	if (*p && *(p + 1))
     -+		return (p + 1) - buffer;
     ++	if (!*path || !*(path + 1))
     ++		return NULL;
     ++
     ++	// position after '/'
     ++	path++;
     ++
     ++	if (path_len) {
     ++		char *url_end = strchrnul(path, ' ');
     ++		*path_len = url_end - path;
     ++	}
      +
     -+	return -1;
     ++	return path;
      +}
      +
       enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
     @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
       {
       	int len;
       	char linelen[4];
     -+	int url_path_start;
     ++	char *url_path_start;
     ++	int url_path_len;
       
       	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
       		*pktlen = -1;
     @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
       	buffer[len] = 0;
      -	packet_trace(buffer, len, 0);
      +	if (options & PACKET_READ_REDACT_URL_PATH &&
     -+	    (url_path_start = find_url_path_start(buffer)) != -1) {
     ++	    (url_path_start = find_url_path(buffer, &url_path_len))) {
      +		const char *redacted = "<redacted>";
      +		struct strbuf tracebuf = STRBUF_INIT;
      +		strbuf_insert(&tracebuf, 0, buffer, len);
     -+		strbuf_splice(&tracebuf, url_path_start,
     -+			      len - url_path_start, redacted, strlen(redacted));
     ++		strbuf_splice(&tracebuf, url_path_start - buffer,
     ++			      url_path_len, redacted, strlen(redacted));
      +		packet_trace(tracebuf.buf, tracebuf.len, 0);
      +		strbuf_release(&tracebuf);
      +	} else {
     @@ pkt-line.h: void packet_fflush(FILE *f);
       #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
       #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
      +#define PACKET_READ_REDACT_URL_PATH      (1u<<4)
     - int packet_read(int fd, char **src_buffer, size_t *src_len, char
     - 		*buffer, unsigned size, int options);
     + int packet_read(int fd, char *buffer, unsigned size, int options);
       
     + /*
      
       ## t/t5702-protocol-v2.sh ##
      @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 -:  ----------- > 2:  c7f0977cabd http-fetch: redact url on die() message

-- 
gitgitgadget
