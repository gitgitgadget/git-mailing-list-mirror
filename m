Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3513C433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 23:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiDDXWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiDDXWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 19:22:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86850FD08
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 16:20:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b13so10486040pfv.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U3+hn+kkItEZ1CZFqz/UcDTttLeEuFo9J3TUWiR4owg=;
        b=oRcS9klq/1xZaUBLVwHeP4+8LRU2Qa9gP1zc/Wc0WRxEoRMRRAytPeyFvC1v3Tw0LB
         gLg/ZtRssdCDV/DkQDHbA/wv+DLgViv/ir+Ih+3TSzPwC/3O1H5/LkuFNkajpTo3TX0v
         Z2+KLjfVSe5/l8+4KVdSUtRKjbE4jErFHvin7xklB47dYN3YvHTSattF1fpfC3vbCv3f
         fsfZbpdAe+/lYP7bwzQd0wakrefAGFLE9vgnnW/9nKKd4dtJB0KtDIf23yf4bxVwuLxW
         2pHMuQQrhyM7AU3CucCyYM1SgN6P7YM6vUBhBH8s/FBEo6pjNR3bBdSclnwuGFHsgee0
         OryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U3+hn+kkItEZ1CZFqz/UcDTttLeEuFo9J3TUWiR4owg=;
        b=TdticKmTkR+KR3EKt9JOAFRFk/mN3zJcbE7K3dGxzy3kEgUdQfuq+hzj39cJrLzVGh
         xvN2WAJibR04TyWcHUkgEwZI+hF5u2WSdRNKVKbNk18NAj4raCvnuCRlutldv9YyZr20
         7w7keL0BhFKL0Aj+APgl1H3RpDoq/V96JXKd+louVidFkCq9CJ8k/jeGhZvsCXlB8ZzY
         RqNdTtGxpNGgX9UXY3mXTV3ffL+MvL1jhoUMjw0qchwMVUz3EAfhEWkKfSDNDSCaPVFd
         /KHHBZ1T5EH6YSiU6O6SPsSsfJnYqk+jI5p61L4K9Rg7ZIedch12EF15tESYNU00i4hN
         J76g==
X-Gm-Message-State: AOAM530WTJdQdNxvsDHUkqKHlEaIvhiZen9wLNKhzGDFpeBV22jtQZFb
        qQcBmXMDb48wfFk0DEd/jLU2eZvPU8Q=
X-Google-Smtp-Source: ABdhPJwdaMZrxyYS5A3AxQuBNJuNLqBW4+jKrzvHmk7nAq6FPHCldGO/iaCyykLLieuXp1S+GvONrA==
X-Received: by 2002:a63:7d4a:0:b0:398:dad:6963 with SMTP id m10-20020a637d4a000000b003980dad6963mr432598pgn.329.1649114417917;
        Mon, 04 Apr 2022 16:20:17 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090a66c600b001ca7dbe1bc2sm192430pjl.46.2022.04.04.16.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 16:20:16 -0700 (PDT)
Date:   Mon, 4 Apr 2022 16:20:14 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ns/batch-fsync (Mon Apr 4, 2022)
Message-ID: <20220404232014.GA75@neerajsi-x1.localdomain>
References: <xmqqilropo3z.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqilropo3z.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 04, 2022 at 01:53:04PM -0700, Junio C Hamano wrote:
> * ns/batch-fsync (2022-03-30) 14 commits
>  - core.fsyncmethod: performance tests for batch mode
>  - t/perf: add iteration setup mechanism to perf-lib
>  - core.fsyncmethod: tests for batch mode
>  - test-lib-functions: add parsing helpers for ls-files and ls-tree
>  - core.fsync: use batch mode and sync loose objects by default on Windows
>  - unpack-objects: use the bulk-checkin infrastructure
>  - update-index: use the bulk-checkin infrastructure
>  - builtin/add: add ODB transaction around add_files_to_cache
>  - cache-tree: use ODB transaction around writing a tree
>  - core.fsyncmethod: batched disk flushes for loose-objects
>  - object-file: pass filename to fsync_or_die
>  - bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
>  - bulk-checkin: rename 'state' variable and separate 'plugged' boolean
>  - Merge branch 'ns/core-fsyncmethod' into ns/batch-fsync
> 
>  Introduce a filesystem-dependent mechanism to optimize the way the
>  bits for many loose object files are ensured to hit the disk
>  platter.
> 
>  Will merge to 'next'?
>  source: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>

Please expect a reroll today to address the remaining issues in that thread.

Thanks,
Neeraj
