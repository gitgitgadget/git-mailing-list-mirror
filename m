Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68CAB20248
	for <e@80x24.org>; Mon, 25 Mar 2019 19:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfCYTT3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 15:19:29 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43337 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfCYTT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 15:19:28 -0400
Received: by mail-wr1-f51.google.com with SMTP id k17so3589395wrx.10
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xQcVEa69D64l/A0SE4FAADI7Vnhzt6LxGk8zoP1GxBI=;
        b=WKklvQP7PV1mULoMCAIr2ZqPLh38JHxlfellDn/+wK00fzkeFmteq4tx7Lq3aWeI5V
         ndNN/N/gRMVrx7LFfU6/Y7elo1vptB0akz/rLNR6KCtY2VXQ63HLR6IgSnmfSEnrO3O8
         mqXPjVNBgjtyx1JzO1IM/BH4jtRCywtGyaSZ0/441tqo5phmHY5HQsBsrDSBIQcU7wHH
         kAmpy5C7We+theZE26At5CLHW9lbMCTvMY2Yrsg5f4fBNJ+k+lYqVbo98m3uReG4jtvd
         wMhHzZuzQUTRKKHhmBv9dAIlwlCauNknuRF5Otc9f+8ZeixnCdUuCSakKtfMMm0/VIHl
         sCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xQcVEa69D64l/A0SE4FAADI7Vnhzt6LxGk8zoP1GxBI=;
        b=j+r1LpkIsjLG/JqZtOVRejOKxBmY0Ha9UDoQpVO7IEu3eBzKKUa6f9jcoaoxVi//K/
         vejrw3RmOx+WDwWhHbZN4XdkzWT02xq9ghsdbwQTCWlmNBbEp+hiBJBlACkLdWUGxakV
         QEoCCyU6HbEfKgOxaFXCKdm8gjSFcYEgD5kOqU4U7IWMe2ebos7yRPOVMpMM/3F55Nid
         lok+0G3wsbksg4caQZ6fjusZu9xAuNdidKPhXFKvJnYr8kVWg7ieOKlKXSSWyUoIpYvG
         HaEehY/pwX31Fc39Ribn5qB9xvkjfikaWnJZ+Drk44oNv750OcUJG/YR2QL+D5X1X5rG
         r/fQ==
X-Gm-Message-State: APjAAAXmYxAXoc40QJ8HAey+3ngdCFbRNjQWO5bIXSIuEkNgBgEKT4T9
        VnidYIacxdWk09KYx1vXUrE=
X-Google-Smtp-Source: APXvYqzOspY5x4xYNAxxIBYQMOy3d38KeIFimDilfT5MpCTlPbQgSY31egGYfpEJaFjYUv5iDUPSFA==
X-Received: by 2002:adf:e541:: with SMTP id z1mr16982151wrm.95.1553541566750;
        Mon, 25 Mar 2019 12:19:26 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b3sm21021455wmj.15.2019.03.25.12.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 12:19:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Strange annotated tag issue
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com> <20190321192928.GA19427@sigill.intra.peff.net> <CAHd499BTACjf91Ohi34ozFQE_NOn-LVf-35t7h4CTtDFoMCpWw@mail.gmail.com> <20190325144930.GA19929@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190325144930.GA19929@sigill.intra.peff.net>
Date:   Mon, 25 Mar 2019 20:19:25 +0100
Message-ID: <87tvfqbw3m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 25 2019, Jeff King wrote:

> On Mon, Mar 25, 2019 at 08:50:14AM -0500, Robert Dailey wrote:
>
>> On Thu, Mar 21, 2019 at 2:29 PM Jeff King <peff@peff.net> wrote:
>> > Tags can point to any object, including another tag. It looks like
>> > somebody made an annotated tag of an annotated tag (probably by
>> > mistake, given that they have the same tag-name).
>> [..]
>> Thanks for explaining. This is very helpful. Am I naive to think that
>> this should be an error? I haven't seen a valid _pragmatic_ use for
>> tags pointing to tags. In 100% of cases (including this one), it is
>> done out of error. As per your example, users try to "correct" an
>> annotated tag pointing at a wrong tag or commit. What they expect is
>> the tag to point to the other tag's commit, but that's not what they
>> get.
>
> I don't think I've ever seen a tag-to-a-tag in the wild, but I wouldn't
> be surprised if somebody has found a use for it. For example, because
> tags can be signed, I can make a signature of your signature, showing a
> cryptographic chain of custody.
>
> And at any rate, it has been allowed in the data model for almost 15
> years, so I think disallowing it now would be a bad idea. It might be
> acceptable to introduce a safety valve into the porcelain, though.
>
>> From a high-level, pragmatic perspective, doesn't it make more sense
>> to change the git behavior so that annotated tags may only point to
>> commit objects? And in the `git tag -f -m outer mytag mytag` case in
>> your example, this would automatically perform `mytag^{}` to ensure
>> that the behavior the user expects is the behavior they get?
>
> I think "just commits" is too restrictive. linux.git contains a tag of a
> tree, for example (we also have tags pointing to blobs in git.git, but
> they are not annotated).
>
> However, I could see an argument for the git-tag porcelain to notice a
> tag-of-tag and complain. Probably peeling the tag automatically is a bad
> idea, just because it behaved differently for so long. But something
> like might be OK:

Sounds good!

>   $ git tag -a mytag
>   error: refusing to make a recursive tag
>   hint: The object 'mytag' referred to by your new tag is already a tag.
>   hint:
>   hint: If you meant to create a tag of a tag, use:
>   hint:
>   hint:  git tag -a -f mytag
>   hint:
>   hint: If you meant to tag the object that it points to, use:
>   hint:
>   hint:  git tag -a mytag^{}
>
> It would be a minor annoyance to somebody who frequently makes
> tags-of-tags, but it leaves them with an escape hatch.

Let's call that something like --allow-recursive-tag (inspired by
'merge' --allow-unrelated-histories) so we don't confuse the desire to
create such a tag with clobbering an existing tag (which -f is
documented to do).

I was going to say "let's make the 'error:' part self-explanatory
without the 'hint:'" part, in case the advice was disabled. But looking
we only allow turning advice off on a per-variable basis, so I suspect
if someone bothered to do that they know about this already. Our
--allow-recursive-tag message is also fairly cryptic (and should, but
doesn't have, advice).
