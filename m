Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D153520401
	for <e@80x24.org>; Tue, 27 Jun 2017 20:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbdF0Uvu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 16:51:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33791 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbdF0Uvt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 16:51:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id j85so7964242wmj.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yFLopKicR2vNsE3gXmqWRZ8z2czN8TfpZbgvbEOT6bs=;
        b=gCP/YWjYBW9ualD0VxPkdEehDa20ipbfJff0Asi8aUrEcG6oXV6HuNfjaCuG4xKHCq
         ObQmhFP6L6LyvwzBYiAffIpnXvX6G2tvBZgUdqfT0NORCcpQ5CkfYF+6T3Pjp6yPxa70
         7GE3XL9fvjTB1ywfPgLmi0KolLV7ifhNriVnArg4YT+QW0AfJJyFYOmN9vjFwdyQArRG
         i0jUVpYPA7zdez3Usesek5bnTMHJD0GTlCk29SsGQqPj0QfuKVKYDxo02HLG7Bj8E0tq
         XxxLe2EASi/2J3EhgqSanvBF3YvFbe6xM0BPLh7eoUwwZG6lhhejadcCXJ9elQ9Peq5x
         Tv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yFLopKicR2vNsE3gXmqWRZ8z2czN8TfpZbgvbEOT6bs=;
        b=FnIBy5XjCisB4VBTdqLd+Clr64dELaQA3zU26C7bEc5EZP4cZl45a6U2TDgXyMjHhW
         qvSGsq/lsreKxgl0Pipjyr9TaFDMjZnDWtpgV2mYSMatluRzKLCGeSzbyJKYf3ON1bAh
         1FhHVhjW/0ufrj9T9D8TZdjIFSBOsjPOS3vrCF/hWG+ivoDotBTOIRPUtL1j0tZN/QPv
         jUwDfdxvw33k4eBuYUX2NOnNYm0AGCuhDJsnJ1SkZ+pgfE/3jDY234OTy4WKw7B3zZ/E
         Qq95sg9zPWp+ppeuOLXBYW5DJOGp/U2ZYQat3QXIrZ65MFrvvwahKh+4DFGYvh8amV72
         kyzA==
X-Gm-Message-State: AKS2vOxzvGa1YTI1upfSLQ0bmaRuCvSTZZ92TYZtgYG9yTGDRaCb5bW8
        uzWwVLK0D2CcAib+byA=
X-Received: by 10.28.11.84 with SMTP id 81mr4898205wml.82.1498596708369;
        Tue, 27 Jun 2017 13:51:48 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4DFA.dip0.t-ipconnect.de. [93.219.77.250])
        by smtp.gmail.com with ESMTPSA id x131sm2752928wmg.13.2017.06.27.13.51.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 13:51:47 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 3/6] t0021: write "OUT <size>" only on success
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqfuel1d9s.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 22:51:46 +0200
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <BEB23654-54FB-40B0-8C7B-E70D1E5BBCF7@gmail.com>
References: <20170627121027.99209-1-larsxschneider@gmail.com> <20170627121027.99209-4-larsxschneider@gmail.com> <xmqqfuel1d9s.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Jun 2017, at 20:44, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> "rot13-filter.pl" always writes "OUT <size>" to the debug log at the end
>> of a response.
>> 
>> This works without issues for the existing responses "abort", "error",
>> and "success". A new response "delayed", that will be introduced in a
>> subsequent patch, accepts the input without giving the filtered result
>> right away. Since we actually have the data already available in our
>> mock filter the debug log output would be wrong/misleading. Therefore,
>> we do not write "OUT <size>" for "delayed" responses.
> 
> I still do not get why you think it makes any difference that you
> are hoarding the result in the mock program.  If the filter needs to
> read a prepared result from a file in t/t0021/ before responding to
> a real request after it replies to "delayed", would that change the
> argument above?  From Git's and the t0021-conversion.sh test's point
> of view, I do not think it makes an iota of difference---it's an
> implementation detail of the mock program.
> 
> I am totally lost.
> 
> Isn't the point of removing the log output from response to "delayed"
> that the filter does not give the output back to Git at that point,
> hence generally the size would not be available in the real-world
> use case (not in the mock program)?

Correct! Sorry for the confusion. How about this?

    "rot13-filter.pl" always writes "OUT <size>" to the debug log at the end
    of a response.

    This works perfectly for the existing responses "abort", "error", and 
    "success". A new response "delayed", that will be introduced in a
    subsequent patch, accepts the input without giving the filtered result
    right away. At this point we cannot know the size of the response.
    Therefore, we do not write "OUT <size>" for "delayed" responses.

    To simplify the code we do not write "OUT <size>" for "abort" and
    "error" responses either as their size is always zero.


Thanks,
Lars
