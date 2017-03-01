Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B522023D
	for <e@80x24.org>; Wed,  1 Mar 2017 22:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbdCAWFq (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:05:46 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33837 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdCAWFm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:05:42 -0500
Received: by mail-qk0-f196.google.com with SMTP id s186so14396339qkb.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bF7ZdPmBBEbIYcTksXXzzOdFPtRXFwJ3cHS4DAk6DpY=;
        b=b2d6gmchekG0M4LXFYkLfLuzi2u1zOb7tefqf+H65CYsOQ8zKXLGQ6pGh2MPaeCFXl
         PfuJUsJQU191sYAhhjXlL9ajyzkGF0ugkFUIpXMYib1ALabfCg6tLg49S/dU2gYHejRb
         ZcIisBKRlkQywSsFajbyuecWi1G3VCdNZBNFrws3FmKV/hQGxUKKwvg9REMhrO+6mNdf
         JZU2taiarBLVfPtzQGv3aa4cQ9RuwkDQE9n1FBACIW1zx65mRBzaisW6sUzB4gZjBFp8
         DsH50PUJ1vwc9oCDoe8d0GQv+BJPmeB5x/bHNzNJLfKlS2GFtATAmRCxUcUpag4vEhvB
         E/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bF7ZdPmBBEbIYcTksXXzzOdFPtRXFwJ3cHS4DAk6DpY=;
        b=t14cIzRqQeEObHQjRjoLo+hLWgafj0NKsmle/QYGmODGIM598KzDEaHnARpxqP0yFr
         PgY6DLXPClXcZUl4OhdekJDAPNLaMZZzxZQJF4bsaElqjMtBjoQTH5g4z+bTMR3XFpO8
         IVcF9dZ3flMQCF5GQhsyVwHCnEdCoOe+zaiyk8XiT/HxafFem90+yYCjeKXgdWA9ON4u
         fZ/SXq3AVaf/CMbK/hywSLVgyXR6mW+cEjVRGXRYXnBMWAhjX6J3tnTq/tnSExx/w/+T
         gzKP37rThXtMNepOegIGB9jKeeO365ug+0QxE0Akzlzo5R+lxDXrt671JQ6zXNmIk4uN
         nIXg==
X-Gm-Message-State: AMke39l0R4QDsGrQPTwHydrIIWoIw2TpjY3J1NoRg2SUohtRGqvnWfWy43FPm1BTt5MVcihDGU6EW10tfwhC9w==
X-Received: by 10.200.1.14 with SMTP id e14mr14061670qtg.244.1488405940659;
 Wed, 01 Mar 2017 14:05:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Wed, 1 Mar 2017 14:05:20 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1703012227010.3767@virtualbox>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 1 Mar 2017 14:05:20 -0800
X-Google-Sender-Auth: FS9IK32wSn9MzuI73-WKC7WuB1g
Message-ID: <CAPc5daU2GVpc5Nhx13apFMs3XkL+O8_+3uA842vGQouwb4kEAg@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>, Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 1:56 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 1 Mar 2017, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>> > That said, I think that it would be lovely to just default to
>> > USE_SHA1DC and just put the whole attack behind us. Yes, it's slower.
>> > No, it doesn't really seem to matter that much in practice.
>>
>> Yes.  It would be a very good goal.
>
> So let me get this straight: not only do we now implicitly want to bump
> the required C compiler to C99 without any grace period worth mentioning
> [*1*], we are also all of a sudden no longer worried about a double digit
> percentage drop of speed [*2*]?

Before we get the code into shape suitable for 'next', it is more important to
make sure it operates correctly, adding necessary features if any (e.g. "hash
with or without check" knob) while it is in 'pu', and *1* is to allow
it to progress
faster without having to worry about something we could do mechanically
before making it ready for 'next'.

The performance thing is really "let's see how well it goes". With effort to
optimize still "just has began", I think it is too early to tell if
Linus's "doesn't
really seem to matter" is the case or not.

Queuing such a topic on 'pu' is one effective way to make sure people are
working off of the same codebase.
