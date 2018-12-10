Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0456C20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 15:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeLJP0s (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 10:26:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40949 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeLJP0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 10:26:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so8279488lfe.7
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 07:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b3odZxJgkt7pO2Qam931BMNIqPKKY4j4usdqeWAWgC0=;
        b=sirO5ds6N5EMOln7Uu5XPNOHzFmcqpUZY797J/9qHOXALhqKiX+RTI91ogM7nUusW0
         ZyAQaZvVCWIfPmwFfm1dNj0Tkb/md/nw50ihALFxrcqq4oGHjSNEkfXIbLJS1NGGMJgX
         28bZQd1NBcAP4keW0Nxp7OkqF+oKf/Gp04LJCDX/QgtCUaBPffaHGXWdPpIS/dvBef7c
         6BQX5SFBH0PLNh6kgE3pBht8ruyAYv1bUxOgSJhOGvHFkhcsCvukhobGHm40pk9wkYSY
         C+8UR2o/98XyhTkXpRoLLJg1Q/Cf0PLa6btfiYcI4K0t3IiTYGk+yuh9aKfxeuZYZKDk
         XtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b3odZxJgkt7pO2Qam931BMNIqPKKY4j4usdqeWAWgC0=;
        b=ooyZKAQjqrOMHySyX1hpvWxdEyJr6UC7TMKAw3bVU4lyibVmjNc/gptZMiSxeugkLX
         NmQ1QnZe4bkTdel7ne5ee/oZnf+9S7RQnk4t/AYNU2ITKp2zjnsQunJ30injfDnQgxdE
         n6vknO4N2YciKaFa6r6QwsXdBQ5QrqZFcRM0soyYgam4eZVCY2LozXjjxcjOWZDy+iaM
         jEM8wUTn/TZZ6wJSvYOKEuZ+TPDGo5Sntk310fw1jCpDU1ugO3VPAsyQyCW+/QOH+8L/
         VBNGbjg31AamK2xM2EOJ7Rs2u8SAkqAiCBIeKhnck5ZOPsXaX1rcMK5Kg6uKIENtoU6X
         tr1Q==
X-Gm-Message-State: AA+aEWakAfSDgWWfaNJ1BxJB6Z40naoi5XFPiwE4fD4Xi79StZN94d4V
        MQz/6XXwU3ff+ryNixd/LrA=
X-Google-Smtp-Source: AFSGD/Vh3OIm7yHkZJYlml+XTgl3HEL55aXZ9IK3TI32TIzmh6pErqA/w7a2T/Hnxf8c0aE5cbnYlA==
X-Received: by 2002:a19:a149:: with SMTP id k70mr7058918lfe.5.1544455606105;
        Mon, 10 Dec 2018 07:26:46 -0800 (PST)
Received: from duynguyen.home (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id k63sm2167842lfe.13.2018.12.10.07.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:26:45 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:26:42 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH] parse-options: fix SunCC compiler warning
Message-ID: <20181210152642.GA16203@duynguyen.home>
References: <87va4cujtx.fsf@evledraar.gmail.com>
 <20181209102724.8707-1-pclouds@gmail.com>
 <xmqqy38xkhvd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy38xkhvd.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 03:36:54PM +0900, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
> > The compiler reports this because show_gitcomp() never actually
> > returns a value:
> >
> >     "parse-options.c", line 520: warning: Function has no return
> >     statement : show_gitcomp
> >
> > The function calls exit() and will never return. Update and mark it
> > NORETURN.
> 
> Yuck.  This should do for now, but I am not impressed by the choice
> to hook show_gitcomp() call into parse_options_step(), which forces
> such an abnormal exit deeper in the callchain [*1*].  For readers
> (not compilers), it would help to have a comment at the caller that
> says that show_gitcomp() never returns and exits.
> 
> 	side note #1.  Perhaps parse_options_start() would have been
> 	a better place, instead of parse_options_step() that is
> 	repeatedly called in a loop and itself has a loop.  ANd
> 	worse yet, the check is done inside the loop even though the
> 	call is to be made only when the --git-completion-helper
> 	option is given as the sole request.

The reason it's in parse_options_step() is because -h is also handled
in there. Although -h does not bury exit() deep in the call chain. So
how about this as a replacement?

-- 8< --
diff --git a/parse-options.c b/parse-options.c
index 3b874a83a0..6932eaff61 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -516,7 +516,7 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 	show_negated_gitcomp(original_opts, -1);
 	show_negated_gitcomp(original_opts, nr_noopts);
 	fputc('\n', stdout);
-	exit(0);
+	return PARSE_OPT_COMPLETE;
 }
 
 static int usage_with_options_internal(struct parse_opt_ctx_t *,
@@ -638,6 +638,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	case PARSE_OPT_HELP:
 	case PARSE_OPT_ERROR:
 		exit(129);
+	case PARSE_OPT_COMPLETE:
+		exit(0);
 	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
diff --git a/parse-options.h b/parse-options.h
index 6c4fe2016d..a650a7d220 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -208,6 +208,7 @@ extern int opterror(const struct option *opt, const char *reason, int flags);
 /*----- incremental advanced APIs -----*/
 
 enum {
+	PARSE_OPT_COMPLETE = -2,
 	PARSE_OPT_HELP = -1,
 	PARSE_OPT_DONE,
 	PARSE_OPT_NON_OPTION,
-- 8< --
