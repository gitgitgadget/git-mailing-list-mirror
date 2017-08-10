Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D34208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbdHJU02 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:26:28 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:37507 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbdHJU00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:26:26 -0400
Received: by mail-qt0-f178.google.com with SMTP id 16so11085192qtz.4
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=//n1fCVPKUlTjJ8bBNggqnkdD2y/CMCE6/vkWbjTj2s=;
        b=Qkix/osjlsNtLIeW5FrWGfZ9jI+aChpy+eZIHJXZTWsg/ddTyzalAEC1oBL2G2JEWK
         guLKUrLgNgtQvd/ueYNZIOwgOu/vk4x35UDJ6lrQy5N544+AMsBj3y2VKaFs2n7L3sjh
         MwIYez+QkLhx0LLO+WtUUGYlw5wn3jnueo1WLzkRGuykzVyBMFbjXT6x8clFGgQhRcu5
         KuTdk8NbbkjARIDJB8ORIvw3gzhqBtCyhKEWhrDWu+C5eJ0Ae3uZ4MHtKeoc0URSVtGp
         qR6S9yrpEhC/afc8Cgl4dsDmJ23TnK1DHrpX/KCmaF9Wy2wI8mHG2Q9FAnAQiRKhGi0u
         58Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=//n1fCVPKUlTjJ8bBNggqnkdD2y/CMCE6/vkWbjTj2s=;
        b=uPH4xkaiQh56dCW7cFkXiS8pSps2au8JcQZ2IJTET1//PZ7EK7lGt4isNQLveG7X0w
         bAiJczELKGvBQ+bRsxGZD7dzg0yCB98F1f6RcWxxXINsgcCQt7K9lItV0HJGz02mxD5C
         ArgqfCY5h8q3ZhNxuUAd5M504itFYbfWuFIqkX3Xzi340Gu4GxLaEMNfWw9IXMypPSnO
         jh6DOc7RIMysrkQB8+ZvrSg+s/qgRHEjG4VxILK02CeqdndWQ61xDszvUGdH/2IFjHiY
         W0n1xpMnsNFetKeF+sw+T0DxrZEMTOKY9Y5f1vQoORiSSHpKawWztq2wcbf8tB6bc5XL
         gIpg==
X-Gm-Message-State: AHYfb5jT5vREa6N2k6p+oTX5OpSIzYovDeaPsGpXMFyH37sORZhxqWNl
        piHebwnJS5XEc78LVfygaRiN+9ohqA==
X-Received: by 10.200.41.247 with SMTP id 52mr17287828qtt.0.1502396785378;
 Thu, 10 Aug 2017 13:26:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 10 Aug 2017 13:26:24 -0700 (PDT)
In-Reply-To: <20170810194251.r76pumddcchlke7c@sigill.intra.peff.net>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net> <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net> <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
 <20170810194251.r76pumddcchlke7c@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 10 Aug 2017 22:26:24 +0200
Message-ID: <CAP8UFD0A59f70i4qT7BBxcbK7Dx4dEoNsWHEmYaqp=MqshpHgw@mail.gmail.com>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 9:42 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 10, 2017 at 09:39:21PM +0200, Christian Couder wrote:
>
>> > If you prefer the normalized form (and the input was line-broken in a
>> > way that you don't like), then this would convert to your preferred
>> > form. I agree that you could potentially want the opposite (folding long
>> > lines). Perhaps something like --wrap=72.
>>
>> Related to this, I wonder if people might want to "normalize" in
>> different ways later. If that happens, we might regret having called
>> this option "--normalize" instead of "--one-per-line" for example.
>
> My assumption was that it would be OK to add other normalization later
> if it brings us closer to the "key: value" form as a standard, and it
> could fall under "--normalize", since that's what callers would want.
> And that's why I didn't want to call it something like --one-per-line.
>
> But if you are arguing that there can be many "standards" to normalize
> to, I agree that's a possibility. I think we have an out by extending to
> "--normalize=whatever-form" in the future.

If we take `git log` as an example, we now have "--oneline" which is a
shorthand for "--pretty=oneline --abbrev-commit".
And the default for "--pretty" is called "medium".

So instead of your suggestion, we could call this option "--oneline"
now, and if other normalizations are later required we could then
create "--pretty=whatever" and say that "--oneline" is a shorthand for
"--pretty=oneline".
