Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12902018A
	for <e@80x24.org>; Fri,  1 Jul 2016 19:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbcGATuM (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 15:50:12 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34313 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbcGATuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 15:50:11 -0400
Received: by mail-io0-f173.google.com with SMTP id g13so108101407ioj.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 12:50:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LgCAnwTJGIRE9UyJjgAifNrpr7ReqZMAOyJ3RJQ06kc=;
        b=ZeySoWjn7l2XQFihrW4E8rrSIcgOMd7pkmcals+8loLGbTHKtWp065sKKIPVcZ7OHO
         9nYfsutwy+fGC/dFPcpPELVdJJxy20rAwb7c7izmoFXmp6NDq1dp0OR3A9jbZx7O/lsg
         /hhfDpnNqfHpqgndVKAlyLq9vkBM6RrPIDdwjqboB4IHzaWMIQQ/VlP1zEfUptWNrMBI
         jh/IAPdnnUFbl8/gpt5j0vVY+z1Q0whoMW5PN4yIH/iJOvSl2Lq2Izi5FRLgZ91wdJfT
         ER3Ux5X0x0E5BU5lVY7fiQ96JsChTXv6wz3f1LugnUBlpAUvOJPbQnE76d3w6cwCS+os
         Wsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LgCAnwTJGIRE9UyJjgAifNrpr7ReqZMAOyJ3RJQ06kc=;
        b=XLWLjEG1b6iwSRxpclIFfmvjLf2ndwSUyR43c9kFqggHNFYg2afsi88j/FZSshdd8u
         YRTkdv5+Zcp0A+1PhMrYft1qiRcV24l6zb3R4hnJRRq3JrYk+aMeh1IJCEAlq4IvWITX
         4cXu3fJmCmysyNB1o7RUau6QF5T8SgtJbsUjA5VjkZ33eQXfhaturNqtV96vInKXTbo9
         8GqMK+JuCdGswwh9OQEPwIlNUYgQDj8SDjEQp25qehFJjAjO3HM46uwjNCXc9lOJwZ1u
         kOEuK4s75XfIR8kIoQNBnv2SCrHMzd7XdCFsIj42onOQEVLS7PUVOEGY9kHS/BC3FFZ7
         73+g==
X-Gm-Message-State: ALyK8tLaujq7N+r9RaNTV94qI4c6wWZ3d1947QYjqsuN290CthftfoG10BTIhc5T+AkIWwJutOtGVLmq8zk7/Dr6
X-Received: by 10.107.186.196 with SMTP id k187mr22584425iof.173.1467402609820;
 Fri, 01 Jul 2016 12:50:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 1 Jul 2016 12:50:09 -0700 (PDT)
In-Reply-To: <20160701193909.GA23141@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com> <20160630005951.7408-2-sbeller@google.com>
 <20160701071410.GG5358@sigill.intra.peff.net> <CAGZ79kaDCLm3BBURJKfkYWKKvozkFTGCn0wGiQCtspUvtQBd+g@mail.gmail.com>
 <20160701175950.GB16235@sigill.intra.peff.net> <CAPc5daWjSW5KM4uUyEBbb+765t50+dUsewF52uPrCiT1HW=NAQ@mail.gmail.com>
 <20160701181102.GA16695@sigill.intra.peff.net> <xmqqr3bdxirw.fsf@gitster.mtv.corp.google.com>
 <20160701193909.GA23141@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 1 Jul 2016 12:50:09 -0700
Message-ID: <CAGZ79kaRG7SOcz1LyOkN8W_dpmK_AjwYyyMrZftZCac9fCo+EQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 12:39 PM, Jeff King <peff@peff.net> wrote:
>
> That was sort of my question. _Is it_ too bad or not? It's hard to say
> without knowing the use cases.
>
...
>
> That's ugly, of course, but not really uglier than the parsing required
> for the COUNT proposal.

ok, I'll try to get the COUNT proposal in good enough shape.

>
> I'm assuming that git actually knows about and enforces that things are
> "key=value". I'm not sure how you'd get by without that (you'd have to
> infer the meaning of a parameter by its position, which seems like a
> recipe for mistakes and incompatibilities).
>

Of course! We could use "a hack" just like in the Git config itself.
If a boolean parameter is not given, the default is assumed. If it is
given the opposite is assumed. Same for attributes, that can be set
by just giving the key (with no "=true").

So I think I can be convinced to go only with key/value pairs for now, but
it would be easier if you'd just have

    git push -o draft ...
