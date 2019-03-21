Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8692320248
	for <e@80x24.org>; Thu, 21 Mar 2019 00:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCUAbj (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 20:31:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39921 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfCUAbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 20:31:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so4733198wrn.6
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7uh+7NnmwruAhK8IJ+LUkxx5EkuQGFwuWzAslJyuX2E=;
        b=jc8ocZ7OI8d5LGhga0RJDQBpc7agKWbR3Da4gy28OC2/3Hv/WhyYi1aZMYQBkbA78V
         bzwJQ88HfWOaCElBwS/7/DM7NwzFHHvRRqHAC434M21SSmH92yOwbX0RcMFL9FF4lQb7
         4GljAojxw+DNKJl7QEbKNJK2flfZxRZr1zV/vhasccA6nV2fYWKwDhLIPv0EIyHNt45E
         a7ScvOikOnsqEmU0wWOt+0kTt9dXpxV8cYLDzAxcSMf1Oo3LkHciK8StM2K1Abee+Siu
         IaGJkHneSjsBtMMR9dKRIFdUjMS8EJ/mMudPJc5Xoipsi22xrq+5/kuNDPFk4TqHGgwp
         hczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7uh+7NnmwruAhK8IJ+LUkxx5EkuQGFwuWzAslJyuX2E=;
        b=chVrd06eyfTS+LIHOzJKhijsFC5GFwiPaTgffM8wZUURXIWpcFsABW+hegiiPle4L0
         LRAPk96GPMc0rs9naD7muhQQOAT50c0NThFAcNLT7eDCF6/Msdut6NVGHByK6RFulE5O
         ShSHFKLHGbeL3fh4TzMFQqCujnV2GSxlV4OBvn4moXsH0e9bI+IlM2x7EOTaStR/r10J
         Ig8Mm3KyMi8m9SdBAhu7w8DvXrdPaVp3Po7tJhMCdZGTbmonNRjcmLJBjJ28Slkevl+l
         e0ynJXDJivpwYlFaJ+YEtHQwpDCZYM6nG3m/WFa5W+0wadUbb/6uZxVApU/8OqqxqqGx
         bAAw==
X-Gm-Message-State: APjAAAWDpnvL8/KoZbNh42qu2bsqDAW43dP7gH5SdpuwjMqd5NL9DYTf
        CxrIjzFErnlB3X7nICv7SaM=
X-Google-Smtp-Source: APXvYqw7PKA/SUgyyEI2dWWm+vlAxyigJROloGUCL2RQjJD96gFzsTh/LQ/iXizBr2o45ex8lfFRew==
X-Received: by 2002:a5d:6051:: with SMTP id j17mr543552wrt.174.1553128297125;
        Wed, 20 Mar 2019 17:31:37 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u14sm2469614wrr.42.2019.03.20.17.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 17:31:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
        <20190320220509.7180-1-rohit.ashiwal265@gmail.com>
        <20190320225638.GF32487@hank.intra.tgummerer.com>
Date:   Thu, 21 Mar 2019 09:31:36 +0900
In-Reply-To: <20190320225638.GF32487@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Wed, 20 Mar 2019 22:56:38 +0000")
Message-ID: <xmqqmulpukyf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 03/21, Rohit Ashiwal wrote:
>> Hey Junio!
>> 
>> On Wed, 20 Mar 2019 12:13:47 +0900 Junio C Hamano <gitster@pobox.com> wrote:
>> > * ra/t3600-test-path-funcs (2019-03-08) 3 commits
>> >  - t3600: use helpers to replace test -d/f/e/s <path>
>> >  - t3600: modernize style
>> >  - test functions: add function `test_file_not_empty`
>> >
>> >  A GSoC micro.
>> >
>> >  Will merge to 'next'.
>> >  cf. <20190304120801.28763-1-rohit.ashiwal265@gmail.com> (v3)
>> 
>> If we are going to merge these in next revision, I say there are some
>> minor changes that Eric suggested, basically there were some extra spaces
>> in commit messages and a small change in commit message of [PATCH v3 3/3].
>> There will *not* be any change in code. Should I attend to them or we are
>> merging anyway?
>
> Junio sometimes applies these fixes himself, if he deems it easier to
> apply them directly than to wait for another iteration, and if he has
> time to do so.  If you have a look at the ra/t3600-test-path-funcs
> branch in gitster/git, e.g. on GitHub [*1*], you can see that Eric's
> suggestions for the commit message in 3/3 have already been applied,
> so there's nothing more you need to do here at this point.

Thanks.
