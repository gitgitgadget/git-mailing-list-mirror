Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2DB1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbeKNBb0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:31:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37921 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbeKNBb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:31:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id e3-v6so13817462wrs.5
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0DWXSJKZLXGR6IUuroubvLmhcqaglFtYJlCG2aUuEiQ=;
        b=T32440cwwkpcDQRxkW8oXimgrVV8qUVXE1qtTx0RjTRIa+BR4uDhgtCZuTYun+4iiZ
         bpp9kE2YCqoHNLU/FDy7UCY/2n8wTa5KyXtzTfcycgOWRnhEm48fiY0WVgmi4XJF3/JH
         ZEon/ONrGkyNopNHkkNNKqYysGeAIeMyCXzCFeJ8Hw2sxTbouN+bxFuzb9U/f49NVsk7
         +bqhtiX43I/0gA9PgsBJGTT8Mtj1BQMfc2R1j4bBDa1Y/gTCxdcf4RZpq5BRPhDVGi6h
         PaZm/RP4Gsdg/Txbh6Fcij2Wqjr3o2tA21UUBpg3tO2PD0C0F3huH4mojZs1pO+XDXav
         /KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DWXSJKZLXGR6IUuroubvLmhcqaglFtYJlCG2aUuEiQ=;
        b=cW+MvqzLHJiD0JwjBKMVquCCpvMsBzv4N8EAu0461Ux4pkW16mNtteI00SOfhMJDea
         28JLPjLKqcrcNSVmaa0YT17O6FMPbT8jhOxVY77MkJY3eZkbcC2loHE9dyIAdcOrzx0s
         cKznp6ontyKgzN7EEzg9tZGP3Yib0eFIe7ipdfzybr7Y02AcCq1SnGuxlE6wFclX8TIE
         GIAA6Y/JHSew4JeE6mMl0dy6Jj6o50GV4Ijr50JJKW4saQ01Utbgg1Y0fPSSlZvtLow5
         fzQQAKCVE1MjHoQERy7Dpw7Lgj8AGxsxfvpeQKhCPc2WKMgNDjpkwgfdZmbiYFhpN8Dz
         NRWQ==
X-Gm-Message-State: AGRZ1gITg1Yiv6Y2o80IUN5VSpQVQBppKt91qjpXVm+aRkFv22oYbUI9
        ECcubI8wz90qL2+zcCpGpiLFeKdk
X-Google-Smtp-Source: AJdET5cTraeCwglnRw4fg2dkF48th5t3RaKhZ8p9RuT8J3fzhQ7ggP05kB+v1QFeTM1KsbZkdQl9lg==
X-Received: by 2002:adf:f290:: with SMTP id k16-v6mr5557165wro.108.1542123166969;
        Tue, 13 Nov 2018 07:32:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l186-v6sm29535408wma.13.2018.11.13.07.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:32:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH] read-cache: write all indexes with the same permissions
Date:   Tue, 13 Nov 2018 15:32:35 +0000
Message-Id: <20181113153235.25402-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <874lcl2e9t.fsf@evledraar.gmail.com>
References: <874lcl2e9t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the code that writes out the shared index to use
create_tempfile() instead of mks_tempfile();

The create_tempfile() function is used to write out the main
.git/index (via .git/index.lock) using lock_file(). The
create_tempfile() function respects the umask, whereas the
mks_tempfile() function will create files with 0600 permissions.

A bug related to this was spotted, fixed and tested for in
df801f3f9f ("read-cache: use shared perms when writing shared index",
2017-06-25) and 3ee83f48e5 ("t1700: make sure split-index respects
core.sharedrepository", 2017-06-25).

However, as noted in those commits we'd still create the file as 0600,
and would just re-chmod it depending on the setting of
core.sharedRepository. So without core.splitIndex a system with
e.g. the umask set to group writeability would work, but not with
core.splitIndex set.

Let's instead make the two consistent by using create_tempfile(). This
allows us to remove the code added in df801f3f9f (subsequently
modified in 59f9d2dd60 ("read-cache.c: move tempfile creation/cleanup
out of write_shared_index", 2018-01-14)) as redundant. The
create_tempfile() function itself calls adjust_shared_perm().

Now we're not leaking the implementation detail that we're using a
mkstemp()-like API for something that's not really a mkstemp()
use-case. See c18b80a0e8 ("update-index: new options to enable/disable
split index mode", 2014-06-13) for the initial implementation which
used mkstemp() without a wrapper.

One thing I was paranoid about when making this change was not
introducing a race condition where with
e.g. core.sharedRepository=0600 we'd do something different for
"index" v.s. "sharedindex.*", as the former has a *.lock file, not the
latter.

But I'm confident that we're exposing no such edge-case. With a user
umask of e.g. 0022 and core.sharedRepository=0600 we initially create
both "index' and "sharedindex.*" files that are globally readable, but
re-chmod them while they're still empty.

Ideally we'd split up the adjust_shared_perm() function to one that
can give us the mode we want so we could just call open() instead of
open() followed by chmod(), but that's an unrelated cleanup. We
already have that minor issue with the "index" file #leftoverbits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I won't have time to finish this today, as noted in
https://public-inbox.org/git/874lcl2e9t.fsf@evledraar.gmail.com/
there's a pretty major bug here in that we're now writing out literal
sharedindex_XXXXXX files.

Obviously that needs to be fixed, and the fix is trivial, I can use
another one of the mks_*() functions with the same mode we use to
create the index.

But we really ought to have tests for the bug this patch introduces,
and as noted in the E-Mail linked above we don't.

So hopefully Duy or someone with more knowledge of the split index
will chime in to say what's missing there...

 read-cache.c           |  7 +------
 t/t1700-split-index.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f3a848d61c..7135537554 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3074,11 +3074,6 @@ static int write_shared_index(struct index_state *istate,
 	ret = do_write_index(si->base, *temp, 1);
 	if (ret)
 		return ret;
-	ret = adjust_shared_perm(get_tempfile_path(*temp));
-	if (ret) {
-		error("cannot fix permission bits on %s", get_tempfile_path(*temp));
-		return ret;
-	}
 	ret = rename_tempfile(temp,
 			      git_path("sharedindex.%s", oid_to_hex(&si->base->oid)));
 	if (!ret) {
@@ -3159,7 +3154,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		struct tempfile *temp;
 		int saved_errno;
 
-		temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
+		temp = create_tempfile(git_path("sharedindex_XXXXXX"));
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
2.19.1.1182.g4ecb1133ce

