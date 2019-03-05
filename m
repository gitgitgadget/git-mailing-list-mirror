Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35BCD20248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCEXUp (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:20:45 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:46271 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfCEXUn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:20:43 -0500
Received: by mail-ed1-f48.google.com with SMTP id f2so8708628edy.13
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d0rJy8ldUQkE6xwxJRDIu9POsIBorPRnjtmNIYyLjG8=;
        b=Pb5k42kDkIPfIFbPEiUzxHYPZTrpybw93SuLPF+iYR17IwzECLa5cUs7S2jvkdoXRl
         yhWQ3CaIfJULaX83xnvSdpvbv23lT8BqQ8HTgpPAdX6xAm6Jh/SDNEF0LZi+9tkix3aS
         xdn4DUMYSsuaf2Al6qJFNho11314iVyhTc6Hfi3P3zrtgPlGRsxy6nJScFi7vV3T6KOg
         bkb0JJQRxR77RklF7dyACXi1UvMWUfL3P/ciNTgx3KeuVMIdaOa+2GepNZcDTv8F1ChS
         OeaupAvRk4sDVgEwcEiAC/b76Zn4yaQBXx5ckWUNx+cpvlBeaGSrTB8nQXyb8hvqSC67
         KoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d0rJy8ldUQkE6xwxJRDIu9POsIBorPRnjtmNIYyLjG8=;
        b=LIvMv5TDIW7Sa39w94c5ixt2phVcKI0wQOhbtNr4Rdol1HS6/E1NtqQQ4xysOconjC
         qCnEjCk5lHeI7YiODPXnRdu5EVl0tjMZ2ydQPBCdVSj+SjjjX19bXkI3iB+HoBKcXyqd
         Vl+pBudJ4u7dpF+tsNwvsf+0XCsWVgmDCjj+MSG0sDLs1DGoS5vKkkvT+vm42C7Y3k6o
         bWp5SAbLcx9TseqjFyk3p5DxC9effEu3XwSr35xSOb802AulyLksLhElyb9N8yshA5/h
         xN4reqGVEh7Qu8EOYG0jNG9DZh6zhPBaLnNXREbAOrhCuuRlBibP6enXHnXbVtGgFaNT
         +X9A==
X-Gm-Message-State: APjAAAUjfZt5uvYfoGiB6HFGzMVg59lfcFQ133qVADNh/DA5xVQhPfRN
        8gLZJXHsbPy8L/GmVzx8ksWS9jVu
X-Google-Smtp-Source: APXvYqw59McQVQkHvFqg2PSveI9UkRc465XzLi+1Bi9XdhFkZWkmzO3d0c5F1gxUY96Z0/Y4ul2QPA==
X-Received: by 2002:a17:906:1552:: with SMTP id c18mr1808854ejd.64.1551828040770;
        Tue, 05 Mar 2019 15:20:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a52sm3351296edc.74.2019.03.05.15.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 15:20:40 -0800 (PST)
Date:   Tue, 05 Mar 2019 15:20:40 -0800 (PST)
X-Google-Original-Date: Tue, 05 Mar 2019 23:20:39 GMT
Message-Id: <018feb32054f47896e159564feb4c88bd7757010.1551828039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.157.git.gitgitgadget@gmail.com>
References: <pull.157.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] remote-curl: mark all error messages for translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Suggested by Jeff King.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote-curl.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 6be3cb5918..06f091d862 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -154,7 +154,7 @@ static int set_option(const char *name, const char *value)
 		else {
 			struct strbuf unquoted = STRBUF_INIT;
 			if (unquote_c_style(&unquoted, value, NULL) < 0)
-				die("invalid quoting in push-option value");
+				die(_("invalid quoting in push-option value: '%s'"), value);
 			string_list_append_nodup(&options.push_options,
 						 strbuf_detach(&unquoted, NULL));
 		}
