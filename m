Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C9820248
	for <e@80x24.org>; Fri,  5 Apr 2019 05:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDEFYf (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 01:24:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42703 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfDEFYf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 01:24:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so6368280wrx.9
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 22:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kJwJX4P/E0BtxQdIMT1gK7LLzcy6a1mi5S8jyQEY08g=;
        b=fs0/4mPMMOH3+eMcs3TW+x/3fgiDWGSpKz4/v59CaeT4f4F77m+cdZpCZDDUz3Bzu6
         9QD5CpKBJxwW5+sx5aBQbJ0CesharD3YA3hgowRGclzdc7oAmvH9YS+Cn4V8G4+5wTN2
         2NCK3AQuKikPXoBlddRtp84FkL9Oq+oaTYXGFUbrM+Rj46Rc0XEh2Hb0vdMSI84YEXKK
         TcGm+yi+4lDWle6aZpr78cVBAoPXXTH0ZQ9lRxJWZ7ZFmozmCFo9/dy9Y50Ut+4Vsq1b
         8uh2mpHogpquu37E7KJS9ptAbUnkei+9hURn1btJPVOLgiabL59ao5W2qQBvvgKCptrt
         ytXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kJwJX4P/E0BtxQdIMT1gK7LLzcy6a1mi5S8jyQEY08g=;
        b=EPA2NaKTGymQygqCxC5y8408feRIIazSIVa23o50I8fw3MgXQTYQeRg1UlBiExT2qG
         E9h8M57WsJjWnuRSGBdMzND6f9lW7igD1SVWomXCBON2H8raF/jH0Z59sL6J/fBbuOPR
         Ct8huc0NAQR4+uOXVPcFYwUSAnQ0VM/yIksKYfyPe8d0OHf46Z0WCDxFfHb0dHOL/mM5
         xjh+vdyoXCNmIDiCTEz2Dp5BgiF/CSStrdPYwtkEKNPwZ9tP31sPiTqBM+Qe16JJrhRQ
         c4DEG82EN5btMlRIQ2o4v/FUhr1XHJh/5KovDHlfptSU80nQwy1fsaWhq4LMXVTA7aRZ
         6vIQ==
X-Gm-Message-State: APjAAAUU9uErhI2ZtADXNY18uL57nvvoMqM2U1DvuHNXCcOInmEAX+mx
        aNH1rLjfFBrUsfnLEQILlwQ=
X-Google-Smtp-Source: APXvYqyuhStZlUBOnuky+4XZfpjYmCPODHnlfHrpk7CVv/p3ULB1TbSzeX/Qw5aDpN0rFTCKnmW/Jg==
X-Received: by 2002:adf:d081:: with SMTP id y1mr6930707wrh.283.1554441873278;
        Thu, 04 Apr 2019 22:24:33 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x14sm1190116wmj.3.2019.04.04.22.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 22:24:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julian Andres Klode <jak@jak-linux.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "Problems" with git format-patch --thread email header ordering
References: <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>
        <xmqqk1h09224.fsf@gitster-ct.c.googlers.com>
        <CAHk-=whe+R7fkTi0eBnhrBY=_k_du3e5dkNsVe=HgKXLoXekdg@mail.gmail.com>
        <20190404180653.curtoo7yot6tpqfk@jak-t480s>
Date:   Fri, 05 Apr 2019 14:24:31 +0900
In-Reply-To: <20190404180653.curtoo7yot6tpqfk@jak-t480s> (Julian Andres
        Klode's message of "Thu, 4 Apr 2019 20:06:53 +0200")
Message-ID: <xmqq7ec9dnxs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julian Andres Klode <jak@jak-linux.org> writes:

>> What Thomas Found out was that the exact same email with
>> 
>>     Message-Id/From/Date/Subject/To
>> 
>> (in that order) does not work, but
>> 
>>     Date/From/Subject/To/Message-Id
>> 
>> does work. Weird and "wonderful". But there might be a lot of other
>> orderings that work or don't.
>> 
>> Having looked through some other emails, I know that
>> 
>>     From/To/Subject/Date/Message-Id
>>     Subject/To/References/From/Message-ID/Date
>> 
>> also works.  Which makes me suspect that it's the Message-ID line that matters.
>
> I also know that gmail rewrites the Message-ID / creates one if it is
> missing or "odd" (such as ends in a .). It those probably makes sense
> in that twisted world view to require that to be fairly late...

Here is a patch that is not polished enough to be commited yet but
should be testable (as I suspect that existing tests need to be
adjusted).

-- >8 --

Subject: [PATCH] format-patch: move message-id and related headers to the end

It has been reported that GMail MSA has an undocumented limitation
that makes it reject or accept depending on some ordering of headers
in the incoming message.  The current suspicion is that they want to
see the Message-Id: header near the end, so let's try doing so and
see what happens..

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1e56df62a7..111b947264 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -363,24 +363,27 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 	const char *extra_headers = opt->extra_headers;
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      &null_oid : &commit->object.oid);
+	struct strbuf message_ids = STRBUF_INIT;
 
 	*need_8bit_cte_p = 0; /* unknown */
 
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
 	graph_show_oneline(opt->graph);
-	if (opt->message_id) {
-		fprintf(opt->diffopt.file, "Message-Id: <%s>\n", opt->message_id);
-		graph_show_oneline(opt->graph);
-	}
+
+	if (opt->message_id)
+		strbuf_addf(&message_ids, "Message-Id: <%s>\n", opt->message_id);
+
 	if (opt->ref_message_ids && opt->ref_message_ids->nr > 0) {
 		int i, n;
 		n = opt->ref_message_ids->nr;
-		fprintf(opt->diffopt.file, "In-Reply-To: <%s>\n", opt->ref_message_ids->items[n-1].string);
+		strbuf_addf(&message_ids, "In-Reply-To: <%s>\n",
+			    opt->ref_message_ids->items[n-1].string);
 		for (i = 0; i < n; i++)
-			fprintf(opt->diffopt.file, "%s<%s>\n", (i > 0 ? "\t" : "References: "),
-			       opt->ref_message_ids->items[i].string);
-		graph_show_oneline(opt->graph);
+			strbuf_addf(&message_ids, "%s<%s>\n",
+				    (i > 0 ? "\t" : "References: "),
+				    opt->ref_message_ids->items[i].string);
 	}
+
 	if (opt->mime_boundary && maybe_multipart) {
 		static struct strbuf subject_buffer = STRBUF_INIT;
 		static struct strbuf buffer = STRBUF_INIT;
@@ -425,6 +428,17 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		opt->diffopt.stat_sep = buffer.buf;
 		strbuf_release(&filename);
 	}
+
+	if (message_ids.len) {
+		static struct strbuf buf = STRBUF_INIT;
+
+		strbuf_reset(&buf);
+		strbuf_addbuf(&buf, &message_ids);
+		if (extra_headers)
+			strbuf_addstr(&buf, extra_headers);
+		extra_headers = buf.buf;
+	}
+
 	*extra_headers_p = extra_headers;
 }
 
-- 
2.21.0-197-g893dd55891

