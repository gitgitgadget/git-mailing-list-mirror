Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2761F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 10:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392219AbfJPKFy (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 06:05:54 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:58805 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389948AbfJPKFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 06:05:53 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 06:05:52 EDT
Received: from localhost.localdomain ([92.7.169.237])
        by smtp.talktalk.net with SMTP
        id Kg3qiFlRmdraxKg3qi41dx; Wed, 16 Oct 2019 10:57:43 +0100
X-Originating-IP: [92.7.169.237]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=tcYJKHXJF8zWhnf8ZoLugA==:117
 a=tcYJKHXJF8zWhnf8ZoLugA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10
 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=PKzvZo6CAAAA:8 a=DW29gNylpxWPYbZ9eGUA:9
 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22 a=q92HNjYiIAC_jH7JDaYf:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=UDnyf2zBuKT2w-IlGP_r:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2] Doc: Bundle file usage
Date:   Wed, 16 Oct 2019 10:57:37 +0100
Message-Id: <20191016095737.1588-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.23.0.windows.1.21.g947f504ebe8.dirty
In-Reply-To: <7vzk4mj38g.fsf@alter.siamese.dyndns.org>
References: <7vzk4mj38g.fsf@alter.siamese.dyndns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAt1PWmiOuJIRTf+T9oGdfZkE3HvJrs5Dv6BlDpgfzZmF5m1TxNoxImouka0AIXOMIPI9W6ZRR7iyt/LYAAbQebGWfOQo5nNhyl1DofUOoA6cDboSEU2
 L0SKFJOSYkCcbCNOh5PVoOH7FLXdVR7wJ6rsCaNbLcONWr6kybdvIec5bwPZmthNHQKynXI2gTOQ9XNbJ8eSsy7CDsOBLSDkEzGg10FjCYedFrzypxavC64k
 WySxZ26/Tv+8VzHomC73NjNFxPExUUnoctnYP8PQu8JwFNXT9RB0cYp/q/MHO37a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

Git URLs can accept bundle files for fetch, pull and clone, include
in that section. Include git clone in the bundle usage description.
Correct the quoting of <git-rev-list-args>.
Detail the <git-rev-list-args> options for cloning a complete repo.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---

This takes up the advice from peff in 
https://public-inbox.org/git/20191011161112.GA19741@sigill.intra.peff.net/
from the original v1 in 2012(!)
https://public-inbox.org/git/1348010734-664-2-git-send-email-philipoakley@iee.org/

Hopefully this covers Junio's concerns from that time.
-- 
Philip

---
 Documentation/git-bundle.txt | 10 +++++++---
 Documentation/urls.txt       |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 7d6c9dcd17..0498e4895d 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -21,9 +21,9 @@ Some workflows require that one or more branches of development on one
 machine be replicated on another machine, but the two machines cannot
 be directly connected, and therefore the interactive Git protocols (git,
 ssh, http) cannot be used.  This command provides support for
-'git fetch' and 'git pull' to operate by packaging objects and references
+'git fetch' and 'git pull' and 'git clone', to operate by packaging objects and references
 in an archive at the originating machine, then importing those into
-another repository using 'git fetch' and 'git pull'
+another repository using 'git fetch' and 'git pull' or 'git clone',
 after moving the archive by some means (e.g., by sneakernet).  As no
 direct connection between the repositories exists, the user must specify a
 basis for the bundle that is held by the destination repository: the
@@ -35,7 +35,7 @@ OPTIONS
 
 create <file>::
 	Used to create a bundle named 'file'.  This requires the
-	'git-rev-list-args' arguments to define the bundle contents.
+	'<git-rev-list-args>' arguments to define the bundle contents.
 
 verify <file>::
 	Used to check that a bundle file is valid and will apply
@@ -92,6 +92,10 @@ It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
+To create a bundle for 'git clone', use `--branches --tags` for
+the <git-rev-list-args>. The (inappropriate) use of `--all` would include
+refs from refs/remotes/* hierarchy in the resulting bundle.
+
 EXAMPLES
 --------
 
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index bc354fe2dc..1c229d7581 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -53,6 +53,9 @@ These two syntaxes are mostly equivalent, except the former implies
 --local option.
 endif::git-clone[]
 
+'git clone', 'git fetch' and 'git pull', but not 'git push', will also
+accept a suitable bundle file. See linkgit:git-bundle[1].
+
 When Git doesn't know how to handle a certain transport protocol, it
 attempts to use the 'remote-<transport>' remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
-- 
2.23.0.windows.1.21.g947f504ebe8.dirty

