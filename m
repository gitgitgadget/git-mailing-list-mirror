Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ABE91F461
	for <e@80x24.org>; Fri, 30 Aug 2019 12:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfH3MKK (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 08:10:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56000 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfH3MKK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 08:10:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id g207so3083163wmg.5
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qCY9t8KMSAaRjBFzzNnJuRtWHd9riKjFnvVTN4WRpFQ=;
        b=IjQJf3RdPNNVsUAA9RyXruBExPSYZOzLviCOIuM+aMGN2PLgo7cAaf00ZUjh8041Y6
         hrAeT+mUbsQJ6ra+JMWpWXsj7vTaT9f6JwL8evftLiJs/BV02QpYoYQoYAGcyYb9h72k
         fpgm6NglYO+jHTpbMpLIo5OekZb4pI1pVlHYvWWsu+F4lJnBUWI/vFmMdhsknZVNDNYu
         Z10OUnNgp59ZvQUnDBCYwojcNIMMWQJvxNgnscBj6K7owoom1x0J096P/2ykeNzSTLvZ
         sIlenq7JWjFPYCvIOjotzEG/x7fDsYu1JX8+X64zQ/ld1tx4MsSZEE/DEKOcU+uXVakA
         hunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qCY9t8KMSAaRjBFzzNnJuRtWHd9riKjFnvVTN4WRpFQ=;
        b=Z596f+MGfGhRgKSW6v8Rt8y02UUcub3P3MKWhmBZMGXhdYK3QXISnuEZbqxk6b5Nzy
         oGI+21+5AkRMKWCCnmsWVgqih6HlEk2I5lARU7tfMq6KjeJhN1pa83rTNTjoc7dg5qHd
         Q/2gnRXSPJH2PYJsXo6l4VmHMusZR5xMvBcawrbpZNZTLDn5CYPYkP0FoqLqtfOt/bXX
         8GxXt++sYyoDB9GwTuhkap+zRNWmkCcYTT6kyYWPTzabX5wZ3fEaiVSXHtASCrVzjO3P
         cRA6b5ilYh/chdezx9Nl2R0ih9F5RqINASd0xuwQPFJj0Qj1o6BtZoqizGy8/FrMihcg
         zxGg==
X-Gm-Message-State: APjAAAWaHlyfFWpWkfD3tCOF4sDbzMascSrHj7InYuNZC4/d7bdKAZqP
        HQ5wo9swlVLH4yvNBDJxQUo=
X-Google-Smtp-Source: APXvYqzwNBPBA5tboVDP9z3rQOxaaer6PNba594NAKw7pm4+rYL1b9mEunlcImu0FzwgoIGHb19K2A==
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr18456077wmh.125.1567167008481;
        Fri, 30 Aug 2019 05:10:08 -0700 (PDT)
Received: from szeder.dev (x4db30fda.dyn.telefonica.de. [77.179.15.218])
        by smtp.gmail.com with ESMTPSA id x10sm7228276wrn.39.2019.08.30.05.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 05:10:07 -0700 (PDT)
Date:   Fri, 30 Aug 2019 14:10:05 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190830121005.GI8571@szeder.dev>
References: <20190828093408.GD8571@szeder.dev>
 <20190828145412.GB14432@sigill.intra.peff.net>
 <20190828153944.GA29715@sigill.intra.peff.net>
 <20190828161552.GE8571@szeder.dev>
 <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
 <20190829141307.GE1797@sigill.intra.peff.net>
 <131dfa37-0f65-f0c3-6f30-5b6eca12d9c0@gmail.com>
 <20190829143805.GB1746@sigill.intra.peff.net>
 <20190829215818.GG8571@szeder.dev>
 <20190829220630.GH8571@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190829220630.GH8571@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 30, 2019 at 12:06:30AM +0200, SZEDER Gábor wrote:
> On Thu, Aug 29, 2019 at 11:58:18PM +0200, SZEDER Gábor wrote:
> > On Thu, Aug 29, 2019 at 10:38:05AM -0400, Jeff King wrote:
> > > So any fixes there have to happen on the client side. I am still
> > > confused about why the client is writing in this case, per the argument
> > > in 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> > > 2019-04-13). It would be nice to use GIT_TRACE_PACKET to see what it's
> > > trying to write, but I still haven't been able to reproduce the issue.
> > 
> > It's the "done" line:
> > 
> >   + cat trace-packet
[...]
> >   packet:  upload-pack> 0000
> >   packet:        fetch> done
> > 
> > In the avarage successful run that "fetch> done" pkt-line is
> > immediately after the "fetch> 0000".

So instead of immediately die()int after write_in_full() returned an
error, fetch should first try to read all incoming packets in the hope
that the remote did send an ERR packet before it died, and then die
with the error in that packet, or fall back to the current generic
error message if there is no ERR packet (e.g. remote segfaulted or
something similarly horrible).  This fixes the test failure with that
strategically-placed sleep() in 'fetch-pack.c'.

  https://travis-ci.org/szeder/git/jobs/578778749#L2689

Alas, passing a 'reader' to a function called send_request() doesn't
look quite right, does it...  And I'm not sure about the stateless
communication, it still uses write_or_die().


diff --git a/fetch-pack.c b/fetch-pack.c
index e18864458b..773d9c7904 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -186,14 +186,27 @@ static enum ack_type get_ack(struct packet_reader *reader,
 }
 
 static void send_request(struct fetch_pack_args *args,
-			 int fd, struct strbuf *buf)
+			 int fd, struct strbuf *buf,
+			 struct packet_reader *reader)
 {
 	if (args->stateless_rpc) {
 		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
 		packet_flush(fd);
 	} else {
-		if (write_in_full(fd, buf->buf, buf->len) < 0)
+		if (write_in_full(fd, buf->buf, buf->len) < 0) {
+			int save_errno = errno;
+			/*
+			 * Read everything the remote has sent to us.
+			 * If there is an ERR packet, then the loop die()s
+			 * with the received error message.
+			 * If we reach EOF without seeing an ERR, then die()
+			 * with a generic error message, most likely "Broken
+			 * pipe".
+			 */
+			while (packet_reader_read(reader) != PACKET_READ_EOF);
+			errno = save_errno;
 			die_errno(_("unable to write to remote"));
+		}
 	}
 }
 
@@ -353,7 +366,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 		const char *arg;
 		struct object_id oid;
 
-		send_request(args, fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf, &reader);
 		while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
 			if (skip_prefix(reader.line, "shallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
@@ -376,7 +389,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			die(_("expected shallow/unshallow, got %s"), reader.line);
 		}
 	} else if (!args->stateless_rpc)
-		send_request(args, fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf, &reader);
 
 	if (!args->stateless_rpc) {
 		/* If we aren't using the stateless-rpc interface
@@ -398,7 +411,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			int ack;
 
 			packet_buf_flush(&req_buf);
-			send_request(args, fd[1], &req_buf);
+			send_request(args, fd[1], &req_buf, &reader);
 			strbuf_setlen(&req_buf, state_len);
 			flushes++;
 			flush_at = next_flush(args->stateless_rpc, count);
@@ -473,7 +486,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	if (!got_ready || !no_done) {
 		sleep(1);
 		packet_buf_write(&req_buf, "done\n");
-		send_request(args, fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf, &reader);
 	}
 	print_verbose(args, _("done"));
 	if (retval != 0) {

