Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB461F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 17:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbeKQDom (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 22:44:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55821 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbeKQDom (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 22:44:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so5498028wmc.5
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gx7Og0K81VVdcu9NpHOUr/VcBfhirfAjsLh1gWSSi9o=;
        b=WxFrwifl4tl4evitk3pRYYaTUNRo7hAfQDDaOv/U37AQNZhkZJX+zvQzGzXRuW5gfB
         P0i/fuJ1NzSGJgUh0wunmVKc1h6uWPxB6g/nS57V0UxSLHHGhV3DkPXoy6pkOKwyqtxQ
         VoMo+YmVOD9ky1gd16X4Qxy5yAuRiBjqLDgX05ef8kqoaLgYvJN1am/sgOrAlhk9+hr/
         Tja+1SwsZPH3ln+z4T6GtzO5MgiRdE/9KBwDDH3yBNoC0IPd/mKmRP9fQXWJK+hq2Ayz
         XZzG0DqeiA2pUopwQUNgXV0SEOecSjqByA4SvnCQHXCIt2E+4GTlhTKJlfmhW7ikR1gO
         aT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gx7Og0K81VVdcu9NpHOUr/VcBfhirfAjsLh1gWSSi9o=;
        b=eqD746bTG/gaNtb+02tNjF0wm5nDk2aQOby0S5jPz7BXVOG4p16rHoD0lX1eOKu7C6
         FmiMa7p17DMWxdbWMjG0MtdVBOB6iGyCrECtiRVL8D3UrBhFnbLHXEE+tvI3Dk99t2OD
         5IWdHpEt9S0cDoHYXJi68vVacIIqa1egiMJfAQXifsoSEYBeZx1QpBT336qig9Q2Jsft
         v44rBRVlp/0vSkeFm+AJZowEM/4u90WMCvlORZK5aZgISB7/z8s/IAmcssrVqgRuD4nm
         SRZBqn0Y/x0/A6fzLV/zq+OTbUznCEr2zpcQw7KOEOnS6UzX77bEJ9C7kIZ1U6pxt5tB
         OZzw==
X-Gm-Message-State: AGRZ1gJqYUYAqrSnIhgCfaGoyOmKnPY0JcMpO9CSbCa3pFYK9PXHD4vy
        Kkuxxz151/CKuhHplsCj/A+yS9Hh
X-Google-Smtp-Source: AJdET5ejQRcPl4Zu8X/8GFvvVR4ITqg9WQcUDHaxkbZ5GHQXa3xQZIt609Bb+q406fnM6aCtpbOJFA==
X-Received: by 2002:a1c:5f83:: with SMTP id t125-v6mr9247889wmb.53.1542389483025;
        Fri, 16 Nov 2018 09:31:23 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t82-v6sm27318136wme.30.2018.11.16.09.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 09:31:21 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] read-cache: write all indexes with the same permissions
Date:   Fri, 16 Nov 2018 18:31:05 +0100
Message-Id: <20181116173105.21784-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.19.1.1053.g063ed687ac
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Change the code that writes out the shared index to use
mks_tempfile_sm() instead of mks_tempfile().

The create_tempfile() function is used to write out the main
".git/index" (via ".git/index.lock") using lock_file(). The
create_tempfile() function respects the umask, as it uses open() with
0666, whereas the mks_tempfile() function uses open() with 0600.

So mks_tempfile() which is used to create the shared index file is
likely to create such a file with restricted permissions compared to
the main ".git/index" file.

A bug related to this was spotted, fixed and tested for in df801f3f9f
("read-cache: use shared perms when writing shared index", 2017-06-25)
and 3ee83f48e5 ("t1700: make sure split-index respects
core.sharedrepository", 2017-06-25).

However, as noted in those commits we'd still create the file as 0600,
and would just re-chmod it depending on the setting of
core.sharedRepository. So without core.splitIndex a system with
e.g. the umask set to group writeability would work for the members of
the group, but not with core.splitIndex set, as members of the group
would not be able to access the shared index file.

Let's instead make the two consistent by using mks_tempfile_sm() and
passing 0666 in its `mode` argument.

Note that we cannot use the create_tempfile() function itself that is
used to write the main ".git/index" file because we want the XXXXXX
part of the "sharedindex_XXXXXX" argument to be replaced by a pseudo
random value and create_tempfile() doesn't do that.

Ideally we'd split up the adjust_shared_perm() function to one that
can give us the mode we want so we could just call open() instead of
open() followed by chmod(), but that's an unrelated cleanup. We
already have that minor issue with the "index" file #leftoverbits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This is a simpler fix iterating from Ævar's RFC patch and the
following discussions:

https://public-inbox.org/git/20181113153235.25402-1-avarab@gmail.com/

 read-cache.c           |  3 ++-
 t/t1700-split-index.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 8c924506dd..ea80600bff 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3165,7 +3165,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		struct tempfile *temp;
 		int saved_errno;
 
-		temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
+		/* Same permissions as the main .git/index file */
+		temp = mks_tempfile_sm(git_path("sharedindex_XXXXXX"), 0, 0666);
 		if (!temp) {
 			oidclr(&si->base_oid);
 			ret = do_write_locked_index(istate, lock, flags);
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 2ac47aa0e4..fa1d3d468b 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -381,6 +381,26 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
+test_expect_success POSIXPERM 'same mode for index & split index' '
+	git init same-mode &&
+	(
+		cd same-mode &&
+		test_commit A &&
+		test_modebits .git/index >index_mode &&
+		test_must_fail git config core.sharedRepository &&
+		git -c core.splitIndex=true status &&
+		shared=$(ls .git/sharedindex.*) &&
+		case "$shared" in
+		*" "*)
+			# we have more than one???
+			false ;;
+		*)
+			test_modebits "$shared" >split_index_mode &&
+			test_cmp index_mode split_index_mode ;;
+		esac
+	)
+'
+
 while read -r mode modebits
 do
 	test_expect_success POSIXPERM "split index respects core.sharedrepository $mode" '
-- 
2.19.1.1053.g063ed687ac

