Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B792B1F406
	for <e@80x24.org>; Thu, 10 May 2018 12:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935517AbeEJMni (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 08:43:38 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40780 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeEJMna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 08:43:30 -0400
Received: by mail-wm0-f54.google.com with SMTP id j5-v6so4128361wme.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Mje7wAm4p2NGScOFeJSDNnVsS3y5Kz4DzoEN4jkiX+8=;
        b=NGs/tUVBNCG82L10JuoLu9M8eDfg/BFjGbZB34rGyKfu4nfqRDFkIktMIMeRL57ohn
         i3EpjtIVAb4bvWf+VkIa/zfUI1tcISxGtdzLVDWpYBm5M9MZwQP7BbctTVPTTrXqLm1E
         1kURsV5VIYkzXOJbZT9cW0106jeAygIxRaZkpsBL5mgnWZVNvPSYNV0rR+U3WD3UlmNa
         Y0NewFoXee3wb3hvEnisnBzs+ON2GvzrF+/UizXD0vJNYUHEknirC33DPzfM1DRbaxZ0
         ZEz/APdEr4JVuABcZTzxSwdNub6nvrY4m2iutJN005MLILt29AB+NPZilXp7Es/HevBf
         o3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mje7wAm4p2NGScOFeJSDNnVsS3y5Kz4DzoEN4jkiX+8=;
        b=B6pfAKeGH5QqZmEGVBS3gJn2iHQpAilDF0CjFQKeEmCOQPocbqg//Pz0ScTBPSFarw
         pGFPtMVf5fh9fvMrOvbJHx0XoQWgn4Oyqo+c2JIe3rPYVx7LyBYfoJ/EzYg4k+HAVAzC
         cPIPxvFEj0cimIH99ERgOGsDliKf07F6C2hP50ZmnMOrat7BviLanIAesZgancGRy/Oq
         HMMVRfaMqJuTgZUGe44g/BIaFwLXyykZglMGovmTyNlNfw74RDziEuh0GMZTotFOcOVo
         o3m36OgyYNB4+MclQNf1f7MFV4Br15z2Ja9MRHfc1oi6BymE5OsXr38zhg6LwFaJCapV
         sGsQ==
X-Gm-Message-State: ALKqPwfe9/IOmwGq1dwOEYb6x0uOX7RQ4NzHWBG5AFos+57pp7MXFoPe
        s1eEYQqY2RW0rtGgouRimpHDs5Ot
X-Google-Smtp-Source: AB8JxZqxg8gQNbbrEG8leOrrVFjy5qyV6tms30aJ17sgLy1WkFPtItVLNQ0nbqrjd+Tm/U1AAtGB8Q==
X-Received: by 2002:a1c:9c2:: with SMTP id 185-v6mr1199626wmj.53.1525956208891;
        Thu, 10 May 2018 05:43:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q7-v6sm1203303wrf.49.2018.05.10.05.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 05:43:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/6] get_short_oid: document & warn if we ignore the type selector
Date:   Thu, 10 May 2018 12:43:03 +0000
Message-Id: <20180510124303.6020-7-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g4ac3413cc8
In-Reply-To: <20180510124303.6020-1-avarab@gmail.com>
References: <20180510124303.6020-1-avarab@gmail.com>
In-Reply-To: <20180501184016.15061-10-avarab@gmail.com>
References: <20180501184016.15061-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The SHA1 prefix 06fa currently matches no blobs in git.git. When
disambiguating short SHA1s we've been quietly ignoring the user's type
selector as a fallback mechanism, this was intentionally added in
1ffa26c461 ("get_short_sha1: list ambiguous objects on error",
2016-09-26).

I think that behavior makes sense, it's not very useful to just show
nothing because a preference has been expressed via core.disambiguate,
but it's bad that we're quietly doing this. The user might thing that
we just didn't understand what e.g 06fa^{blob} meant.

Now we'll instead print a warning if no objects of the requested type
were found:

    $ git rev-parse 06fa^{blob}
    error: short SHA1 06fa is ambiguous
    hint: The candidates are:
    [... no blobs listed ...]
    warning: Your hint (via core.disambiguate or peel syntax) was ignored, we fell
    back to showing all object types since no object of the requested type
    matched the provide short SHA1 06fa

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c                         | 11 ++++++++++-
 t/t1512-rev-parse-disambiguation.sh |  5 ++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 46d8b1afa6..df33cc2dba 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -438,6 +438,7 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
+		int ignored_hint = 0;
 
 		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
 
@@ -447,8 +448,10 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 		 * that case, we still want to show them, so disable the hint
 		 * function entirely.
 		 */
-		if (!ds.ambiguous)
+		if (!ds.ambiguous) {
 			ds.fn = NULL;
+			ignored_hint = 1;
+		}
 
 		advise(_("The candidates are:"));
 		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
@@ -457,6 +460,12 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
 		oid_array_clear(&collect);
+
+		if (ignored_hint) {
+			warning(_("Your hint (via core.disambiguate or peel syntax) was ignored, we fell\n"
+				  "back to showing all object types since no object of the requested type\n"
+				  "matched the provide short SHA1 %s"), ds.hex_pfx);
+		}
 	}
 
 	return status;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 2701462041..1f06c1e61f 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -344,7 +344,10 @@ test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
 	echo 872 | git hash-object --stdin -w &&
 	test_must_fail git rev-parse ee3d^{commit} 2>stderr &&
 	grep ^hint: stderr >hints &&
-	test_line_count = 3 hints
+	test_line_count = 3 hints &&
+	grep ^warning stderr >warnings &&
+	grep -q "Your hint.*was ignored" warnings &&
+	grep -q "the provide short SHA1 ee3d" stderr
 '
 
 test_expect_success 'core.disambiguate config can prefer types' '
-- 
2.17.0.410.g4ac3413cc8

