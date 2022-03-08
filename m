Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D99DC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 08:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbiCHIGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbiCHIGu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 03:06:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3483E5E4
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 00:05:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m22so16484225pja.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 00:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBdfjUDmA/VC/T6IgycwmHdMxZLyPQQkTb9NJNeFUqw=;
        b=PnewnY2WeYsj0EH/6HUtrIorXs8Yf0zxHa1P9hLilMkUZfcnPtmwPCiKWtwTXa7Thh
         wSMWVARYK+rH5Wjinj9qevRDV3O61iLTh4vGvGSVig0Jl4cL1C/MHA5EG+1EDIiv3A03
         KdPp4lPcmsxW903JrCq+7keJEW8DIOKZFyShqrXuNywGcjQNd8e90bIA7nmlgMUdWvRT
         lFDusXtrdU3m95Wzy9uSLlRgWUv9yld6kKMJajKaFFw7HHFX0qPopfXG3kY4vYJK5jlW
         pLCroG8bZYtx80m+m1kmBQFDLT9QvGsTj22NCr4JgZSUK8fr+zvNa50r53XgVDUkfmJd
         zY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBdfjUDmA/VC/T6IgycwmHdMxZLyPQQkTb9NJNeFUqw=;
        b=K2tZLbHTowcg8MnixWraNan/IOsCq2TwzRl9FS8wz3Wf6rsGtd3yplTJPRTXOgCb/n
         GACELBeV1vdY1EUKuuvip9n4UZAbSrPUMvfBLZP1EikEFoqeAHfRiFZEq2pWToR2BNPJ
         7aDAqR4tjXsBz6t2vkNdwwxLpqTn1QJ6Ynt44L1omiwRBJGoXpbZoravdK24SAQg++o4
         BPkZEvz8uUuBmD/RfSQSblmQe+XOdJNV+kJcAQMz2FkpTtWcLYTyxuCtRUHySEUNQ52h
         OSRPsXPbPZPyH44chdfONmxibUssQJivxhoflNEmBtNIUiRbYEe6KsdGZyFWlZkyuF6H
         Hx4w==
X-Gm-Message-State: AOAM533BW5DQiPAEOQQhxObyPutIcVKf49OWfRoIgMi4alUeCw3/+FbQ
        ZEB5zu7OlPvHy13+gm++cdw=
X-Google-Smtp-Source: ABdhPJwWEeiI+Um0O8qDfmqbt0UY4AT+PWyuA0ARNqAj1sLf+0edUBR8GPgVw5avfer1KEyCaeNZwA==
X-Received: by 2002:a17:902:d202:b0:14e:f6b4:aa0f with SMTP id t2-20020a170902d20200b0014ef6b4aa0fmr15920268ply.104.1646726754484;
        Tue, 08 Mar 2022 00:05:54 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.33])
        by smtp.gmail.com with ESMTPSA id oo16-20020a17090b1c9000b001b89e05e2b2sm2008927pjb.34.2022.03.08.00.05.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:05:54 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: What's cooking in git.git (Mar 2022, #02; Mon, 7)
Date:   Tue,  8 Mar 2022 16:05:51 +0800
Message-Id: <20220308080551.18538-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <xmqqilspp5yg.fsf@gitster.g>
References: <xmqqilspp5yg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote on Mon, 07 Mar 2022 17:51:19 -0800:

>[Stalled]
>
>* tl/ls-tree-oid-only (2022-03-04) 12 commits
> - ls-tree: support --object-only option for "git-ls-tree"
> - ls-tree: introduce "--format" option
> - cocci: allow padding with `strbuf_addf()`
> - ls-tree: introduce struct "show_tree_data"
> - ls-tree: slightly refactor `show_tree()`
> - ls-tree: fix "--name-only" and "--long" combined use bug
> - ls-tree: simplify nesting if/else logic in "show_tree()"
> - ls-tree: rename "retval" to "recurse" in "show_tree()"
> - ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
> - ls-tree: use "enum object_type", not {blob,tree,commit}_type
> - ls-tree: add missing braces to "else" arms
> - ls-tree: remove commented-out code
>
> "git ls-tree" learns "--oid-only" option, similar to "--name-only",
> and more generalized "--format" option.
> source: <cover.1646390152.git.dyroneteng@gmail.com>


Sorry for the late reply.

I posted a updated patchset last week, we already had a private review on that,
but maybe string need Ævar Arnfjörð Bjarmason for taking a look.

Thanks.
