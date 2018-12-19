Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BC681F405
	for <e@80x24.org>; Wed, 19 Dec 2018 21:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeLSVnf (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 16:43:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44198 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeLSVnf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 16:43:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so18697951lji.11
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 13:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9cw9xCJjpSLVyQbapzZX74TWKltXGZ+JjBURKwlCCRM=;
        b=t2gn+SlhEuZcHytBf493m7CluJianUThIkrmzMP9jkjKdvSzlvjjyLOVc4LfD5h5Of
         Mp1cVvzHgzfV5un1CE6MBqBeyIrU2yimS8JDGlci+5XxoMCzUwPe2/rzVf+SLS3+lIt+
         HB7SOChQl7ClPbyRL6L3TzXLLsFXcGjKMdK0Smjdq+FnO0BcSPgbMDazB9vuH44m3bnj
         qUE7HsRsb1sfsEEhBPxJ1qZRhJg0hZaL6LqH+ahlUjx9mpcKL5P/iJ5Hg1jNfcpDmreZ
         4styXsn0hylq4EWFqrEtFEG2BSWob0jul5ZHhiXdGcoUSuRoBJWG06POJhbbJq687xjB
         3iVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cw9xCJjpSLVyQbapzZX74TWKltXGZ+JjBURKwlCCRM=;
        b=heCelvQdIVYmU0/rmlYxKltF3dWfL+W/CQsdbJi7dL/6klZ+db4Z79sGr0Q/ylOm/X
         fhmetc+2asm9XOlM/01OqW1BCvMO9f4Unn94EayUD0pVdQ+6by4Syso2MaP7V5/QlwPr
         fpIt8C4rvff9hZBp18+CeU7C/6tFy6WLsBhQ1i63y92159RYd9s2e2PiTO/NU2UgPcqO
         tMZrdGLRRIOP9+Dh6gf9JoxfY/C13sDeggNuCGD8t7UEjK/Z+xjrU6WexhJKVcR21TrY
         KeeRZA1UU3zUJ/xhdxCGtD8x1OyMGubDiyL+C7Kf3sV6V3rRwO1FgvWbd3w6VCRGYjvi
         xM2w==
X-Gm-Message-State: AA+aEWb4n9tLlAEbW/q5eRISKsXnxm6uuxvSEN2Qtk0hG3HMYltEvclW
        D/2xB6NzgEINgnxsjfBSp143iY1eul7gRakqwgobwQ==
X-Google-Smtp-Source: AFSGD/XkhEss9+B0mxS76b0OTNnIvZaoaRCXXUNB+fohnmpxs5t0hN+fNa1APRvGup6Jih6cU5mjE7NTCSTlHb61kX0=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr523870ljg.23.1545255812164;
 Wed, 19 Dec 2018 13:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-3-martin.agren@gmail.com> <20181219001801.GA520988@genre.crustytoothpaste.net>
In-Reply-To: <20181219001801.GA520988@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 19 Dec 2018 22:43:21 +0100
Message-ID: <CAN0heSoORpNWSVmMiG0MF3f07FDtV5NfUhSuO1o1iDn7Mos-NQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] setup: do not use invalid `repository_format`
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Dec 2018 at 01:18, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I think this change is fine, because we initialize the value in
> the_repository elsewhere, and if there's no repository, this should
> never have a value other than the default anyway.

Thanks, it feels good that this patch matches how you think about the
`hash_algo` field.

> I looked at the other patches in the series and thought they looked sane
> as well.

Thanks for a review, I appreciate it.


Martin
