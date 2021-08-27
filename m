Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2DDC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C769660F58
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhH0VRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhH0VRC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:17:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6884C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:16:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c12so13742300ljr.5
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ub1ToS5Aqxm4AqkbB7Bdgx5/d2BRs4Ea57ith4ahMg0=;
        b=IxxtYOYydlb9IVUF8tsc4fyMNqbng5mVem1qDwmtIw6cw77Ou/xk5SlWi8VpBr9mb2
         D37OD6rIjpk/zJ2Z5ALJmIbDLPsNYBbFuM0ExeGN2u60QPxjWPkgSHiXUiX36qIAKDLM
         wxWe15bj2UsssBHBDecZpp9etJsUuTXgW9tQZi3tWQC0Cp0/Wknb1izKCokfPVfUTUgp
         QAUGzwQ5nI+S/W0qBSxB7x0Pcj80VxPfv+uu454EKvlS8OTp+1bgldV/GujFQl1kbnXM
         3Ww+AHRgHrE4M3uklOhEZkIiVytKIGZn6GPzqnlCpZ4v21MJlguPDaoGsEnMlScEkuJs
         leJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ub1ToS5Aqxm4AqkbB7Bdgx5/d2BRs4Ea57ith4ahMg0=;
        b=kJacmRBfrFcZGO7pwbnZs+TQYRJgDFTrUFKB7fDUyab33KEd7FxI+WF9HVgKMGtJ+M
         S6UX8SqiFwg0QAeIYMtWPfwe7jvVKd3bl4/tCmqdY1AxZCq1S84XVt6geoD8kWriihJz
         vc/gKc/HZdJwXIxDXbsAtyhrPvZQfMQmCBz6kd6jrIAKgCXMHo++wMFra5OYZICetWnG
         QbFbnucPMiYvo8xIMxoaEWqCFQerxtYg6Sy6llkM2TIFujOnBd6Npw0RW3zr2f5Hkf2T
         1bBm1GQqzrg3YopCydgDON/DNyyekshbMyyvcpB+dhrY/oo9vB4QPQcDU99NppC7QHvW
         M7eA==
X-Gm-Message-State: AOAM533fB+5bd7oIUjYar33WMq1pjvg6xoGB3DsY6tcUyHGxu56tNC4c
        EGmg/fO2jgr84VnlfiGqXunfe1ycn4mtl2sRMuHP92c08y24KA==
X-Google-Smtp-Source: ABdhPJx12Iqbq8VWd/xwCEbt8k/JICPOSuYsxjnrk+0jMm6Q131FFGHbFpYbXo4SVLEVKZ6eajDk2kp+Jjr9tR1ZB6U=
X-Received: by 2002:a2e:8906:: with SMTP id d6mr9303243lji.248.1630098971185;
 Fri, 27 Aug 2021 14:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com> <f1764f9ed187a2f383bd8269e198192fe0486bda.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <f1764f9ed187a2f383bd8269e198192fe0486bda.1629842085.git.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 27 Aug 2021 18:16:00 -0300
Message-ID: <CAHd-oW5ZgG0Rr4THdeyWQtkdNpJGmp-WuCW7RjJA1AiN1nmSKg@mail.gmail.com>
Subject: Re: [PATCH 08/13] add: prevent adding sparse conflict files
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When a merge results in a conflict outside of the sparse-checkout cone,
> the conflicted file is written to the working tree and the index entry
> loses the SKIP_WORKTREE bit. This allows users to add the file to the
> index without realizing that the file might leave the working tree in a
> later Git command.
>
> Block this behavior, but keep in mind that the user can override the
> failure using the '--sparse' option.

Hmm, didn't we already block this behavior at patch 6?

Nevertheless, as I mentioned there, I think the change to
find_pathspecs_matching_skip_worktree() from this patch should be
together with the other changes from 6.
