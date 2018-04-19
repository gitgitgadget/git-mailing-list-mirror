Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06CFF1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 20:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeDSU0z (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 16:26:55 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36122 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753366AbeDSU0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 16:26:53 -0400
Received: by mail-wr0-f170.google.com with SMTP id q13-v6so17343445wre.3
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnU41KEoFNWspbtgj5kg7fuQ2fBkzZxkOCASM2odA2A=;
        b=NBoR4Mp8AbZzOEL6t36MScZgzK6tTiOFLe0WCCHPPGukEMgcG5qT5IPbRhVjxCCK/e
         EsokyBv9v4cRh0L/P0nHETQpLglWYKttaV63W5vkrP/sYE9pN0TXGvxmacFwBlDwDwTk
         wSGmwF8t0JkUlt6F+nGLMDPrrNQ+yF82Ma6I+E5H7aP4ZIjbNwfZwv5gZbZAZosEb/r0
         YwsIuEpRtw2cgpKJGE+0yokW+hDv/f4kPq4TMF/EMIl4Swh7dg9+Ivrg1t+SzqaG//yN
         HKFZLB4zZJqBU2HWNzN9RnUG6MonWD9NdGtLLBUXG+zBu/cOv64T/VVoZfKIfFnsyVoU
         2Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnU41KEoFNWspbtgj5kg7fuQ2fBkzZxkOCASM2odA2A=;
        b=cIgpSPRh/8SO4VhbQHpzQHw5WA6XAXhBYDp0jSH/GfJ66jUj++Sd6pZ7foDYq0uQ9s
         Kj+GTj1fKfqmo1x5EDImMPoTsFEInsF9KolOiUw5iN3nL2vv+ACGYz+Bp6T7AWSuRfZ2
         qLgGE+9AkkJNbOKxOLOyDVn/xbn3kZon9bE0tbSlMe5k6JUoHe+te+ISEBO4ux2FkUeY
         CnusYQMGyUztiyfw26Aoe6jasqpYGuFEv1SAWuTd4GmoQSl97ehDCPa47fqQWxx7tGs0
         VLGL9EVJZayvaSYfaCLWeCPS93OYgoRSp6v5vVayLlyzFxQYvkyRmdJELJODbO/LlTYi
         L4LQ==
X-Gm-Message-State: ALQs6tBE3YOiGvYIUUV87jxPUT7xru2yLuDjKCsjsooQoH8KShhG1F1v
        2N0pGqqSUHNdPMo5zF+K5TY=
X-Google-Smtp-Source: AIpwx49Cf7Aa9r4a67HH5Oo2+8qu7HtaWv78O9EkkT91LMw8Nr0ZUtANx8qagMLQOOhtVXz02Aua5Q==
X-Received: by 2002:adf:ba50:: with SMTP id t16-v6mr3469273wrg.237.1524169612281;
        Thu, 19 Apr 2018 13:26:52 -0700 (PDT)
Received: from localhost.localdomain (x590cec04.dyn.telefonica.de. [89.12.236.4])
        by smtp.gmail.com with ESMTPSA id u35-v6sm6201505wrc.29.2018.04.19.13.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Apr 2018 13:26:51 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v10 32/36] t6046: testcases checking whether updates can be skipped in a merge
Date:   Thu, 19 Apr 2018 22:26:41 +0200
Message-Id: <20180419202641.13593-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.geecde6d7e
In-Reply-To: <20180419175823.7946-33-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-33-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a couple of minor things:

