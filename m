Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB411F406
	for <e@80x24.org>; Tue, 26 Dec 2017 02:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdLZCL5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 21:11:57 -0500
Received: from mail-pl0-f48.google.com ([209.85.160.48]:37070 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbdLZCL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 21:11:56 -0500
Received: by mail-pl0-f48.google.com with SMTP id s3so17203713plp.4
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 18:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dhHNl8lOz+4dwlU32Ip9uIfnMgjxNEkcEgbsS+TWJtA=;
        b=XInRURluO3KoEbD3Dijyl1L2wrJhrIYFl439k3/DBO+LhMNMnASar4bCr8vLGpaRnZ
         jQqRJfQ/mYIDJbKmALiIkH+ReRid6M4QmvoZSKh+UnBOfJCJiy5I22XYfcHSakkBkBWE
         EGKHO2WWkeHo177qhb5GH5LugUv3WMVgn9vUERyUHtGo1HHand8Dx2XCPklgirM9uO1V
         yc6i5Kkit6QaBmBZ4ZPNZHqZuGLoaHa9x9DhkWHWoADq6rwjc+erXkGIAcibse4rEDGR
         W0uNxJ5iBQzi/6Nk0y7//ct9G4h+exFKigqRqkG9tGMhTzNUJ5fsGPvJq/QYtjgxwrQR
         7/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhHNl8lOz+4dwlU32Ip9uIfnMgjxNEkcEgbsS+TWJtA=;
        b=iHtJ9SfPtdRzKP0WROCSFrlA4AfUKX63SG2GHqtzAoeiRxWEecqy0Ae8sl/W6k1sco
         ZeogIatrYPwpWTgNQRIFRIHfJSmPkrfZh/gno7R8qchlq8V5ZDfA7FOI5Ef2jygpC5WD
         nfR3snBvBBhVBqaVVpJHV6nlV1MC8U2sRURkiWbmS6RwQlZUdXZegf0dSdwZvDCyDow+
         /9orOpXpV+p5jP2UGoUNnvt8ODTa5vlZl2DUu1nfhBUoO7zuZ67QGKdoyLmL75qnjgcC
         CcpZ6M7esZa1but7wcXpC628qthq9EQvoyQPK22DfAkLCHx1X4xy5Ib6ZaWZaZg0x/3C
         IgGw==
X-Gm-Message-State: AKGB3mLB1FiM56y4TZDe1+eEKLSsq7qaSeRmFJ161VIYk1b9T+GNBYM0
        x0U0CBOfOtYD7HSAyRLqUCbL3A==
X-Google-Smtp-Source: ACJfBovDQtqBVzSN54gFJ9/hfZZHh8Z1t32odub+nJv+MXu0tTsq5yEu/IDdPgIvB4pNtEm5aiFxHg==
X-Received: by 10.159.246.20 with SMTP id b20mr23436018pls.95.1514254315766;
        Mon, 25 Dec 2017 18:11:55 -0800 (PST)
Received: from duynguyen.vn.dektech.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id k9sm46446634pgo.53.2017.12.25.18.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 18:11:55 -0800 (PST)
Date:   Tue, 26 Dec 2017 09:11:50 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     alexmv@dropbox.com, git@vger.kernel.org
Subject: Re: [PATCH] status: handle worktree renames
Message-ID: <20171226021150.GA10059@duynguyen.vn.dektech.internal>
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
 <20171225103718.24443-1-pclouds@gmail.com>
 <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 07:26:27PM +0100, Igor Djordjevic wrote:
> But I`ve noticed that "--porcelain=v2" output might still be buggy -
> this is what having both files staged shows:
>
>     $ git status --porcelain=v2
>     2 R. N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 R100 new-file	original-file
>
> ..., where having old/deleted file unstaged, and new/created file
> staged with `git add -N` shows this:
>
>     $ git status --porcelain=v2
>     1 .R N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 new-file
>
> So even though unstaged value is correctly recognized as "R" (renamed),
> first number is "1" (instead of "2" to signal rename/copy), and both
> rename score and original file name are missing.
>
> Not sure if this is a bug, but it seems so, as `git status` "Porcelain
> Format Version 2"[1] says the last path is "pathname in the commit at
> HEAD" (in case of copy/rename), which is missing here.

Yeah v2 looks problematic. The way the document is written, it's not
prepared to deal with a rename pair coming from comparing the index
(with intent-to-add entries) with worktree, only from comparing with
HEAD. So either we could ajust v2 semantics slightly like this

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 81cab9aefb..3da10020aa 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -309,13 +309,13 @@ Renamed or copied entries have the following format:
 		of similarity between the source and target of the
 		move or copy). For example "R100" or "C75".
     <path>      The pathname.  In a renamed/copied entry, this
-		is the path in the index and in the working tree.
+		is the path in the index.
     <sep>       When the `-z` option is used, the 2 pathnames are separated
 		with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
 		byte separates them.
-    <origPath>  The pathname in the commit at HEAD.  This is only
-		present in a renamed/copied entry, and tells
-		where the renamed/copied contents came from.
+    <origPath>  The pathname in the commit at HEAD or in the worktree.
+		This is only present in a renamed/copied entry, and
+		tells where the renamed/copied contents came from.
     --------------------------------------------------------
 
 Unmerged entries have the following format; the first character is

The problem is, you cannot know if it's a rename from HEAD or from
worktree with this updated v2 (or perhaps you could because HEAD name
should be all zero?).

Or we disable rename-from-worktree when porcelain v2 is requested (and
optionally introduce v3 to support it). Jeff, any preference?
--
Duy
