Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CFD31F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 23:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbeJIGch (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 02:32:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35848 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIGch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 02:32:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id c26-v6so11998edt.3
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 16:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FqjpZCvH5/659pLRz9ScIQ8IdP+/Wi4mabnbjdiiI8=;
        b=f0ubZDcv9pWNOn8vn/+G711NLsJEPXIF33up2X8qCPEw6KpJpd62ABCPloS1y7Tmrl
         nNgtrWL3bsLPQdppHiSzlPRp67y/rxeDP/cE1f1zXp7TYaHVCW9AqDl+gnt0BTolDkuJ
         CB7VgZxfwEKHQ2OTC9rI9aVmSGxGyZqufgxXHnjEAiH7eeZSzDnjXBOAReIwILq8+Xh0
         XU1XflEHxcj7PUDBwt1hEIbgF8enFaMdOSdpYAbVOs/Hi7oEcPB8u8//DQzvgn5E1ypL
         BAaUro3zvo8wdFOfLK13z9LK5TOIj1acyrQ9ke4ue8GdB1Xd42C47smAUWebCv8/3gq3
         bqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FqjpZCvH5/659pLRz9ScIQ8IdP+/Wi4mabnbjdiiI8=;
        b=sj+lTaZ7aTa8+4apL84nHaoVFjoSik4BO7WLSl2rEa7ScUHDsevZCK1//p2codcZjE
         yiHxZmGLDwrt/0cOR1jVHBf+ZCLnIXrUiKTpsLJ7QAjNltD4aRfp9CAPdH8cER+lWiVt
         oX/jyG2s23JRtpwiAVcBSVYNz3CBc+9N0Lk6clKaMUopv7Fl6Vx0it+hhAd82cFJZEfE
         8NpEtJIi7XlhTTpEymkz8LwMqNuav6YJd1rwJ+Z6Lk1QJUxYq98xXPzXa+6bhwaXrxlL
         eN0dshnBNisuK81pfv9OwHHYGgcXUzoep9mRmQVtpA+0oLz45BQxnFIIaoMlD0T7yNkf
         71pg==
X-Gm-Message-State: ABuFfojVq1f27Dpz40NcZCpcktCF8h/5W7boux/LasZg8oS77yyHOf6u
        9MJfYU8EIZdeZGV227DAeNTm+2vakckTHBnqRY2k0wpR4TQ=
X-Google-Smtp-Source: ACcGV61M/gwcJeSF8L2+1YySrvP/RgKGxt1ClD9vZZWg6TQhow9URpxfQCf8zLWf2udZMBLEZ5qq7cL068r6aI0NAYA=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr30874805edc.76.1539040710833;
 Mon, 08 Oct 2018 16:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181008215701.779099-1-sandals@crustytoothpaste.net> <20181008215701.779099-15-sandals@crustytoothpaste.net>
In-Reply-To: <20181008215701.779099-15-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Oct 2018 16:18:19 -0700
Message-ID: <CAGZ79kZ+Kmo4QkatN7MufPy7UNT9_qb4om8J5oGB0D5aH+PtkQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] rerere: convert to use the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 8, 2018 at 2:57 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Since this data is stored in the .git directory, it makes sense for us
> to use the same hash algorithm for it as for everything else.  Convert
> the remaining uses of SHA-1 to use the_hash_algo.  Use GIT_MAX_RAWSZ for
> allocations.  Rename various struct members, local variables, and a
> function to be named "hash" instead of "sha1".
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  rerere.c | 81 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 42 insertions(+), 39 deletions(-)

I have reviewed all patches and had minor questions on some of them,
all others look good to me.

Thanks,
Stefan
