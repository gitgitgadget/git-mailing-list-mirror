Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72FE5215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756490AbeEASk6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:40:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35123 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756473AbeEASk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id o78so20387742wmg.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HDJw5U3mU595w+AEKgWBavrH3Gy5+fOebH2ApKsOrUI=;
        b=vYlcwtR7YJz8YvCb/uLO/T4WbcKsTO956TvWNEHA7nvwmBLyiSxz+6edhJIxuLIRQ8
         H4gX24YZvd2yWzdcIcvpa7WNnJknh1+Um7oPWKjDutqfJIj2xo3PvCcwSR2ogUCb+Z4P
         ggTEgKABug90/ckXyHcJkpBuPEb2VKg32ySLI4Cn7tj3QxYfRyqgL2X5nBJ8Y+z2fn8v
         rKgVbTWkKAEMqc5b1cgwIb2Xt/rqY/aDE2nRX50RjBf+SSDuNAZEJvi3RZsoCF/9gNdW
         s8S0Yw8nMemC0AncGIknESahvt49XoqTwDX9BUpyYtqetAodZ7EsMAd1VUquakPLLjGw
         U7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HDJw5U3mU595w+AEKgWBavrH3Gy5+fOebH2ApKsOrUI=;
        b=itHVEjhJFA0hhj/pkwKZOnKvPqQeSodc4Wk4U2fWPf9MjQ3cjj48quPysGl4VFbn06
         jQd3dc+PbWWNL99aSdKjxTa+x+XHcI86a18znToF69LkV08Bzrem34XdJ5w9Y3l3zPGA
         kyEjZiu7qk/V98R7PK7Nr4J7coXQLSnzoHdwBAX5yU1MPuksc30DprtsiHIJIG/qPT/3
         88sJqzvT+uQuT4YgHFK5XJYO6dI99DqmnpRqBsDb1LJkcmp3FU64Mh4ygqgaRr8o431t
         Ns0OYvdKGqepYO5It9jFhzAtebG1oPApME7d/zLd3XRD9P5bK/mV+a54HLd/kX9qQDxp
         jmGQ==
X-Gm-Message-State: ALQs6tBnT7Ox7PQJ+rbp6vFMv2kyTuc81UAEZCzMmsXkYDDth5jcCoXw
        H4V1sdAaIavkJ1EIxcYODpOS1sMU
X-Google-Smtp-Source: AB8JxZqdK+2rLIy5+eueUbN3RfJOgmIne1dgWNegah/2VIao90tEORhln0rhDUi8Gf5u46/1tHoJfQ==
X-Received: by 10.28.63.199 with SMTP id m190mr9461031wma.158.1525200054481;
        Tue, 01 May 2018 11:40:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:53 -0700 (PDT)
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
Subject: [PATCH v3 10/12] get_short_oid / peel_onion: ^{commit} should be commit, not committish
Date:   Tue,  1 May 2018 18:40:14 +0000
Message-Id: <20180501184016.15061-11-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
References: <20180501184016.15061-1-avarab@gmail.com>
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
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

