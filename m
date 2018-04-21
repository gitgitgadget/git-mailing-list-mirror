Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18C11F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbeDUJnu (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:43:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:53975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeDUJnt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:43:49 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEo4s-1fBWx93yUU-00G3j1; Sat, 21
 Apr 2018 11:43:46 +0200
Date:   Sat, 21 Apr 2018 11:43:29 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 00/11] Deprecate .git/info/grafts
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HMLIPqbgHA77AjlJm1UmMjHrzVdLDlfxB+Vb7rEKLroD4N4Dh9V
 onQdW4lGsLN9sh1i9vtZm+lUXm993fA2VR+I9hrhmvCRliAY2qe/I2kPor7J+icy91Ul/yV
 gY6k9aJCtuCGHFTVXXLdH3h8VZIC5sJJiLV+NuHiB7VqJD7aQ7fJhC5DeJzWzsUK5mlUcfp
 uiXDw5pruMjBh0kmzIXRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:APkyHGqFLzI=:xt6/D0KSsz3PzINC9B3Hdq
 ncoQJlV20NebHIAl/sKn7aI0lpbHqanQBHvLbA6hca6I0p8bk/jPOGlnUxFaC2lz9HFx0VKUG
 wiU5SXG8bkOpaE+kRZLlSYeGt2Gp7dpd/OfU5ES+3ouSL37TU4FDdCprzk7Tnv3MetKn0Nud9
 UDLt1sMizIwFWtB3mzXUOVaHZHrSLC9Qt80SZvxH9QQXhUqw+hwg8KPo52Bsmd2zFXAFUJz2Q
 Rli4Q4Uh98T2cS38RH+KWy8HoojVYDjvAG3vHvBkvitljPLd7ZIR6PuIzFpLKhNx91zfjYO8f
 kE7xChv9wzntphJtCQKldJYcCJ4klUiQ21jegM4youcwRO/+M6KLVrLcaZMiUd4JxW03PZTK5
 F7P2KcjAtqB2GsdosL3CKU7sb1e6nEJwwr66pSq5537V9IAwmmEgji64BVGZbnPtB2LRhlOdw
 D+oIkzymOs1QiEbJIFYVSYvv1b8nflNy1X7AW/1zQ/rSOSn+O+iyOurVHEAVo2TMvMRSnz/Nj
 v1nvbj54BsJpnAirt3id54yvuDA2qk09HuDHXDePOmCHtLVcSK25yHLG2SmXHVKRzPTaDQ6LC
 vNj9jkAnDVwLrLaATJe4UzOUo1+XeilkO9JRVJPmjVf2SUnovBGEBKkmHXY2E6vGfOczdRqsg
 IL6QIp2xWHm6EyyQ2vyBsnpvM2IXn3a94ZyLIbKDgk7xt19UkVXPnCtTTuG0SfmYJr1ikHDqR
 YDV6ZzwyuJ6UjrN2sYr0HyWQ/lb8ehnoACJEF11VUxpqqqu9583JhMu2BxxLKChmXHSYYN1cA
 b5KGgYTHYdW/KHL4Wxjbj+27GMZ8b6jdtXoMrbhyhXvc2PpYks=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is fragile, as there is no way for the revision machinery to say "but
now I want to traverse the graph ignoring the graft file" e.g. when
pushing commits to a remote repository (which, as a consequence, can
miss commits).

And we already have a better solution with `git replace --graft <comit>
[<parent>...]`.

Changes since v3:

- The argv_array_split() declaration now has a clear comment indicating
  that it does not perform any "un-quoting" but goes purely by
  whitespace.

- Fixed t6050 under GETTEXT_POISON.


Johannes Schindelin (11):
  argv_array: offer to split a string by whitespace
  commit: Let the callback of for_each_mergetag return on error
  replace: avoid using die() to indicate a bug
  replace: "libify" create_graft() and callees
  replace: introduce --convert-graft-file
  Add a test for `git replace --convert-graft-file`
  Deprecate support for .git/info/grafts
  filter-branch: stop suggesting to use grafts
  technical/shallow: describe the relationship with replace refs
  technical/shallow: describe why shallow cannot use replace refs
  Remove obsolete script to convert grafts to replace refs

 Documentation/git-filter-branch.txt       |   2 +-
 Documentation/git-replace.txt             |  11 +-
 Documentation/technical/shallow.txt       |  24 ++-
 advice.c                                  |   2 +
 advice.h                                  |   1 +
 argv-array.c                              |  20 +++
 argv-array.h                              |   2 +
 builtin/replace.c                         | 189 +++++++++++++++-------
 commit.c                                  |  18 ++-
 commit.h                                  |   4 +-
 contrib/convert-grafts-to-replace-refs.sh |  28 ----
 log-tree.c                                |  13 +-
 t/t6001-rev-list-graft.sh                 |   9 ++
 t/t6050-replace.sh                        |  20 +++
 14 files changed, 236 insertions(+), 107 deletions(-)
 delete mode 100755 contrib/convert-grafts-to-replace-refs.sh


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
Published-As: https://github.com/dscho/git/releases/tag/deprecate-grafts-v4
Fetch-It-Via: git fetch https://github.com/dscho/git deprecate-grafts-v4

Interdiff vs v3:
 diff --git a/argv-array.h b/argv-array.h
 index c7c397695df..750c30d2f2c 100644
 --- a/argv-array.h
 +++ b/argv-array.h
 @@ -19,6 +19,7 @@ LAST_ARG_MUST_BE_NULL
  void argv_array_pushl(struct argv_array *, ...);
  void argv_array_pushv(struct argv_array *, const char **);
  void argv_array_pop(struct argv_array *);
 +/* Splits by whitespace; does not handle quoted arguments! */
  void argv_array_split(struct argv_array *, const char *);
  void argv_array_clear(struct argv_array *);
  const char **argv_array_detach(struct argv_array *);
 diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
 index 8a3ee7c3db9..bed86a0af3d 100755
 --- a/t/t6050-replace.sh
 +++ b/t/t6050-replace.sh
 @@ -460,8 +460,8 @@ test_expect_success '--convert-graft-file' '
  	test_when_finished "rm -f .git/info/grafts" &&
  	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
  	test_must_fail git replace --convert-graft-file 2>err &&
 -	grep "$EMPTY_BLOB $EMPTY_TREE" err &&
 -	grep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
 +	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" err &&
 +	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
  '
  
  test_done
-- 
2.17.0.windows.1.15.gaa56ade3205

