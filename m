Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 749261FD09
	for <e@80x24.org>; Wed, 31 May 2017 17:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdEaRzH (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 13:55:07 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35016 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdEaRyd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 13:54:33 -0400
Received: by mail-pf0-f170.google.com with SMTP id n23so13935120pfb.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6pyb6h589pDFOWNWcOJjuDcbzn2KXq8Y0KVgzi+n4Ck=;
        b=a2wwORVBPUVFxsxlXUGKRr2IEr5zsVL5Nz/0P3yOmr4zzJ35J70BHvyVzLzm5YHo/v
         56oCqq/bhSDvJjBNJkVD3JoIQyCm/fIJHGpOHh0Jw5F/7O4xKgVLDXUXIXmOCQ3Pe7Q+
         a/AqF4YDXh2IdlkxQPvz025aILEMetwTNNni5/akoDqNU7fXwpqp7Q9UcC8v7+u069C3
         FacpkzX38sL7lMyeeXH1S+Oi3wH6nNFTgeNMEaIzUZUgsZfhkID034vqBYAlOEscxisk
         TieM6eGIGcxACg2kIQrgh3wtPXEvM89UK5a3476/PlL3vZrvQJQQIDl/gCwBVnNt4cY/
         i3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6pyb6h589pDFOWNWcOJjuDcbzn2KXq8Y0KVgzi+n4Ck=;
        b=W4bq7p4T93PIy2CAKNlsvdjpbktJnjIyZWMqX4uLqE89/AffVUDz6lzFFvRZP8OK3P
         wzJTzfETpeQjFtNbRcvBPGT9cjtQE8eHpVO0qtD2jkmJeC3LV/DDI2XKMm/R7x9kaxQk
         4ubMBZ173FOo9lq/5U4zVroTss3x1uzhe9ah0cSWOWo4Mj7do9bZKTdnLjqGHmFjYTOP
         BdmOLKsOxHbPCSDk1bPyg/i5JaIYt6WJx/pLAbtRNX8Jt+yad/EGtsFIGe9uTwLL6v7b
         TIejI78vd39DEVerXoKw53Vu51sJY39qcNdOwdJihY3pniIxmFmBMaHW5z9h34hB3Gqu
         oDuA==
X-Gm-Message-State: AODbwcBBpBBsbjbDM1tMYby9TVhJdyJsMv8aV/rzAk6N2++Mpt1Wlwfs
        0g9jqsmL4E1+ZE5zuPxpkg3UpjNge/CD
X-Received: by 10.98.91.5 with SMTP id p5mr30986929pfb.94.1496253272527; Wed,
 31 May 2017 10:54:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 10:54:32 -0700 (PDT)
In-Reply-To: <20170530173109.54904-23-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com> <20170530173109.54904-23-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 10:54:32 -0700
Message-ID: <CAGZ79kZ9oWE1vniOPc+i4x-iLBwTU8B3f+OfiF0ZKN=_sqoDtA@mail.gmail.com>
Subject: Re: [PATCH 22/33] notes-merge: convert notes_merge* to struct object_id
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 10:30 AM, Brandon Williams <bmwill@google.com> wrote:
> Convert notes_merge and notes_merge_commit to use struct object_id.
>
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

spurious new line before sign off.
