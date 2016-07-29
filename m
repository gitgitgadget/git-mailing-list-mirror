Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A8E1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbcG2SMT (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:12:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34351 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbcG2SMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:12:18 -0400
Received: by mail-oi0-f67.google.com with SMTP id c199so8298628oig.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 11:12:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ONFUebPDIyxlClF2fPn5yvP/i/sBQ6+0RPf2eT3FcZg=;
        b=dr6d/kH8jYLdppWHJNkj0pi4Xn1Fy2aUaKAIoMXO0uRdA7hxLuzLjqjpzmoMhWpCLO
         /w8l126+ePE1fVbDW/+cq3VhCk3qU8vVox76m+Zl/OXWwPAzvHTpXfxebhuIz4RVwQeV
         lN3xPoTF2vwdkiefuLMeSYhMXpqBnAkoZUCIGajBmDzKaS8AqIyyhVQSBlPiPMfu8GGY
         grqmP/OjgK/x/gS4nm/qNxYfXD+KsSpT9mQJwr+/CmVm7B1WFkjjv98dfRWe2zC8ZRcO
         E/nga+cAujZqFa/iGlvFNFiKXU8r63mu69BdTCIjlP3F9mHRofJ2CPlr/iFVP+HEVJuS
         vHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ONFUebPDIyxlClF2fPn5yvP/i/sBQ6+0RPf2eT3FcZg=;
        b=JViOn/+W3011YeaNqwDFnNrYi13vF7arC6o6CW+0alKPFC1vEuH36d3pUz9zl0XH05
         xahvkpH7cE3dJGL4aRIpAkK5513DMOzr3FpDKzkLGbNazmRhaDOwTyvv2Zw6cXzPYhes
         b9ZGOGZi4FpODlWMizZnCGZ8l/zUU70ehxk2ErAL9jolso8USnP4jT9MUKAHj9+tiwkQ
         r4oN/XtFjB5UdYOviruIDQFsEOl7mlSVvqRdKvhBRjtH/gytxSZwXuvvWRb/79qqOAYX
         b6Zjzc7tsIDiEUM4Nqbo4M+yTPJC5lHBLC/PEoyOAAQdzeUiko6q7odPZCOelhZ59hnL
         IG/Q==
X-Gm-Message-State: AEkoouutHaWUQ9p7uefUyFfdOnO7btQfInF2qwIaCwVLi6PHgqC8XWmAdjnjGuV4bEpgJkOzyAWzWkPBkFXKzw==
X-Received: by 10.202.73.205 with SMTP id w196mr26883073oia.121.1469815937141;
 Fri, 29 Jul 2016 11:12:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.204.35 with HTTP; Fri, 29 Jul 2016 11:12:16 -0700 (PDT)
In-Reply-To: <20160729180517.GA14953@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net> <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net> <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
 <20160729180517.GA14953@sigill.intra.peff.net>
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Fri, 29 Jul 2016 11:12:16 -0700
X-Google-Sender-Auth: vQ_cIJ67cZHDl07XsNblgzV2XNA
Message-ID: <CA+55aFy+DyHPcPeSeW1ssSqykkOLmgCeYWHQsxRieScTXxYb=A@mail.gmail.com>
Subject: Re: [PATCH] reset cached ident date before creating objects
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 11:05 AM, Jeff King <peff@peff.net> wrote:
>
> Linus suggested resetting the timestamp after making the commit, to
> clear the way for the next commit. But if we reset any cached value
> _before_ making the commit, this has a few advantages:

Looks fine to me. It should trivially fix the git-am issue, and I
can't see what it could break. Famous last words.

              Linus
