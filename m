Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAA71F597
	for <e@80x24.org>; Sun,  5 Aug 2018 03:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbeHEFje (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 01:39:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46110 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbeHEFjd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 01:39:33 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so4192100ply.13
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WUDNZOLZKR4Ukv5y6RJr8z+ChB2KwICSLiIx10/4kOE=;
        b=WbgUJjTGR6CQmMCwq9bEz8CHd+DdlGEoMhV1Jj5l7IcdlrhNgQdIZ07mo7lJKk01Oz
         wutbxr70DglFzMwseeTDBG0WKDqTnyswV52by8YSUnNDSx676yj9qc3ugT8cRYKT6xbD
         YzcH8RCjEvVLzS7aMx/CUIWW504S0kqhaUK8IvQV68sWsPitPZTAcK7kLHzSohT4VusO
         kwrM4BaWHGg9O2h0MPdJWQdyJLcr8cCMZsUXFx6HNtIC7taWFZe65/V6bf7dmF0rJ+uN
         kNiip3ZI0aqJ/KUXayg3TrkGnVpYLyo/rfsionWo22sobIdxPM2kFy0rxuR91uCmS3mh
         qGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WUDNZOLZKR4Ukv5y6RJr8z+ChB2KwICSLiIx10/4kOE=;
        b=amK2cGDeKvZDO06KlEgQN6wvlYL8ZqlJCG9ZDPpynTNxe/IRzPBzqb1zW3S68xoWBa
         wYU+bfpTV+8d56dP1PccqaAZWqfLMxNWHJiphjH7Eazof7K3xr19+wkr1IsSxXjjPI/m
         HLYMNSHSC4JkNU47eNQxKTwglRXH47j8JnMEJk7tjW20qN2Ken6eLMUiMBroALqixXDZ
         cDydhnpHoV8cE6uXOVU+PtGyRCWkazsYKtlL2B7KpuvXN0Np+a6rk3NWF8rQwIqgRlap
         nRZqdw/Nq2vvQ77PkHp8DW03JnZKF3zQWJWGBFVHwN4XbExqNuPnFH5zJapv1/XtUbFo
         okVw==
X-Gm-Message-State: AOUpUlHv6kQ5mKTBN0REOx1ZX4NSKc1CrfqJcPhdUYIlguX+sDkFLJYZ
        Jg0YIQOAu+BL1I3bipvaR7I=
X-Google-Smtp-Source: AAOMgpdjwg113asv73e705L2mi8klQHZ/VgfTne5cjEjlus7/MkooPYsjXUJxH6gynZ1Pt1/mG6Bqw==
X-Received: by 2002:a17:902:bd97:: with SMTP id q23-v6mr9198939pls.311.1533440191779;
        Sat, 04 Aug 2018 20:36:31 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n80-v6sm16202986pfb.95.2018.08.04.20.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 20:36:31 -0700 (PDT)
Date:   Sat, 4 Aug 2018 20:36:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     William Chargin <wchargin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] t/test-lib: make `test_dir_is_empty` more robust
Message-ID: <20180805033629.GH258270@aiede.svl.corp.google.com>
References: <20180805022002.28907-1-wchargin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805022002.28907-1-wchargin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

William Chargin wrote:

> While the `test_dir_is_empty` function appears correct in most normal
> use cases, it can fail when filenames contain newlines.

This information belongs in the commit message, since it's useful
context for understanding the motivation behind the patch when
encountering it with e.g. "git log".  That's part of why I recommend
never sending a separate cover-letter email for a single-patch series.

See [1] from Documentation/SubmittingPatches for more on this subject.

>                                                         I originally
> wrote this patch for the standalone Sharness library, but that library
> advises that such patches be sent to the Git mailing list first.

Thanks for writing it!  Continuing the note about administrivia, this
kind of cover letter material that you want to not be part of the
commit message can go below the three-dashes delimiter when you send a
patch.  There's more about this at [2].

Thanks again,
Jonathan

[1] https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#describe-changes
[2] https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#send-patches
