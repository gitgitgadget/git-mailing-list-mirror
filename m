Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924191F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933964AbeBMKFA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:05:00 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:38557 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933814AbeBMKE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:04:56 -0500
Received: by mail-wr0-f178.google.com with SMTP id t94so17996982wrc.5
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 02:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUnVXNAwQSuHPRdK70HBzR6LNG9PVhok9NcKW/Xlbug=;
        b=FpaQGICY2Mqgbwf1Gb29mMWgdMmHoakFLVfQCtq0roeTg4/2Xjjkbk2WWvMPTDaDrP
         3Xgy9noWgCrvyP5ZmbHtIf1l+Y/JEEgl/BrYVx7zOR3gypOWOrPis6Edb6k7o1r3f0i7
         YmHeU1rybz1hha6oNrQa/cWT5OJytQDGnEgLh6nRV94sCQl2otWx6D+afbIQKl0QxE4Z
         T1N+Vr+H0cnn63qLXkCVhJL32f8gRmQu1sapfCkIqrM18/RAXi9ci2oOllBLgAC+8UX7
         xZpNyKFxEV+xMti/+9+F52QPu1zDSjX+yOjsslWlu+zDCMwptpAU91QWf+2JB6WUbY+K
         tWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUnVXNAwQSuHPRdK70HBzR6LNG9PVhok9NcKW/Xlbug=;
        b=HMDaI0Zvle6/9CbCZXwKlCE9udLMlHmChOgkFrZS7FpCSkBpX9Hnk3Dvx/y4BAGsfd
         XJzSL++byAxmZ7g2cF6+NgedJeyg6/D7lH/O4oCmlq7HQwfMI/7Mn63lvQmblajuj6kE
         b02E9ZF1t1RC+xHOin98d+PiZC+8v1UD5GqOdEs+6hv5rJGXuDRfOh8o8a8VxmZaF2d0
         tu/KrWUUY32ZjFVUeBAkuvjhQ2oND2fnltbmTCdP4wTTnGf7RUO+MerXMnHETxVNj5vd
         TpQwrgY+Sntta2e48UavKnNiKh7UFQpF8ANjzFKhs76iha8wlRiHPnnPOpURv5jZXlQp
         8b1A==
X-Gm-Message-State: APf1xPBteXSTyKQHBqSmS8puqWEdQnzQq/fkn6EO24UknRSRj4dJ4O5H
        DhtDR5D9Igz8EEWBKz9Ojms=
X-Google-Smtp-Source: AH8x224pmcAWAt54hxyh4WwEC97H506aQtg3Nw5zZFWy2Cmmi+O1snE0h/rowcKNVcnxguceve6U9Q==
X-Received: by 10.223.131.69 with SMTP id 63mr751782wrd.228.1518516294837;
        Tue, 13 Feb 2018 02:04:54 -0800 (PST)
Received: from localhost.localdomain (x4db283b8.dyn.telefonica.de. [77.178.131.184])
        by smtp.gmail.com with ESMTPSA id q81sm16178630wmd.3.2018.02.13.02.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Feb 2018 02:04:54 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
Date:   Tue, 13 Feb 2018 11:04:37 +0100
Message-Id: <20180213100437.15685-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.181.g4b60b0bfb6
In-Reply-To: <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com> <xmqq3726t11d.fsf@gitster-ct.c.googlers.com> <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com> <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > I must admit that I didn't think about the effect of the useless
> > "| sort" on the exit status!  What I saw was: a process that
> > received no input, sorted nothing and produced no output - pretty
> > much the definition of useless! ;-)
> 
> I am not sure what you mean by "receive no input, sort nothing and
> produce no output".
> 
> Ahh, OK, this is a funny one.  I think the original meant to do
> 
> 	grep ... | grep -v ... | sort >actual
> 
> but it did
> 
> 	grep ... | grep -v ... >actual | sort
> 
> instead by mistake.
> 
> And we have two possible "fixes" for that mistake.  Either removing
> "|sort" (and replace its only effect, which is to hide brittleness
> of relying on exit status of the second grep, with something else)
> to declare that we do care about the order multiple warning messages
> are given by the last test in the script (by the way, the script is
> t5536, not t5556; the patch needs to be retitled), or keeping the "|
> sort" and move the redirection into ">actual" to the correct place,
> which is to follow through the intention of having that "sort" on
> the pipeline in the first place.  I somewhat favor the former in
> this particular case myself, but the preference is not a very strong
> one.

A third possible fix, which is also in the "we don't care about the
order of multiple warning messages" camp and has a nice looking
diffstat, would be something like this:


diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 2e42cf3316..91f28c2f78 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -18,14 +18,6 @@ setup_repository () {
 	)
 }
 
-verify_stderr () {
-	cat >expected &&
-	# We're not interested in the error
-	# "fatal: The remote end hung up unexpectedly":
-	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
-	test_i18ncmp expected actual
-}
-
 test_expect_success 'setup' '
 	git commit --allow-empty -m "Initial" &&
 	git branch branch1 &&
@@ -48,9 +40,7 @@ test_expect_success 'fetch conflict: config vs. config' '
 		"+refs/heads/branch2:refs/remotes/origin/branch1" && (
 		cd ccc &&
 		test_must_fail git fetch origin 2>error &&
-		verify_stderr <<-\EOF
-		fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1
-		EOF
+		test_i18ngrep "fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1" error
 	)
 '
 
@@ -77,9 +67,7 @@ test_expect_success 'fetch conflict: arg vs. arg' '
 		test_must_fail git fetch origin \
 			refs/heads/*:refs/remotes/origin/* \
 			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
-		verify_stderr <<-\EOF
-		fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1
-		EOF
+		test_i18ngrep "fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1" error
 	)
 '
 
@@ -90,10 +78,8 @@ test_expect_success 'fetch conflict: criss-cross args' '
 		git fetch origin \
 			refs/heads/branch1:refs/remotes/origin/branch2 \
 			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
-		verify_stderr <<-\EOF
-		warning: refs/remotes/origin/branch1 usually tracks refs/heads/branch1, not refs/heads/branch2
-		warning: refs/remotes/origin/branch2 usually tracks refs/heads/branch2, not refs/heads/branch1
-		EOF
+		test_i18ngrep "warning: refs/remotes/origin/branch1 usually tracks refs/heads/branch1, not refs/heads/branch2" error &&
+		test_i18ngrep "warning: refs/remotes/origin/branch2 usually tracks refs/heads/branch2, not refs/heads/branch1" error
 	)
 '
 
