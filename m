Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D579D20401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbdFNLgE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:36:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:60759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbdFNLgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 07:36:02 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfVzj-1dAQ9h1AXz-00P2WP; Wed, 14
 Jun 2017 13:35:54 +0200
Date:   Wed, 14 Jun 2017 13:35:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 4/6] t1308: relax the test verifying that empty alias
 values are disallowed
In-Reply-To: <cover.1497440104.git.johannes.schindelin@gmx.de>
Message-ID: <2c480fe5c160c560b501b6190a95154ef6b19ba7.1497440104.git.johannes.schindelin@gmx.de>
References: <cover.1497440104.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:z/DukpmNZWWLQwJLcZkRDQ8zWbNPZk1XV9yAsAhfqxUM3v0ngxp
 u1kLuIx1+Jk+myKOLNxhFt3oKmduU+ILHaVEh96UJuHN7IbLTueLamvpg+RqL9l4dWflCWT
 nnEB6+Z4lmwgOuk7OAHM3QneEwnfi0zsf2WI6fuIUhguGwJfM702lOqP4+KRrtY+476pN8L
 hEueQcxuEIgN7zRhlIEvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xGy5iBrnzEY=:F/HRKj6x6ViOUMt5h8DEVf
 EfdbLzwuuyACGBBIW90x41+pMtWf1PJyzFclYp4pW4dIBsmov5XLdnSDpNhZ2wdzkcL7WLZ1x
 yhUN9gGjhtEYSE8Pz/W9mzb006+I38kv7lXmYZD4OF+9oH2dnrnmX8cGTAlFxDzYrt6AoaOwe
 stsP+MKpruV0XR+puDxteDAQRxLMMOr7+9t9DFEoFsUp+UxFN7ZreA8Hh4HKZj633PGRL595H
 o6W+GiLLzZx8iRhsK06OS8Fnt7xLUWv3tYzLDpyMt+qU3B7rbiZaLUh8rWau4VWWsavICtNku
 d5zmcqVeaHOy9E/Gm0Z5+yXRm4y9OBZeDnVwtcnyrVn/0ZazJ2wWO3/8bj/36fkxXQ5g0q8Ib
 XufhtVTs6XhO1IrJNUu1moOzu+o7qABY4n1EE3fz73mgKi6AZO6Fa80gJdwjb/C90CWAStbfk
 GJa/YwI3ozQ/Q1b72SqaE0/x42vocSyipkcJt2W+nm5Fy1Iz2k8C1VbTuP1p/MYl3WpOp+Ync
 fV60IXeBgZDHWUOV5NOZqCrBT7uhIwKmZYJ1WIemYhC2GZiDxTBy3KdA10mEgWJ13KUvgUyHs
 f3SD3DP+JehPgAJtih57b6Im9JrMfi7JaME6cjgXHjIae1XAe8qAlpp2i38WRD+UpJGXLfJ7/
 InR+ewmIqUGf04wHXkg2dgU/OaJbvHf5C6ZX/QsEHzJTFpKRP7b+F0Hc4N+MffrRAgdWdzTCD
 Aj2OY/0bhYCTE/gahk+7e85ITGTZzHbj5RlZrdoYL1qjS6dpBcbSWPJnrZ6ak3zD2CzKqoZtT
 ogT0Oyn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to change the way aliases are expanded, to use the early
config machinery.

This machinery reports errors in a slightly different manner than the
cached config machinery.

Let's not get hung up by the precise wording of the message mentioning
the line number. It is really sufficient to verify that all the relevant
information is given to the user.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1308-config-set.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index e495a616161..bafed5c9b88 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -226,7 +226,9 @@ test_expect_success 'check line errors for malformed values' '
 		br
 	EOF
 	test_expect_code 128 git br 2>result &&
-	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
+	test_i18ngrep "missing value for .alias\.br" result &&
+	test_i18ngrep "fatal: .*\.git/config" result &&
+	test_i18ngrep "fatal: .*line 2" result
 '
 
 test_expect_success 'error on modifying repo config without repo' '
-- 
2.13.1.windows.1.1.ga36e14b3aaa


