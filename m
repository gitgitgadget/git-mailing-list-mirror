Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A68200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeECXBe (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:01:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:36413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbeECXBc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:01:32 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LbgyV-1eTGBD1uWJ-00lGb1; Fri, 04 May 2018 01:01:24 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH v2 4/6] sequencer: allow introducing new root commits
Date:   Fri,  4 May 2018 01:01:23 +0200
Message-Id: <0ee765bbb3627a19329d34ae3631a145653f5468.1525388472.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.38.g05ca542f78d
In-Reply-To: <cover.1525388472.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <cover.1525388472.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fYFXeXkpowWBPY0DwB3bDYc2HSaMs/TokUEYOtKYUMLh0tbzaRZ
 vBLxa2l9UKXtVx619ySS/XeL/AwQqcjcsMk8yE5cb3beaZNlY3gRH725xRF7CvRmG1Qyj2C
 1e3IKLvrau0OcSLcN04RvFHiyYNgq1WuytLNQN1bKCgFVL+FiuWBNL6u3+TLRx4Y2gaMX2L
 4KhSK4YKFeGbD2kdG/BXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vW8RBnW0j8c=:hBOqd4GlhvVvyWHBmvpeJ5
 Fw/2x/JH4W7An94bFB6fBkGod2+b1HJTf0tdk3hWLBs3g1xTDLUAXord6FEI7VKapBS8e+/YK
 qrvCyNWn+Ler+46USZ5+z3iVmhL3sW2YMt5cwkZ/ZsONRq58+LSs61ox0G+Cmoe23VmoCm3Y9
 tBS4gHjQjjh2HKvA94WVS4jlO0Vd6XNOHdKYj6tzGgIuigFMrRUY52aR0h46YnmICOOxJEh/g
 38L5D8acIMbwVzir2/9g2/5y7xADLWKgufC5QsBK5gGxHSDOVqoWGa0grI/3oCQdp128qFU8H
 1IavHbryJvf5t4Aupvd24UxRdw91H+DkxT538pf/m1mODdwQt8qRB7hY1B05Ef2GH/AWfKKv7
 OraJYxVws7Hxf0+ESzvoh9JdtOimya4ufsF3ar8dJgX5Df8Lw3NnrV5fnuw1jdQDn6aBaYoaq
 h97Tt5OSsgmsISLawc5hm9hUsi0UkW0WrrWb/vQBJhWkDBcFe6r/9mjg9uU2eFXbR10KrCkR/
 96WrcMaxr3ERbyTpPfPFSfJD6KTvvvaU+Cfzkhytk2eary/H3LMLsbmzrx95m+Djwx6drnBNb
 5aX68bQGbBqpnYt2EsXLIpjepeR46dJIfX0Cog5bjX35lu+hsKwmVPL0AjLRr3LM6SxUd/mTM
 CBJHEOHzx6cUetdLCqO0EoZp06t1eEVZXIURuPvBKXDlQ0vY82oQpMCkerx8Zd83+Rxi6JfwX
 qKuUDUTb7vyLNpmnt984d4zQYxyGhrtnyZVQFa99tRKP4XfxEWeJlc/6/4uiLaRUlUvMxhunH
 PK+FK2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the context of the new --rebase-merges mode, which was designed
specifically to allow for changing the existing branch topology
liberally, a user may want to extract commits into a completely fresh
branch that starts with a newly-created root commit.

This is now possible by inserting the command `reset [new root]` before
`pick`ing the commit that wants to become a root commit. Example:

	reset [new root]
	pick 012345 a commit that is about to become a root commit
	pick 234567 this commit will have the previous one as parent

This does not conflict with other uses of the `reset` command because
`[new root]` is not (part of) a valid ref name: both the opening bracket
as well as the space are illegal in ref names.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 40 ++++++++++++++++++++++++++++------------
 t/t3430-rebase-merges.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8eddda681d1..a7832399b1f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2747,18 +2747,34 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
-	/* Determine the length of the label */
-	for (i = 0; i < len; i++)
-		if (isspace(name[i]))
-			len = i;
-
-	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
-	if (get_oid(ref_name.buf, &oid) &&
-	    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
-		error(_("could not read '%s'"), ref_name.buf);
-		rollback_lock_file(&lock);
-		strbuf_release(&ref_name);
-		return -1;
+	if (len == 10 && !strncmp("[new root]", name, len)) {
+		if (!opts->have_squash_onto) {
+			const char *hex;
+			if (commit_tree("", 0, the_hash_algo->empty_tree,
+					NULL, &opts->squash_onto,
+					NULL, NULL))
+				return error(_("writing fake root commit"));
+			opts->have_squash_onto = 1;
+			hex = oid_to_hex(&opts->squash_onto);
+			if (write_message(hex, strlen(hex),
+					  rebase_path_squash_onto(), 0))
+				return error(_("writing squash-onto"));
+		}
+		oidcpy(&oid, &opts->squash_onto);
+	} else {
+		/* Determine the length of the label */
+		for (i = 0; i < len; i++)
+			if (isspace(name[i]))
+				len = i;
+
+		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
+		if (get_oid(ref_name.buf, &oid) &&
+		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
+			error(_("could not read '%s'"), ref_name.buf);
+			rollback_lock_file(&lock);
+			strbuf_release(&ref_name);
+			return -1;
+		}
 	}
 
 	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 3d4dfdf7bec..35260862fcb 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -241,4 +241,38 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
 	test_cmp_rev HEAD $before
 '
 
+test_expect_success 'root commits' '
+	git checkout --orphan unrelated &&
+	(GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
+	 test_commit second-root) &&
+	test_commit third-root &&
+	cat >script-from-scratch <<-\EOF &&
+	pick third-root
+	label first-branch
+	reset [new root]
+	pick second-root
+	merge first-branch # Merge the 3rd root
+	EOF
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	git rebase -i --force --root -r &&
+	test "Parsnip" = "$(git show -s --format=%an HEAD^)" &&
+	test $(git rev-parse second-root^0) != $(git rev-parse HEAD^) &&
+	test $(git rev-parse second-root:second-root.t) = \
+		$(git rev-parse HEAD^:second-root.t) &&
+	test_cmp_graph HEAD <<-\EOF &&
+	*   Merge the 3rd root
+	|\
+	| * third-root
+	* second-root
+	EOF
+
+	: fast forward if possible &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_might_fail git config --unset sequence.editor &&
+	test_tick &&
+	git rebase -i --root -r &&
+	test_cmp_rev HEAD $before
+'
+
 test_done
-- 
2.17.0.windows.1.38.g05ca542f78d


