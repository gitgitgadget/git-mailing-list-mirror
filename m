Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9A81FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 13:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1431360AbdDYNw0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 09:52:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:49188 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1430832AbdDYNwS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 09:52:18 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2ojS-1cAdJZ0KpS-00sebu; Tue, 25
 Apr 2017 15:52:15 +0200
Date:   Tue, 25 Apr 2017 15:52:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 8/9] t3415: test fixup with wrapped oneline
In-Reply-To: <cover.1493128210.git.johannes.schindelin@gmx.de>
Message-ID: <669be37bd417294913596a1d47e046b03eb23f6d.1493128210.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <cover.1493128210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mozap8vtdwFcsBns9nyj2knGWNirG4GCdow37yVHPHBKWQJ/oxk
 bhXZZsdCV1tGZed4ZVNt/iq3iSmq6b30xY0QXa6ZksP1AWag8a7Zna+IUegEp3DgqL1bG+j
 CD5qBF43xMfZaZzdc5Rbi088CD+Rnm4Id3HsI0cQGqMj6EoFx5HY10FOgD3ANsAq/FpOhHF
 rRxAYBWc8O/UeMHlUVwvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QhUPezN0PPM=:2J72kINKDBOb+RvQjPG6R9
 cG2VMhuPVYF6hUN20gVVv/pgJcD+Z+eiUzwQ1Y+VyKat8c8bOf8uIJn1iCt1WoL/d2e6MumWy
 Fh+KSh9uufYQ/78iaV7+89LOMNwWZ+QyX+EZLioXvcDQ6ykBwD2m0CsXcSsWmAARMItknweIX
 gierRKXB0GLTg12tjAltwGg3LXSRwdup/XqjGEAt7HvDLGDKDRr3XBQrAG6UKRI2/PuZ+UqQt
 IBRZk+/JVN7u2LvpFm6dWHV88Z+eukf3PydD9CnSN1ZSA1B/S7xfEdgTkcYvXlavxRRDmcng6
 mg7TyW7ccfJbvHd0Z1V12qt0aB+YcEPyg3Dla6GAf/9OaElursWfa0LA58mxGHQ9pQYqPemgH
 +O2y1WOrFDUzCRN8Vlvnap1dNowFtbPDQi3LoxUyDMW0F26QoZD9ApfUN8RwgYk8plpXbP6Xi
 4lqrs+7Qd1Z7ErttE8F7zdohQGnrxwN38ENzag14F2mukU2MupoBftk0tF/b9wyt0g7uyLDWc
 yv2IEuONm6DZjYm8qKKPfciBtyIkslKQ87XyJzmDVmEdQ5D6PNK/VLNggWj1E1Rf5qab1TA+J
 v6RVAx0aJ6K85C/C2wZX2lsbPuJw5Smt6mcuXvWbuX9Wt8+cmuWMQU1rFo9I4EXOHNj+4hQzr
 yx5Ntc9AaHjvrPDnjd2svdX5jVolA96wm1SkQXCWhPFE1BCxLX+MEbXmLrfUfFFgile/JM3Ri
 V6++FvNuDNrZW/c3daZZSmdbvqFKDRllHL2bcVpiomIS/sRyWN2in5qWuvyyiJzjgoSDMFQ1n
 d3L8cSf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git commit --fixup` command unwraps wrapped onelines when
constructing the commit message, without wrapping the result.

We need to make sure that `git rebase --autosquash` keeps handling such
cases correctly, in particular since we are about to move the autosquash
handling into the rebase--helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 48346f1cc0c..9fd629a6e21 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -304,4 +304,18 @@ test_expect_success 'extra spaces after fixup!' '
 	test $base = $parent
 '
 
+test_expect_success 'wrapped original subject' '
+	if test -d .git/rebase-merge; then git rebase --abort; fi &&
+	base=$(git rev-parse HEAD) &&
+	echo "wrapped subject" >wrapped &&
+	git add wrapped &&
+	test_tick &&
+	git commit --allow-empty -m "$(printf "To\nfixup")" &&
+	test_tick &&
+	git commit --allow-empty -m "fixup! To fixup" &&
+	git rebase -i --autosquash --keep-empty HEAD~2 &&
+	parent=$(git rev-parse HEAD^) &&
+	test $base = $parent
+'
+
 test_done
-- 
2.12.2.windows.2.406.gd14a8f8640f


