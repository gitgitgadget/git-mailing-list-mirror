Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7DA1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 20:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965895AbeBMUfg (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 15:35:36 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39332 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965634AbeBMUfd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 15:35:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id b21so18255212wme.4
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 12:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=beGhHXI5EBsqVwZqv09yXxSdzJ/+srzXt+e22XC2nNE=;
        b=OmqhumfiNyQoCXFAI2J76TccBvM1dSJC8SkmVPjlwCGg3B9JSMBFVqSfUmBbRenm7e
         3vQSmGAG7/OKY9H/KPfFinmVxBFa+EOVbU/e1CFaT2FNnJiQwtzuaXpPzyVndAPozjMt
         B8SXqjbW9eTDlxK7GcLG4rPbE3GF+10R6NbtDm9XbZlj/BN5izQymdv933k/9sTUnUty
         24J38f2kH+i//2Z4zo7QcL2XKR/BweonKst/jzvZMAWUBKoeoGJsIgxSvtPIcqfIrSWi
         nU5ywjZ5LqewdtgRTgyYeFP4BAoz+kEMB3L+50s+1vozeeJmVrogx7FLffqGkt2aqYFs
         egCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=beGhHXI5EBsqVwZqv09yXxSdzJ/+srzXt+e22XC2nNE=;
        b=CxDN6V/DDYzackJ11iGSt1N1cRgwiJj13cV/bLXjb/8WeqP+B2/jslf4e5nZE2iFA6
         xuhFzRAi1hldJp1ahs5BFsBPUkWG5tyyfS0RAuRxHzWzn49N912OkNKwYJ0QibZFMjfh
         u0HjUmv4+/tRYFablhXK+i4RR2+tWV15P7zDAVZXnLx2lP2hWGYu3oGtOdWpY7Cr9/5+
         jHdVLVuGDZKQ5jmq9HP7YOlQvlRgB+NaMqGPrcbV8Szqvcv19keK4G/fZQRupxBqw2+u
         cjPTZrR43H9AITxjtOyQNyyZcaxJbznONjrdnH6B+KZp5CdcuVbDjDi5gjezSrWsX+/P
         uoSA==
X-Gm-Message-State: APf1xPCowpQzLUfpF8j5CgfKeFvEeyMZuSsy/IMXl34WOa9kIPKyUjLo
        46B35xPaOMSf3IGR8IlLumo=
X-Google-Smtp-Source: AH8x224GIJUuwHLK7hyTfhVOcT0j2ihhgddtSD+RMrQsfARApc/isf4oF9Qs+DhffCP4OEdKOQ9uiQ==
X-Received: by 10.28.38.133 with SMTP id m127mr2214875wmm.40.1518554132284;
        Tue, 13 Feb 2018 12:35:32 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p5sm11120113wmf.13.2018.02.13.12.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 12:35:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/4] t3701: add failing test for pathological context lines
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180213104408.9887-3-phillip.wood@talktalk.net>
Date:   Tue, 13 Feb 2018 12:35:30 -0800
In-Reply-To: <20180213104408.9887-3-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Tue, 13 Feb 2018 10:44:06 +0000")
Message-ID: <xmqqr2popqzx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When a hunk is skipped by add -i the offsets of subsequent hunks are
> not adjusted to account for any missing insertions due to the skipped
> hunk. Most of the time this does not matter as apply uses the context
> lines to apply the subsequent hunks in the correct place, however in
> pathological cases the context lines will match at the now incorrect
> offset and the hunk will be applied in the wrong place. The offsets of

Good.  The --recount "feature" on the receiving end does not have
enough information to do a job as good as the code sitting at the
side of producing a patch to be applied, and this goes in the right
direction.

