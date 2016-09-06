Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AEF91F859
	for <e@80x24.org>; Tue,  6 Sep 2016 06:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbcIFG6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 02:58:37 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36775 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750721AbcIFG6g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 02:58:36 -0400
Received: by mail-yw0-f193.google.com with SMTP id q4so2692402ywq.3
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ukQXFMmvmfx0Em7Cz2hmv8ZBp2bqMrvh9CSrpUM0Pco=;
        b=zUbTqqxrXJHRZpWvoCu5BlDIF5EU4xpcFyfXBES62qkcoV7cQ0qylkSYlbTc/TDbCv
         qzjuqVfE+kPSb+YWKTCXlF6Q0LMYVKrrmRVdBN4rNU4dh7uui1JjRAF9R2powKBVJjpz
         X3GU3x9cRE01yvou2L+oE0v4JUiCjrWjtsHnUbwmMAfQ8cQ35iOaoiRx1QdkgIrEbx0R
         iEE9NzI03v+jLiL4PPUrtbQdaU+mLuvHIw3Bmv0znOA12xBJY4bk7+Nbd+x9EvLGxbmx
         WNJ/DI7eUlRw0QYa8+lGDlrEu8Iy4f5+ZvCeW9UOxiJpGT48rbmvzbNBo2guwVjHX06a
         4a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ukQXFMmvmfx0Em7Cz2hmv8ZBp2bqMrvh9CSrpUM0Pco=;
        b=lZc5X4vd2yZzfp/S3PpzyXe9J8AKddBj70ZJJrNV4ktoBhRKi3WjNkkDVBSBRa0vwR
         nX2HsdsJs7UUzi4wMCNsBatAb5x2cBiTDtBhd8hyPSoFmgM0MYtDHsTY6kbqbG/gZkTF
         DqeuuY/kaR5rWQ96B1N4FjdZyESBlc2sSdr7w1eQ/DB9wXMctNx7sE4Hu3UpSMxa96V+
         apHTw2/1VU6J84Kptd4jW8SuvkoXMipGXksflOp3T1BuVqjU76F84j9yj2DYmAg8AF9d
         WrHbVcPqW6Tvg3koVuozXfi8teoWkXbYmLlrIz/Filh0XGaXWY4xd/Ns+evYxT/H/VGz
         VhLw==
X-Gm-Message-State: AE9vXwNppZUwEIqA8e98mAZrVtVLau1NTyXwtA5HYIN0U30XFRYuDWZqH6h4sziIEtjc+ss2K4AUsmtiHej4wQ==
X-Received: by 10.129.125.84 with SMTP id y81mr6737343ywc.234.1473145115732;
 Mon, 05 Sep 2016 23:58:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 5 Sep 2016 23:58:15 -0700 (PDT)
In-Reply-To: <CAGZ79ka7VV6Pqw-rcVFv0xU4J4D9dHWPg-oocPPWJdY5JVhT+A@mail.gmail.com>
References: <20160904234237.10548-1-stefanbeller@gmail.com>
 <CA+P7+xr=Lp36wDw2BRuhQ9Genv4q6iu9beGQe5hzOn5PJYDPfw@mail.gmail.com> <CAGZ79ka7VV6Pqw-rcVFv0xU4J4D9dHWPg-oocPPWJdY5JVhT+A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 5 Sep 2016 23:58:15 -0700
Message-ID: <CA+P7+xo9KqnjajkPbP9_Q2H6hHT47dqPX9i3e5hvm28a0JWJOQ@mail.gmail.com>
Subject: Re: [PATCHv3] diff.c: emit moved lines with a different color
To:     Stefan Beller <sbeller@google.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 5, 2016 at 7:20 PM, Stefan Beller <sbeller@google.com> wrote:
>> If I understand, this is to ensure that we don't keep re-hashing each
>> line right?
>
> No, this is to ensure we have the context sensitivity of one prior line.
>
> In the collection phase we look at each line of the patch and make a hash of it.
> Then we store the hash temporarily (think of a state machine that goes line by
> line and always keeps the hash of the last line)
>
> What we store in the hashmaps is the hash(current line) ^
> hash(previous applicable line).
> With previous applicable line I mean any line starting with " " or "+"
> when the current
> line starts with "+" and " " or "-" when the current line starts with "-".
>
> When going through the second pass and actually emitting colored lines
> we only find matches in the hash map if the current line AND the previous line
> match as we lookup by hash code, i.e. if we have a moved line, but the
> previous line
> changed we do not find it in the hashmap and we don't color it, such
> that the reviewer
> can spot a permutation.
>
> So in the second phase we also need to have access to previous line, so maybe
> we could also go with just taking the line with us instead of 2 hash codes.
> But that implementation detail seems like a trade off to me, where I'd lean
> on keeping the hashes around as lines may be very long in bad cases, whereas
> the hashcode is short and it is a cheap hash.
>
> (I am referring to http://i.imgur.com/MnaSZ1D.png where in the malicious
> case all lines were moved to there as well, but permutated)

Good that clears up a lot of my questions. It seems like a reasonable
algorithm, and I like the example of per-muted lines.

I think if we can find some real-world data on how much slower this
is, we can find out what kind of configuration we want to give it? It
seems like something incredibly helpful to me, but having a way out is
nice incase it ends up being too costly. I suspect that will only be
the case for a large patch.

Thanks,
Jake
