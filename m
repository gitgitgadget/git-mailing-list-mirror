Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C051FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdBMTO2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:14:28 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35777 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdBMTO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:14:27 -0500
Received: by mail-oi0-f68.google.com with SMTP id x84so392361oix.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MCmSUeG1Rk5SUsPiy+3uouKIGP+gdHazTl7yxYIMDT0=;
        b=fWJplN4eG9aSkwM/iIDeilObOXFqylykVLtCI5L6vu38gbQNehxEoGzbclFgLlFR0O
         CaWTOgTTYJw/Uvulmisxi7zFAsLLYQxgJ/Ln1h6/89f0LP1hovc5lLW9PqlNEIBc/CkQ
         Rd9042AfNxC9BDWBLa3PndlPysyGZ8PDZPGlAB0ulOMyKfPxSNaLx/72r3rMhpbmXcox
         ydSsSKWk6Deub5NplX7hHg+LEh/FIT10OdBd9EgxKDUNnwN61KPi8WO+eBswlakJJsHm
         V1TW8Lw1/dGLzj1tWPv95KIpMVZ6OLGgdoi0EsLVjG4gEXyGsDjCrEHEwKtbkeJbXbi4
         GBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MCmSUeG1Rk5SUsPiy+3uouKIGP+gdHazTl7yxYIMDT0=;
        b=C1FPA4OLG/qVYetpo+lB3XsYHfC9X+AOKdO+icgEt9d/uVwiEwC8eM30qNHSLLs2En
         Rvg4BgbFDQ5TyPMGPyfFaCsqNQVC86lq3223iZllDFVyV+HbjRb38sVaLW7X5QpoagUt
         A9OSba41ubKaMnoKcYiItG9+hbmyeDxTkhS2WY4JOLszFX0KbUhIU8Ybh0PhDq9MD9oQ
         54/oNs64Zj224+bNRNErLyTRWEPb8I6654i6M8T092Pu3XgzzDZXvMMfUbL8/0y9kFvX
         xibsHq/AFa/XDtWWilSBSwkvKdkqcahjugeao47nk9xLs7Z+bRpUfvaoCOywvYKeDTtw
         K5MQ==
X-Gm-Message-State: AMke39kR52FY+eD3S0eEPNkmpQ+yiqtJTFtiPtx11qjWJIh9dX0yg9VwhVVEfCQvrMsC6A==
X-Received: by 10.84.210.33 with SMTP id z30mr27495087plh.79.1487013266403;
        Mon, 13 Feb 2017 11:14:26 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id h68sm16097348pfj.124.2017.02.13.11.14.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 11:14:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
References: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de>
        <128b4de6-7b8e-27b9-414d-c6c6529cb491@web.de>
        <alpine.DEB.2.20.1702131722350.3496@virtualbox>
        <74dfcffe-274c-7045-420a-95612394d66b@web.de>
Date:   Mon, 13 Feb 2017 11:14:24 -0800
In-Reply-To: <74dfcffe-274c-7045-420a-95612394d66b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 13 Feb 2017 19:27:01 +0100")
Message-ID: <xmqqinodewdr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Initializing to NULL is still the correct thing to do, of course --
> together with removing the conditionals (or at least the negations).

So, let's give Pranit a concrete "here is what we want to see
squashed in", while you guys discuss peculiarity with various
platforms and their system headers, which admittedly is a more
interesting tangent ;-)

There are early returns with "goto finish" even before _syn
variables are first assigned to, so they would need to be
initialized to NULL.  The other two get their initial values
right at the beginning, so they are OK.

 builtin/bisect--helper.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8cd6527bd1..6949e8e5ca 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -280,7 +280,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 	int missing_good = 1, missing_bad = 1, retval = 0;
 	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	char *good_glob = xstrfmt("%s-*", terms->term_good);
-	char *bad_syn, *good_syn;
+	char *bad_syn = NULL, *good_syn = NULL;
 
 	if (ref_exists(bad_ref))
 		missing_bad = 0;
@@ -341,14 +341,10 @@ static int bisect_next_check(const struct bisect_terms *terms,
 	}
 	goto finish;
 finish:
-	if (!bad_ref)
-		free(bad_ref);
-	if (!good_glob)
-		free(good_glob);
-	if (!bad_syn)
-		free(bad_syn);
-	if (!good_syn)
-		free(good_syn);
+	free(bad_ref);
+	free(good_glob);
+	free(bad_syn);
+	free(good_syn);
 	return retval;
 }
 
