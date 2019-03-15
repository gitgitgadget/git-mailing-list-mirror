Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C7820248
	for <e@80x24.org>; Fri, 15 Mar 2019 04:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfCOErT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 00:47:19 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:33354 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCOErT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 00:47:19 -0400
Received: by mail-wm1-f47.google.com with SMTP id c13so8284057wmb.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 21:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UuzWnax0cAkTY5jhkObsr3j3m1L/m07rUWTc7Ctciio=;
        b=tQN3Iou2s8nBnbhSQYpuRYv1z1s1/SMO8sKbbvHCVKuuHZlHLrZDRP6BODqtD7z0dZ
         8G0wna4ry44gnIxH/ijMssZvozoKrOuqQf3+WLHelWFeuWO5GFvAMsTUnMW35fffjZQH
         KzfDcDzk2VNxsQq6QJ+ImffKMgT5Y6us1TD/QBb7qTiiMZV8RkGvs36IWwU3G+xBjzG3
         8c9NKkF7SxqitEaOQfqB9Cd8dy2hysY5+jKp9T9rV4V5H63IA+nOqOBKIt1BwLX4gMRt
         slc6nHwtvgp0hN/5MQFUTcqFRg15Crn+NVpVfv/sRmX0y6FJmaviuD/FTONObHFHyuhd
         MzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UuzWnax0cAkTY5jhkObsr3j3m1L/m07rUWTc7Ctciio=;
        b=eZtzf/ZYcCygl6ZKzPYuKOmBw56SpfXFN3SEU/CGPdwKSMeIklP0R6o1vGamDRtVD5
         2E3QBI4wPKmrUdAYDmnYrF00Go3UAKHpvbYbl07r+vbAVwLgmj8j/44O1KDrXmRFlEN5
         wgprxELtUNBpBtVa8PzItEMAXa2ppI93at+MF96+XLxXMScx9jz9A/dWD0JE7KeRCGYk
         3yLSdKOHvHqOelOt1mQpTmUlm4wrUkJDn75gQ2w4DBKoUGn3IKKfPSIi9bWjQbTL21DI
         RY4JP/qiWb0+rhkZePmxqBM7gDwZIlvFr1CBQ43ZEbcthR3NytMF9IF0hp3dnsgou2hd
         /0HA==
X-Gm-Message-State: APjAAAWvbb8ydmVvaiK5mQsg4vwz7m+n9jgPjNMLAOhpf2zi7yahAjFi
        2ufEHA0PJ+iM8HZYJEjyB3I=
X-Google-Smtp-Source: APXvYqzJooR7F36DMLan+rBb3bNB5Uy9i8j2Q8or9QH+bEsUHI2lOwlobRabM3Fn6g5EAKqRnbVgpQ==
X-Received: by 2002:a7b:c5c3:: with SMTP id n3mr686571wmk.82.1552625237047;
        Thu, 14 Mar 2019 21:47:17 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z14sm1000375wrh.29.2019.03.14.21.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 21:47:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git List Mailing <git@vger.kernel.org>
Subject: Re: "Problems" with git format-patch --thread email header ordering
References: <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>
Date:   Fri, 15 Mar 2019 13:47:15 +0900
In-Reply-To: <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 14 Mar 2019 16:44:51 -0700")
Message-ID: <xmqqk1h09224.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> While it's true that header ordering isn't specified, there's a common
> "canonical" order that the headers are listed in. To quote rfc822:
> ...
>             body must occur AFTER  the  headers.   It  is  recommended
>             that,  if  present,  headers be sent in the order "Return-
>             Path", "Received", "Date",  "From",  "Subject",  "Sender",
>             "To", "cc", etc.
>
> But git format-patch does create the email headers out in a different
> order than the one recommended.  When you do "git format-patch
> --thread" to create the emails, the header ordering looks roughly like
> this:
>
>   Message-Id: <cover.1552606170.git.torvalds@linux-foundation.org>
>   From: Linus Torvalds <torvalds@linux-foundation.org>
>   Date: Thu, 14 Mar 2019 16:29:30 -0700
>   Subject: [PATCH 0/6] *** SUBJECT HERE ***
>   MIME-Version: 1.0
>   Content-Type: text/plain; charset=UTF-8
>   Content-Transfer-Encoding: 8bit
> ...
> And yes, if somebody from Google on this list wants to bring this up
> with the gmail team, I wish you the best of luck. Let me know how it
> goes.

I obviously won't do the last one myself, but if the issue is only
to swap from and date, then this may be sufficient, perhaps?

I suspect that there would be fallouts in t/ directory before we can
call this a fix.

 pretty.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index f496f0f128..40c7236fbc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -452,6 +452,14 @@ void pp_user_info(struct pretty_print_context *pp,
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 
 	if (cmit_fmt_is_mail(pp->fmt)) {
+
+		/* 
+		 * Date: before From:
+		 * cf. <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>
+		 */
+		strbuf_addf(sb, "Date: %s\n",
+			    show_ident_date(&ident, DATE_MODE(RFC2822)));
+
 		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
 			struct strbuf buf = STRBUF_INIT;
 
@@ -502,8 +510,7 @@ void pp_user_info(struct pretty_print_context *pp,
 		break;
 	case CMIT_FMT_EMAIL:
 	case CMIT_FMT_MBOXRD:
-		strbuf_addf(sb, "Date: %s\n",
-			    show_ident_date(&ident, DATE_MODE(RFC2822)));
+		/* has been done much earlier */
 		break;
 	case CMIT_FMT_FULLER:
 		strbuf_addf(sb, "%sDate: %s\n", what,
