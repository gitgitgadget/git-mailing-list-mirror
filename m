Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6BB1F404
	for <e@80x24.org>; Sat, 13 Jan 2018 22:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753675AbeAMWfB (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 17:35:01 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37383 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbeAMWfB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 17:35:01 -0500
Received: by mail-wr0-f196.google.com with SMTP id f8so8325210wre.4
        for <git@vger.kernel.org>; Sat, 13 Jan 2018 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ANwXCXjK78TCrnaTt0syCLvx1VBNISqjRO/GoWRedEg=;
        b=KPAjwXx+7DID3jK5H6yzThg+FkN4KnvrCkF+6fyLx6Crnqrvqt1vmcQNwchOVWXQM5
         XDtYmmEJ7SmUoo+3dm5W005POVfkzAAnG+5qN2G+TedICb41vRkv4zM4I3GzPAIggaux
         jL9/wdPT2n7ewqKm3pXFb5rqAPhPiQYvaytaUYpuCJpot6UzeNeJ6SYeI8vp7ume7vp3
         /+gErf9zBNLPfQuUpCxynlKGNXSBS9EL1wgWFeYjPwCuAZWkacYv7vV2j4RSC6FdfCXl
         iXRpaJw1XCnelodgxD9f+blHLD2FqhhNyjsAfPgvHpeWubhIifRpith16l235acApPXf
         t8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANwXCXjK78TCrnaTt0syCLvx1VBNISqjRO/GoWRedEg=;
        b=I8ZF/xDo3MOg8RakRWJeDLOBbYAoDT6hw5fNRidQoHoA5eBtYopD3bcwf6SFuvJaSm
         L/mJjREzKxvqFtmudYSGVkKMSjnNvQw7fKdPlt3z+JMdFGsXnfzIpb9WOJgxb4GxKnzT
         d7VsbwXO1USW7On2IQI2M1fnLXzZMg5vU1QhgCD4wkWxbJflAt+LJnaT3WHow7B+iRwL
         swIyt2RvD/+Vg70lrRcAOIUI7bbP7Gvtg61iJ2hJQ/scCRrOaooGFpW2YyHp0WxOCFDm
         NedEjspnba5O71mEUeZZI+aLeYUbZZCboyZmfW4PVA8shSiubmLaYvVLwrWT3eYUYKSj
         HpOA==
X-Gm-Message-State: AKGB3mLU8VLEWTdIeAczjRdPVc9kbMPRKWUxmLt6gNpfm838aUxwwKmw
        PNA/26IsYrNCaWcdMWeGmLwKFs2v
X-Google-Smtp-Source: ACJfBosc9u3SOv4Mug1+8/7TX3EF34cLLSzATvtk+Pq7+G+2JeSCmIN/SqHKWzJuiG77FEwfWWictA==
X-Received: by 10.223.155.131 with SMTP id d3mr25933449wrc.134.1515882899933;
        Sat, 13 Jan 2018 14:34:59 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v195sm3183196wmf.25.2018.01.13.14.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Jan 2018 14:34:58 -0800 (PST)
Date:   Sat, 13 Jan 2018 22:37:15 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 4/3] read-cache: don't try to write index if we can't
 write shared index
Message-ID: <20180113223715.GJ2641@hank>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180107223015.17720-1-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a0a967568e ("update-index --split-index: do not split if $GIT_DIR is
read only", 2014-06-13), we tried to make sure we can still write an
index, even if the shared index can not be written.

We did so by just calling 'do_write_locked_index()' from
'write_shared_index()'.  'do_write_locked_index()' always at least
closes the tempfile nowadays, and used to close or commit the lockfile
if COMMIT_LOCK or CLOSE_LOCK were given at the time this feature was
introduced.  COMMIT_LOCK or CLOSE_LOCK is passed in by most callers of
'write_locked_index()'.

After calling 'write_shared_index()', we call 'write_split_index()',
which calls 'do_write_locked_index()' again, which then tries to use the
closed lockfile again, but in fact fails to do so as it's already
closed.

In the current version, git will in fact segfault if it can't create a
new file in $gitdir, and this feature seems to never have worked in the
first place.

Ever since introducing the split index feature, nobody has complained
about this failing, and it really just papers over repositories that
will sooner or later need fixing anyway.

Therefore just make being unable to write the split index a proper
error, and have users fix their repositories instead of trying (but
failing) to paper over the error.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d13ce83794..a9c8facdfd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2471,18 +2471,15 @@ static int clean_shared_index_files(const char *current_hex)
 	return 0;
 }
 
-static int write_shared_index(struct index_state *istate,
-			      struct lock_file *lock, unsigned flags)
+static int write_shared_index(struct index_state *istate)
 {
 	struct tempfile *temp;
 	struct split_index *si = istate->split_index;
 	int ret;
 
 	temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
-	if (!temp) {
-		hashclr(si->base_sha1);
-		return do_write_locked_index(istate, lock, flags);
-	}
+	if (!temp)
+		return error("cannot create new shared index");
 	move_cache_to_base_index(istate);
 	ret = do_write_index(si->base, temp, 1);
 	if (ret) {
@@ -2565,7 +2562,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	new_shared_index = istate->cache_changed & SPLIT_INDEX_ORDERED;
 
 	if (new_shared_index) {
-		ret = write_shared_index(istate, lock, flags);
+		ret = write_shared_index(istate);
 		if (ret)
 			goto out;
 	}
-- 
2.16.0.rc2.280.g09355b536d

