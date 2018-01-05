Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C9E1F406
	for <e@80x24.org>; Fri,  5 Jan 2018 10:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeAEKMF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 5 Jan 2018 05:12:05 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:48294 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750927AbeAEKMD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jan 2018 05:12:03 -0500
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-mua-02.web4all.fr)
        by mut-mta1-se01c-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1eXOyl-0005Kp-AR; Fri, 05 Jan 2018 11:12:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id A971660E3E;
        Fri,  5 Jan 2018 11:11:58 +0100 (CET)
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GgWfz5cMTKlg; Fri,  5 Jan 2018 11:11:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 355B960EA1;
        Fri,  5 Jan 2018 11:11:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zXOdeg5PdPBh; Fri,  5 Jan 2018 11:11:58 +0100 (CET)
Received: from moylip.lip.ens-lyon.fr (dhcp-13-157.lip.ens-lyon.fr [140.77.13.157])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTPSA id 7F44A60E3E;
        Fri,  5 Jan 2018 11:11:56 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH] send-email: add test for Linux's get_maintainer.pl
Date:   Fri,  5 Jan 2018 11:11:49 +0100
Message-Id: <1515147109-8077-1-git-send-email-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <q7h9wp0wod8y.fsf@orange.lip.ens-lyon.fr>
References: <q7h9wp0wod8y.fsf@orange.lip.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.0040945877455)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5nA/+f02enMjDxyuczw7JJHj1g3/PwYZaTCzSym8uE9H5V9HS/UjyLh5
 Xg9Z20I+ldOdd+K3aOwUtzTIWGGP7CJTYi2bf0F0JzgUQ/o6tR7CXAQiOAisNwrWhTdeG2lEVlPJ
 qZFwGwHl8QHr1SLrR7t9/HimTUzho/rtpZDweBNDYUMLLqJKWLPbFSEIeeCq8YrDEAERDCV0j+28
 5vMyfZdSmYTQ2HQKwfzkOhXcruVNQuMb7P+4hoAyoWeOQ+b4oY325TySbVTF/fiZ7sskqjrVzPEq
 DILMAa0/AwU6ZTYeCdOOuHrTVxzlPuSm9ELht2wEzz/Xni1guZA8Hje3K7ExCtgMTZKWSEGrKAYn
 74P6cVfdKD+w8s7W83fx+SGwJPBjHpXVtOBlF5TvPbH7W+s6rDn0tTOVcmJwqI8Ju2neb8/dDrnw
 22i185WXA/1j10quS8oNOhSFq235dUaodchFGyeJ0IY0Cr1pZR+LLwvQ7LEu2Y9ouXVMXhi4QD47
 R6lb3jSUvyQBw3jj+H4QpBh/P5Timil8RVEoPuUQQ8kRB1sAul7ieF3TwxbJWD0kX7pMm9ThlSCL
 bAqHU+dQwbJf7YSuADBwlX2p8sVzMfgtuBJ+lX3YYpnkKenVX8OM0ME8K4C1VqzFsEEStoE8cXs9
 llqvvHoJNZZn5rjYxZbXpMdNZTIboPE3gH54KaWkmew+6aOK8jyQors6UZX4b3UP/tHCXl9v5T0a
 XYg6H3OeP2Zg5Hr0gRillw/EoELJUtD5c2vhBTJk3PS4u9EpjFmnH1Pnd9bYnQBiABUxHI9Cp3Jk
 DxukdsNDStzVrxK4r+WG98Qt1L9FDY0yO5V/pgIMvERvSqxL+j1wLSMV1DUC7WFms/r3CECVl6WL
 sD+XmLXHYVRW5JYrFz37w7dzlfvWkz1VSMJJ9RdNUuHlKJPYT4wPt/OpIKGz7i7CIVU4wkFDmz24
 WKkPfOYR2dD7CCpu6ispy1B40ZjzQhlkSE67cs6ShRaQD4LfvLL2NCokPg==
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Bennée <alex.bennee@linaro.org>

We had a regression that broke Linux's get_maintainer.pl. Using
Mail::Address to parse email addresses fixed it, but let's protect
against future regressions.

Patch-edited-by: Matthieu Moy <git@matthieu-moy.fr>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
---
 t/t9001-send-email.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4d261c2..f126177 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -172,6 +172,28 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
 	test_cmp expected-cc commandline1
 '
 
+test_expect_success $PREREQ 'setup fake get_maintainer.pl script for cc trailer' "
+	cat >expected-cc-script.sh <<-EOF &&
+	#!/bin/sh
+	echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
+	echo 'Two Person <two@example.com> (maintainer:THIS THING)'
+	echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/bar))'
+	echo '<four@example.com> (moderated list:FOR THING)'
+	echo 'five@example.com (open list:FOR THING (FOO/bar))'
+	echo 'six@example.com (open list)'
+	EOF
+	chmod +x expected-cc-script.sh
+"
+
+test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
+	test_commit cc-trailer-getmaint &&
+	clean_fake_sendmail &&
+	git send-email -1 --to=recipient@example.com \
+		--cc-cmd="./expected-cc-script.sh" \
+		--smtp-server="$(pwd)/fake.sendmail" &&
+	test_cmp expected-cc commandline1
+'
+
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-- 
2.7.4

