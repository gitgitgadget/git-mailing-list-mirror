Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C271F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeH1Nna (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:43:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37962 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeH1Nn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:43:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so1316348wmi.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SfMxrg6qCjWmjprNhE39ggySgEDqZpU4+reA1okVGVE=;
        b=fEC2H67YlAS7rtDRTMS+//gM6IDbTl4tN7ZoLmmyTBz/f1hrkSiuplkuClqadWa65d
         uzKDudlfyFrAcE2rRLa8joCFTMM4wS7328s2+w+dX/T50/VacbMyKfbZb/GxWlcxY75+
         7KbSL83eartzg7u1PU/0UVLClNSUUqUgbBsma9BsV1gRjhiDwwT1dPt7WDMLXjt+S9m4
         hfMFUmzq3kKIW+u0NniMxe+a8nt454Z7nobFj/higajn6j4ZtYG4Pg1KcaevUA94a8en
         oQpBNTwqwWvLVzJShA8CYCiqAVQMhnRQSa88+HQZqMvI+HDIx6t37PI3MYLgXOb1qHra
         YfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfMxrg6qCjWmjprNhE39ggySgEDqZpU4+reA1okVGVE=;
        b=XVBK9V+Rome10TluOrteZzuysiH+TPdTlRGaE0zw+P9yUbOJCfnSjy5EJKUDoYJnSt
         ZP6aHlBiogPp39uxDbSNrpyUsqtTAqHU6N9y5PgVbjEuEDFQF4td+d0ovA6RKCN2UHTS
         yGeJkVtYIxo2k4UcnEmtk0U4Dl/0DDyNj6GAzURKdrTM02cWP83ztAwGqw6VeIw4dtLD
         b+Rq+/UEHw1ZNufx4lWq+mGy2qVdq+Ex06kS3Q8fVc0HmD+LY118UnYzP0FcE3lXO5VD
         +yIBA4rN+Pa6tt1Y/MVJPga72F7IfVWBv3zVpP+KNd26aCS2WqVR5QGQLo2MwnXeRIlz
         r2TQ==
X-Gm-Message-State: APzg51C6sD3UgTowh8NVRVknnxjCkwkX9R4PEd5xUKGPEimldxQJ7Q7b
        yzxz+4hSLsOPu2kIH5wLcqF5Hh8cd78=
X-Google-Smtp-Source: ANB0VdYUCDDQh9GNItIw2OYkXPeULWXllmaUUKMUAz22wutxnrWCVWLyQGnfLdy8p6B3AuEqAR7Jeg==
X-Received: by 2002:a1c:5e08:: with SMTP id s8-v6mr909383wmb.88.1535449956335;
        Tue, 28 Aug 2018 02:52:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1572238wrc.21.2018.08.28.02.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:52:35 -0700 (PDT)
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
Subject: [PATCH v4 3/8] fsck: document and test sorted skipList input
Date:   Tue, 28 Aug 2018 09:52:14 +0000
Message-Id: <20180828095219.23296-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
References: <87lg8refcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since the skipList support was first added in cd94c6f91 ("fsck:
git receive-pack: support excluding objects from fsck'ing",
2015-06-22) the documentation for the format has that the file is a
sorted list of object names.

Thus, anyone using the feature would have thought the list needed to
be sorted. E.g. I recently in conjunction with my fetch.fsck.*
implementation in 1362df0d41 ("fetch: implement fetch.fsck.*",
2018-07-27) wrote some code to ship a skipList, and went out of my way
to sort it.

Doing so seems intuitive, since it contains fixed-width records, and
has no support for comments, so one might expect it to be binary
searched in-place on-disk.

However, as documented here this was never a requirement, so let's
change the documentation. Since this is a file format change let's
also document what was said about this in the past, so e.g. someone
like myself reading the new docs can see this never needed to be
sorted ("why do I have all this code to sort this thing...").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 10 +++++++++-
 t/t5504-fetch-receive-strict.sh | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index eb66a11975..b2fdbc6764 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1710,7 +1710,7 @@ doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
 will only cause git to warn.
 
 fsck.skipList::
-	The path to a sorted list of object names (i.e. one SHA-1 per
+	The path to a list of object names (i.e. one SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
 	be ignored. This feature is useful when an established project
 	should be accepted despite early commits containing errors that
@@ -1725,6 +1725,14 @@ Unlike variables like `color.ui` and `core.editor` the
 fall back on the `fsck.skipList` configuration if they aren't set. To
 uniformly configure the same fsck settings in different circumstances
 all three of them they must all set to the same values.
++
+Older versions of Git (before 2.20) documented that the object names
+list should be sorted. This was never a requirement, the object names
+can appear in any order, but when reading the list we track whether
+the list is sorted for the purposes of an internal binary search
+implementation, which can save itself some work with an already sorted
+list.  Unless you have a humongous list there's no reason to go out of
+your way to pre-sort the list.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index cbae31f330..fa56052f0f 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -142,6 +142,25 @@ test_expect_success 'fsck with no skipList input' '
 	test_i18ngrep "missingEmail" err
 '
 
+test_expect_success 'setup sorted and unsorted skipLists' '
+	cat >SKIP.unsorted <<-EOF &&
+	0000000000000000000000000000000000000004
+	0000000000000000000000000000000000000002
+	$commit
+	0000000000000000000000000000000000000001
+	0000000000000000000000000000000000000003
+	EOF
+	sort SKIP.unsorted >SKIP.sorted
+'
+
+test_expect_success 'fsck with sorted skipList' '
+	git -c fsck.skipList=SKIP.sorted fsck
+'
+
+test_expect_success 'fsck with unsorted skipList' '
+	git -c fsck.skipList=SKIP.unsorted fsck
+'
+
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
-- 
2.19.0.rc0.228.g281dcd1b4d0

