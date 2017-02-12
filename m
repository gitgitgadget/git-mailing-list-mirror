Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A24D1FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 12:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdBLMgf (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 07:36:35 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32768 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdBLMge (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 07:36:34 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so7099069pgd.0
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 04:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9nO6tqnMx3hC8btxQKH+5NYZyEkDnBpJUvbRdxlIzno=;
        b=k7Q89PX9XsfNwE9TmxjepRch6/nrygqmztnc1p3M9oKClwlRbcgxVK8qwwS2rHixQi
         Dl82VUr939GPYJjtUVyRXYipZUL7GG1ti2A+kGHNvL4jsV1ebM1vgJoYCnFdeejVsZz1
         pHCU3EBE6KzxEMxz807Px2asrzJV1iSe16vULUKUYyQ3G5cXvragvcMBmncpTTq6upSg
         LaajQH/ATBxqE5aYoJbwOquxDpxEeVhXdikC95Z3vuwdThni/KXVjZB1XClK75vuAkY1
         5lX0tqKxHq6GJQKClHa0dF6+MZlCfHV+6hm0ogNV6rUXHE1D+xlXg/sV0vDlsWfJL8jv
         VDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nO6tqnMx3hC8btxQKH+5NYZyEkDnBpJUvbRdxlIzno=;
        b=RvUK/es+eSS4M/cYVZ8v4Z2nc7Ba6XN9tyKfthktDZdBFAX9IgW2Oz1oRisBbKRPjy
         XTP+UbXVpURBBH9EmRgp1xzD8UC/hdoeuVDBf46xmwYO68E7EvY5wV0Kt8TAJ+ER5Eik
         AksMgfw6u5YmhCgy53BLjOr5isJxXAnavC9aFEq4KvCyXx1TXej3eYjb6fa6Jbtwc+vF
         Y86kL0IVXsbGKpfx2Sec4wkJ0MEG1uIR3aqaQ6oUzKAdIGWLZNaPvd1gOzEveKcT265a
         9k4Ead/xmM3y9YjgVWWQG4wG2O6othoQ05jNO9uu78ZLT+rd02wS/NEW77BRRdIWVTay
         NecA==
X-Gm-Message-State: AMke39ng1pPd6IePZX/L5dVVITbSvrftfnbkYXY1O9q8tZ5Q/JeOLmfniReCcWR+YBYjrA==
X-Received: by 10.99.102.135 with SMTP id a129mr21058684pgc.220.1486902993720;
        Sun, 12 Feb 2017 04:36:33 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id m29sm15168284pfi.54.2017.02.12.04.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Feb 2017 04:36:32 -0800 (PST)
Date:   Sun, 12 Feb 2017 12:36:30 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/2 v3] revision.c: args starting with "-" might be a
 revision
Message-ID: <20170212123630.GA20872@ubuntu-512mb-blr1-01.localdomain>
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
 <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
 <xmqqh941ippo.fsf@gitster.mtv.corp.google.com>
 <20170211075254.GA16053@ubuntu-512mb-blr1-01.localdomain>
 <xmqqefz4h1vq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefz4h1vq.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 11, 2017 at 01:08:09PM -0800, Junio C Hamano wrote:
> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
> 
> > Um, I am sorry, but I feel that decrementing left, and incrementing it again is
> > also confusing.
> 
> Yes, but it is no more confusing than your original "left--".
> ...
> 
>  * If it is an option known to us, handle it and go to the next arg.
> 
>  * If it is an option that we do not understand, stuff it in
>    argv[left++] and go to the next arg.
> 
> Because the second step currently is implemented by calling
> handle_opt(), which not just tells if it is an option we understand
> or not, but also mucks with argv[left++], you need to undo it once
> you start making it possible for a valid "rev" to begin with a dash.
> That is what your left-- was, and that is what "decrement and then
> increment when it turns out it was an unknown option after all" is.

So, our problem here is that the function handle_revision_opt is opaquely also
incrementing "left", which we need to decrement somehow.

Or: we could change the flow of the code so that this incrementing
will happen only when we have decided that the argument is not a
revision.
> 
>  * If it is an option known to us, handle it and go to the next arg.
> 
>  * If it is a rev, handle it, and note that fact in got_rev_arg
>    (this change of order enables you to allow a rev that begins with
>    a dash, which would have been misrecognised as a possible unknown
>    option).
> 
>  * If it looks like an option (i.e. "begins with a dash"), then we
>    already know that it is not something we understand, because the
>    first step would have caught it already.  Stuff it in
>    argv[left++] and go to the next arg.
> 
>  * If it is not a rev and we haven't seen dashdash, verify that it
>    and everything that follows it are pathnames (which is an inexact
>    but a cheap way to avoid ambiguity), make all them the prune_data
>    and conclude.

This "changing the order" gave me the idea to change the flow. I tried to
implement the above steps without touching the function handle_revision_opt. By
inserting the handle_revision_arg call just before calling handle_revision_opt.

The decrementing then incrementing or "left--" things have now been removed.
(But there is still one thing which doesn't look good)

diff --git a/revision.c b/revision.c
index b37dbec..8c0acea 100644
--- a/revision.c
+++ b/revision.c
@@ -2203,11 +2203,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (seen_dashdash)
 		revarg_opt |= REVARG_CANNOT_BE_FILENAME;
 	read_from_stdin = 0;
+
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+		int opts;
 		if (*arg == '-') {
-			int opts;
-
 			opts = handle_revision_pseudo_opt(submodule,
 						revs, argc - i, argv + i,
 						&flags);
@@ -2226,7 +2226,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				read_revisions_from_stdin(revs, &prune_data);
 				continue;
 			}
+		}
 
+		if (!handle_revision_arg(arg, revs, flags, revarg_opt))
+			got_rev_arg = 1;
+		else if (*arg == '-') {
 			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
 			if (opts > 0) {
 				i += opts - 1;
@@ -2234,11 +2238,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
-			continue;
-		}
-
-
-		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
+		} else {
 			int j;
 			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
@@ -2255,8 +2255,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			append_prune_data(&prune_data, argv + i);
 			break;
 		}
-		else
-			got_rev_arg = 1;
 	}
 
 	if (prune_data.nr) {


The "if (*arg =='-')" line is repeated. On analysing the resulting
revision.c:setup_revisions function, I feel that the codepath is still as
easily followable as it was earlier, and there is definitely no confusion
because of a mysterious decrement. Also, the repeated condition doesn't make it
any harder (it looks like a useful check because we already know that every
option would start with a "-"). But that's only my opinion, and you definitely
know better.

now the flow is very close to the ideal flow that we prefer:

1. If it is a pseudo_opt or --stdin, handle and go to the next arg
2. If it is a revision, note that in "got_rev_arg", and go to the next arg
3. If it starts with a "-" and is a known option, handle and go to the next arg
4. If it is none of {revision, known-option} and we haven't seen dashdash,
   verify that it and everything that follows it are pathnames (which is an
   inexact but a cheap way to avoid ambiguity), make all them the prune_data and
   conclude.

> But I think the resulting code flow is much closer to the
> above ideal.

(about Junio's version of the patch): Yes, I agree with you on this. It's like
the ideal, but the argv has already been populated, so the only remaining step
is "left++".

> 
> Such a change to handle_revision_opt() unfortunately affects other
> callers of the function, so it may not be worth it.

handle_revision_opt is called once apart from within setup_revisions,
from within revision.c:parse_revision_opt.

If this version is not acceptable, we should either revert back to your version
of the patch with the fixed variable name OR consider re-writing
handle_revision_opt, as per your suggested flow. Note that this will put the
code for "Stuff it in argv[left++]" in every caller.

Thank you for the time you have spent on analysing each version of the patch!

--
Best Regards,

Siddharth Kannan.
