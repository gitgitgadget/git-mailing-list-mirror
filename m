Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B9B20248
	for <e@80x24.org>; Wed, 17 Apr 2019 18:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfDQSB0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 14:01:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35127 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDQSB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 14:01:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so12393345plp.2
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HkScEN5PpC/+tojUrClQmVvoONfdfonTu05yzWQoeMo=;
        b=t93zk4Z408vLePOgdC/wtv+PBo9X7prmLyYF7QLYgQtg30qXRlvf7E7PWaqjzzNQKQ
         yH95WtJkcT2DSB9gKOgNUtpg0Wg9uwR0l8UiKv2XKR8484M3s7t38BqXjjPAvDfsRzW0
         A2Nqd1PNFlayZLDX3/ycAmQ4UlF4Z0yL2TY0bCG1xgDnig26EUW+UlGpeZP+hG0Q0rSf
         Ggk1dhxYV6PcIfZn3O4p3qeTBijjHceQX3HdU1Hkc7Z8LUlLw7CvSBRE04m6uJzNSS4S
         2o3TSGNlXgFS41loGN93UhEyDsQipvVzD0KyCGb7XfkZ3BhkrvhOGbtgQ5DR72SLaFbf
         P5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HkScEN5PpC/+tojUrClQmVvoONfdfonTu05yzWQoeMo=;
        b=HANKOGuw0nZBsa0RNQQZMPC7CEx5ZqLZDQhJcVYRTYOvVohD+gbeH97E9Q7+TZ7f3Z
         XzbkH9o47Co5dJDphRvoJS3JHt0+fLaSz4XAhnSUwqJXoH50NKSeyIPAgH0ieG5mpGfY
         DIIlIKuK6rPUwINbI7SxOs+qvoLFARdjVDosus+98nSKJF+zfr8tXhO6T1pyo8N7HQJA
         g0Bsx/XVHztysgujmmQIR/SQpuHnuQVGLBx3DgB/lhkyQ/NW4x9wMHIv5ID/HiZ2hPVS
         RHs2Hi/RHIkdgZPAGl1e5v6I3VqRGBlCIYJPd5pxQFgvnZ1B7TYzmvlrLEkNAoRyRoVG
         jghg==
X-Gm-Message-State: APjAAAXnfyG5QDv5WUthGww3wo00u27c2qBCXxzSJIYhZn8xToQQOwjp
        BMh3ZXqg22rNT/PKk2frX2grrQ9BkKw=
X-Google-Smtp-Source: APXvYqxSKR/l4WyvUG++Na5dG2fHeQ1NNKAvi5BjK2A5m4iD/8q4fxW8AwhrE0m+2xctNWSLsLpc1g==
X-Received: by 2002:a17:902:4481:: with SMTP id l1mr26458275pld.75.1555524084771;
        Wed, 17 Apr 2019 11:01:24 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id l192sm48757354pge.42.2019.04.17.11.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:01:23 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:01:22 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 0/5] rebase: teach rebase --keep-base
Message-ID: <cover.1555523176.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1554500051.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the comments, Junio and Phillip.

I've fixed the ASCII art graphs and also refactored the if-else into a
goto tower.

Hopefully, this will be the last reroll of this series ;)

---

This patchset now depends "[PATCH 1/8] tests (rebase): spell out the
`--keep-empty` option" which is the first patch of Johannes's "Do not
use abbreviated options in tests" patchset[1]. (Thanks for catching
that, Johannes!)

Changes since v1:

* Squashed old set into one patch
* Fixed indentation style and dangling else
* Added more documentation after discussion with Ævar

Changes since v2:

* Add testing for rebase --fork-point behaviour
* Add testing for rebase fast-forward behaviour
* Make rebase --onto fast-forward in more cases
* Update documentation to include use-case

Changes since v3:

* Fix tests failing on bash 4.2
* Fix typo in t3431 comment

Changes since v4:

* Make rebase --fork-point fast-forward in more cases

Changes since v5:

* Fix graph illustrations so that the "branch off" is visually in the
  correct place
* Refactor if-else in can_fast_forward into one-level-deep ifs to
  increase clarity

