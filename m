Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392052070C
	for <e@80x24.org>; Wed,  6 Jul 2016 20:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606AbcGFUQT (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 16:16:19 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34887 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbcGFUQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 16:16:18 -0400
Received: by mail-yw0-f181.google.com with SMTP id l125so96866065ywb.2
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 13:16:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZMeTYFL8OI48+fttPMapWEvSgWoGTATV253QVcSNNpM=;
        b=paK/EWhrfDcTbpIHKRg5OwJyjFhrAjqVrvM8BdSp7fNjOpnEB/nrAimqyvB+UjdxUV
         /kIx8WfdKzfcxpyrFplgflcNThEV62hsCsk4Ej976NBZZDjok6G/q7oYIH7MIJsbV3Xk
         5oZAJAiCkimKhd6M56yjPXV5i2y9punkLTD/f+XN6xD8FnC2XamxlAAGM4gbFQky7tMr
         ks08L2DHRCTtWP8+nBu1Q15KQt2ofMbx2u/jEWV8WpWcw7nGvuIr1NQmdyQvSsd+VyGY
         aZP0LVlET+WYuKVWrOWKfM7Jg+9ke6JbvLD046XCALNmVo9FEeCc3aUGggxYgBnxBQDj
         5g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZMeTYFL8OI48+fttPMapWEvSgWoGTATV253QVcSNNpM=;
        b=KXPiHjAEkusvVOieluxdxB2haaaQC0Y8ZfFknENSdC/mNVIT02XCVCKWlSlkPrpOF/
         jSxtnYYwjgkWx2lPw8M5Uo+mkWgb3qnzSmPBRYGupK5Ad4w/eOUVQZR5AOU05GFn3UYR
         hAfpwHSHcL93jQrnxwHOS2VCOJREiR4cxr83NNplLCmjp7VWA2xLSNX5yl9cTWgrpqfn
         9Pipc1O2WQ7K97Em2yxMn3bIYki9Gx55ozTMbI3KKvN2tahCTxEqbUATCVrF148fqg2f
         rguJUsFDUHcz843J8j+9J1P8nJjpr+Owv68Cg0UfPB9GqqeHPtvTC3lLmlqgZDjucq1w
         /kDw==
X-Gm-Message-State: ALyK8tJnqNeASnT3KZ5vXWRL+gMcIvgKoSgcPmg/keek2WwGMdh+8u53+ygIZ6okDegBHel3Q/Obt8+osvpgfQ==
X-Received: by 10.129.164.85 with SMTP id b82mr16371254ywh.310.1467836177910;
 Wed, 06 Jul 2016 13:16:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.34.133 with HTTP; Wed, 6 Jul 2016 13:15:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607061514200.6426@virtualbox>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
 <20160705202820.GA14496@sigill.intra.peff.net> <20160705204447.GB14496@sigill.intra.peff.net>
 <CA+P7+xqODaXn2NFY-=Ktr1stzR1mu6_ZO7Lfgj7AEzhzxhLAbw@mail.gmail.com>
 <alpine.DEB.2.20.1607060857240.6426@virtualbox> <d1e0e688-a309-2a01-4ee2-c1af9d71cea0@drmicha.warpmail.net>
 <alpine.DEB.2.20.1607061514200.6426@virtualbox>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Wed, 6 Jul 2016 13:15:58 -0700
Message-ID: <CA+P7+xpVbSbHP-j1c+zQjMALb_C5eOb-c23290AbVjufxOHqoQ@mail.gmail.com>
Subject: Re: Over-/underquoting, was Re: [PATCH] revert: clarify seemingly
 bogus OPT_END repetition
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 6, 2016 at 6:16 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Johannes Schindelin venit, vidit, dixit 06.07.2016 09:01:
>> OTOH, I often have to look up the original message because people cut
>> too much, or because they take one sentence out of context.
>
> And others quote too much. In your case, the reference to Peff's patch was
> not at all what you referred to.
>

I obviously left the whole message, and I usually try to cut what I am
replying to but I forgot and was in a bit of a hurry that day. I think
most people are capable of checking archives if they are worried about
someone quoting out of context.

>> It is not unheard of that a MUA can collapse and expand properly quoted
>> parts on request...
>
> Sure. Show me some kick-ass, scriptable mail client and I will have a
> look.
>

Yep, I haven't found a mail client that really works for me either :(

> Ciao,
> Johannes

Regards,
Jake
