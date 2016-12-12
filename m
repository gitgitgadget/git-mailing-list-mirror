Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0931FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 09:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbcLLJCd (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 04:02:33 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:57972 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbcLLJCc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 04:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=+mmi9YzNHheBTi
        ErpxIwGyp6FWxQQ9gmQzltzj3Q0oQ=; b=SFWn2jNvzkNOTQMMB0jl0Bc4RnBqge
        H2tlWJgh1LAdNUHEX1rGKrD7ipBchvBhzIZ9UWmLPUkhTniOlGsdX1XXwyv9KgA4
        +lxwPGUcb0/Gaggomsyk1vTpiyWRZ8dH5EfSRR3NpS/KHVWQ/xpT3VywGYK52Gsa
        G5XvbAhTxzbAo=
Received: (qmail 25323 invoked from network); 12 Dec 2016 10:02:29 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 12 Dec 2016 10:02:29 +0100
Subject: Re: [RFC/PATCH] merge: Add '--continue' option as a synonym for 'git
 commit'
To:     Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
References: <CAFOYHZAsU_gNb=_K=iMFKFdt60SJ4Wm=Ag5=XMXuQgxNxCqWLA@mail.gmail.com>
 <20161212083413.7334-1-judge.packham@gmail.com>
Cc:     peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <b814932a-b395-2b27-979f-cd170ba363ee@jump-ing.de>
Date:   Mon, 12 Dec 2016 10:02:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161212083413.7334-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.12.2016 um 09:34 schrieb Chris Packham:
> Teach 'git merge' the --continue option which allows 'continuing' a
> merge by completing it. The traditional way of completing a merge after
> resolving conflicts is to use 'git commit'. Now with commands like 'git
> rebase' and 'git cherry-pick' having a '--continue' option adding such
> an option to 'git merge' presents a consistent UI.

Like.

While Junio is entirely right that this is redundant, the inner workings of Git are just voodoo for a (guessed) 95% of users out there, so a consistent UI is important.

>  DESCRIPTION
>  -----------
> @@ -61,6 +62,9 @@ reconstruct the original (pre-merge) changes. Therefore:
>  discouraged: while possible, it may leave you in a state that is hard to
>  back out of in the case of a conflict.
>  
> +The fourth syntax ("`git merge --continue`") can only be run after the
> +merge has resulted in conflicts. 'git merge --continue' will take the
> +currently staged changes and complete the merge.

I think this should mention the equivalence to 'git commit'.


Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
