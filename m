Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E2D20966
	for <e@80x24.org>; Thu,  6 Apr 2017 02:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbdDFCXC (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 22:23:02 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34746 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbdDFCXB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 22:23:01 -0400
Received: by mail-oi0-f43.google.com with SMTP id d2so36836739oig.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 19:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DbiGt6TVZbySQdae+ODeWqBr32kYQ+zQCUba29YDKr4=;
        b=EHKcrXmAgqMH5g3fBItDYY0gFLUult51nKJCoDXSmjDnzfgwYR8Z5G7IzOxsYXcSQ5
         Gi5eYEFbnvvZLZSvmfeZcPDT3p/APqgajI4UMlyvWU6LmPGnxKXWHLPBMI6zp02NtJ/D
         efhGn6v7ItSmg86s1Gl55fNaXM5vJqFqJ22R+vafg5RYRa/9UAnhHg9cbA4lY6UM+SO4
         kf1ZzyTkunmN69frOp/shar3eoSHjuIfmArpBdnvbMJ9i7FHbfWGiBz2wvEFvJJJfcL/
         sK/ztIgAUXx0DvzyoyyhSELgodEE3g3BC9g8Albwc4CPY/IMxCo3Llto3Tl73lH/Pe8k
         wJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DbiGt6TVZbySQdae+ODeWqBr32kYQ+zQCUba29YDKr4=;
        b=YjUENULFPaWrpIJH48WOKzbABm6k/JJJ4bamTm6YVOlNmWp9Elurnb5znxdA46z5Xs
         tGXGqFdA8KsfG4ck6rltTn6iFMkJRWznfuBVWHYGk4N1UIlgq8splaGO9O/gwBDRSBfO
         JszW8BN4KtFk990LRBu6C4DkaE2g5aE8sXJ1B3pxnlcj4ygp71C7kdE5/SEQwRZBGtjE
         Z4hcCgPxphB7bvywV0q5gAqBtTVbYCTwjm+XaCG5bGoaxJY0vN8XBUFT3VJMbGTOgUKe
         Pz34RI5ADJ4NNMFT33BUrmZuB8IhaTS3wXSymoQ4OkwIlPWab6v7v883wJvoWXtWY1St
         Sp8Q==
X-Gm-Message-State: AFeK/H1nIzhF9JiAvn6ZhqRnvCJo/pZG4mscFzjg5Rq+Y5HG6+OHiyL+X74EKhf7K7d2nV/ISw+6p8O9659/3Q==
X-Received: by 10.202.72.77 with SMTP id v74mr14385742oia.186.1491445380358;
 Wed, 05 Apr 2017 19:23:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 5 Apr 2017 19:22:29 -0700 (PDT)
In-Reply-To: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 6 Apr 2017 09:22:29 +0700
Message-ID: <CACsJy8CCb+i3xjtEY=6_dWCGw8VJHT1Mo5973YmQ-6xpTd=z=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] thread lazy_init_name_hash
To:     git@jeffhostetler.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 8:46 PM,  <git@jeffhostetler.com> wrote:
> This patch series is a performance optimization for
> lazy_init_name_hash() in name-hash.c on very large
> repositories.
>
> This change allows lazy_init_name_hash() to optionally
> use multiple threads when building the the_index.dir_hash
> and the_index.name_hash hashmaps.  The original code path
> has been preserved and is used when the repo is small or
> the system does not have sufficient CPUs.

If sha1 verification in the index file can now be optionally skipped,
I wonder if you would have faster startup time by storing hashes in
the index as an extension. I have never tried it (though I planned to
have some sort of caching for this) but I would guess loading hashes
would cost less than 0.27 seconds, hopefully closer to 0.05 seconds.
-- 
Duy
