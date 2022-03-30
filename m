Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F8C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 07:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbiC3Heu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 03:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiC3Hes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 03:34:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3867E0D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 00:32:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w21so16916434pgm.7
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14MWY7FxRwnQutUs+zh69CIdA1BWO6PiV3sNHAuLuPs=;
        b=ly7XZXA33NRUsUm9zS8jrHFQN/dPaVoMx3pdOzTxmExTDejrH+9JGSFScHtI06VBSq
         VHa6Cv7NlEyNe8OBOmh8GMopAS59WoFjzPYRp0Wt00T5227qG1KDSlPVf4WxwDFd2STW
         tC+8P2IceH39b6s3NJYqj3v8G31dQN1dsQ9MeJG8RBzi2YNOvS6YLR/mDMuvdLqF1K0X
         BVwyaS3i4jksIZAjmHGO8EDu1Lu2KmgLqG+U5W/L6xzZEZxRvQ65R9Fl4igyxDLt6Kjy
         j0bekH+ED+KC3/HCIxm4xHD+4eYtSPFC1dgMgKTEKJYjVC6CvyGte4wER5oCg+jPK33r
         +SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14MWY7FxRwnQutUs+zh69CIdA1BWO6PiV3sNHAuLuPs=;
        b=eJdMStl2PkTsvdfxHeqPdCtgNI5W6EenzuiYCii501R6KNmuzk8EA543V5xNGCpiOJ
         EoP+LGNi6xRveN+sSe2UmU8JO+7vtuaFr7CfYPxb871dzD3SL87xTCaO7qpfoqtunojV
         dSc+sOstq/FNghUjqJZqJmOWA7ZTg3t4IY5FuGxzTTUTuyQRSW8V0SwjvS21Rof+OOvY
         Oi+1afKtdTVIiSd5o1n+zhOeD8pQklp7jXHrMWClB0Iw/J8uyqqoQSeJzj+kaPOyy445
         lsRK+EhWPVWLiNwv9Mg/v6fbJmV0SEvMB3E44ZrWnTCL+bjqRjywYNq7TE/hhAsnreS6
         hHCA==
X-Gm-Message-State: AOAM532ROg0l0SD7Q7lzUQ5u5PgAp1I05YDOFE/qSPqMy6OKeXjg/rEg
        uUO7rA1t3aFxU+2F3GRQEP0=
X-Google-Smtp-Source: ABdhPJwK+aRUk80ELbG03duoE+r6acVzhHuBHmMjM+hmB39SYah+Xb73IO+wi36ssgE+dt7PGBb1Wg==
X-Received: by 2002:a63:194e:0:b0:372:c757:c569 with SMTP id 14-20020a63194e000000b00372c757c569mr5143715pgz.516.1648625565471;
        Wed, 30 Mar 2022 00:32:45 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.55])
        by smtp.gmail.com with ESMTPSA id u62-20020a638541000000b00382791c89efsm18172530pgd.13.2022.03.30.00.32.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Mar 2022 00:32:44 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Teng Long
Date:   Wed, 30 Mar 2022 15:32:30 +0800
Message-Id: <20220330073230.61358-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.580.ge94251479c.dirty
In-Reply-To: <YkPGq0mDL4NG6D1o@nand.local>
References: <YkPGq0mDL4NG6D1o@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 29 Mar 2022 22:55:39 -0400, Taylor Blau wrote:

> You're right; open_pack_bitmap_1() doesn't need to care about whether or
> not bitmap_git->midx is or isn't non-NULL, since:
> 
>   - if we did open a MIDX bitmap (which we will always attempt first
>     before trying to open single-pack bitmaps), then we won't even
>     bother to call open_pack_bitmap() at all.
> 
>   - if we _do_ end up within open_pack_bitmap_1(), then we _know_ that
>     no MIDX bitmap could be found/opened, so there is no need to check
>     in that case, either.
> 
> So I think we realistically could do something like:
> 
> --- 8< ---
> 
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 97909d48da..6e7c89826d 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -387,3 +387,3 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
> 
> -  if (bitmap_git->pack || bitmap_git->midx) {
> +  if (bitmap_git->pack) {
>       /* ignore extra bitmap file; we can only handle one */
> 
> --- >8 ---
> ...but having the conditional there from the pre-image doesn't hurt,
> either, and it makes the error clearer in case of an accidental
> regression where we start looking for single-pack bitmaps after
> successfully opening a multi-pack one.

I agree with the "accidental regression", it's a protection without
any disadvantages so far. So, if we don't remove the "bitmap_git->midx"
condition for some robust reason, then I think maybe we can let the
warning more detailed if the "accident" happens, like:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 91a6be358d..e64a85bc59 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -333,7 +333,15 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
                struct strbuf buf = STRBUF_INIT;
                get_midx_filename(&buf, midx->object_dir);
                /* ignore extra bitmap file; we can only handle one */
-               warning("ignoring extra bitmap file: %s", buf.buf);
+               warning("%signoring extra bitmap file: %s",
+                       bitmap_git->pack ?
+                               xstrfmt("A non-MIDX bitmap has been opened: %s, ",
+                                       bitmap_git->pack->pack_name) :
+                       bitmap_git->midx ?
+                               xstrfmt("A MIDX bitmap has been opened : %s, ",
+                                       midx_bitmap_filename(bitmap_git->midx)) :
+                                     "",
+                       buf.buf);
                close(fd);
                strbuf_release(&buf);
                return -1;
@@ -398,9 +406,17 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
                return -1;
        }
 
-       if (bitmap_git->pack) {
+       if (bitmap_git->pack || bitmap_git->midx) {
                /* ignore extra bitmap file; we can only handle one */
-               warning("ignoring extra bitmap file: %s", packfile->pack_name);
+               warning("%signoring extra bitmap file: %s",
+                       bitmap_git->pack ?
+                               xstrfmt("A non-MIDX bitmap has been opened: %s, ",
+                                       bitmap_git->pack->pack_name) :
+                       bitmap_git->midx ?
+                               xstrfmt("A MIDX bitmap has been opened : %s, ",
+                                       midx_bitmap_filename(bitmap_git->midx)) :
+                                     "",
+                       packfile->pack_name);
                close(fd);
                return -1;
        }
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f775fc1ce6..a962f6861f 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -421,6 +421,7 @@ test_expect_success 'complains about multiple pack bitmaps' '
                test_line_count = 2 bitmaps &&
 
                git rev-list --use-bitmap-index HEAD 2>err &&
+               grep "A non-MIDX bitmap has been opened" err &&
                grep "ignoring extra bitmap file" err
        )


Does that make sense to you? 

And also I look codes in "open_midx_bitmap_1()", it's really nice for me to read and
understand, but the "char *idx_name = ..." declaration made me a litte confusing at
the beginning, I think maybe it's better to name it as "bitmap_name" for it, I know
bitmap is also a kind of index structure for using, but when I saw "idx", it brings
me to the ".idx" or "multi-pack-index" like files naturally in git context, of course
this is not a problem and maybe it's just me.
