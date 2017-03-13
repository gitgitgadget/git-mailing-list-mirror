Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F0B20373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbdCMUMf (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:12:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:50428 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754148AbdCMUM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:12:28 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQRWm-1cfhm43GgO-00TmlW; Mon, 13
 Mar 2017 21:12:20 +0100
Date:   Mon, 13 Mar 2017 21:12:18 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 12/12] setup.c: mention unresolved problems
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <bdfa3845b81531863941e6a97c28eb1afa62dd2c.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XNl+8pZjJFa+M9C37ps4khjD+TeHzYibx09kLkb9fMIK1heI+PU
 QSKmVXZGpBI2aw4+0UTwlN6f8vv/mDeW6bSJ/EZuht/jr0MlIUWpS1Tf6kgqj4iGv30jO4D
 1bIkZ39Vd0YwKWzXeZ33rxt+Omh1JIFhx4zqNN/+3+B1Wq96nOGq8U9z3CjhU1je/63viLM
 VPOqPc+UIRdgj0DSo0XPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g7HL0QaHHp0=:MSL0ObppO+7vxkO4wUJp9X
 umkqsLvJTQai7vSKuPVXO4Q+2lVL66toLAd/o3URTJu8aJWTN8dAJPvGLY3OQq0Sl7orEOlVw
 9SMnXp45rLWYxH8+rmKf5mJUwze+Dj22P9CiCVthHAgPHxF2eNa5Hy2NE+BmrL9tNUHnydq3s
 Bb7+aDuBtRbh/GlTB+uC8cQXZroTLGgQAX+QSjaEM2BYvcN0q7krTwY3h9tUoK2RqLCvpqCpD
 ATVpbLwQf+LLTnRDJmOXw89JyTibqIuBFGqAuHmUvdZ7aGdWt6qCKdXL3xEZ7ZucAIPlWbGe1
 02INThPmP0luwryy1sfW0nnaiJqC1iaQpj04W46mLqmUTbM5Rf5W/ONqhCQKQSdp7kIY6fYB4
 FXURep3ByX4PiMjWRLDllphewSiIBA+AcH5iwlNUUfaxnxiBwGuV6XEZ8C6ThW1IVTWyCWdP3
 3fckcs2/RlZfGuopgUFrqTYv7+IqYgpCkQR8UY9v4L1Ru22+nKacJ2TEy+BU2YJzb9fC8S8R2
 sDJkeQTk46k1ultudTw5VndNM3HcnpnwGqKOykp3E7H99Ld51HrUTVbFRzmin4B/B8qoI7ADT
 hlqY3KI4XOw3t23AeXOZ4potgPjabXD1l0hOl2U3k0FEY+t8a75hURNkFAXwTntwBZmk5nbpA
 RnjiCw6sxqnw55yhr8TEFurCmt9stlT0BYIje/aD1QOOTuF689y/Wynd9P94rJUoh9v4ltmuu
 vNwlZiR8peRzTOAwjQQNUpx85RvnVnuyh7f3qOQDeAlNUMQkGNdUTj7L0NAQa6wOm/zNstcfG
 IsqZ7Za
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the review of the `early-config` patch series, two issues have
been identified that have been with us forever.

The idea of that patch series was to fix the hard-coded (and sometimes
wrong) .git/config path when looking for the pager configurations. To
that end, the patches refactor the helper functions behind the
functionality of setup_git_directory(), to make it reusable without
changing any global state. Not to change said functionality.

So let's just mark the identified problems for later so that we do not
forget them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/setup.c b/setup.c
index f31abf8a990..64f922a9378 100644
--- a/setup.c
+++ b/setup.c
@@ -531,6 +531,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	ssize_t len;
 
 	if (stat(path, &st)) {
+		/* NEEDSWORK: discern between ENOENT vs other errors */
 		error_code = READ_GITFILE_ERR_STAT_FAILED;
 		goto cleanup_return;
 	}
@@ -902,6 +903,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		if (!gitdirenv) {
 			if (die_on_error ||
 			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
+				/* NEEDSWORK: fail if .git is not file nor dir */
 				if (is_git_directory(dir->buf))
 					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
-- 
2.12.0.windows.1.7.g94dafc3b124
