Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC6A215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbeEAMHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39988 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755132AbeEAMHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:41 -0400
Received: by mail-wr0-f193.google.com with SMTP id v60-v6so10642778wrc.7
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HDJw5U3mU595w+AEKgWBavrH3Gy5+fOebH2ApKsOrUI=;
        b=JnuH4XOrSypK2zDnQKA405iAZC+jqohkJEo8HSUbFxYM3mGleAsyo+PFvdbnxQNw2I
         nF6i5FfPC2r/wuIgwWMNfflhPDJZQysip+cDT9lc1qmYT8nmxyvU00cdEFY9w6zrlGiB
         Bj4Do7sMTBTSwdIorSggWAh1r+Pr2i2PP1rpJNoL+mABlpMXCKTnDX6ZXg1UZ/2mzBLZ
         kiJp2c/NPesALH0ucszIU3ZIoKALYjL4n4oNU5hS033TkokCR/X6DSudOA6SNLXfxl7z
         PvAqgqYiFHi0TzDvb06jbi7L5+bn0P7DRFkleFyiUzvczrzxQzqFfJIxQ9HQW390wwsr
         H/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HDJw5U3mU595w+AEKgWBavrH3Gy5+fOebH2ApKsOrUI=;
        b=ARbZahw8mzqWitaHgW65YYJxsmNugOZ0912J1slCV7LIdg8BRH6VHkEA+NbPd2p7IG
         vyFC4NXq2iB9FRGMolcm5lVpC2h1JqbH1r42/PraMtIVfqfC4gnNtejNcpJFVGZ1xwvQ
         ZhxrF6aaJOUHC1oE/64eRoK516YjyUsK8bwE1unh5OfAFLYkIvszj86Bpasbf/LCI+Pa
         RHpyJgrshCnUb/n3oTUUm9btCCf6PiuSZl1rwafirw+gF6SCnxgzZuwTAVWhynLUXmq0
         Qz51Ffu+rbTIQaxdqSYRCY56hC98XCUH0wwuZl6qufc4dY+1q+IPAW5gDFykK9cvS9/3
         HRpA==
X-Gm-Message-State: ALQs6tBVOMCyhdBo4ukWV7OuPazXH4ZP0ijXOjQa2JDgVYMo7cQ/oNqW
        ceIeLPOZ7E9q9DIWBoplmIPBbd5p
X-Google-Smtp-Source: AB8JxZrCRjaLS9dKJNQjA8oV79hMpX7pro3eZMxRz7OmfUJ5vDjtKRr1Tzb8pbkMzZrJI4Bh6nYTzg==
X-Received: by 2002:adf:86b2:: with SMTP id 47-v6mr11562236wrx.256.1525176459431;
        Tue, 01 May 2018 05:07:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/12] get_short_oid / peel_onion: ^{commit} should be commit, not committish
Date:   Tue,  1 May 2018 12:06:49 +0000
Message-Id: <20180501120651.15886-11-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the ^{commit} syntax to mean just commits instead of committish
for the purpose of disambiguation. Before this e8f2^{commit} would
show the v2.17.0 tag as a disambiguation candidate, but now it'll just
show ambiguous commits:

    $ git rev-parse e8f2^{commit}
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    [...]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c                         | 2 +-
 t/t1512-rev-parse-disambiguation.sh | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index b61c0558d9..1d2a74a29c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -966,7 +966,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 
 	lookup_flags &= ~GET_OID_DISAMBIGUATORS;
 	if (expected_type == OBJ_COMMIT)
-		lookup_flags |= GET_OID_COMMITTISH;
+		lookup_flags |= GET_OID_COMMIT;
 	else if (expected_type == OBJ_TAG)
 		lookup_flags |= GET_OID_TAG;
 	else if (expected_type == OBJ_TREE)
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 81076449a2..b17973a266 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -341,8 +341,8 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguity hints' '
 test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
 	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
 	grep ^hint: stderr >hints &&
-	# 5 commits, 1 tag (which is a commitish), plus intro line
-	test_line_count = 7 hints &&
+	# 5 commits plus intro line
+	test_line_count = 6 hints &&
 	git rev-parse 000000000^{tag} >stdout &&
 	test_line_count = 1 stdout &&
 	grep -q ^0000000000f8f stdout &&
@@ -366,7 +366,8 @@ test_expect_success 'core.disambiguate config can prefer types' '
 	# ambiguous between tree and tag
 	sha1=0000000000f &&
 	test_must_fail git rev-parse $sha1 &&
-	git rev-parse $sha1^{commit} &&
+	# there is no commit so ^{commit} comes up empty
+	test_must_fail git rev-parse $sha1^{commit} &&
 	git -c core.disambiguate=committish rev-parse $sha1
 '
 
-- 
2.17.0.290.gded63e768a