@@ -250,7 +250,7 @@ static struct ref *parse_info_refs(struct discovery *heads)
 			mid = &data[i];
 		if (data[i] == '\n') {
 			if (mid - start != 40)
-				die("%sinfo/refs not valid: is this a git repository?",
+				die(_("%sinfo/refs not valid: is this a git repository?"),
 				    transport_anonymize_url(url.buf));
 			data[i] = 0;
 			ref_name = mid + 1;
@@ -389,15 +389,15 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		break;
 	case HTTP_MISSING_TARGET:
 		show_http_message(&type, &charset, &buffer);
-		die("repository '%s' not found",
+		die(_("repository '%s' not found"),
 		    transport_anonymize_url(url.buf));
 	case HTTP_NOAUTH:
 		show_http_message(&type, &charset, &buffer);
-		die("Authentication failed for '%s'",
+		die(_("Authentication failed for '%s'"),
 		    transport_anonymize_url(url.buf));
 	default:
 		show_http_message(&type, &charset, &buffer);
-		die("unable to access '%s': %s",
+		die(_("unable to access '%s': %s"),
 		    transport_anonymize_url(url.buf), curl_errorstr);
 	}
 
@@ -424,12 +424,12 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		 */
 		line = packet_read_line_buf(&last->buf, &last->len, NULL);
 		if (!line)
-			die("invalid server response; expected service, got flush packet");
+			die(_("invalid server response; expected service, got flush packet"));
 
 		strbuf_reset(&exp);
 		strbuf_addf(&exp, "# service=%s", service);
 		if (strcmp(line, exp.buf))
-			die("invalid server response; got '%s'", line);
+			die(_("invalid server response; got '%s'"), line);
 		strbuf_release(&exp);
 
 		/* The header can include additional metadata lines, up
@@ -544,7 +544,7 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 			rpc->pos = 0;
 			return CURLIOE_OK;
 		}
-		error("unable to rewind rpc post data - try increasing http.postBuffer");
+		error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
 		return CURLIOE_FAILRESTART;
 
 	default:
@@ -588,7 +588,7 @@ static int run_slot(struct active_request_slot *slot,
 				strbuf_addstr(&msg, curl_errorstr);
 			}
 		}
-		error("RPC failed; %s", msg.buf);
+		error(_("RPC failed; %s"), msg.buf);
 		strbuf_release(&msg);
 	}
 
@@ -626,7 +626,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 
 static curl_off_t xcurl_off_t(ssize_t len) {
 	if (len > maximum_signed_value_of_type(curl_off_t))
-		die("cannot handle pushes this big");
+		die(_("cannot handle pushes this big"));
 	return (curl_off_t) len;
 }
 
@@ -738,11 +738,11 @@ static int post_rpc(struct rpc_state *rpc)
 
 		ret = git_deflate(&stream, Z_FINISH);
 		if (ret != Z_STREAM_END)
-			die("cannot deflate request; zlib deflate error %d", ret);
+			die(_("cannot deflate request; zlib deflate error %d"), ret);
 
 		ret = git_deflate_end_gently(&stream);
 		if (ret != Z_OK)
-			die("cannot deflate request; zlib end error %d", ret);
+			die(_("cannot deflate request; zlib end error %d"), ret);
 
 		gzip_size = stream.total_out;
 
@@ -871,7 +871,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 
 	ALLOC_ARRAY(targets, nr_heads);
 	if (options.depth || options.deepen_since)
-		die("dumb http transport does not support shallow capabilities");
+		die(_("dumb http transport does not support shallow capabilities"));
 	for (i = 0; i < nr_heads; i++)
 		targets[i] = xstrdup(oid_to_hex(&to_fetch[i]->old_oid));
 
@@ -885,7 +885,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 		free(targets[i]);
 	free(targets);
 
-	return ret ? error("fetch failed.") : 0;
+	return ret ? error(_("fetch failed.")) : 0;
 }
 
 static int fetch_git(struct discovery *heads,
@@ -932,7 +932,7 @@ static int fetch_git(struct discovery *heads,
 	for (i = 0; i < nr_heads; i++) {
 		struct ref *ref = to_fetch[i];
 		if (!*ref->name)
-			die("cannot fetch by sha1 over smart http");
+			die(_("cannot fetch by sha1 over smart http"));
 		packet_buf_write(&preamble, "%s %s\n",
 				 oid_to_hex(&ref->old_oid), ref->name);
 	}
@@ -977,13 +977,13 @@ static void parse_fetch(struct strbuf *buf)
 			struct object_id old_oid;
 
 			if (get_oid_hex(p, &old_oid))
-				die("protocol error: expected sha/ref, got %s'", p);
+				die(_("protocol error: expected sha/ref, got %s'"), p);
 			if (p[GIT_SHA1_HEXSZ] == ' ')
 				name = p + GIT_SHA1_HEXSZ + 1;
 			else if (!p[GIT_SHA1_HEXSZ])
 				name = "";
 			else
-				die("protocol error: expected sha/ref, got %s'", p);
+				die(_("protocol error: expected sha/ref, got %s'"), p);
 
 			ref = alloc_ref(name);
 			oidcpy(&ref->old_oid, &old_oid);
@@ -995,7 +995,7 @@ static void parse_fetch(struct strbuf *buf)
 			to_fetch[nr_heads++] = ref;
 		}
 		else
-			die("http transport does not support %s", buf->buf);
+			die(_("http transport does not support %s"), buf->buf);
 
 		strbuf_reset(buf);
 		if (strbuf_getline_lf(buf, stdin) == EOF)
@@ -1031,7 +1031,7 @@ static int push_dav(int nr_spec, char **specs)
 		argv_array_push(&child.args, specs[i]);
 
 	if (run_command(&child))
-		die("git-http-push failed");
+		die(_("git-http-push failed"));
 	return 0;
 }
 
@@ -1110,7 +1110,7 @@ static void parse_push(struct strbuf *buf)
 			specs[nr_spec++] = xstrdup(buf->buf + 5);
 		}
 		else
-			die("http transport does not support %s", buf->buf);
+			die(_("http transport does not support %s"), buf->buf);
 
 		strbuf_reset(buf);
 		if (strbuf_getline_lf(buf, stdin) == EOF)
@@ -1220,7 +1220,7 @@ static size_t proxy_in(char *buffer, size_t eltsize,
 		strbuf_reset(&p->request_buffer);
 		switch (packet_reader_read(&p->reader)) {
 		case PACKET_READ_EOF:
-			die("unexpected EOF when reading from parent process");
+			die(_("unexpected EOF when reading from parent process"));
 		case PACKET_READ_NORMAL:
 			packet_buf_write_len(&p->request_buffer, p->reader.line,
 					     p->reader.pktlen);
@@ -1336,7 +1336,7 @@ int cmd_main(int argc, const char **argv)
 
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
-		error("remote-curl: usage: git remote-curl <remote> [<url>]");
+		error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
 		return 1;
 	}
 
@@ -1361,14 +1361,14 @@ int cmd_main(int argc, const char **argv)
 
 		if (strbuf_getline_lf(&buf, stdin) == EOF) {
 			if (ferror(stdin))
-				error("remote-curl: error reading command stream from git");
+				error(_("remote-curl: error reading command stream from git"));
 			return 1;
 		}
 		if (buf.len == 0)
 			break;
 		if (starts_with(buf.buf, "fetch ")) {
 			if (nongit)
-				die("remote-curl: fetch attempted without a local repo");
+				die(_("remote-curl: fetch attempted without a local repo"));
 			parse_fetch(&buf);
 
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")) {
@@ -1408,7 +1408,7 @@ int cmd_main(int argc, const char **argv)
 			if (!stateless_connect(arg))
 				break;
 		} else {
-			error("remote-curl: unknown command '%s' from git", buf.buf);
+			error(_("remote-curl: unknown command '%s' from git"), buf.buf);
 			return 1;
 		}
 		strbuf_reset(&buf);
-- 
gitgitgadget