> +###########################################################################
> +# SECTION 1: Cases involving no renames (one side has subset of changes of
> +#            the other side)
> +###########################################################################
> +
> +# Testcase 1a, Changes on A, subset of changes on B
> +#   Commit O: b_1
> +#   Commit A: b_2
> +#   Commit B: b_3
> +#   Expected: b_2
> +
> +test_expect_success '1a-setup: Modify(A)/Modify(B), change on B subset of A' '
> +	test_create_repo 1a &&
> +	(
> +		cd 1a &&
> +
> +		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b

Broken && chain.

<...>

> +###########################################################################
> +# SECTION 2: Cases involving basic renames
> +###########################################################################
> +
> +# Testcase 2a, Changes on A, rename on B
> +#   Commit O: b_1
> +#   Commit A: b_2
> +#   Commit B: c_1
> +#   Expected: c_2
> +
> +test_expect_success '2a-setup: Modify(A)/rename(B)' '
> +	test_create_repo 2a &&
> +	(
> +		cd 2a &&
> +
> +		test_seq 1 10 >b

Broken && chain.

> +		git add b &&
> +		test_tick &&
> +		git commit -m "O" &&
> +
> +		git branch O &&
> +		git branch A &&
> +		git branch B &&
> +
> +		git checkout A &&
> +		test_seq 1 11 > b &&

Nit: space between redirection operator and filename.

<...>

> +# Testcase 2b, Changed and renamed on A, subset of changes on B
> +#   Commit O: b_1
> +#   Commit A: c_2
> +#   Commit B: b_3
> +#   Expected: c_2
> +
> +test_expect_success '2b-setup: Rename+Mod(A)/Mod(B), B mods subset of A' '
> +	test_create_repo 2b &&
> +	(
> +		cd 2b &&
> +
> +		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b

Broken && chain.

<...>

> +# Testcase 2c, Changes on A, rename on B
> +#   Commit O: b_1
> +#   Commit A: b_2, c_3
> +#   Commit B: c_1
> +#   Expected: rename/add conflict c_2 vs c_3
> +#
> +#   NOTE: Since A modified b_1->b_2, and B renamed b_1->c_1, the threeway
> +#         merge of those files should result in c_2.  We then should have a
> +#         rename/add conflict between c_2 and c_3.  However, if we note in
> +#         merge_content() that A had the right contents (b_2 has same
> +#         contents as c_2, just at a different name), and that A had the
> +#         right path present (c_3 existed) and thus decides that it can
> +#         skip the update, then we're in trouble.  This test verifies we do
> +#         not make that particular mistake.
> +
> +test_expect_success '2c-setup: Modify b & add c VS rename b->c' '
> +	test_create_repo 2c &&
> +	(
> +		cd 2c &&
> +
> +		test_seq 1 10 >b

Broken && chain.

<...>

> +###########################################################################
> +# SECTION 3: Cases involving directory renames
> +#
> +# NOTE:
> +#   Directory renames only apply when one side renames a directory, and the
> +#   other side adds or renames a path into that directory.  Applying the
> +#   directory rename to that new path creates a new pathname that didn't
> +#   exist on either side of history.  Thus, it is impossible for the
> +#   merge contents to already be at the right path, so all of these checks
> +#   exist just to make sure that updates are not skipped.
> +###########################################################################
> +
> +# Testcase 3a, Change + rename into dir foo on A, dir rename foo->bar on B
> +#   Commit O: bq_1, foo/whatever
> +#   Commit A: foo/{bq_2, whatever}
> +#   Commit B: bq_1, bar/whatever
> +#   Expected: bar/{bq_2, whatever}
> +
> +test_expect_success '3a-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
> +	test_create_repo 3a &&
> +	(
> +		cd 3a &&
> +
> +		mkdir foo &&
> +		test_seq 1 10 >bq &&
> +		test_write_lines a b c d e f g h i j k >foo/whatever &&
> +		git add bq foo/whatever &&
> +		test_tick &&
> +		git commit -m "O" &&
> +
> +		git branch O &&
> +		git branch A &&
> +		git branch B &&
> +
> +		git checkout A &&
> +		test_seq 1 11 > bq &&

Space between redirection operator and filename.

<...>

> +# Testcase 3b, rename into dir foo on A, dir rename foo->bar + change on B
> +#   Commit O: bq_1, foo/whatever
> +#   Commit A: foo/{bq_1, whatever}
> +#   Commit B: bq_2, bar/whatever
> +#   Expected: bar/{bq_2, whatever}
> +
> +test_expect_success '3b-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
> +	test_create_repo 3b &&
> +	(
> +		cd 3b &&
> +
> +		mkdir foo &&
> +		test_seq 1 10 >bq &&
> +		test_write_lines a b c d e f g h i j k >foo/whatever &&
> +		git add bq foo/whatever &&
> +		test_tick &&
> +		git commit -m "O" &&
> +
> +		git branch O &&
> +		git branch A &&
> +		git branch B &&
> +
> +		git checkout A &&
> +		git mv bq foo/ &&
> +		test_tick &&
> +		git commit -m "A" &&
> +
> +		git checkout B &&
> +		test_seq 1 11 > bq &&

Space between redirection operator and filename.

<...>

> +###########################################################################
> +# SECTION 4: Cases involving dirty changes
> +###########################################################################
> +
> +# Testcase 4a, Changed on A, subset of changes on B, locally modified
> +#   Commit O: b_1
> +#   Commit A: b_2
> +#   Commit B: b_3
> +#   Working copy: b_4
> +#   Expected: b_2 for merge, b_4 in working copy
> +
> +test_expect_success '4a-setup: Change on A, change on B subset of A, dirty mods present' '
> +	test_create_repo 4a &&
> +	(
> +		cd 4a &&
> +
> +		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b

Broken && chain.

<...>

> +# Testcase 4b, Changed+renamed on A, subset of changes on B, locally modified
> +#   Commit O: b_1
> +#   Commit A: c_2
> +#   Commit B: b_3
> +#   Working copy: c_4
> +#   Expected: c_2
> +
> +test_expect_success '4b-setup: Rename+Mod(A)/Mod(B), change on B subset of A, dirty mods present' '
> +	test_create_repo 4b &&
> +	(
> +		cd 4b &&
> +
> +		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b

Broken && chain.

