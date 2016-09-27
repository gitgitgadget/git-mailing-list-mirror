Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183BB20986
	for <e@80x24.org>; Tue, 27 Sep 2016 22:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbcI0WKB (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 18:10:01 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35670 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbcI0WJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 18:09:59 -0400
Received: by mail-pf0-f175.google.com with SMTP id s13so9973317pfd.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l2RCha7zPeqX4eYLldcmBGQL6keIwyJU/rSNlgYezT0=;
        b=lOp/KMuVgmt5/6ie1XwSya1BWH2eOl/0r0oej2/DX9A2AFnSLv44VadHGN1c42DOhw
         AKdvtcWO4rPhxZwErXklbRLN9CdIqQ+bM3aNyMWI6sRXlqLaCegTH+ZoKALSeKbvrEUh
         CMY9cjjl31R7YRtNnpr84WEWate3pwR6fSS6kg3hFIr1J4vkyskiyd5tcsK3rxky2F6q
         QsIePZBH2tjf74b6aU8snDFFhLa6XLZH376w0Nqxvqu1IENryrUf91qXJGPcf3NLtShD
         ReBuYuKvNwqEis+QbMdFzopzWaE96vNmmUHs/C0fHXC3j0kk0dY8jhJ544PxjcHFrFfZ
         3ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2RCha7zPeqX4eYLldcmBGQL6keIwyJU/rSNlgYezT0=;
        b=TRHGLz5+ARMipJswVGt3Ll2cwApUrSuaBn5vjbZ5YaGtFasB5q7x6DHYrWkJh3j9CW
         Z6RhoKPgpLS/wV/b3QhA6t75PoDeAqPetuXuHY21Dcj2GFr9D3k/4A0RdYQBTxn2d1JL
         1NwA0F0U4b0falNfhjVZMXle648bbN900mcW6Rd+Fr9eAXWJmOQEQLio/XsPb3dNbAMz
         slXIPbKCBMH/10vlKMq93QXvD1GsdCA4yTU6AEM6godCb0nF3E+igHk8QA5D0dRVxJpL
         n9R1RZl38TC0faeeTKzF2vFdmtpaxit7FmjjEDU/cXuS0N70RFShBzPMkFtanEUuFdHE
         7GdA==
X-Gm-Message-State: AE9vXwOtEAMzRmd3U1WDA1sdsReqhiKm08iNswzFcb6oiFuazFC26k/mcwogshBpvF94z5iI
X-Received: by 10.98.112.197 with SMTP id l188mr50731139pfc.151.1475014199068;
        Tue, 27 Sep 2016 15:09:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:59b9:10d8:28e3:453e])
        by smtp.gmail.com with ESMTPSA id o5sm7166280pfb.9.2016.09.27.15.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 15:09:57 -0700 (PDT)
Date:   Tue, 27 Sep 2016 15:09:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
Message-ID: <20160927220955.GA38615@google.com>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
 <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
 <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
 <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com>
 <xmqq60phm39w.fsf@gitster.mtv.corp.google.com>
 <20160927214854.GA180705@google.com>
 <xmqqwphxknoj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwphxknoj.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Well maybe...I don't really know much about how the prefix interacts in
> > every scenario but would what you describe still work if we are in a sub
> > dir of the superproject (which contains other directorys and perhaps a
> > submodule) and execute a --recurse-submodules command in the
> > subdirectory?  I suspect we don't want to force users to be in the root
> > directory of the project in order to use --recurse-submodules.
> 
> You need to remember "must be at the top" is relevant only to the
> command that is invoked with --super-prefix, not the recursive one
> that drives such a process.
> 
> Suppose your superproject is organized like so:
> 
>     - file-at-top
>       a/file-in-A
>       a/b (submodule)
>       a/b/file-at-top-of-B
>       c/  (submodule)
>       c/file-at-top-of-C
> 
> If you are in a subdirectory of your superproject, say, a/,
> 
>     cd a && git ls-files --recurse-submodules -- "b*"
> 
> I would expect we would recurse into the submodule at "a/b" and find
> "b/file-at-top-of-B".  What does the internal invocation to do so
> would look like?  I would think "git -C b --super=b ls-files" that
> is run from "a".
> 
> Your code would is already prepared to find "file-at-top-of-B" in
> the index of the submodule, prepend "b/" to it and report the result
> as "b/file-at-top-of-B" when such a call is made, I think.
> 
> Now, can you refer to c/ and c/file-at-top-of-C while sitting at a/?
> 
>     cd a && git ls-files --recurse-submodules -- "../c*"
> 
> would be the top-level invocation.  This would iterate over the
> index of the superproject, trying to find what matches "c*" (or,
> "../c*" relative to "a" i.e. where you are), find that 'c' that is a
> submodule, and invoke "git -C ../c --super=../c ls-files"
> internally, I would imagine.  I think your code is prepared to
> accept this case as well.
> 
> In any case, the "must be at the top" does not come into the picture
> at all for the end-user interaction, i.e. invocation of the command
> that is told to recurse into submodules, so we'd be OK.

Thanks for the clear explination that makes sense.

Also, --super-prefix as a name is growing on me :)

-- 
Brandon Williams
