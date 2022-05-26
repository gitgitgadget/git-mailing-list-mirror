Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71043C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 09:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbiEZJVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346858AbiEZJVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 05:21:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFE6C6E5B
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:21:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e28so1356560wra.10
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3YN9KS8+rMJOYSsWrB98cjmYylZ/4PHa3tlTcQC9Abs=;
        b=WNHzcR45EgR4qcfOSQk+T9KoQ0HDSn0BJA1RJrWinEnxP1OXjELm85lsO6B29BYRdC
         W0rQJus7p1OzLo89rLTSSSRWqZzUVLqCcDStc4mY5+b6d6eWm5EPbBhjgG8pTtlBELLl
         2T669K67hJvugVpTdvIWPkPMOIH4X0MlWS6wZugD/cP1uGgimIbXGxqXPkRpQf782UbD
         4jLPfv4TxLzbvfK4NVGedzSGRF554NqpXZfJwu4TRvIy/8iupal7kfKZV13+kOb8elfL
         +l5owNJTJADzg45sOSzA4Tf+XFJOHCFbSJzAnPjCnXdeyMWFmnXEQSu0Fs1aeWT1jt3T
         czgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3YN9KS8+rMJOYSsWrB98cjmYylZ/4PHa3tlTcQC9Abs=;
        b=lIdnZ/9OLuHbNkPduvcBjDzfzehRgrN3lWE4+iKu7BLIfvdgcJJv3xxz7/TTr3eH3D
         xiqWOLdGpyegZ4Lw+Zhtkcg59EC/MmaOwU8Da1VsHaabwKTyzGmpCX3jrObvaH5g/L6j
         2ziRehqe2j8r/iN34wNBLjtytJZzOpiRwIRQBMRxx9XSvR+0svBmo8cr86G+p4lUfjN5
         f5qtvJbJT0T57nVYZncnsuoI+p+WwFkUn+kRN3eWAU6wQKh5q0I1ckAKawAGrnPRopbX
         1oIwrAyncWun+0Pd0ak6YESv8BpRvDfOQI5lpx84Y41WdxlhewX1l/AkGszMzmxqddIB
         9d7g==
X-Gm-Message-State: AOAM530kGpaVRPBoru9jicrRExlvxKW0eXU0Z0cSS7tZCcxRs2fz0Vez
        WTY+S+63jC3qfkJVq1CE311nS7ZCnBI=
X-Google-Smtp-Source: ABdhPJwGXvfBBU60h69qQWXfPTXJR5fgjkyQLRYb3KsnDeo6u1p1AlEzBchKgr+3feuwQdf/pDULCQ==
X-Received: by 2002:a5d:414d:0:b0:210:531:81f9 with SMTP id c13-20020a5d414d000000b00210053181f9mr3480308wrq.67.1653556866229;
        Thu, 26 May 2022 02:21:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a05600c410300b0039732f1b4a3sm1436078wmi.14.2022.05.26.02.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:21:05 -0700 (PDT)
Message-Id: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 09:21:02 +0000
Subject: [PATCH 0/3] Die preserve ggg
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series is a follow up to GitGitGadget "Update the die()
preserve-merges messages to help some users (PR #1155)" [1].

The first patch is a tidy up of the --preserve option to highlight that it
is now Deleted, rather than Deprecated.

In response to Avar's comments that the former error message merely
'tantilised without telling' the user what to do, it became obvious that the
underling problem was that the user was unable to git rebase --abort which
was also fatal, when a preserve-rebase was in progress.

Thus the main update is to allow the rebase --abort command, even when a
--preserve is in progress, to proceed. The --abort code was unchanged by the
removal of the preserve option, as the resetting and clean up of internal
state is common to the other rebase options.

The user facing fatal message now simply advises to abort, or downgrade to a
version that has preserve-merges to complete the rebase.

The final patch highlights that some IDEs still allow the setting of the
preserve-merges option as a pull config setup.

Philip Oakly

[1] GitLore ref pull.1155.git.1645526016.gitgitgadget@gmail.com
https://lore.kernel.org/git/pull.1155.git.1645526016.gitgitgadget@gmail.com/

Philip Oakley (3):
  rebase.c: state preserve-merges has been removed
  rebase: help users when dying with `preserve-merges`
  rebase: note `preserve` merges may be a pull config option

 builtin/rebase.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)


base-commit: c4f0e309ae745751d08727f24e8ff55e56355755
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1242%2FPhilipOakley%2Fdie_preserve_ggg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1242/PhilipOakley/die_preserve_ggg-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1242
-- 
gitgitgadget
