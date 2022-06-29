Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AD7C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiF2U6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiF2U6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:58:37 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA933DA64
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:58:36 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id y14so26716848qvs.10
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+pQRnAQE4hHIsJxBTxN3O5IsN7T3xYlgd8CQFYKLQQA=;
        b=LxsY+e5jzvlo7MM57Iczez/Q5inXyBOjjVRQz9K18OQn0qrTCv50RcJunMnKMejF56
         HNmVrOJlcxoCCRRt6L6FMYj27pRuQ6tZrLFjzprDLL20vNGDi6+IsVa8Mcvn8xX2Vn6Y
         9aPRMxdZGU4TxavX091CWskfrH/a7A2Jld3Wbt2asd79heKRMltz9Fp/nTYGEH/Dy1x9
         iapuA+YmOFi1KjBJfV3AZ3mIPkE+dU6Bh4InTZY8doPLgDe2DOqnlBTAnfbFbTK8CwqK
         qqebIoaJaf2VlzVwEVyJN/mqeuWYC+ay4b51TuRLJxw7LM7MK/IZz3v/VqMEUioI+dB5
         /vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+pQRnAQE4hHIsJxBTxN3O5IsN7T3xYlgd8CQFYKLQQA=;
        b=ppe2wqegysBrna/q1pZsDhXlVUzaQB2TB0slpwrFo66AsbgiUvycOOH55ITUIc990b
         78KojJi5ogtoY8QMYEXpAHrfZeMtS9cHVl97zbm9c6pGUH/TdTeWti72nj8v16XeMiti
         jpWBjaWZN8qDuaSXZZjfWUqlI6hdtxqnAF2eDYivuLIPRfQE90oyQmUTIUsLzF0Pjcin
         FD24MOKrYJqZ2QfLG6G91d66C7pNh1C7K2Hv1vvu1YBjpLYFHoTPPSubS8KrevpT0Smt
         Fzs/LC59hLn8w+kpD4l6f5k800RUIVvE5d0uJMn2hTGh4lJkrZeGTFb5+QhS4AKLWQgK
         pq7w==
X-Gm-Message-State: AJIora8SVM2a1tlsRDktqI0kjk8Xxiwxnzn/zvqa/SfBSJXrzDHZQG5e
        RsfP5w3kd0h89unHo7SPCttoLg==
X-Google-Smtp-Source: AGRyM1sy/Bxu/Uv1O1lXgKFrSbSXHPHKiGtEfaFsADX2JiY4Jv2jSy9CYUG6l03otb2Y8j2KUq91pA==
X-Received: by 2002:a05:6214:20e5:b0:470:3fd9:391f with SMTP id 5-20020a05621420e500b004703fd9391fmr9692971qvk.86.1656536315486;
        Wed, 29 Jun 2022 13:58:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a408e00b006a5d2eb58b2sm15606084qko.33.2022.06.29.13.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:58:35 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:58:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [GSoC] Abhradeep's GSoC blogs (27 Jun, 2022 IST)
Message-ID: <Yry89ZO0ipfafC8C@nand.local>
References: <20220627124408.15611-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627124408.15611-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Mon, Jun 27, 2022 at 06:14:08PM +0530, Abhradeep Chakraborty wrote:
> Blog update
> ------------
>
> Title - GSoC Week 2: redesign the table format
> Blog link - https://medium.com/@abhra303/gsoc-week-2-redesign-the-table-format-829dae755a5

As usual, another great blog post! I think you did a nice job
summarizing the main discussion from reviewing the first round of your
patches.

You're exercising a good skill here, which is taking a big pile of
emails and figuring out what the main areas are that you need to
prioritize. That can be tricky, sometimes, since different reviewers
will tend to focus on different things, and may not even agree with each
other!

But I think you did a nice job teasing everything apart, and the v2 that
I've looked at already is a nice reflection of your work there.

I am glad that your work updating the series to the new format proved to
be an interesting challenge. I'm really happy with the result, so it was
definitely time well spent!

(One thing to keep in mind regarding the bug you fixed in `store_bitmap`
would be to ask why we weren't able to see that bug in CI. Assuming that
you encountered some other way, we should turn that into a test and make
sure that we don't regress there in the future).

Finally, your next steps sound interesting, and I'm looking forward to
seeing what you come up with! In the meantime, keep up the great work
:-).

Thanks,
Taylor
