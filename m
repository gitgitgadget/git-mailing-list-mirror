Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8641F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 20:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405717AbfJRUbE (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 16:31:04 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:35244 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfJRUbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 16:31:03 -0400
Received: from localhost.localdomain ([92.30.121.54])
        by smtp.talktalk.net with SMTP
        id LYtmijcQ9nuQZLYtoirrGR; Fri, 18 Oct 2019 21:31:01 +0100
X-Originating-IP: [92.30.121.54]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=/cLN2YrzNMz5fcHgWq8JfQ==:117
 a=/cLN2YrzNMz5fcHgWq8JfQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10
 a=DW29gNylpxWPYbZ9eGUA:9 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4] Doc: Bundle file usage
Date:   Fri, 18 Oct 2019 21:30:52 +0100
Message-Id: <20191018203052.2451-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.23.0.windows.1.21.g947f504ebe8.dirty
In-Reply-To: <68ef6ca5-0baf-fa30-ce0d-138a41620da6@iee.email>
References: <68ef6ca5-0baf-fa30-ce0d-138a41620da6@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOAdVO17uqd2qt+7G+8lYK9tESU4wTECREgvcvYnCwywVXK09z1ex/pk8csCEK01LpoYTWigItqc6WskhTKWlFE3ZsxV3oEXzfdxB9xX64L2HxkFO0uD
 wbghYoaVuOK9EyxUkDHTo3A8Z3SCwfK1X3ZCEOceM0i9F6m2mYjDtRGBnRDAPCAUIIvbiaGvkb7RFEwITnDcxGplHfQu0jDe78Udob7nfvGfM7yhwlMP4/RZ
 5tiz8dLriznNRGoYlxoS1K8Y5amgm+T18yluGJDGTz1jysDKOIfpVWa+0zc2W4To
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the command description, including paragraph spacing.

Git URLs can accept bundle files for fetch, pull and clone, include
in that section. Include git clone in the bundle usage description.
Correct the quoting of <git-rev-list-args>.

Detail the <git-rev-list-args> options for cloning a complete repo.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
The new paragraph uses the more modern back-ticks while elsewhere
the quote style is matched locally.

Author email address corrected. Thanks to Pratyush for the reminder.
---
 Documentation/git-bundle.txt | 23 +++++++++++++++++------
 Documentation/urls.txt       |  3 +++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 7d6c9dcd17..a441a13d58 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -20,11 +20,14 @@ DESCRIPTION
 Some workflows require that one or more branches of development on one
 machine be replicated on another machine, but the two machines cannot
 be directly connected, and therefore the interactive Git protocols (git,
-ssh, http) cannot be used.  This command provides support for
-'git fetch' and 'git pull' to operate by packaging objects and references
-in an archive at the originating machine, then importing those into
-another repository using 'git fetch' and 'git pull'
-after moving the archive by some means (e.g., by sneakernet).  As no
+ssh, http) cannot be used.
+
+The 'git bundle' command packages objects and references in an archive
+at the originating machine, which can then be imported into another
+repository using 'git fetch', 'git pull', or 'git clone',
+after moving the archive by some means (e.g., by sneakernet).
+
+As no
 direct connection between the repositories exists, the user must specify a
 basis for the bundle that is held by the destination repository: the
 bundle assumes that all objects in the basis are already in the
@@ -35,7 +38,7 @@ OPTIONS
 
 create <file>::
 	Used to create a bundle named 'file'.  This requires the
-	'git-rev-list-args' arguments to define the bundle contents.
+	'<git-rev-list-args>' arguments to define the bundle contents.
 
 verify <file>::
 	Used to check that a bundle file is valid and will apply
@@ -92,6 +95,14 @@ It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
+`git clone` can use any bundle created without negative refspecs
+(e.g., `new`, but not `old..new`).
+If you want to match `git clone --mirror`, which would clone other
+refs such as `refs/remotes/*`, use `--all`.
+If you want to provide the same set of refs that a clone directly
+from the source repository would get, use `--branches --tags` for
+the `<git-rev-list-args>`.
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

