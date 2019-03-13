Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC7720248
	for <e@80x24.org>; Wed, 13 Mar 2019 01:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCMBtZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 21:49:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37681 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfCMBtY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 21:49:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id x10so219943wmg.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 18:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RDoBip+xOJyZKULECRXUCXdzqzFwbJyFtbNqbf7yFUs=;
        b=CjH6dmDHNAO4TYHN3CoSiFAidu6RohBoTMmxBTSn0mNJ86dWtTZIQ8Oe3lZ/OQJch4
         JrDBPpzgUeTmnmY0kCn+HGQoRMmn/2FQnNiF4A4vDQaEAWKSW0ipTz5N2XjufxSGTKrR
         2vMqrsJatgmBB1ZBZbo3NlU4Tk/ep2WVvrSMxiaIFOpMm0x4sCNu5/qZiNdQBn+jXn+7
         MdD0NfDaRP8oOO8PUWj84AVLPXywF/sOruFT+Wd5CRfFpb9sLNEbD3uG+yL/MZa1rNgi
         bpsnFzB+uu7yzRr3HJU48ESMsa6hzKQ97sIB34tblnms8DkVl2MWIILJKrklpEDuXboR
         9Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RDoBip+xOJyZKULECRXUCXdzqzFwbJyFtbNqbf7yFUs=;
        b=G045pjC4h5Yxb3Fp7odMpFpP2GHfZVrse/CsjDRYXpuesGtl6kg95Gg48pE7Bsz9uk
         kkw+ZuJYh/xNu34j6BhoHhPZb8z8N2/cDiZBYYWcRT+skopUwbwxQSfsvxVV4gzZWv8e
         eUTnFQZJDLvACROewr8hR5OL5vB0vg0fNSmkJkiiEBMz+0N6dbxtKcD07jagR52BQQrQ
         RlJ880MR0Itotercw0J6NLgN/d7dtBvFBduAZWoSlXK7Usfjc2xyC9F0jngN/ayZjAJ5
         VUsJ0Uy8pHotjDjM5RcFCkQhtc97gYeikuiifxKv4nB0hhPwZ9HX4NY6EqRxVa4dpeeJ
         YbBA==
X-Gm-Message-State: APjAAAVQwWyfqtT/7y0nQNkCMbWYUEa28gY5FB28BjXBzqaRX23FKlmg
        8MMTXMq8tCLwmkEuy19xUR8=
X-Google-Smtp-Source: APXvYqxE+PaWod1qywi3W7tW4Klyf6J+A/mCFS878Rpw1aHTZ+YETYJTsMoVp8lL43soSxF1hnSfCg==
X-Received: by 2002:a1c:7c0c:: with SMTP id x12mr381430wmc.38.1552441763202;
        Tue, 12 Mar 2019 18:49:23 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z1sm7543615wrw.28.2019.03.12.18.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 18:49:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
References: <20190312213246.GA6252@sigill.intra.peff.net>
Date:   Wed, 13 Mar 2019 10:49:22 +0900
In-Reply-To: <20190312213246.GA6252@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 12 Mar 2019 17:32:46 -0400")
Message-ID: <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> infrequent contributors. And there are a few reasons to prefer GGG:
>
>   1. submitGit seems to still have a few rough edges. E.g., it doesn't
>      munge timestamps to help threaded mail readers handled out-of-order
>      delivery.

Hmph, I had an impression that the recent "why aren't these sorted"
topics were via GGG, not submitGit, though.


>   2. Subjectively, GGG seems to be more commonly used on the list these
>      days, especially by list regulars.
>
>   3. GGG seems to be under more active development (likely related to
>      point 2).
>
> So let's actually swap out submitGit for GGG. While we're there, let's
> put another link to the GGG page in the PR template, because that's
> where users who are learning about it for the first time will want to go
> to read more.

Yeah, I see Roberto agrees with the direction, and I do too.

Thanks, Roberto for submitGit that served us well, Dscho for GGG
that will serve us better, and Peff for updating this ;-)