[1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1553537656.git.gitgitgadget@gmail.com/

Denton Liu (6):
  t3431: add rebase --fork-point tests
  t3432: test rebase fast-forward behavior
  rebase: refactor can_fast_forward into goto tower
  rebase: fast-forward --onto in more cases
  rebase: fast-forward --fork-point in more cases
  rebase: teach rebase --keep-base

 Documentation/git-rebase.txt     | 30 +++++++++--
 builtin/rebase.c                 | 86 +++++++++++++++++++++++---------
 t/t3400-rebase.sh                |  2 +-
 t/t3404-rebase-interactive.sh    |  2 +-
 t/t3416-rebase-onto-threedots.sh | 57 +++++++++++++++++++++
 t/t3431-rebase-fork-point.sh     | 57 +++++++++++++++++++++
 t/t3432-rebase-fast-forward.sh   | 83 ++++++++++++++++++++++++++++++
 7 files changed, 289 insertions(+), 28 deletions(-)
 create mode 100755 t/t3431-rebase-fork-point.sh
 create mode 100755 t/t3432-rebase-fast-forward.sh

Range-diff against v5:
1:  0f1e9ac5c8 ! 1:  eb64f6c91d t3431: add rebase --fork-point tests
    @@ -18,9 +18,9 @@
     +
     +. ./test-lib.sh
     +
    -+# A---B---D---E       (master)
    -+#     \
    -+#      C*---F---G (side)
    ++# A---B---D---E    (master)
    ++#      \
    ++#       C*---F---G (side)
     +#
     +# C was formerly part of master but master was rewound to remove C
     +#
2:  148027a14b = 2:  4c087ec041 t3432: test rebase fast-forward behavior
-:  ---------- > 3:  3d348d2c37 rebase: refactor can_fast_forward into goto tower
3:  ec55da0719 ! 4:  2559ab54a2 rebase: fast-forward --onto in more cases
    @@ -5,8 +5,8 @@
         Before, when we had the following graph,
     
                 A---B---C (master)
    -                \
    -                 D (side)
    +                 \
    +                  D (side)
     
         running 'git rebase --onto master... master side' would result in D
         being always rebased, no matter what. However, the desired behavior is
    @@ -49,6 +49,7 @@
     
         While we're at it, remove a trailing whitespace from rebase.c.
     
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
      diff --git a/builtin/rebase.c b/builtin/rebase.c
    @@ -64,45 +65,26 @@
     +			    struct object_id *head_oid, struct object_id *merge_base)
      {
      	struct commit *head = lookup_commit(the_repository, head_oid);
    --	struct commit_list *merge_bases;
    --	int res;
    -+	struct commit_list *merge_bases = NULL;
    -+	int res = 0;
    - 
    - 	if (!head)
    - 		return 0;
    + 	struct commit_list *merge_bases = NULL;
     @@
    - 	merge_bases = get_merge_bases(onto, head);
    - 	if (merge_bases && !merge_bases->next) {
    - 		oidcpy(merge_base, &merge_bases->item->object.oid);
    --		res = oideq(merge_base, &onto->object.oid);
    -+		if (!oideq(merge_base, &onto->object.oid))
    -+			goto done;
    - 	} else {
    - 		oidcpy(merge_base, &null_oid);
    --		res = 0;
    -+		goto done;
    - 	}
    -+
    + 	if (!oideq(merge_base, &onto->object.oid))
    + 		goto done;
    + 
     +	if (!upstream)
     +		goto done;
     +
    - 	free_commit_list(merge_bases);
    ++	free_commit_list(merge_bases);
     +	merge_bases = get_merge_bases(upstream, head);
    -+	if (merge_bases && !merge_bases->next) {
    -+		if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
    -+			goto done;
    -+	} else
    ++	if (!merge_bases || merge_bases->next) {
     +		goto done;
    ++	}
     +
    -+	res = 1;
    ++	if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
    ++		goto done;
     +
    -+done:
    -+	if (merge_bases)
    -+		free_commit_list(merge_bases);
    - 	return res && is_linear_history(onto, head);
    - }
    + 	res = 1;
      
    + done:
     @@
      
      	/*
    @@ -115,7 +97,8 @@
     -	    !is_interactive(&options) && !options.restrict_revision &&
     -	    options.upstream &&
     -	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
    -+	if (can_fast_forward(options.onto, options.upstream, &options.orig_head, &merge_base) &&
    ++	if (can_fast_forward(options.onto, options.upstream, &options.orig_head,
    ++		    &merge_base) &&
     +	    !is_interactive(&options) && !options.restrict_revision) {
      		int flag;
      
4:  2256a902c1 ! 5:  0a466e830f rebase: fast-forward --fork-point in more cases
    @@ -27,8 +27,8 @@
      {
      	struct commit *head = lookup_commit(the_repository, head_oid);
     @@
    + 	if (!oideq(merge_base, &onto->object.oid))
      		goto done;
    - 	}
      
     +	if (restrict_revision && !oideq(&restrict_revision->object.oid, merge_base))
     +		goto done;
    @@ -40,7 +40,8 @@
      	 * Check if we are already based on onto with linear history,
      	 * but this should be done if this is not an interactive rebase.
      	 */
    --	if (can_fast_forward(options.onto, options.upstream, &options.orig_head, &merge_base) &&
    +-	if (can_fast_forward(options.onto, options.upstream, &options.orig_head,
    +-		    &merge_base) &&
     -	    !is_interactive(&options) && !options.restrict_revision) {
     +	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
     +		    &options.orig_head, &merge_base) &&
5:  d6e7e1ca4b = 6:  c542c7afc1 rebase: teach rebase --keep-base
-- 
2.21.0.944.gce45564dfd

