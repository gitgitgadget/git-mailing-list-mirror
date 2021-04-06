Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93290C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 23:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDCB613BE
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 23:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhDFXCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 19:02:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:43018 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232398AbhDFXCA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 19:02:00 -0400
Received: (qmail 9674 invoked by uid 109); 6 Apr 2021 23:01:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 23:01:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1085 invoked by uid 111); 6 Apr 2021 23:01:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 19:01:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 19:01:51 -0400
From:   Jeff King <peff@peff.net>
To:     Varun Varada <varuncvarada@gmail.com>
Cc:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <YGzoX9OeWMKXpqtf@coredump.intra.peff.net>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 06, 2021 at 02:36:27PM -0500, Varun Varada wrote:

> > while using "will not impact" in an incorrect or unclear way may be a
> > problem the word "impact" in itself is not "jargon".
> 
> The word means "to have a strong or marked effect on" (v.) and "a
> strong or market influence" (n.) when used figuratively; it is not
> synonymous with "affect" and "effect", respectively, as shown even by
> all of the entries you've cited. Using it as such is the incorrect
> part, so those are the instances I've changed in the diff.

Er, is that true? From Michal's definitions:

> > From The Collaborative International Dictionary of English v.0.48 :
> [...]
> >      2. To affect or influence, especially in a significant or

It literally uses "affect" to define it. The "especially significant"
does not apply to many, but I don't think that makes it necessarily
wrong to use impact to mean "affect".

Likewise:

> > From WordNet (r) 3.0 (2006) :
> [...]
> >       v 1: press or wedge together; pack together
> >       2: have an effect upon; "Will the new rules affect me?" [syn:
> >          affect, impact, bear upon, bear on, touch on,
> >          touch]

That is likewise listing "impact" and "affect" as synonyms.

I do agree the word is over-used in some forms of writing, but I don't
find anything at all confusing or wrong about the uses that you changed
in your patch. I am a native speaker of English. I'm open to the
argument that non-native speakers may be more confused by the word. But
this seems like mostly a style preference thing, and I'd generally
prefer to leave the contributions and style of the original writers
intact unless there is a good reason not to.

Such changes are doubly unwanted in cases like this:

> --- a/compat/nedmalloc/malloc.c.h
> +++ b/compat/nedmalloc/malloc.c.h
> @@ -2952,7 +2952,7 @@ static size_t traverse_and_check(mstate m);
>  #endif /* (FOOTERS && !INSECURE) */
> 
> 
> -/* In gcc, use __builtin_expect to minimize impact of checks */
> +/* In gcc, use __builtin_expect to minimize affect of checks */
>  #if !INSECURE
>  #if defined(__GNUC__) && __GNUC__ >= 3
>  #define RTCHECK(e)  __builtin_expect(e, 1)

where the text is imported from another project, and we'd prefer to stay
as close to their version as possible (e.g., to avoid unnecessary
conflicts when pulling in new versions).

Also, this one should be "effect" anyway, as it is a noun.

-Peff
