Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB6CC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 09:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiCQJxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 05:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiCQJwv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 05:52:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D81C7F1E
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 02:51:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a5so6424952pfv.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 02:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdXg26NCTl45zYcQQWfiB6iWah5cwhazmZ8TuR+szdA=;
        b=fhtOYZs1Xwg+RyWK9g2l5BblB2TtrKRthf9mfyAg1czuk+En5p3JLP4E5x17Y87MWe
         O6GZgDOeqjr+yPsqeWPLhJc/i1I3EbT+5qFCYAXGOki3pFWfxMZotQQHILv6Xh5CipsU
         v9SGNMO40+HBffyLUDgXNEhxPDZclTVCeo6SZv4mGStrJk3kArnLR2Higeifrs9CbMiW
         RFxEct8qQisL2L74lQojq12dMKLH25LeleyZhFxasNjjRI93bYXIyQN9nGdqabyLC2zD
         uQmRgBbLzfyCi13lAJmTEuhJOnmBeE0U7XDLOXV5/DQgMgJbP8uXaz0R5beZCaGyZRyF
         87wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdXg26NCTl45zYcQQWfiB6iWah5cwhazmZ8TuR+szdA=;
        b=mDNzXdhG/VWgwI4QDPx4uYtgikZdiwg1YRov10Hp+AQDelWye8AzMYXuvkfRcIuZHf
         M/1aCq0PIZYhYM/lucgvMdhvRm+zn/ZWFLjHEop8m+dqcFPEjBMhc67BcfhC4XzsLbGG
         fA78iKBvcGL0OWn7U2yrwSdd3x3LhQBnk0bk5dBGtfo9a161477jNyYG/C2ISik7RhE8
         As5YO2rAcd0FBqaukHaTsZnhkWg5hF0Cl2BI7TJ36aVy7i6v9iicVU9kY7U/vKsZciYl
         6XgzCKvVaOWo7q6EBiMdCRi/qUkj3SOGfab0EsSJQKU4DwQABE49+j1tnr0zD+Itf327
         8rKQ==
X-Gm-Message-State: AOAM532cQDZelpATzvu6JWErsbqKhTbVVpg/UJX86VXsNaHVpdgNqSc+
        89IrS+fsNEYTdmE2L6337g0=
X-Google-Smtp-Source: ABdhPJyBT1lIlSqd8OJ94+CAJXRwONNOkPMocGgv3oIPDRs/1uk3Bc1VUQDUcMwSC8QqJ3UaDFQ9Qw==
X-Received: by 2002:a63:4845:0:b0:378:43b1:a3b9 with SMTP id x5-20020a634845000000b0037843b1a3b9mr2944986pgk.221.1647510694863;
        Thu, 17 Mar 2022 02:51:34 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.54])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm6723729pfm.17.2022.03.17.02.51.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2022 02:51:34 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC/REVIEW 0/7] fixups/suggestions/musings for tl/ls-tree-oid-only
Date:   Thu, 17 Mar 2022 17:51:29 +0800
Message-Id: <20220317095129.86790-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote on Thu, 10 Mar 2022 14:56:56 +0100

> I don't think all of these need to be squashed or fixed up into the
> proposed series, but are just various small issues/questions I came 
> with while reviewing it. Brief notes 
>
> Ævar Arnfjörð Bjarmason (7):
> ...


I looked these commits in "RFC/REVIEW" and I think each one is a good
improvement. So next, to make the squashes or keep it alone  I think
maybe it's like: 


(1) ls-tree tests: add tests for --name-status

    They are new test codes that better than old ones. 

    Action: Keep it individually.

(2) ls-tree tests: exhaustively test fast & slow path for --format

    They are better test codes for the correctness formatting mechanism.

    Action: Squash into commit 'ls-tree: introduce "--format" option'

(3) ls-tree: remove dead labels

    They remove the dead labels, and you mentioned it should be squash into
    the commit which brought them in.
    
    Action: Squash into commit 'ls-tree: slightly refactor `show_tree()`'

(4) ls-tree: remove unused "MODE_UNSPECIFIED"

    As the subject describes, remove unused "MODE_UNSPECIFIED" and make
    "mutx_option" to a better name "mutx_option". It's the prepared commit
    for 'ls-tree: remove FIELD_*, just use MODE_*''

    Action: Squash into commit 'ls-tree: slightly refactor `show_tree()`'

(5) ls-tree: detect and error on --name-only --name-status

    Optimized the incompatible detecting tests codes in "t/t3103-ls-tree-misc.sh"
    and add a new 'MODE_NAME_STATUS'.

    Action: Keep it individually.

(6) ls-tree: remove FIELD_*, just use MODE_*

    Using MODE directlly and make a format-mode mappings for fast-path detection.

    Action: Keep it individually.

(7) ls-tree: split up "fast path" callbacks

    Expand "ls_tree_cmdmode_format" structure for each formats with the specific 
    show function and split up the current show functions name.

    Action: Keep it individually.


This is the way I try to continue this work, please let me know if I understand you wrong.

I look forward to your reply and I will decide the next step based on the reply. If we have
a consistent understanding of the next actions, I will try to make a pull request to your
Git fork first. If there is no problem, I will continue to send patches to the mailing list.

Thanks.
