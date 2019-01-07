Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9AE1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 16:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfAGQmn (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 11:42:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40466 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGQmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 11:42:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so1103316wrt.7
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 08:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Gy+bOjtw7eLVZTNkv4Ue0G4fiDAtH+XWeNMmNsf3v3U=;
        b=MHWijzqccUAZw2PBVEuTXMvlhrNs6pjSPJHKuh9rRP43F9ASPrw/hBsz+iZfF7pFdN
         sD6a6ukMAq0Az358wN8vc4q8VCmnXu53fTXP4RfNr98MpqUHxbQy0G/2RoqCXBABUkMi
         l8Vqzx9Pb4JEdMfdkIW5fCD+rgtTvVnImoGvUfgf7/DsjEphgvNB7pexSco0+z0DlZ6a
         7vfjWEbyzrTwGgbfC/Ww5kWNglVwpHTc2qWn+mb0RATktY7J33G5MhlWeIuBPKjX3985
         x4exJBsv/MhHDm3dMFrhfjola9O8POPF9LlV8EUGgiaKf/CzFbdfWMAbjB/hDisZ8ZrB
         L0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Gy+bOjtw7eLVZTNkv4Ue0G4fiDAtH+XWeNMmNsf3v3U=;
        b=HOfWyq97eizDX8p5whyET1IzhsK+OJLff9NqG3CozYxCCy0eo9IxGeu5d8MXryOemf
         DG/18eNCL1LSqvgkzct6ajslgqMutbGVV3/KlF6C8G9002WqOQT3QO5L2RNZqnsHaBms
         2v4HZhv/rqavBb85toNwjCE5htIlpLkJ5rTCmZipPZmImCOW4i1ydQ9OeVGAC2HP1zd+
         6zUMHOsaNA0U6+6J8jyVpJ4O5q4fIhd9Br4q9GsrPuECRZdmRfBeH//K/51DBDXlZXJ2
         1XC5X/b1B1yoaMYNnuD+X1lyiXu+1ermA/iAZjnzThl1MAgCxDDA+NXe6bBe/E+PlcRt
         Lcag==
X-Gm-Message-State: AJcUukcS+Vd1v7TiE0806jhD7jujy/H8h0w51S7f659DlaqVGNcnyFRp
        ncORLZ1f2zq2fiW09ycuMjU=
X-Google-Smtp-Source: ALg8bN51Viez9LYENjeX5BmkVceYcAU1VJEaPkd33GmjbJrQDRSBa4/xxZjPDsDXQfhfuEdqAX6gHA==
X-Received: by 2002:adf:dec4:: with SMTP id i4mr50382561wrn.307.1546879360538;
        Mon, 07 Jan 2019 08:42:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 60sm70216114wrb.81.2019.01.07.08.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 08:42:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Hennings <andreas@dqxtech.net>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: --preserve-merges to add "exec git merge ..." instead of "pick ..."
References: <CAH0Uv3Eu7bGSVaJKu6kDjp0BPRe0yROucDfJ8QHV3X_ZjNJT7g@mail.gmail.com>
Date:   Mon, 07 Jan 2019 08:42:39 -0800
In-Reply-To: <CAH0Uv3Eu7bGSVaJKu6kDjp0BPRe0yROucDfJ8QHV3X_ZjNJT7g@mail.gmail.com>
        (Andreas Hennings's message of "Mon, 7 Jan 2019 15:02:14 +0100")
Message-ID: <xmqq36q4berk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Hennings <andreas@dqxtech.net> writes:

> This means we need a rebase operation where:
> - The commits of the acceptance branch itself are being replaced.
> - The commits of the feature branches remain as they are.
>
> A "git rebase --preserve-merges" almost does this, but not really.

This wished-for feature sounds to me more like the "first-parent"
mode that has been discussed a few times in the past but never
materialized.

The preserve-merges mode is getting abandoned by the original author
as unsalvageable.  Have you tried the rebase-merges mode?  That may
let you choose replaying only the merge commits on the acceptance
branch without touching the tips of the feature branches getting
merged.
