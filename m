Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DD991F4F8
	for <e@80x24.org>; Fri, 30 Sep 2016 09:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbcI3JlP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 05:41:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45545 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932088AbcI3JlN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Sep 2016 05:41:13 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A761F20EA8;
        Fri, 30 Sep 2016 05:41:12 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 30 Sep 2016 05:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=7nUrVkcUdR/PpFjEc9/Njz3TK+E=; b=WZ402E
        Av1+jbB3U1D2lbXlCBTnS2zqO5XNHuUui26AidCNq7xBKMIFNqbmosZCSAyI11Tk
        CIM9y+VRJrPnW2pVwujPaiWO6K20gCOWcUpAHgaUjRaDyJEbKorbU9u8VwCrOPBq
        9OuzA08HMqrOkPZaUCKsxUs8tSf13b9qWiMEE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=7nUrVkcUdR/PpFj
        Ec9/Njz3TK+E=; b=rDw486sy4n5re2O7jCN7XjkYREU8tvTOtPVlrMpND49VgCf
        ez2JMbJaqrQwKH0uAcEOQKhcYbHIR2DR/4ZEK5RiHvhrcTmxukFtM2Yu+S7zHlnC
        /uK65FnSXq+5CEbZKfycLmeDif7b1T3sXCOrZzL9Z2EsC4qwdOk6tt1G9iMM=
X-Sasl-enc: hkfu+5Noq2DzLUHI6VsqCEJdJ95FPXZEgmiXJ2yWRy0K 1475228472
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1160AF29CF;
        Fri, 30 Sep 2016 05:41:11 -0400 (EDT)
Subject: Re: [PATCH v2] gpg-interface: use more status letters
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
 <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
 <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
 <24ecc903-3e5a-47f6-f073-00a1c709d5e8@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Alex <agrambot@gmail.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <85fa6296-17f0-0e8c-ec1b-54cd48c45223@drmicha.warpmail.net>
Date:   Fri, 30 Sep 2016 11:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <24ecc903-3e5a-47f6-f073-00a1c709d5e8@ramsayjones.plus.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones venit, vidit, dixit 28.09.2016 23:09:
> 
> 
> On 28/09/16 20:59, Junio C Hamano wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>  
>>> +  "X" for a good expired signature, or good signature made by an expired key,
>>
>> As an attempt to clarify that we cover both EXPSIG and EXPKEYSIG
>> cases, I think this is good enough.  I may have phrased the former
>> slightly differently, though: "a good signature that has expired".
>>
>> I have no strong opinion if we want to stress that we cover both
>> cases, though, which is I think what Ramsay's comment was about.
> 
> Kinda! ;-)
> 
> I'm not sure that it is a good idea to mash both EXPSIG and EXPKEYSIG
> into one status letter, but I was also fishing for some information
> about EXPSIG. I was only vaguely aware that a signature could expire
> _independently_ of the key used to do the signing. Also, according to
> https://www.gnupg.org/documentation/manuals/gnupg/Automated-signature-checking.html
> for the EXPSIG case 'Note, that this case is currently not implemented.'

A key can have an expiration date.

A signature can have an expiration date.

The "goodness" of a signature is independent of the expiraton dates.

Signature expiration is implemented, I tested that (gpg 1 aka "classic").

> Hmm, I guess these are so closely related that a single status letter
> is OK, but I think I would prefer your phrasing; namely:
> 
>  "X" for a good signature that has expired, or a good signature made with an expired key,
> 

I'm open to whatever phrasing you deem clearer.

Also, I'm open to using another letter for EXPKEYSIG but couldn't decide
between 'Y', 'Z', 'K'. 'K' could be confused with REVKEYSIG, I'm afraid.
'Y' is next to 'X' and contained in 'KEY', it would be my first choice.

Cheers,
Michael

