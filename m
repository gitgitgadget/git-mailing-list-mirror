Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BFC77B7A
	for <git@archiver.kernel.org>; Sat, 13 May 2023 16:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjEMQ5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEMQ5J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 12:57:09 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623812D68
        for <git@vger.kernel.org>; Sat, 13 May 2023 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
        :Message-Id:Date:Subject:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=GhYNDa50KBTLn9JcSNWbK+3RVcItuU6uz7yrT0QFcjg=; b=cDgqoB
        oLOVEBMs5Hpex70lntvVOwKIA+i6JaruHprXKx6jbvkjrqgant0hDDhCzmBfWi1WzWe3v3k6EqOi6
        lDCnh6q59ciItPdXy36RZc0o5D3nIDnsnW8aaUTPhHOIUuFhBCTdPYSYD4sfYSMOBQiUSVdnIix2O
        +c+aBIuXDO4=;
Received: from 88-110-117-142.dynamic.dsl.as9105.com ([88.110.117.142] helo=localhost.localdomain)
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pxsYM-000CBr-5z;
        Sat, 13 May 2023 17:57:07 +0100
From:   Philip Oakley <philipoakley@iee.email>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, alexhenrie24@gmail.com,
        git@vger.kernel.org, newren@gmail.com, philipoakley@iee.email,
        phillip.wood123@gmail.com, tao@klerks.biz
Subject: [PATCH 1/1] doc: Glossary, describe Flattening
Date:   Sat, 13 May 2023 17:56:56 +0100
Message-Id: <20230513165657.812-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.40.0.windows.1
In-Reply-To: <xmqq5ybug8s8.fsf@gitster.g>
References: <xmqq5ybug8s8.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify the term 'flatten' and the unexpected effects that the user
may come across, such as discussed in [1] and [2].

[1] https://lore.kernel.org/git/xmqqr0ukggk5.fsf@gitster.g/

[2] https://lore.kernel.org/git/xmqq5ybug8s8.fsf@gitster.g/

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/glossary-content.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 5a537268e2..36125e503c 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -173,6 +173,19 @@ current branch integrates with) obviously do not work, as there is no
 	missing from the local <<def_object_database,object database>>,
 	and to get them, too.  See also linkgit:git-fetch[1].
 
+[[def_flatten]]flatten::
+	Flattening is a common term for the 'linearizing' of a
+	selected portion of the <<def_commit_graph_general,commit graph>>.
+	Flattening may include excluding commits, or rearranging commits,
+	for the linearized sequence.
+	In particular, linkgit:git-log[1] and linkgit:git-show[1] have a
+	range of "History Simplification" techniques that affect which
+	commits are included, and how they are linearized.
+	The default linkgit:git-rebase[1] will drop merge commits when it
+	flattens history, which also may be unexpected.
+	The two common linearization types are chronological (date-time), and
+	topological (shape) based orderings. Generation numbering is topological.
+
 [[def_file_system]]file system::
 	Linus Torvalds originally designed Git to be a user space file system,
 	i.e. the infrastructure to hold files and directories. That ensured the
-- 
2.40.0.windows.1

