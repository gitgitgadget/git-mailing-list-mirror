Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B765C1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 19:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKLTiT (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 14:38:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40641 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLTiT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 14:38:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id r4so14057331pfl.7
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 11:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTokw0f2v3aCJD3kpF/qNgPBsBBolhRhupy/R2PebvU=;
        b=Ohm7Fkb56lyfdvxzNhhBzV/v119MQAq28ObucKbsucoQRPBirbxR6MP+NApFU80JZA
         1qYxOHrOdmkxns+IF5FOpTmBGJRB9d1WSUc3HDRLxprbMpJxSZMMiePjtpXLm1x2ihqT
         J01IH+2kbrEJhN995XnA+fqJg+WCnmKIk6car2VpXvQSuQwTwq7sTUylQCj6pnJv3ZmQ
         QDJ6Mb51xiQDtQ/pi1vD96ORrr6fChKfNIFajnZY7w8oKEdCOYTEiAm6yKeP2lVZMPWW
         a6U/nWOlhikbkQX6ulUIC08L67Atun0rfTCCRroBpfwgiur6r7NVCyp/aWwdDHBEtCSw
         LVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTokw0f2v3aCJD3kpF/qNgPBsBBolhRhupy/R2PebvU=;
        b=QLR4MuoULML2oiGC0pyUs7J37MGCictGCq+fqJzKW47txIYBg9BUoaqIVEmpKn2mOW
         jf2CDDSQ9Ck2L58a22opBQM2+d/o+r5OLLaxChr/QXYU6moi4+bS0/M+yQqx0+zOdflv
         lYcjA4IdTW4bfVgb7bXw2BrRH/UejEkOIgaAZP+xdKxLDfob7ZMLDb8FT4Y7TG44KAnB
         fLevTCYfJ8dQuWGZg7qcvn8qce5VRTCj5TSGiT1KbDMMJzFYsl/+4Zh69UNQTyDSW8bE
         fZnKqICj4Q+0dqACb54GjXA6vkSBBWD1pchq/HRwgJH9ErIos+sfswEdlfooEjE2uvCy
         wI2Q==
X-Gm-Message-State: APjAAAWqUtQJxpP9xTVfPB+MNJjLShOZKhVVh7+X8v0DeDoMHo7lgyKU
        IVh5kyW2ZKs4wrtynkspd7791R/j
X-Google-Smtp-Source: APXvYqwH9bZJ1eTr54LvJtz+BayqJs1Xv1vqJSG1Jzzkd1cYYtiZuGnPoi3fDf7E4E6tMyMzECsOlQ==
X-Received: by 2002:a63:715d:: with SMTP id b29mr152734pgn.369.1573587496764;
        Tue, 12 Nov 2019 11:38:16 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id h5sm3058072pjc.9.2019.11.12.11.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:38:15 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:38:13 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fixup! t: teach test_cmp_rev to accept ! for not-equals
Message-ID: <018d2035e0c830d0e184ff209f3f75dd291aa30f.1573587373.git.liu.denton@gmail.com>
References: <xmqq5zjpfux2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zjpfux2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for the suggestion, Junio. Since it's just a minor cleanup,
here's the fixup patch for it.

 t/test-lib-functions.sh | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 01cdbb0478..15f4c96777 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1016,11 +1016,13 @@ test_must_be_empty () {
 # provided first, that its other two parameters refer to different
 # revisions.
 test_cmp_rev () {
-	local op
+	local op wrong_result
 	op='='
+	wrong_result='different'
 	if test $# -ge 1 && test "x$1" = 'x!'
 	then
 	    op='!='
+	    wrong_result='the same'
 	    shift
 	fi
 	if test $# != 2
@@ -1033,15 +1035,8 @@ test_cmp_rev () {
 
 		if ! test "$r1" "$op" "$r2"
 		then
-			local comp_out
-			if "x$op" = 'x='
-			then
-				comp_out='different'
-			else
-				comp_out='the same'
-			fi
 			cat >&4 <<-EOF
-			error: two revisions point to $comp_out objects:
+			error: two revisions point to $wrong_result objects:
 			  '$1': $r1
 			  '$2': $r2
 			EOF
-- 
2.24.0.300.g722ba42680

