Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED13C433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 16:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ2Ql0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJ2QlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 12:41:25 -0400
Received: from smtp-out-6.talktalk.net (smtp-out-6.talktalk.net [62.24.135.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A5A58B47
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 09:41:23 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id ootdodzgpnO7EooteoWf2E; Sat, 29 Oct 2022 17:41:22 +0100
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=X8gs11be c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=L21Qlja0vAKRWb0B7dUA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Subject: [PATCH v3 2/4] glossary: add "commit graph" description
Date:   Sat, 29 Oct 2022 17:41:10 +0100
Message-Id: <20221029164112.2097-3-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <20221029164112.2097-1-philipoakley@iee.email>
References: <20221022222539.2333-1-philipoakley@iee.email>
 <20221029164112.2097-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOKsCis3vDScwXOoU+93/5lVtlzNd3Dj8x6CzIUracups1vICUZRpsjtuwrIR1EK0mMVZuRy7Kv6idXopNzlr7ZO56RuNsyCvXphLtdanRddg32GaiUM
 cmF7PGytbO1myt8ofqqmM+iHG2b43QWL9zdvslSQ7n8zeKx1N+3wF6XVP93Da6sJZIUBHJoSCpvQ+l5KF7vWK/y5YuSvs0uUCOkmQcyx0zJTDMq08GEph58I
 yJQD4QtQbQBZ1RTaS7m5RqJH5x6LFJLG6hRu75rmN699TxaACh4u3e95Dm4eSAF4PFy+6iovh6iYrhiMrdlXYM2Y1B5+p/D2Bk93O1Zw2RW9qT7sT8Q+BANX
 5lXQYKv5
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git has an additional "commit graph" capability that supplements the
normal commit object's directed acyclic graph (DAG). The supplemental
commit graph file is designed for speed of access.

Describe the commit graph both from the normative DAG view point and
from the commit graph file perspective.

Also, clarify the link between the branch ref and branch tip
by linking to the `ref` glossary entry, matching this commit graph
entry.

The commit-graph file is also distinguished by its hyphenation.

Subsequent commit catches the few cases where the hyphenation of
commit-graph was missing.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/glossary-content.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 947ac49606..a526710278 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -20,7 +20,7 @@
 [[def_branch]]branch::
 	A "branch" is a line of development.  The most recent
 	<<def_commit,commit>> on a branch is referred to as the tip of
-	that branch.  The tip of the branch is referenced by a branch
+	that branch.  The tip of the branch is <<def_ref,referenced>> by a branch
 	<<def_head,head>>, which moves forward as additional development
 	is done on the branch.  A single Git
 	<<def_repository,repository>> can track an arbitrary number of
@@ -75,6 +75,21 @@ state in the Git history, by creating a new commit representing the current
 state of the <<def_index,index>> and advancing <<def_HEAD,HEAD>>
 to point at the new commit.
 
+[[def_commit_graph_general]]commit graph concept, representations and usage::
+	A synonym for the <<def_DAG,DAG>> structure formed by the commits
+	in the object database, <<def_ref,referenced>> by branch tips,
+	using their <<def_chain,chain>> of linked commits.
+	This structure is the definitive commit graph. The
+	graph can be represented in other ways, e.g. the
+	<<def_commit_graph_file,"commit-graph" file>>.
+
+[[def_commit_graph_file]]commit-graph file::
+	The "commit-graph" (normally hyphenated) file is a supplemental
+	representation of the <<def_commit_graph_general,commit graph>>
+	which accelerates commit graph walks. The "commit-graph" file is
+	stored either in the .git/objects/info directory or in the info
+	directory of an alternate object database.
+
 [[def_commit_object]]commit object::
 	An <<def_object,object>> which contains the information about a
 	particular <<def_revision,revision>>, such as <<def_parent,parents>>, committer,
-- 
2.38.1.windows.1

