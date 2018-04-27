Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCE91F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759279AbeD0V24 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:28:56 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:37582 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759079AbeD0V24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:28:56 -0400
Received: by mail-yb0-f176.google.com with SMTP id i13-v6so1127162ybl.4
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+KE4XYtvx2MuZ8VjmTSFQE+1TEra38BN1NNoYuQFIgI=;
        b=hmnoZc8yg5tB0tQ2hgY8B8yFCyuzwUrGjOIuCAXu7of31j1qhVBLk+J+vPbxGEw/M8
         RONch0IVXeDm25RX01JgI4RfKgRQrgfjwURTTWpp9q9SA/h5l/6WCJoWscoM+rKREoNc
         1pYbghHovBYQ2Lh1UYl7+f9RHKJwqcinwxvPrtW85OwtV37+vJDI7xjgrSl42jyFg2O4
         H4I1lgvjQK1HFbIbY7zFNpK6MYR7BVvjIoJn48t/Fu9q6l6Yh5crNrG3iJzXM7lts5D/
         1zeUWWc/G9fsqm8J/dNh64oSrbKYMH9MS9ubpWufQi4HqV7JxzFtGLNFNijWLfYE59AK
         sbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+KE4XYtvx2MuZ8VjmTSFQE+1TEra38BN1NNoYuQFIgI=;
        b=iBzsqGRNGVZLDKGVwvDmXdiZjwRrRZnzEG1dr8ueJZUzith9F7l6i1dw7q9W+VXTev
         +PVnGsQNl/cQbiM51Vt6TKCWju5oDE0c41dhSoUnf+rO4/ttyRFrqIRinr5PmK38o7Zt
         BwTnbMYw4zTqHUcWzATy4QA+b+lgpUEWNW2TmjcKrhyuO/5jJKk953OSt9VZJbqQVA3p
         7xaWoA8h20AyId7oP6QV1bcZOaT4DvpmBRggqAXwYmmRTq2Mt9SRzF/fXXSoyIoAoCXn
         YBZ4TwPmkFEMKUn96FbcUjppWmYiGP8pBVjAqqbRs7rH0jpKcPIHhZnJIY8cunppwZcW
         qOEw==
X-Gm-Message-State: ALQs6tASvtANVvr2NQKj3KwqPn6F90kdgQ6SGI1Gu3BfaHqermEwZxeV
        GNBhqpqySjpHWShid+D6ULdD7LreiTeUYWjVHVpxeA==
X-Google-Smtp-Source: AB8JxZphLfg94cHEw5+KTxbLgPU1ZdPXtuZr31olalIaRG4e/8zE7N4nkBMXP8v+jKZlAXxp+DXfXqUMNqMrN3q5UmA=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr2115855ybn.167.1524864534999;
 Fri, 27 Apr 2018 14:28:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Fri, 27 Apr 2018 14:28:54
 -0700 (PDT)
In-Reply-To: <08609b5f2d5bc7f3f6d010088db4b58695dfbd64.1524862093.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
 <cover.1524862093.git.johannes.schindelin@gmx.de> <08609b5f2d5bc7f3f6d010088db4b58695dfbd64.1524862093.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Apr 2018 14:28:54 -0700
Message-ID: <CAGZ79kYJ--qt5AdM3EX9vwMb_AwD6gtWFp7wt2KP4OKsdOYLGQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] rebase --skip: clean up commit message after a
 failed fixup/squash
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 1:48 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> During a series of fixup/squash commands, the interactive rebase builds
> up a commit message with comments. This will be presented to the user in
> the editor if at least one of those commands was a `squash`.

This sounds as if the whole series will be presented to the user, i.e.

 pick A
 squash B
 fixup C

would present A+B+C in the editor. I always assumed the sequencer
to be linear, i.e. pick A+B, open editor and then fixup C into the
previous result?

No need to resend it reworded, I just realize that I never tested my
potentially wrong assumption.

> The diff is best viewed with --color-moved.

... and web pages are "best viewed with IE 6.0" ;-)

I found this so funny that I had to download the patches and actually
look at them
using the move detection only to find out that only very few lines are moved,
as there are only very few deleted lines.
