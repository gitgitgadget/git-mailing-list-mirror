Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A29C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 01:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiKVByj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKVByh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 20:54:37 -0500
Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6DE13CF3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 17:54:35 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id xIUZoyRZMbPhbxIUaokLGo; Tue, 22 Nov 2022 01:54:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1669082073; bh=dGcQbdmWNGjsxihoWCgPWHyBKc+j+ot7xSFbTdBt68A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DP06y1X58LtMQc2ZUXJOD9Y/rScoL5vZNplOF3vOrYpQ70ToYEKBzyjcpDYOWQUWa
         PWcZ7c5FaXScWxJBfxXVKsY9AaQERSj3Gp2PDFCHX+g7v+Xq9K2BVbLbyCTiYsYZRX
         FEfY2xr+IFzaLd1hj1wi2E5qw87BjWA3aHGcGqtIzcHsOlH2XZDRJs9Ngh3JxDGLpG
         zR9el2EPi6gWIOLVNAGw0CIfw+7TKIrL75xRBDJPg42juzpHEqDfHNJHcgDgdkb+S3
         pKH6d/q6BvZc/6UYmSO2oF19pobdXlBJj1I0PH0wgWGP0A8k7tmklwUEYn3VbV9qTg
         41anrCHyZViWA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=U+qBsMnu c=1 sm=1 tr=0 ts=637c2bd9
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=4FXq4VCEx6OLR-ejWYkA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <5d4206a4-c15a-7483-e059-e1b93ec320e2@ramsayjones.plus.com>
Date:   Tue, 22 Nov 2022 01:54:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Makefile: fix cygwin build failure
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Adam Dinwoodie <git@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
References: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
 <Y2wwfQWrs+KYpWNv@nand.local> <221110.868rkjpty3.gmgdl@evledraar.gmail.com>
 <Y2xf7HbAdqXOmgR3@nand.local> <Y2xgI30EFZisqpRG@nand.local>
 <Y2xgef6IvBHnnfE/@nand.local>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Y2xgef6IvBHnnfE/@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAQA/IyahdT44kQL4mALoB6oiI6OnTapCDJ8bBo+8XR/OKbAJytBtRb9aMhEwjiYi1+NXbity3yTuDfdJr/VgevC+kvkgo8yCoHVFTUuGHL16/BYWyNB
 5oqVveLPF9ONu6aNIoEOTmGlzVOCcEW/sefwuNX0pDm+N7Qd4zSku+MNuR38sMc68wjh3Yo+swwiGGK0oK9FVw4Y0FQlCV4AbNw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/11/2022 02:22, Taylor Blau wrote:
> On Wed, Nov 09, 2022 at 09:21:23PM -0500, Taylor Blau wrote:
>> On Wed, Nov 09, 2022 at 09:20:28PM -0500, Taylor Blau wrote:
>>> Yes, 'ab/remove--super-prefix' is only in seen for now.
>>
>> Oops, I clearly meant 'ab/make-bin-wrappers' here. Sorry about that.
> 
> ...Double oops. Now that I think about it, my notes show that we were
> planning on dropping this topic per the discussion beginning at [1].
> 
> If that's not the case and you were planning on resending this topic,
> then incorporating these changes in would be appreciated. If not, I
> think we can drop both of these.
> 
> Thanks,
> Taylor
> 
> [1]: https://lore.kernel.org/git/Y2rPrNz6BD6DlRcO@nand.local/

I noticed my origin server:

    $ git config remote.origin.url
    git://git.kernel.org/pub/scm/git/git.git
    $ 

.. updated tonight, so I fetched, built, and noticed cygwin is
still broken! :(

If the 'ab/make-bin-wrappers' branch is going to stay, could you
please squash my patch[1] into (or put it on top of) this branch.

Thanks!

ATB,
Ramsay Jones

[1] https://lore.kernel.org/git/0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com/

