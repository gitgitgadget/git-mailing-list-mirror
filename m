Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CC71FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 17:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbdC1RNd (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 13:13:33 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35868 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbdC1RNc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 13:13:32 -0400
Received: by mail-pg0-f44.google.com with SMTP id g2so77841723pge.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cTBy33xl8IwU25NdupwOjENN2i283/bYJDWQC0gQceA=;
        b=bdGHpvRZ4afoiQYczNXceSqgmJZyQqKqPrNjBh/AWzVDEZrVr74S63stlL5padqTCG
         bL/rss2plgncl9qEbrgPT0rHP0K0qPRi9iFdgmY72gkv3WzkeSPvVyBLoV5RmsVzXpKY
         WOK2QjdOikptZXKCAO++pCh2I7lbSCJoXx+5sEUR7Sq7Z+tpxHIo/6gmmynuOUmSMc2t
         ub+MFN3OGapIm7l8jPRYx+Ubp2xp2+3NI1O9eAiYtI2/pEv/63ZpHc25QEZZpykCkl8c
         77xVbS/PMq1v+Ytp0eRNWpoiHQ976UFrqX7RIYd3KOcPBfdD43J2+BhXLtzyeB/rfV0l
         kB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cTBy33xl8IwU25NdupwOjENN2i283/bYJDWQC0gQceA=;
        b=skH5C1S/3q8cF53tzIGiWkURnwQHtoG6zku8lY40ewRCjeKI2G772n3EtxeMIldI46
         POhF3dh1YshVwDWCKACEy8kKhPR9KdvqiMlKE2Owc0IrLCQnTEvTm0NPB+KQrbgfWL9w
         kKcNiixl0RBCqnM4x9HjgIeR51vSfhi6Ze7RcVl6NrvJe4WpPiicpTWdtIBtS+cXa/M1
         1EDUcRAcstpvb0yjKS/Pl85kcErSamOeW7ZDnwFPzDUPyhKu2VuGv4JZ1J3/ZKi/SDfG
         XX72+iDBQppKRCEdkQreO16UeBTtqB/LL8c7QU+a0K2KEGR1bhyt2plDzmooOz1Z/o1l
         fILw==
X-Gm-Message-State: AFeK/H0iMzhua83H1o6f0zqrOqF3XpL56XHDvxztfwFPAB2xiBd1h0v9gdrBMFZxzB6SHKdgJKrSRKPFWR/iGd+C
X-Received: by 10.99.137.66 with SMTP id v63mr31357360pgd.183.1490721191088;
 Tue, 28 Mar 2017 10:13:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 10:13:10 -0700 (PDT)
In-Reply-To: <1490465551-71056-1-git-send-email-bnmvco@gmail.com>
References: <1490465551-71056-1-git-send-email-bnmvco@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 10:13:10 -0700
Message-ID: <CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] [GSoC] remove_subtree(): reimplement using iterators
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 11:12 AM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> This is the third version of the GSoC microproject
> of refactoring remove_subtree() from recursively using
> readdir() to use dir_iterator. Below are the threads for
> other versions:
>
> v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#mae023e7a7d7626f00e0923833c4359f5af493730
> v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
>
> Duy suggested adding features to dir_iterator might go
> beyond the intention of a microproject, but I figured I
> might go for it to learn more about the project.
>
> The dir_iterator reimplementation has been tested in a
> separate binary I created (and linked with libgit.a) to
> reproduce remove_subtree()'s contents. As pointed out in the
> last thread, git's tests for this function were unable to
> catch a daunting bug I had introduced, and I still haven't
> been able to come up with a way to reproduce remove_subtree()
> being called. Any help?
>

I would think a test llike the following would work:

test_expect_success 'remove nested subtrees' '
    test_commit initial &&
    mkdir -p dir/with/nested/dir &&
    echo content >dir/with/nested/dir/file &&
    echo content >dir/file &&
    git add dir/with/nested/dir/file dir/file &&
    git commit -a -m "commit directory structure" &&
    git checkout initial &&
    ! test dir
'
