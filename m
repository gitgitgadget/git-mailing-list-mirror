Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF6C1FAE3
	for <e@80x24.org>; Mon, 29 Jan 2018 22:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeA2Wy7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:54:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:63152 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbeA2Wy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:54:56 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MYg42-1eJnNg2F5G-00VSPh; Mon, 29 Jan 2018 23:54:50 +0100
Date:   Mon, 29 Jan 2018 23:54:49 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 04/10] sequencer: fast-forward merge commits, if
 possible
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
Message-ID: <2fdde64f9de580cde654988931e53a36a30f36bf.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gnzgefSUWczXXnp5KXPg3POqQjU9RK3RQCACSKplaerjW7gcd6U
 C8oJBdKF5l04fdP8WiEwDL9W39QPe7pdHdEbgW+yeGiEw/jLkjTZCzf2NKc5y6jn/+VOCsc
 BI7KeEmN6MMm0BzHpIdSsSbhgEBOfDwELbse9ECh99d8BQTXRUFVQj1T8H0YFr7fy8Hjuj8
 pIPJrVl888HFt+P2Hskag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ru8bdWo9b0E=:G17KSa9GjIaTuIoiwXlbLm
 DGe3eRpMZ9raDDGDLctsVqw2KV9lRshvsSzbITxdlj+WRZBHmTp3FY3i5bdTxVOymkDklv30i
 IvYyk6olEpVG3qvMJs2w8nf0CsWsCz8p0joMDciTg4QHfyo56OcMY28tCVwJIhtsL+4yBGE4p
 8sifIvZaDLwyXZNm5mRKu53HG63fF7wJrQCVU7idEf5rx+r7RWQYyazZy1bLhYFM3PaAR3yxm
 CwpqK+NJ3DCEZmM9sa1RKo1cpAAtM8t1vhw01GsXxyQxcH1PN83FX4N9ggrkSD0cRxHfOVfoH
 xzPAyzd9ZEFw+87CV0FVH6DYDDZBlviN8uq8ctAWtQgSBtI1jsdQOB1NSaEBzBcU4cT7NuoQM
 YOtLaZh4sWTLnQ4vGuRcJVUcG5XJwgzFyVTtBD4L7Wuzrvl0456ocB08G21+TmiFiwcRjg8P7
 ohPhQ89CksEntH8xrwAItrP16KWaQBKX+eyG0A3TPl45Zt/pdsK1GGTIZAErLQdNrUwwcb0Cw
 CgbGL+T0xVeEFMjPJsvql1UF//SpMqbcOUThIjglN0ornWaO3AfOCEDa7R9x7l0scxS++yEP5
 jY9k40/odFerJze4abhp30dS6m2DujpYFK31GWoS3aV2zcGsBXV49tS2vBzZZbQAEWwbO3t2z
 z2YU231aOZN2mjvofw4pXVItapBtZM9xGmn25hgRwsPI/G6CBydH+0cU/6spMBerqM64BcMce
 wjCUw/Qs9ddmGnWHlv7lxbF8TsoYt8ciNJTnfk5hxigwSSl2qc9j3dO1Cdgawya5Ui1VPSGgK
 X9NsMNZZ0IJkd3RMRXIlCXCY4ibkfQv0T7ad+LpUGIlU1mqlIEZJ874njLeof6bX7MrfrKy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like with regular `pick` commands, if we are trying to recreate a
merge commit, we now test whether the parents of said commit match HEAD
and the commits to be merged, and fast-forward if possible.

This is not only faster, but also avoids unnecessary proliferation of
new objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index dfc9f9e13cd..df61e7883b3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2088,7 +2088,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *common, *j, *reversed = NULL;
 	struct merge_options o;
-	int ret;
+	int can_fast_forward, ret;
 	static struct lock_file lock;
 
 	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
@@ -2154,6 +2154,14 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		strbuf_release(&buf);
 	}
 
+	/*
+	 * If HEAD is not identical to the parent of the original merge commit,
+	 * we cannot fast-forward.
+	 */
+	can_fast_forward = opts->allow_ff && commit && commit->parents &&
+		!oidcmp(&commit->parents->item->object.oid,
+			&head_commit->object.oid);
+
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
 	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 	if (!merge_commit) {
@@ -2167,6 +2175,17 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		rollback_lock_file(&lock);
 		return -1;
 	}
+
+	if (can_fast_forward && commit->parents->next &&
+	    !commit->parents->next->next &&
+	    !oidcmp(&commit->parents->next->item->object.oid,
+		    &merge_commit->object.oid)) {
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return fast_forward_to(&commit->object.oid,
+				       &head_commit->object.oid, 0, opts);
+	}
+
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
-- 
2.16.1.windows.1


