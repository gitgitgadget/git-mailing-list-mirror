Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F2061F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbeKTH24 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:28:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44925 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbeKTH24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 02:28:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so27369731lji.11
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 13:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kQw/9gsfObsi1xU5d8zkOjQx3yT4j56ieoxcmVYafXY=;
        b=ujJiDHaOJoOU3Na347R95rResK+/HK53TUNGf52vgFmWv9Z5IXK8bLLd+a4X880TrB
         zAo4d/FNy0id2dqWlf9raC/ftAkwpFerf0Oh0marReP5Dz/GQdaMxvTeReox3vEZzpXN
         6+7pqjaGOOkAMOWnEm5+Engl4tAIzLlfUEsenwpYKGoT3j3VQqpSoJyOPsYSauUez+Q0
         JeRDL+3E1uAmSlVjly7sMu0qPssbV63EA2+373YNUp6D6mQtopMdzwakgykhwKsA6UBR
         rZlJtS14trPff8G+ypq6IqomF/i0D/Dn1yozoPKwfpVnTDYjThMpjIaoMft1J/VsRm7r
         N/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQw/9gsfObsi1xU5d8zkOjQx3yT4j56ieoxcmVYafXY=;
        b=Q3HlSb2FU8lBDwt1QnEy12bRpBf9RcTEx1BDYzPyutIV+6CQJ6A1y+ZRP9RXGXJMeO
         bDcS5kKsqOm97JsdOiozBJPkeIdjkuGbFhQwr6fY0lYWz1sr8PUhbRgofoLz1n6VH5oO
         krv3IoykmLY9H2BzPy1PziAr8BFvzAHmXcupRTSlZewruU+/Rmf23IWeIxKqAmRwvEdh
         Xy0fbA5A7AeIm7Ntcvyz65GEN9oGCV6R0jUVvu9vLo9LOvYMcrvVshfN8/SJlwKwgfqR
         PdvShcz5rlAMMdoYC/VzNDRfydWl5O4Op0e5dIgOQk22c0Jw9KBKcZr7HG8UCTWLlrtq
         VK6g==
X-Gm-Message-State: AA+aEWZRhU39Qq/WK569wTy9D04xtqcVVdFLS7j9rPSAyb73OFGwLT3h
        qagO/iu7ZiK+FPPSiB7AFPQ=
X-Google-Smtp-Source: AFSGD/XMZF0vmkDVnasiY0hpENWqGqbgKl0veDK6V+7hUIS4l06ENJyztZErKmdm9qFxo0S016vLbg==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr1618565ljj.95.1542661407171;
        Mon, 19 Nov 2018 13:03:27 -0800 (PST)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p91sm5047608lfg.4.2018.11.19.13.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:03:26 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:03:24 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20181119210323.GA31963@duynguyen.home>
References: <20180817161645.28249-1-pclouds@gmail.com>
 <20181119082015.77553-1-carenas@gmail.com>
 <37b7a395-3846-6664-9c4d-66d2e4277618@web.de>
 <CAPUEsphrYOV64m08JY_tsVuJ-uwTv=o=m5LdCFOWd+8tWJP54A@mail.gmail.com>
 <CACsJy8A_c-O5DrZnMvEbsSa+YzatiLH3TLAy3OV1+AwY5rrCjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8A_c-O5DrZnMvEbsSa+YzatiLH3TLAy3OV1+AwY5rrCjQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, Ramsay, it would be great if you could test the below
patch and see if it works on Cygwin. I assume since Cygwin shares the
underlying filesystem, it will share the same "no trusting inode"
issue with native builds (or it calculates inodes anyway using some
other source?).

Back to the APFS problem...

On Mon, Nov 19, 2018 at 07:24:26PM +0100, Duy Nguyen wrote:
> Could you send me the "index" file in  t/trash\
> directory.t5601-clone/icasefs/bogus/.git/index ? Also the output of
> "stat /path/to/icase/bogus/x"
> 
> My only explanation is somehow the inode value we save is not the same
> one on disk, which is weird and could even cause other problems. I'd
> like to know why this happens before trying to fix anything.

Thanks Carlo for the file and "stat" output. The problem is APFS has
64-bit inode (according to the Internet) while we store inodes as
32-bit, so it's truncated. Which means this comparison

    sd_ino == st_ino

is never true because sd_ino is truncated (0x2121063) while st_ino is
not (0x202121063).

Carlo, it would be great if you could test this patch also with
APFS. It should fix problem. We will have to deal with the same
truncated inode elsewhere to make sure we index refresh performance
does not degrade on APFS. But that's a separate problem. Thank you for
bringing this up.

-- 8< --
diff --git a/entry.c b/entry.c
index 5d136c5d55..809d3e2ba7 100644
--- a/entry.c
+++ b/entry.c
@@ -404,13 +404,13 @@ static void mark_colliding_entries(const struct checkout *state,
 {
 	int i, trust_ino = check_stat;
 
-#if defined(GIT_WINDOWS_NATIVE)
+#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
 	trust_ino = 0;
 #endif
 
 	ce->ce_flags |= CE_MATCHED;
 
-	for (i = 0; i < state->istate->cache_nr; i++) {
+	for (i = 0; i < trust_ino && state->istate->cache_nr; i++) {
 		struct cache_entry *dup = state->istate->cache[i];
 
 		if (dup == ce)
@@ -419,10 +419,24 @@ static void mark_colliding_entries(const struct checkout *state,
 		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
 			continue;
 
-		if ((trust_ino && dup->ce_stat_data.sd_ino == st->st_ino) ||
-		    (!trust_ino && !fspathcmp(ce->name, dup->name))) {
+		if (dup->ce_stat_data.sd_ino == (unsigned int)st->st_ino) {
 			dup->ce_flags |= CE_MATCHED;
+			return;
+		}
+	}
+
+	for (i = 0; i < state->istate->cache_nr; i++) {
+		struct cache_entry *dup = state->istate->cache[i];
+
+		if (dup == ce)
 			break;
+
+		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
+			continue;
+
+		if (!fspathcmp(ce->name, dup->name)) {
+			dup->ce_flags |= CE_MATCHED;
+			return;
 		}
 	}
 }
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index f1a49e94f5..c28d51bd59 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -628,7 +628,7 @@ test_expect_success 'clone on case-insensitive fs' '
 	)
 '
 
-test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '
+test_expect_success !MINGW,CASE_INSENSITIVE_FS 'colliding file detection' '
 	grep X icasefs/warning &&
 	grep x icasefs/warning &&
 	test_i18ngrep "the following paths have collided" icasefs/warning
-- 8< --
