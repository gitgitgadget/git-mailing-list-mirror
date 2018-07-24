Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AB51F597
	for <e@80x24.org>; Tue, 24 Jul 2018 15:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbeGXQUi (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 12:20:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32857 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbeGXQUh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 12:20:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id u14-v6so3249262lfu.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cefd63r35x2ZT/Kgu9TWpWSyYFSA9Q4Py6Qf8Yg1D+M=;
        b=Im0dmumr7jm2B99o64X5nxk/AGfvb+D7vY8TMRaavdfT+X/8awK860DlF7FKP82os2
         r7yUYNIdTeJBUkBdKrnL6vNmSFyWqkVCsGRW+kmSbTOjIhLqt0sE4zgQJJzrv2/+Xl6w
         MGXj5BpwOScHx53Z9UL+qH84rzpLY+C92h5HrRvEazEwuyfliz2zlyR+wNAy4BrJQb8S
         ICz6wiIzMBQkn4KWt6VvZWztpJK4ufhOzD4IrAPnS7Fy0f0h5x9rtUHs/rUZ5rm5zZ7m
         H/LRQE20Mi5UH/S/xy4b+0jdqzGJFkrYn2H47n5jmOGn5DcFdwMiagw/MwtthU5V5dTA
         hsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cefd63r35x2ZT/Kgu9TWpWSyYFSA9Q4Py6Qf8Yg1D+M=;
        b=ZoqnoXF1P2PjLA4IWbvVSXv65sRVBKwlN/TJgUvI0bJlIAnEdq7z0++C4mVyfruas+
         dgn2YZ21CT67U5GB/BJjypTs8C4IkPpDkNByTOzRznzKJPUCO/Q48kM+dlbSfU2JvMsq
         /7DNxKN550lPP1NI5h08NpdwPDgpEFsd4CkpMAKoMUsGJmkpJ5dZNOprfzR2MMYD9dKq
         lbD8StZXqniT7GGNveuJvDMj7qoBsEC7k4ncj2ZUHODOfBudcq+P6UBtzyO39f2S0T7+
         DgY6Njfw0cWXYDrsp0vIHwLQzNA0LQxeizuCJmNWKKdXJBD1OEYTL+buQp8KZOidX/zf
         kJQg==
X-Gm-Message-State: AOUpUlGTtmkxSIdgFxvbM5S7EtmXZ3e2p35o8YQtALkBOBnllWGa+Onw
        FKCU89G05+L9esaNjd6/DIQ=
X-Google-Smtp-Source: AAOMgpclyy+X6IopcwSQMNTM28On3xvXziPxWEjv6iDL88MyOvUImsC0Z9m4F4G1lHUZPWULzNqY6w==
X-Received: by 2002:a19:a685:: with SMTP id p127-v6mr11034932lfe.4.1532445219412;
        Tue, 24 Jul 2018 08:13:39 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h16-v6sm2328998ljh.26.2018.07.24.08.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 08:13:38 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:13:36 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
Message-ID: <20180724151336.GA1957@duynguyen.home>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 04:51:38PM -0400, Ben Peart wrote:
> >>> What's the current state of the index before this checkout?
> >>
> >> This was after running "git checkout" multiple times so there was really
> >> nothing for git to do.
> > 
> > Hmm.. this means cache-tree is fully valid, unless you have changes in
> > index. We're quite aggressive in repairing cache-tree since aecf567cbf
> > (cache-tree: create/update cache-tree on checkout - 2014-07-05). If we
> > have very good cache-tree records and still spend 33s on
> > traverse_trees, maybe there's something else.
> > 
> 
> I'm not at all familiar with the cache-tree and couldn't find any 
> documentation on it other than index-format.txt which says "it helps 
> speed up tree object generation for a new commit."

I guess you have the starting points you need after Jeff's and Junio's
explanation (and it would be great if cache-tree could actually be for
for this two-way merge). But to make it easier for new people in
future, maybe we should add this?

This is basically a ripoff of Junio's explanation with starting points
(write-tree and index-format.txt). I wanted to incorporate some pieces
from Jeff's too but I think Junio's already covered it well.

-- 8< --
Subject: [PATCH] cache-tree.h: more description of what it is and what's it used for

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/cache-tree.h b/cache-tree.h
index cfd5328cc9..d25a800a72 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -5,6 +5,35 @@
 #include "tree.h"
 #include "tree-walk.h"
 
+/*
+ * cache-tree is an index extension that records tree object names for
+ * subdirectories you see in the index. It is mainly used for
+ * generating trees from the index before you create a new commit (see
+ * builtin/write-tree.c as starting point) but it's also used in "git
+ * diff-index --cached $TREE" as an optimization. See index-format.txt
+ * for on-disk format.
+ *
+ * Every time you write the contents of the index as a tree object, we
+ * need to collect the object name for each top-level paths and write
+ * a new top-level tree object out, after doing the same recursively
+ * for any modified subdirectory. Whenever you add, remove or modify a
+ * path in the index, the cache-tree entry for enclosing directories
+ * are invalidated, so a cache-tree entry that is still valid means
+ * that all the paths in the index under that directory match the
+ * contents of the tree object that the cache-tree entry holds.
+ *
+ * And that property is used by "diff-index --cached $TREE" that is
+ * run internally.  When we find that the subdirectory "D"'s
+ * cache-tree entry is valid in the index, and the tree object
+ * recorded in the cache-tree for that subdirectory matches the
+ * subtree D in the tree object $TREE, then "diff-index --cached"
+ * ignores the entire subdirectory D (which saves relatively little in
+ * the index as it only needs to scan what is already in the memory
+ * forward, but on the $TREE traversal side, it does not have to even
+ * open a subtree, that can save a lot), and with a well-populated
+ * cache-tree, it can save a significant processing.
+ */
+
 struct cache_tree;
 struct cache_tree_sub {
 	struct cache_tree *cache_tree;
-- 
2.18.0.656.gda699b98b3

-- 8< --
