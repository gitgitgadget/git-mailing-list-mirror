Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28AB31F406
	for <e@80x24.org>; Wed, 17 Jan 2018 23:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbeAQX54 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 18:57:56 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:45508 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbeAQX5z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 18:57:55 -0500
Received: by mail-it0-f47.google.com with SMTP id x42so11356524ita.4;
        Wed, 17 Jan 2018 15:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vC+rO8PsH9gUmIE+FBBgRWFZuXr6HghJxXGat2PSGKY=;
        b=SHaTFDl6cqsgSEXPZgLbVAxCaXvTCyxWb8MLMGzE9cwM0CY7QWh5N74HsLllpIE+8J
         C7gtStFRl/EYJI9eq1yZQGez+A8/bqMv8raKjNd6emDS13zT1LlNr7zD8uyI2kGrPfCc
         UvXjHws6/+IuWTX65WQuqJlR+KhIv5CYQm1fTDaLecuMI72EkkXv8INyVslAkV9EkkLS
         8ltQjvz43AszmexhQvymkDHeBON6CazVfUeOiha/kaeUuNTyyUTWFhdHP5tD/qPhNNjr
         Kuv/PYwDH12I+YJqvCQSlbXCdMV5gIie6gdzvkCfjJpOaXhHNRGWgZK4uTKbtydJUsN3
         0+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vC+rO8PsH9gUmIE+FBBgRWFZuXr6HghJxXGat2PSGKY=;
        b=XNCq7hxX4emDZ4VG7wKHh10EUv2fKd52bzRKWHogRrKxbpUzfA49CiXt34vZYebCs6
         2DuDOFUIMJ3hJoIwATU8ZnwWfUCHyZjHpanctKatvaT7GgrM5sReowstiIP157C5c3JO
         AeYQjmp4QSfTrut3qEPSXkqpqbT3iunSqrbNroLF2XYQvkSHFpDnfvd9mg+2pIQET7Br
         LIh8veusJtzPHaq5l3JQrzWIL7tdjtnC94uOpEgilBvj1uib6rMHdGDsW2+WzqDSQUfL
         f6M3QrG8pRdHOt/jejyaRCTv1PFl/yHhEkPqqiL8qxzqaC0rwPWrGknJwmGnuIeRZLbF
         gyNw==
X-Gm-Message-State: AKwxytcwbOFkBO+4Np97w5fEz9YWLMtlaQ/A5knEK1r/g0sWuD7UPM1F
        HkbJGRcwM4Z6Sr84Mycbg1IvJZSZmCSGnzsDZi0=
X-Google-Smtp-Source: ACJfBouCPfgZ1smvFwwz5UXxurbVGcg7W/rWM/CXGwwVLuRZeOjVE9zIP3USdhkKmHX11Diw9dCbPF11EcIfR3mDYcI=
X-Received: by 10.36.248.134 with SMTP id a128mr4074170ith.152.1516233474472;
 Wed, 17 Jan 2018 15:57:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.147 with HTTP; Wed, 17 Jan 2018 15:57:53 -0800 (PST)
In-Reply-To: <20180117235220.GD6948@thunk.org>
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
 <87h8rki2iu.fsf@evledraar.gmail.com> <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
 <20180117235220.GD6948@thunk.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jan 2018 15:57:53 -0800
X-Google-Sender-Auth: BOYy9XhSRKuZq6_9A-al21ckMnY
Message-ID: <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 3:52 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Well, let's be fair; this is something *ext3* got wrong, and it was
> the default file system back them.

I'm pretty sure reiserfs and btrfs did too..

          Linus
