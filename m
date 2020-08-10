Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A24C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 23:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195DC206C3
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 23:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHJXVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:21:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46728 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHJXVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 19:21:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12so9707033wru.13
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 16:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDjD+wgOgW2s8Q5pm7Hh7nKCqTdr5n4RGeqoxw307NU=;
        b=cJFtQ/PAzh9OvbKYGEfrNGEAusPbWsfToReZJ8ynvqAKSV0lWcWS7tAQHSXNWCmyDK
         1yUDKV1x0vSQwhXpjBhid82g7gcWnkB5fCyULcBZhxWDlzU3PIAwnDGvJVUzbPx+e0S9
         7Ijx0NtY+HsBFU5qv1nggazWVPPBG15mvJGZfMEllCyfmucUPKLWWOYuuJqBxpNNtaik
         XIXosOMmZjuRUTMjRWvgL/C/BqBR23eTOX0qUoEXpVLIWwMX7/2GAKqpPbhf6U1HhzWa
         BO3DQXQSPxbbnauns3l9ut4ARco9AFCHxwhC5468GlPpKs4yYynZ/KQlfPybgGtIp33i
         v7/g==
X-Gm-Message-State: AOAM532boQWVxHPeilFq8J8QzCgr68HhW2h4Ij6dHh+iNgbVZEBj/5co
        zRa6De4lBHaUefmmSNS/QV95feOk8kdHnAN/jew=
X-Google-Smtp-Source: ABdhPJyNgRvOqwAcutbUfdURBvCT65yZhdLhpqHQeY6R8sjbvLt76iSFNXkUCQdqEdg2z++tpn1fj7B1B8LLHP1r2Tw=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr27055637wrn.415.1597101711584;
 Mon, 10 Aug 2020 16:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cSn_wrBuMKzoUZ720Hy-Y9RuPpJtmZ1mr--cnyAP866-Q@mail.gmail.com>
 <C4TOW9DJ7JW0.1QXQ173P2ERVN@ziyou.local>
In-Reply-To: <C4TOW9DJ7JW0.1QXQ173P2ERVN@ziyou.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 Aug 2020 19:21:40 -0400
Message-ID: <CAPig+cSSBbgGZmKfEZ0P=J4a2=97uifHKvWAa3t6xU7B+bE-Pw@mail.gmail.com>
Subject: Re: [PATCH] t4069: test diff behavior with i-t-a paths
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 7:09 PM Raymond E. Pasco <ray@ameretat.dev> wrote:
> More rigidly, it's nice to confirm that it's a diff from the empty blob
> and not from some other random blob.

The tests can get access to the correct OID of the empty blob without
hardcoding it either via $(test_oid empty_blob) or just as
$EMPTY_BLOB, however, that's the full length hex string, so you'd
still need to do some tweaking.
