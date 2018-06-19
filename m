Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5EDF1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967059AbeFSQqV (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:46:21 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:53417 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967052AbeFSQqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:46:19 -0400
Received: by mail-wm0-f49.google.com with SMTP id x6-v6so1473919wmc.3
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JrSJlJtaL9nVaYebX2ADD/nQ1D0kHYUamTizs4MRWJg=;
        b=RsRZFdkgrwnLHJBf7JqeDJrlP8vN4nEF++jxP7h/1Cnz+Y9dQE8TqV6ra3xwnghgnc
         pLs6G3a6DeIoxstCZit3YWqsOMR2qIPuczLbZg1jgYxD41iSlWubqbkFpcbZMJ3QT9Ym
         KzNsLhRxrlVH7Npiv0tVUD3DHTHGBfVm/CHbRLdxQCDd4Ik5Yuo2/2w1MrGjhcdNAVsn
         GorYi2QP4sHqsJxzNFZB9JwsVd0Ndbuj3XoPkb7wgZcROZv838iW7LQ7jy88k8ZmdSxI
         9lNai0X6cVQxoZtv/ZyTJcYlwCVFtlb8AQFCkwRPqUQU0tkv6swI5f5t2dPYRlk+CfLY
         M6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JrSJlJtaL9nVaYebX2ADD/nQ1D0kHYUamTizs4MRWJg=;
        b=eQbBrYtOKPaFeVd49QUdDK0eqPMhV2BBT2FY3KViF/HWk70VJJqJj4Rse6L6NXP07U
         Z+DDJGQXiIp/Qx5xZEy/3OgnSuu4YX1ME5pK6EiD794oHyL7s0R6a5Oy36MGhi9qnf2X
         obmSYN5Ys9W/cAAgBhR+spzAGPNUl9+x013NJQ0x8VjgYfEvaX6cjLI6ewSki0rbx5Xr
         bIYSBRx6zyOMmK3itdzE6zhbhP/obcS6LDnkKyeouEXnAq3aTu6AjJIqsYCKMUPxZn4w
         dnUk8xcaVMCEEvI6Mv3wvjuxifhhyj+yBv/DCHZ3huwwFLUvNV1Ax90MfEPF252jswNo
         zd8w==
X-Gm-Message-State: APt69E3F4I3COXEXdPKUz0mvWWg1U6OrX8qdZJ8AlsdoikHdLqXMnpHK
        FUTCXqF3S/TyRfPjfaxZx/FIQ3h5
X-Google-Smtp-Source: ADUXVKLTsfSGRPrd3/OA6UqKbxJnDg2R8MvJx+thV1dfk7Ya4SD4OrlsWevp28OrPSuMrYF8GU3nKg==
X-Received: by 2002:a1c:e8c:: with SMTP id 134-v6mr12882055wmo.51.1529426777972;
        Tue, 19 Jun 2018 09:46:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c129-v6sm505627wma.37.2018.06.19.09.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:46:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
References: <cover.1529365072.git.me@ttaylorr.com>
Date:   Tue, 19 Jun 2018 09:46:16 -0700
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 18 Jun 2018 18:43:01 -0500")
Message-ID: <xmqq1sd2wwpz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Attached is a ``fresh start'' of my series to teach 'git grep --column'.
> Since the last time I sent this, much has changed, notably the semantics
> for deciding which column is the first when given (1) extended
> expressions and (2) --invert.
> ...
> In the future, I'd like to revisit this, since any performance gains
> that we _do_ make in this area are moot when we rescan all lines in
> show_line() with --color.

Sounds like a plan.  From a quick scan, it seems that this is
sufficiently different from the last round so I won't bother
rebuilding your "--only" series on top, and instead just drop those
two series from the older round and queue this as the new and
improved tb/grep-column topic.

Thanks.
