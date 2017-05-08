Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3B01FDEA
	for <e@80x24.org>; Mon,  8 May 2017 09:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbdEHJmD (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 05:42:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:64521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753612AbdEHJmA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 05:42:00 -0400
Received: from virtualbox ([95.208.59.245]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqzIJ-1ddPLv1IQ7-00eb8k; Mon, 08
 May 2017 11:41:44 +0200
Date:   Mon, 8 May 2017 11:41:42 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     David Turner <dturner@twosigma.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
Subject: [PATCH 1/1] unpack-trees: preserve index extensions
In-Reply-To: <cover.1494236457.git.johannes.schindelin@gmx.de>
Message-ID: <52008ec9f5b6c459f596052836cd88addb7167db.1494236457.git.johannes.schindelin@gmx.de>
References: <cover.1494236457.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OnfYrFIjA933XcUHmcYxV20oO/SqAY41hVSLbBbcp5MKpDX5Swk
 04bItviutK1RRSsKohS4FVSU1DvmU9drALy+TF7o2/tXKTQSC7aRXyT9TckYMvqIvPUm1yr
 xHX3bNnAnxQIx+7MvyqsnH9BfCZNPZLJyNrHwUXAxp7K7cqu3P2FI4LHI/TnVhC8p0bbwhJ
 m79Ar6R4aQc6LbdiSPuXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f7CHhv+i1Kc=:UUlC+y6Q/9lW/H5OnrLQW+
 QHORRqowWcS63GI0TD1WUSEYxN3zYLMmbUHIutyg2855Az18yv4UnLLj//RgPAfnciTtj2blg
 wy8YygKfz3nF0uH7ejTgz0NthnmRwn4TMwwA9W6wbhZWPACTmAy+pE7AqaZWPfNvuu6CFzBAp
 14tyjywwIkwrooI04I2ZUDPPiKkEmMbz8wf+dtl3ANRizz3dG5jjsHEiFIKKOjXrvoupnuWSG
 dWwh7jFz+SEfnAe9rxRtv+81SzgGRQSnoh+Or5dMX8i9meZ+D3Qfmk5bvm/9+UCgV76hEFJ0E
 GurTZefgpnBDYT7BEJfKHDhylZYxij/XITRa1lu/mu/yPJaG1qMzlhrxxdzHb2kLpsSAC6tnI
 KdzycVTTWb+VIhfe30JWL+SED6y8tkFi+EBFoA+z+ZN39QIB8V/mypTPjBsBCCjSJy31cGlsM
 PO3rivqTsUoAHkWJ7sMGxGfjCKyFmSJTuT59F75Bi3aiZcTHGLfYhOaJo0d37P70X8rBWMMzM
 5kzLso9l21yr8fuuvlFiWJcqnQa/pJYZYae/snGzDp2QgDpFUYCc7PWCgDKUFXQ6llo9S4hIK
 sWexisZLS2jLdPJR1RjuocvgDlXQNHSj98mM5SUjWjYtfTj3e39Uf2a1ySX7ijKUPDSNpA0j7
 legbVxmlzmpBX+oNwkScrbM7AkBnovt2zSEAsqhRW11xaYqoa7Bv7EDwxLsN6pmwpfZEJRQKE
 Pcv6Y6hanx9z+DHIaS3gbb4A+eUmFJB9BQ+Q6/nTuTCHZPLGm07AwrvfIBW6qNeoSDEPvlgq9
 1BbOa/d+mRmu7ATvhM3s9iGhkVR/XdaIcqfA4etxSDeZvEhUUOU7so3eZhiphtG2w2YLADj1K
 UZ/SCzNgPWEHCi0MCH4GKWWanAk4EmTj7nmDTvMHk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twosigma.com>

Make git checkout (and other unpack_tree operations) preserve the
untracked cache. This is valuable for two reasons:

1. Often, an unpack_tree operation will not touch large parts of the
working tree, and thus most of the untracked cache will continue to be
valid.

2. Even if the untracked cache were entirely invalidated by such an
operation, the user has signaled their intention to have such a cache,
and we don't want to throw it away.

[jes: backed out the watchman-specific parts]

Signed-off-by: David Turner <dturner@twosigma.com>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h                           |  1 +
 read-cache.c                      |  6 ++++++
 t/t7063-status-untracked-cache.sh | 22 ++++++++++++++++++++++
 unpack-trees.c                    |  1 +
 4 files changed, 30 insertions(+)

diff --git a/cache.h b/cache.h
index e1f0e182ad0..d41336dfd5d 100644
--- a/cache.h
+++ b/cache.h
@@ -597,6 +597,7 @@ extern int read_index_unmerged(struct index_state *);
 #define CLOSE_LOCK		(1 << 1)
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 extern int discard_index(struct index_state *);
+extern void move_index_extensions(struct index_state *dst, struct index_state *src);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
diff --git a/read-cache.c b/read-cache.c
index 0d0081a11b8..79827a4d710 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2628,3 +2628,9 @@ void stat_validity_update(struct stat_validity *sv, int fd)
 		fill_stat_data(sv->sd, &st);
 	}
 }
+
+void move_index_extensions(struct index_state *dst, struct index_state *src)
+{
+	dst->untracked = src->untracked;
+	src->untracked = NULL;
+}
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 0667bd9dd3e..e5fb892f957 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -661,4 +661,26 @@ test_expect_success 'test ident field is working' '
 	test_i18ncmp ../expect ../err
 '
 
+test_expect_success 'untracked cache survives a checkout' '
+	git commit --allow-empty -m empty &&
+	test-dump-untracked-cache >../before &&
+	test_when_finished  "git checkout master" &&
+	git checkout -b other_branch &&
+	test-dump-untracked-cache >../after &&
+	test_cmp ../before ../after &&
+	test_commit test &&
+	test-dump-untracked-cache >../before &&
+	git checkout master &&
+	test-dump-untracked-cache >../after &&
+	test_cmp ../before ../after
+'
+
+test_expect_success 'untracked cache survives a commit' '
+	test-dump-untracked-cache >../before &&
+	git add done/two &&
+	git commit -m commit &&
+	test-dump-untracked-cache >../after &&
+	test_cmp ../before ../after
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index aa15111fefc..17117bd0fda 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1391,6 +1391,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
+		move_index_extensions(&o->result, o->dst_index);
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
-- 
2.12.2.windows.2.800.gede8f145e06
