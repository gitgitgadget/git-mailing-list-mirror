Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1BE1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 17:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405057AbeHAT2o (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 15:28:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55757 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404872AbeHAT2o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 15:28:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so7912103wmc.5
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X/NZCbHVU+ZrmdoeJDR74KNawv4FghxyphNk6o4pKpU=;
        b=mfgFZq7UiQqLjMuZz0uRtJv2e/r3fHMhrjH5c+F1pl6QGWYZ6UlQ7/4o5ccmsEufiD
         5i5l/83Roxkyqy3+7X7rxMkKHIosg+dbcRSF3GPFwrwSa0ee69nUq5cQw8b82FL0vn6G
         EWO1297ari0VVNtlO3sVlouSaq6HKB+bskVL1X8qRKVybAZJmUL6S3o9TdYln2+PzaMG
         aYeoStUWfIcrVBpxlSEW9pyrMBtLFinxLx3PJXWWalvd8S74ZZt+zClu2BNS/s/+Ul+3
         v+213bgdutJ99L6Tq/ivuRPE1SmUtOEKAatDCF78CrbxcuL4F4Xm6H6wiGItlxgdSBDm
         8j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X/NZCbHVU+ZrmdoeJDR74KNawv4FghxyphNk6o4pKpU=;
        b=HNKqHRspsx6bAcQGyukG6oc5r9E0gw5NTxx7qfc+jgeB90NMenjZlq4WCp6pjHV0em
         rOglNZvvdvswoe6dNl0xAhyxtDBjCBpsWeRdben+wqcOudEp6W7N99PAApC3xiPudl4I
         VtLY+DIgaiUoBVnbOAPN1BzwKOAN1aQM+ezAVRSZc1rDRiDD8aG/yiQOMoldt91aGUaz
         M2E/bgOsVqKv9sqI8sF7M1DoVpAx7fDqcDMfgTlQ2HTKHZ2Aa/6kE1GiXlEiMDiB0M9h
         3lMQ3mnzHvUaka61tqdxZ/kqjxJvaojjaKUi9pdir2BhHXhjJTQGLqpG1Qw5O+r6utKl
         q16Q==
X-Gm-Message-State: AOUpUlEz4x+bMArY8fOL8Tp2yt6dgoqDBwnMYQSWu7LdQpr5k3lTQvHn
        c2u4ChP2Ne9MNAnPoSpJQPu76/LA
X-Google-Smtp-Source: AAOMgpeliuAZjKo9YwwlWhYU3XkeH3KGVLm79DhmTtSDpP5CA0aHFFFFbiMhkzp78bM/Ssuun+p1hw==
X-Received: by 2002:a1c:69cb:: with SMTP id z72-v6mr2243319wmh.10.1533145315553;
        Wed, 01 Aug 2018 10:41:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z141-v6sm8570860wmc.3.2018.08.01.10.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:41:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chen Bin <chenbin.sh@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
References: <xmqqmuu686mp.fsf@gitster-ct.c.googlers.com>
        <20180801155432.4041-1-chenbin.sh@gmail.com>
Date:   Wed, 01 Aug 2018 10:41:54 -0700
In-Reply-To: <20180801155432.4041-1-chenbin.sh@gmail.com> (Chen Bin's message
        of "Thu, 2 Aug 2018 01:54:32 +1000")
Message-ID: <xmqqzhy66l25.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chen Bin <chenbin.sh@gmail.com> writes:

> The `p4-pre-submit` hook is executed before git-p4 submits code.
> If the hook exits with non-zero value, submit process won't start.
>
> Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
> ---

I see that the only difference between this and what has been queued
on 'pu', i.e. 

  https://github.com/gitster/git/commit/fb78b040c5dc5b80a093d028d13f8cd32ade17cd

is that this is missing the update in

  https://public-inbox.org/git/xmqq1sbkfneo.fsf@gitster-ct.c.googlers.com/

and also Luke's "Reviewed-by:".

I recall that you had trouble getting "git p4" in the test (not
"git-p4") working for some reason.  Has that been resolved (iow
have you figured out why it was failing?)

Thanks.
