Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8061FA14
	for <e@80x24.org>; Thu, 13 Apr 2017 00:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755593AbdDMAHb (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 20:07:31 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35497 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754721AbdDMAH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 20:07:29 -0400
Received: by mail-lf0-f42.google.com with SMTP id 75so22007420lfs.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 17:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WMVZRgYuayJxyioIoQrYJwfnnrGM28Dj3VpoTSvtwuQ=;
        b=U0pB1I4nLKAASO6lbke4+QH3LvvrsrYkuM6qgbHHUCRc8TRv3EK5B6+C7q/aqdBk7O
         laulkeoRwDUZ6wBZjnQbiqnOCdQ3IHvkrGYMEMd6VCoxT3kXZUKKwWvyOrDGKPURtx3f
         zcpqfBllGls0uPdSphBi/GDdAPu5kx5uN+HQj121XD2BlV0yaAHoCyp6WhiBnr7Nl+UY
         emEdiC2dI9aYstbqsy+CEGm4biTUKeSSrBeTggoZL+TsiartEHBbeqzG0H4xrttkdShn
         SGYDRJp7T08mObmG1zrFz2JGgFv22Le2/5KJ+Xfru2JlEFw5n7+v0JYu4EzRAAA+FBJZ
         cP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WMVZRgYuayJxyioIoQrYJwfnnrGM28Dj3VpoTSvtwuQ=;
        b=LaSjvJtrfKQlTV4jhg1Ws3PIap3wMdyXkjrEknKsc3F2HSHQcJdqaDMSiIBkSYBbnH
         jV6B5kGqUTHRQKsBFseAhphyvjkY84pequdROpDIO484nCkb2PtO4fAQ5kwpOu9OfXHD
         ZdJ8tkuzIQMWWQi2qIKJF8QMdxnDJJNmmlnEp2oW/UFq8btqPb45IfvsMA6xiBEmg07a
         dAii4j7vG+s1DSKXiG7KpdkVe5WqWzQcwnTfWCvsnp8kOg7xpRq/6OrQevx+Gg2FSSOp
         G8Wru+E4n8BcBym8HITjhQJbxQNIHGl7hir1uvkBbO4KoPsL6b3bO5dkH0opkB/kB/jd
         1NsQ==
X-Gm-Message-State: AN3rC/7tU76PxdiYQb2XsXWQbfKWR5cD7G8WrTCUxqmOwfRc/DLosKc5
        je/q7tKCAkVHULYipYn+btXWU/bRsg==
X-Received: by 10.25.219.84 with SMTP id s81mr115603lfg.110.1492042047914;
 Wed, 12 Apr 2017 17:07:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.193.136 with HTTP; Wed, 12 Apr 2017 17:06:57 -0700 (PDT)
In-Reply-To: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Wed, 12 Apr 2017 21:06:57 -0300
Message-ID: <CAEA2_RJfcOc6FD41FNzU9LYs2xfzGZJxQyb2x8txuQqUE8RtNQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] [GSoC] remove_subtree(): reimplement using iterators
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there! I'm sorry for bothering you, but any chance you might have
overlooked this patch for a review? (I'm just not familiar with how
long patches usually take to be reviewed, and since I always got an
answer within two days of sending it I wondered if you may have just
not noticed it.)

-- Daniel.

On Wed, Apr 5, 2017 at 10:39 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> This is the seventh version of a patch series that implements the GSoC
> microproject of converting a recursive call to readdir() to use dir_iterator.
>
> v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#t
> v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
> v3: https://public-inbox.org/git/CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com/T/#t
> v4: https://public-inbox.org/git/1490747533-89143-1-git-send-email-bnmvco@gmail.com/T/#e437a63e0c22c00c69b5d92977c9b438ed2b9fd3a
> v5: https://public-inbox.org/git/1490844730-47634-1-git-send-email-bnmvco@gmail.com/T/#m2323f15e45de699f2e09364f40a62e17047cf453
> v6: https://public-inbox.org/git/1491107726-21504-1-git-send-email-bnmvco@gmail.com/T/#t
> v7: https://public-inbox.org/git/1491163388-41255-1-git-send-email-bnmvco@gmail.com/T/#t
>
> Travis CI build: https://travis-ci.org/theiostream/git/jobs/219111182
>
> In this version, I applied pretty much all suggestions Michael and Stefan had
> for the patch.
>
> Michael, regarding the patch you sent for parsing the arguments on the
> test-dir-iterator helper, I did not squash because it'd generate too many
> merge conflicts. I just preferred add your code manually. Let me know how I
> can properly credit you for it.
>
> The only "controversial" part of this code is how I ended up caching the result
> of lstat() on the dir_iterator_level struct. Having to handle the case of the
> root directory ended up making set_iterator_data() way more complicated (having
> to handle the case of level->stat not being set by push_dir_level()), as well
> as required the introduction of st_is_set member in the level struct. This issue
> would be solved if we could lstat() the root dir on dir_iterator_begin() and
> possibly return an error there. Regardless, I appreciate other suggestions to
> make this less complex.
>
> Daniel Ferreira (5):
>   dir_iterator: add tests for dir_iterator API
>   remove_subtree(): test removing nested directories
>   dir_iterator: add helpers to dir_iterator_advance
>   dir_iterator: refactor state machine model
>   remove_subtree(): reimplement using iterators
>
>  Makefile                        |   1 +
>  dir-iterator.c                  | 247 +++++++++++++++++++++++++++++-----------
>  dir-iterator.h                  |  35 ++++--
>  entry.c                         |  39 +++----
>  refs/files-backend.c            |   2 +-
>  t/helper/.gitignore             |   1 +
>  t/helper/test-dir-iterator.c    |  48 ++++++++
>  t/t0065-dir-iterator.sh         |  93 +++++++++++++++
>  t/t2000-checkout-cache-clash.sh |  11 ++
>  9 files changed, 373 insertions(+), 104 deletions(-)
>  create mode 100644 t/helper/test-dir-iterator.c
>  create mode 100755 t/t0065-dir-iterator.sh
>
> --
> 2.7.4 (Apple Git-66)
>
