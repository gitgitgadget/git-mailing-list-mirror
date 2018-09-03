Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B0C1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeICTKS (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45959 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so901116wrb.12
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAxjOzBFeFuGXXv4QnSW+5JWqJpO9XSMGfKqBOjf4zo=;
        b=DfhANe0juyYDnjEvDjFlm0mW4mm3cZ6WqjclucHAyYcIcc7OwzJZ8/ctHV4Dv4+ajc
         0JrESC585SWSwcBgHyvtnv0nquPFrGnsCQsyJ5R3DefsB2GtosLgwZHWukC6KaRzKl/3
         gdXHIIrojSRqRy0yq0ZRWv+gfX/CKjK7bB38RC5jC5GrGHihmagKytca0qyVnZndw8tE
         6Bjf5VvXRHiIa9ZTnQNscdc9IJH7KrqdK1rUegFGegqBrgAvjx8V7rJronRK0DZfOSs1
         C86ot92qOIHGa1GV6HyjdpPZ9icwb3d+cptr/YEntO7b2P07IgoENW6csb0QISQgkvdk
         4MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAxjOzBFeFuGXXv4QnSW+5JWqJpO9XSMGfKqBOjf4zo=;
        b=YNnhJRvanGq2WyY9afGq+aDXC6AhWHw8WnwVQCELc85plER0AyXlhEvERL/YnBYpUo
         I2O60VvbOqdcefVJ3n1piwKMwmrFPuECZVhw1EyBjKHf0VnCMUXJJYoM2alrJjV9L//G
         OhkXv/jE7TeLKv8r/hNUfuzly+5kJGN323SZW9eDdBxwQpK9XB459jVKYcsWnbNfbogx
         falwP5OP0/YwqWfPudeRgYT8aTAfgJLDgIHMy2D9qjd8UDTqfD4azargdcYysfp07rAs
         wdhRLjZAIuLcQmuQDS40zhAdDwYKOTGxrzViy3yZONmgHREbvLXTxM256ODzRCLuBt7C
         5d+w==
X-Gm-Message-State: APzg51Bhl/oSEBUQif+OYO/E6QszEVTaOrvUByoZvEVlCAZ92hDcMAVP
        yqkEjIgaT8UEyvrxHumAHiEUZhD4
X-Google-Smtp-Source: ANB0VdZXqv8jh0f9i8r2IK+Db+n2qg7S7tyQciCbm0/Z/bLWTWwurI/gojii4XxdBh6771EEME7VQg==
X-Received: by 2002:adf:ee86:: with SMTP id b6-v6mr18736313wro.242.1535986186032;
        Mon, 03 Sep 2018 07:49:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/10] fsck: document that skipList input must be unabbreviated
Date:   Mon,  3 Sep 2018 14:49:23 +0000
Message-Id: <20180903144928.30691-6-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abbreviating the SHA-1s in the skipList input has never worked, but
the documentation hasn't unambiguously stated that this is an error,
and there was no test for it.

Let's fix both since it would be easy for some later refactoring
e.g. switch to accidentally switch to a looser OID parsing function,
causing the tests before this change to pass, but for older versions
of git to be incompatible with the new skipList format.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 2 +-
 t/t5504-fetch-receive-strict.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e1ce7de8b..3287c7ef8a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1710,7 +1710,7 @@ doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
 will only cause git to warn.
 
 fsck.skipList::
-	The path to a list of object names (i.e. one SHA-1 per
+	The path to a list of object names (i.e. one unabbreviated SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
 	be ignored. Comments ('#') and empty lines are not supported, and
 	will error out.
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 38aaf3b928..96bf9facbd 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -190,6 +190,12 @@ test_expect_failure 'fsck no garbage output from comments & empty lines errors'
 	test_line_count = 1 err-with-empty-line
 '
 
+test_expect_success 'fsck with invalid abbreviated skipList input' '
+	echo $commit | test_copy_bytes 20 >SKIP.abbreviated &&
+	test_must_fail git -c fsck.skipList=SKIP.abbreviated fsck 2>err-abbreviated &&
+	test_i18ngrep "^fatal: Invalid SHA-1: " err-abbreviated
+'
+
 test_expect_success 'push with receive.fsck.skipList' '
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
-- 
2.19.0.rc1.350.ge57e33dbd1

