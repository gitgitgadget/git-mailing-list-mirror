Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D6A1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfIPUqY (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 16:46:24 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46907 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfIPUqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:46:24 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46XJDt4xl8z5tlC;
        Mon, 16 Sep 2019 22:46:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BEFEC10A;
        Mon, 16 Sep 2019 22:46:21 +0200 (CEST)
Subject: [PATCH v2 1/2] diff, log doc: say "patch text" instead of "patches"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <fac55175-dc1e-addf-194b-97aaf6a33e3b@kdbg.org>
 <CAN0heSoaYf0_2FhKQNnswLvFppu=dyBcKGYB_Jd=uF70yjNiCQ@mail.gmail.com>
 <xmqqv9ts9fox.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <76602d23-f2b2-4a15-21ad-7bd91a4b5e44@kdbg.org>
Date:   Mon, 16 Sep 2019 22:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9ts9fox.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.09.19 um 21:58 schrieb Junio C Hamano:
> I wonder if the result becomes even clearer if we dropped "instead
> of the usual output".  It is a given that presence of an option
> would change the behaviour, so "instead of the usual" does not add
> any value in the context of the explanation we are giving.

Agreed.

> Also I question the value of the "running git diff without --raw
> option" sentence; "diff --stat" is also a way to suppress the patch
> text and see only the overview; I know it is not a new problem this
> patch introduces, but the objective of this patch is clarify about
> the generation of output in patch format, so...

You have a point here, too.

Below is v2 of just patch 1/2. 2/2 remains unchanged. I've added
git-show to the enumeration.

--- 8< ---
diff, log doc: say "patch text" instead of "patches"

A poster on Stackoverflow was confused that the documentation of git-log
promised to generate "patches" or "patch files" with -p, but there were
none to be found. Rewrite the corresponding paragraph to talk about
"patch text" to avoid the confusion.

Shorten the language to say "X does Y" in place of "X does not Z, but Y".

Cross-reference the referred-to commands like the rest of the file does.

Enumerate git-show because it includes the description as well.

Mention porcelain commands before plumbing commands because I guess that
the paragraph is read more frequently in their context.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Documentation/diff-generate-patch.txt | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index f10ca410ad..c482c94e6b 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -1,11 +1,15 @@
-Generating patches with -p
---------------------------
-
-When "git-diff-index", "git-diff-tree", or "git-diff-files" are run
-with a `-p` option, "git diff" without the `--raw` option, or
-"git log" with the "-p" option, they
-do not produce the output described above; instead they produce a
-patch file.  You can customize the creation of such patches via the
+Generating patch text with -p
+-----------------------------
+
+Running
+linkgit:git-diff[1],
+linkgit:git-log[1],
+linkgit:git-show[1],
+linkgit:git-diff-index[1],
+linkgit:git-diff-tree[1], or
+linkgit:git-diff-files[1]
+with the `-p` option produces patch text.
+You can customize the creation of patch text via the
 `GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables.
 
 What the -p option produces is slightly different from the traditional
-- 
2.23.0.95.gcfbaf7d16f
