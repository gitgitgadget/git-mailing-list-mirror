Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1041F4B5
	for <e@80x24.org>; Mon, 11 Nov 2019 23:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKKXVn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 18:21:43 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34211 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbfKKXVn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Nov 2019 18:21:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 90B695B1;
        Mon, 11 Nov 2019 18:21:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Nov 2019 18:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lastninja.net;
         h=date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9wkGUWTr9eLO849qs4xoovWqG8+
        dSXbbKFMDG1L5n/Q=; b=F6eUYUJ0GA3P0uQBKDOqcQggSo4kho3uAt+W1bDnUF3
        p9h1a12ba652O7mobNaVMZotRBYIYsnX+S+fk8y3T5YMKG0QPyyDlO6b8dkgogJ3
        7HnzezWsZYHpGqcqUCZ9vUc2bwWN5PZrZOHBb2wqWPHofrvDT9Q5Iy8vVgir3UwD
        EIjkTs17BAmmRYkRe24tPiKT6bNT1126ECMdJPB0Xi9bbIt2JiFDIkGrwZk8bbzO
        MAeAJDQE8TxgGC+9RfGvlgazCimPI5zn6uuCgUC17k+DjbsJhniAL38r5a4QA6OM
        PYhLOTnB0cSGOZa0LsHaDZgzWm2FcxHh06bSKa5qnJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9wkGUW
        Tr9eLO849qs4xoovWqG8+dSXbbKFMDG1L5n/Q=; b=dkdqYYuyM5NmPi7wRNt7qr
        kClC+BUv4mcT9nT2VU67UvnkPLYIxMakoTR048lOpv5Oq+07Uhnz6vkzXLBlfQ89
        elv3hxYsdheFJqxfqko+EWDp8bBfnkykvbJIvy9wjgiIrZ1wbW1x4BpksZk1COuq
        UlUP34CeKJjLv3JMp7V6d8vltcJGUM6CE8lkeBZDHuk2VKfCO8Jkwr+8YfUgn3FI
        Rc/u2TJ8T551vREir6aTgVQXihLJaazs1MhKtZyZkMSqgg9ILjzBqeJgFkpKglNo
        qzB0mB5jRhZRPBmjm88qYOeZ/4jcqDJjg5s8SsYeGyNkMRcOaG/RPss7aQwj2UfA
        ==
X-ME-Sender: <xms:Bu3JXdtKhTzDytJalIZyTydUALh2AbLUoaTTZPfbzz15ZRmy6CngdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddvjedgudejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesth
    dtredttdervdenucfhrhhomheppfgrvhgvvghnucfprghthhgrnhcuoehnrghvvggvnhes
    lhgrshhtnhhinhhjrgdrnhgvtheqnecukfhppedvtddvrdegrdduieehrddvheegnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnrghvvggvnheslhgrshhtnhhinhhjrgdrnhgvthen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Bu3JXR8srbQxqWyNcsIfmX-mjed-o-BY8uqaxuRtM8iOp1YVUkTQTQ>
    <xmx:Bu3JXV3yFXVOiJJyAp8EkuC7mU3m50vfEm99LAxVYuARHqsog3RrOQ>
    <xmx:Bu3JXTKMZSeLdn8BrXlxBahaiRhqtdMDdho5XSk_F2LwBVIbOtBgHg>
    <xmx:Bu3JXWxxspiuQ9VoHv87DoP1okBlnRn1XduB37I7RUfPOXy1PxZkLg>
Received: from a.local (unknown [202.4.165.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id 23C2280060
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 18:21:40 -0500 (EST)
Date:   Tue, 12 Nov 2019 10:21:37 +1100
From:   Naveen Nathan <naveen@lastninja.net>
To:     git@vger.kernel.org
Subject: [PATCH v2] doc: improve readability of --rebase-merges in git-rebase
Message-ID: <20191111232137.GA29586@a.local>
References: <20191110095942.GB6071@a.local>
 <xmqqr22ehjbg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr22ehjbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --preserve-merges was deprecated in 427c3bd28a a sentence
was introduced describing the difference between --rebase-merges and
--preserve-merges which is a little unclear and difficult to parse.
This patch improves readability while retaining original meaning.

Signed-off-by: Naveen Nathan <naveen@lastninja.net>
---
 Documentation/git-rebase.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 639a4179d1..0c4f038dd6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -443,8 +443,8 @@ the `rebase-cousins` mode is turned on, such commits are instead rebased
 onto `<upstream>` (or `<onto>`, if specified).
 +
 The `--rebase-merges` mode is similar in spirit to the deprecated
-`--preserve-merges`, but in contrast to that option works well in interactive
-rebases: commits can be reordered, inserted and dropped at will.
+`--preserve-merges` but works with interactive rebases,
+where commits can be reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
-- 
2.21.0

