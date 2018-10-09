Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21E61F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 05:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJIMhJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 08:37:09 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35071 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeJIMhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 08:37:09 -0400
Received: by mail-wm1-f54.google.com with SMTP id e187-v6so466471wmf.0
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 22:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZiyiTjanlDUk3MTSOZvhqI6nzSpBKfWFmV5+J8JNEL8=;
        b=IwFmMM92YROACYGNMyr295u3pBRfyeaUrISwUaNdGSrFDKLpDTLDM5hDNzgLn/aWU1
         Qzh6DxaXwULEq6PmS58s6PNBcaBkhzyqtBYSLt/kaN/EOwAv5TvDRFKKurwbfedWTRwL
         gKiH1M42Yo8MuR4rsRQtoXAWsDWjviyZTs5AsOkiBgk6Vygt1ZDWDZ6rK5fxIeYZo9sC
         1nYDPp7A4UMT68YQOzC70ATGlbdrLFYZ67FHWRh4yW9JMclTEh09w1DOF/3ef+CHZqDB
         noeBEY+b69aUCMvDVSntbJZ9kKfL6fX91lSQI8B01bI591oQ1SScdvgFNySJTsyn7+Ya
         9lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZiyiTjanlDUk3MTSOZvhqI6nzSpBKfWFmV5+J8JNEL8=;
        b=Dm4vtsJxseeVT9gw6wuRAUChE9No66bSHPTGt5SPb/C76q34iGPCAQIEJrJ+NSDzYU
         YDZ2OzmES/OydXqI1BtQt5IFhiTIX7n/NuFpwrrZ6TgjerzNB0xtmR2Pknr2PNJQgc/b
         4Gn8gPilPoLdHK+dpTZNnojNlpmKNFGi9HVmqwC8u9PK5LODNYc+fZwTdQRGeIBGeci/
         zlC+dh7MQVoN+VMpvAfVcppg6/kbkKQChylRcVo+A7BViOw93ChgqtoVnG+A/ck/SBR1
         Z3D3D6FWZN9KDyHcxWH7+Th+NSW5W+DH1uuu9tbQF3O2RvrGtBk/ed0C8yczJ1Gmdxkl
         lYLg==
X-Gm-Message-State: ABuFfoiKPAvugjtTROlaMEoXUqHyCqQz+MhLEHKw7650VZqzjyNZblJR
        fHqL122ecCwdqZZNJuVb3wI=
X-Google-Smtp-Source: ACcGV637VZ6Bwse15qr1fKE0Pn8y/RpPL15fNdT48zasWaWZctHkmVguADaw/Ion6m9NosHO13AVVA==
X-Received: by 2002:a1c:e717:: with SMTP id e23-v6mr598726wmh.145.1539062520635;
        Mon, 08 Oct 2018 22:22:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o201-v6sm15430169wmg.16.2018.10.08.22.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 22:21:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: git log -S or -G
References: <alpine.DEB.2.21.1810061712260.2402@hadrien>
        <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com>
        <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com>
        <alpine.DEB.2.21.1810070719200.2347@hadrien>
        <xmqq8t38t4r7.fsf@gitster-ct.c.googlers.com>
        <20181009032124.GE6250@sigill.intra.peff.net>
Date:   Tue, 09 Oct 2018 14:21:57 +0900
In-Reply-To: <20181009032124.GE6250@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 8 Oct 2018 23:21:24 -0400")
Message-ID: <xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think that is the best we could do for "-S", though, which is
> inherently about counting hits.
>
> For "-G", we are literally grepping the diff. It does not seem
> unreasonable to add the ability to grep only "-" or "+" lines, and the
> interface for that should be pretty straightforward (a tri-state flag to
> look in remove, added, or both lines).

Yeah, here is a lunchtime hack that hasn't even been compile tested.

 diff.c             |  4 ++++
 diff.h             |  2 ++
 diffcore-pickaxe.c | 22 ++++++++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index f0c7557b40..d1f2780844 100644
--- a/diff.c
+++ b/diff.c
@@ -5068,6 +5068,10 @@ int diff_opt_parse(struct diff_options *options,
 	}
 	else if (!strcmp(arg, "--pickaxe-all"))
 		options->pickaxe_opts |= DIFF_PICKAXE_ALL;
+	else if (!strcmp(arg, "--pickaxe-ignore-add"))
+		options->pickaxe_opts |= DIFF_PICKAXE_IGNORE_ADD;
+	else if (!strcmp(arg, "--pickaxe-ignore-del"))
+		options->pickaxe_opts |= DIFF_PICKAXE_IGNORE_DEL;
 	else if (!strcmp(arg, "--pickaxe-regex"))
 		options->pickaxe_opts |= DIFF_PICKAXE_REGEX;
 	else if ((argcount = short_opt('O', av, &optarg))) {
diff --git a/diff.h b/diff.h
index a30cc35ec3..147c47ace7 100644
--- a/diff.h
+++ b/diff.h
@@ -358,6 +358,8 @@ int git_config_rename(const char *var, const char *value);
 				 DIFF_PICKAXE_KIND_OBJFIND)
 
 #define DIFF_PICKAXE_IGNORE_CASE	32
+#define DIFF_PICKAXE_IGNORE_ADD	64
+#define DIFF_PICKAXE_IGNORE_DEL 128
 
 void diffcore_std(struct diff_options *);
 void diffcore_fix_diff_index(struct diff_options *);
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 800a899c86..826dde6bd4 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -16,6 +16,7 @@ typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 
 struct diffgrep_cb {
 	regex_t *regexp;
+	struct diff_options *diff_options;
 	int hit;
 };
 
@@ -23,9 +24,14 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffgrep_cb *data = priv;
 	regmatch_t regmatch;
+	unsigned pickaxe_opts = data->diff_options->pickaxe_opts;
 
 	if (line[0] != '+' && line[0] != '-')
 		return;
+	if ((pickaxe_opts & DIFF_PICKAXE_IGNORE_ADD) &&	line[0] == '+')
+		return;
+	if ((pickaxe_opts & DIFF_PICKAXE_IGNORE_DEL) &&	line[0] == '-')
+		return;
 	if (data->hit)
 		/*
 		 * NEEDSWORK: we should have a way to terminate the
@@ -45,13 +51,20 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 
-	if (!one)
+	if (!one) {
+		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_ADD)
+			return 0;
 		return !regexec_buf(regexp, two->ptr, two->size,
 				    1, &regmatch, 0);
-	if (!two)
+	}
+	if (!two) {
+		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_DEL)
+			return 0;
 		return !regexec_buf(regexp, one->ptr, one->size,
 				    1, &regmatch, 0);
+	}
 
+	ecbdata.diff_options = o;
 	/*
 	 * We have both sides; need to run textual diff and see if
 	 * the pattern appears on added/deleted lines.
@@ -113,6 +126,11 @@ static int has_changes(mmfile_t *one, mmfile_t *two,
 {
 	unsigned int one_contains = one ? contains(one, regexp, kws) : 0;
 	unsigned int two_contains = two ? contains(two, regexp, kws) : 0;
+
+	if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_ADD)
+		return one_contains > two_contains;
+	if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_DEL)
+		return one_contains < two_contains;
 	return one_contains != two_contains;
 }
 
