Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AFF81F731
	for <e@80x24.org>; Thu,  8 Aug 2019 18:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbfHHSPh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 14:15:37 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35932 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732634AbfHHSPh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 14:15:37 -0400
Received: by mail-vs1-f67.google.com with SMTP id y16so63626637vsc.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzjzTC6/0eN41PC2StSskOlFemrKdpPxgvfMPJuOYF8=;
        b=CwqU4IV9YQrJ6d/Qs1PnasTWDOW1oN2iZXYWqHEUS1iSPRVJ77TqRqXO4H68ADsAbq
         PC5fwItTILZL5gW17h8sQ+Q2r9S3qskDlWDCMTmTsJoQtNM8pJR1DIt/Q96jTOgwAgVl
         QkfHkBTuaje5Frxff3iLh6aQikRdpJsXJyRIxPIenL7pxyf30qrjcmFhqYJhlYHqkNCL
         Jsn58YAfWgS4luvJQL7h2laTYHxFdBPsVT/Hs/iZwH1IX1NTo7h6KmeehX1BfEoCL8im
         hS8jNikQG1PsAclTsDzCN5t0xFocV6bMdf+Sii2XIpfb4qhbMQyzZBXGlZ262hiuBaFU
         dYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzjzTC6/0eN41PC2StSskOlFemrKdpPxgvfMPJuOYF8=;
        b=QK0KkL+I9oHUvEbmMZ+gfU8BlIaHzMzhKevrupqFDTAtfTykuOZ7fGL1I2+SYtKGJr
         t8b11TNCggID4JmWUtAlfZJlI4A+btWFguBRKVG+zYirKk4iUqN8eS8FCJYG6jlAg1NX
         1VMF/WM6n/ZR9/bttdZffHn8x7dqoSOW6wvnGmr6KRDUboiUDoviQ/dF7S4+17TZo08O
         6la0XJNbZ4v4zQSckhIW7Vbi+9ff3swRB2/Q0pgbupk72aDpiqKvxpC8bI0UOHLaDxGN
         rM4GvnhQpYuH8wJx9rXVJ9Szpwiv11x60MSgNspUkVMZDaMUYyi+3WMLiSvZcNIRx7tJ
         abtw==
X-Gm-Message-State: APjAAAU67TytUqHDHz3MYw1Yfe1Ah6pJPRi3mzXaZNcwKBQ0FP7TRmRx
        JiM1/IMJvlT4on8AvergxZOGj1Z48JgPxsL/AKQ=
X-Google-Smtp-Source: APXvYqwCfljSB8swRwJaateR8qtZLjhZ0D3Qm+9/5uw1W3IhdtwIRR4b/fk5iLAm3l45FexQreEwObYz5i299KbaoyQ=
X-Received: by 2002:a67:f5d0:: with SMTP id t16mr11159774vso.175.1565288135961;
 Thu, 08 Aug 2019 11:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190808035935.30023-1-phil.hord@gmail.com>
In-Reply-To: <20190808035935.30023-1-phil.hord@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Aug 2019 11:15:24 -0700
Message-ID: <CABPp-BFH++aJinkzg+qsZDRN6R5-E8LPCG_u+udZLW6o0MGBug@mail.gmail.com>
Subject: Re: [PATCH 1/1] delete multiple tags in a single transaction
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 7, 2019 at 9:11 PM Phil Hord <phil.hord@gmail.com> wrote:
>
> From: Phil Hord <phil.hord@gmail.com>
>
> 'git tag -d' accepts one or more tag refs to delete, but each deletion
> is done by calling `delete_ref` on each argv. This is painfully slow
> when removing from packed refs. Use delete_refs instead so all the
> removals can be done inside a single transaction with a single write.

Nice, thanks for working on this.

> I have a repo with 24,000 tags, most of which are not useful to any
> developers. Having this many refs slows down many operations that
> would otherwise be very fast. Removing these tags when they've been
> accidentally fetched again takes about 30 minutes using delete_ref.

I also get really slow times on a repo with ~20,000 tags (though order
~3 minutes rather than ~30, probably due to having an SSD on this
machine) -- but ONLY IF the refs are packed first (git pack-refs
--all).  If the refs are loose, it's relatively quick to delete a
dozen thousand or so tags (order of a few seconds).  It might be worth
mentioning in the commit message that this only makes a significant
difference in the case where the refs are packed.

>     git tag -l feature/* | xargs git tag -d
>
> Removing the same tags using delete_refs takes less than 5 seconds.

It appears this same bug also affects `git branch -d` when deleting
lots of branches (or remote tracking branches) and they are all
packed; could you apply the same fix there?

In constrast, it appears that `git update-ref --stdin` is fast
regardless of whether the refs are packed, e.g.
   git tag -l feature/* | sed -e 's%^%delete refs/tags/%' | git
update-ref --stdin
finishes quickly (order of a few seconds).
