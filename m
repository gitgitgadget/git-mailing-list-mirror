Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC3B201A7
	for <e@80x24.org>; Thu, 18 May 2017 02:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754147AbdERCwX (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 22:52:23 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33605 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbdERCwW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 22:52:22 -0400
Received: by mail-pg0-f44.google.com with SMTP id u187so15804011pgb.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 19:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6UQ0p765oOmx6OSra1E3vzCt96ycraQByvY2CUP8Z/I=;
        b=cddUaqYU8y7QTNGQ1vKU26ZskoEBsz/3RT2omYD8cg2SW9SU8/5EvYhkJjmlGNXv9n
         GPPk4Hy46xeCqJurR085aN9L8LnwGx86T7pK74G0iinbcaAvUlNIwwECg3+efIlclbNL
         Ssr0hATOAH6l1gsv/5eb3/FzxIQXII5Fimi+NDLV+JZzqq9ZuNuHCT4tucjOyJheLW3H
         lY8p2GbwR6zG6KlwKFUz41nS7C7zAgAIzy30q+jKeIQVWm/AHTQJPU2ZOWSN5VoWI88q
         WcgITE4EdgrGXB6Q0qz9s2iz5JOX3qcEZAETG0/icFyskqrmKmzFK2CoU8Gaz0+xWUaN
         eOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6UQ0p765oOmx6OSra1E3vzCt96ycraQByvY2CUP8Z/I=;
        b=Ha0DfAR2/yFcnOgV1SMhR5w+rijwWOmyekNs96U38qrdnGF/xdp6cpDuNphybf8H3N
         x+7ofb8VpV8SodmbJ3+3xdWyA2yQwFzpP0msHLDe7VVu4VagmqlwP9j7GGOygillAtn6
         1OavqJns7/8oT7sEDRvsJm/3TwwVZ0ii9Q61Ii8671STiRMBOzXo3Iks0sTJBsGjJUKK
         NH16D2kyOWTZtPlqzG8bXU0Y/VOzuU7M5sSTnNQ1maKXB2FZ0e884wiKB4h3LJqvWB6g
         pHsjubhk2z4Q5bdZ5OPGY67unh2cDUkqCvqGxdy9LZvrBkT7rpHFn+LVAlHmRpBddp3R
         UsZA==
X-Gm-Message-State: AODbwcBO6qAneiGd1nMIpBDghnLaCWJAy2HboxpDTyo/DP6J0C5HpK0J
        ZyEYuSgukm75+w==
X-Received: by 10.84.229.143 with SMTP id c15mr2064066plk.27.1495075941755;
        Wed, 17 May 2017 19:52:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id f27sm7640270pga.41.2017.05.17.19.52.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 19:52:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: t5545: reduced test coverage
References: <ca942ab1-db57-5794-4587-1a756686c833@ramsayjones.plus.com>
        <xmqqbmqsyzn7.fsf@gitster.mtv.corp.google.com>
        <xmqqmvacxhk0.fsf@gitster.mtv.corp.google.com>
        <xmqqinl0xga6.fsf@gitster.mtv.corp.google.com>
        <17124bdc-c6cb-5f1a-5021-7c92ad7e669c@ramsayjones.plus.com>
Date:   Thu, 18 May 2017 11:52:20 +0900
In-Reply-To: <17124bdc-c6cb-5f1a-5021-7c92ad7e669c@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 17 May 2017 21:48:55 +0100")
Message-ID: <xmqqo9uqvpuj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I would probably have simply split the test file into two, but ...
>

Hmph, that's a thought.


> ... this looks good to me. (tested on Linux and cygwin).

Thanks.

-- >8 --
Subject: [PATCH] test: allow skipping the remainder

Because TAP output does not like to see the remainder of the test
getting skipped after running one or more tests, bf4b7219
("test-lib.sh: Add check for invalid use of 'skip_all' facility",
2012-09-01) made sure that test_done errors out when this happens.

Instead, loosen the check so that we only pretend that the rest of
the test script did not exist in such a case.  We'd lose a bit of
information (i.e. TAP does not notice that we are skipping some
tests), but not very much (i.e. TAP wasn't told how many tests are
skipped anyway).

This will allow inclusion of lib-httpd.sh in the middle of a test,
which will skip the remainder of the test scripts when tests that
involve web server are declined with GIT_TEST_HTTPD=false, for
example.

Acked-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 13b5696822..30eb743719 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -745,20 +745,25 @@ test_done () {
 	fi
 	case "$test_failure" in
 	0)
-		# Maybe print SKIP message
-		if test -n "$skip_all" && test $test_count -gt 0
-		then
-			error "Can't use skip_all after running some tests"
-		fi
-		test -z "$skip_all" || skip_all=" # SKIP $skip_all"
-
 		if test $test_external_has_tap -eq 0
 		then
 			if test $test_remaining -gt 0
 			then
 				say_color pass "# passed all $msg"
 			fi
-			say "1..$test_count$skip_all"
+
+			# Maybe print SKIP message
+			test -z "$skip_all" || skip_all="# SKIP $skip_all"
+			case "$test_count" in
+			0)
+				say "1..$test_count${skip_all:+ $skip_all}"
+				;;
+			*)
+				test -z "$skip_all" ||
+				say_color warn "$skip_all"
+				say "1..$test_count"
+				;;
+			esac
 		fi
 
 		test -d "$remove_trash" &&
-- 
2.13.0-427-gdfae0f5495

