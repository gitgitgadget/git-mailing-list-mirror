Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F9D20188
	for <e@80x24.org>; Wed, 10 May 2017 17:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbdEJRuX (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 13:50:23 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37921 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbdEJRuW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 13:50:22 -0400
Received: by mail-it0-f47.google.com with SMTP id e65so6195759ita.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O5XKgltNw45tfpV2Y++QjzaeaeY01XPegg3xOgJRd4A=;
        b=o2++SrgpKTgkP6SQy4JiOSMsoDOhYEwp0eqaLY/V7ymd6ka6fdVKDWkSqPeYsQQKHo
         3WaRJNCbjXRy98Oin/vOw7lqSkWXy6+BdlSzlJm+mStP675GDlO8dYnzsSR6ey9pTFXP
         c8eE7x7Mk5pEZHlCFOHYk2lj1XJQS1L3WjAsvMylQS9xC4ZUEh7j4H2VXKDcpdr3co/f
         4UAJS7xTSNPpnRxTJ41Ta01e/HXOL+ZJAv8W4an24tRht31KhQ2m/Jmo2IXJAQarqcak
         eHr5gHvRaMXC7A+P5uk0yXccuT5zRh8TjRWPioJPinoUISGLbF6scMner0EUfU5Vqq6O
         lqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O5XKgltNw45tfpV2Y++QjzaeaeY01XPegg3xOgJRd4A=;
        b=dvP/UwP/V0IWALht5XcIyi+jCu9PdaR9L0yqx0Cou+1pFn350CihDWnb16DFarRUsp
         bXcStPJ+c91jUBrk1C3aWS5vMoAR0ICoQA4Z34Cu1DKXP4V46BAKHPjHDvsPNe4SAEBa
         UjUZzgeuXY/8SNKtRiN4RWCceu55tNe0b2GSr0zWlky8IKQUGsBeF/vucTLFH7zA5lLk
         Pl9Db19AmzcDA+xlbLzN3Lz3KPqQlneyeQERyjpWo08RVPtboZwuk040ChKHNetkZzz9
         xsX0BtSYDFkYL3aTmDQQUBZ9/Phe0yXMScKFwlJw5o+t03rJEp0Jhj3s/rhJMYK8NquQ
         rc4Q==
X-Gm-Message-State: AODbwcCjqrsXXoRFaJJWjunX8rxywlH9wvM2+jlDXyDUCe6cUWCGViQl
        pKqr0X6Qw6RkmGITypRIip2g7+beig==
X-Received: by 10.36.138.131 with SMTP id v125mr2634139itd.66.1494438622003;
 Wed, 10 May 2017 10:50:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 10 May 2017 10:50:01 -0700 (PDT)
In-Reply-To: <20170510044626.g4dwcujfr7vhv55d@glandium.org>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net> <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
 <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net> <20170510044626.g4dwcujfr7vhv55d@glandium.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 10 May 2017 19:50:01 +0200
Message-ID: <CACBZZX4AnmP2N_-WLtqQncUDCZDeWS3LFomZrWLYP6iW-hL5KA@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
To:     Mike Hommey <mh@glandium.org>
Cc:     Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 6:46 AM, Mike Hommey <mh@glandium.org> wrote:
> On Wed, May 10, 2017 at 12:33:44AM -0400, Jeff King wrote:
>> On Tue, May 09, 2017 at 09:22:11PM -0700, Shawn Pearce wrote:
>>
>> > > Hmm. That makes sense generally, as the request should succeed. But it
>> > > seems like we're creating a client that will sometimes succeed and
>> > > sometimes fail, and the reasoning will be somewhat opaque to the user.
>> > > I have a feeling I'm missing some context on when you'd expect this to
>> > > kick in.
>> >
>> > Specifically, someone I know was looking at building an application
>> > that is passed only a SHA-1 for the tip of a ref on a popular hosting
>> > site[1]. They wanted to run `git fetch URL SHA1`, but this failed
>> > because the site doesn't have upload.allowtipsha1inwant enabled.
>> > However the SHA1 was clearly in the output of git ls-remote.
>>
>> OK. So this is basically a case where we expect that the user knows what
>> they're doing.
>>
>> > For various reasons they expected this to work, because it works
>> > against other sites that do have upload.allowtipsha1inwant enabled.
>> > And I personally just expected it to work because the fetch client
>> > accepts SHA-1s, and the wire protocol uses "want SHA1" not "want ref",
>> > and the SHA-1 passed on the command line was currently in the
>> > advertisement when the connection opened, so its certainly something
>> > the server is currently willing to serve.
>>
>> Right, makes sense.  I wondered if GitHub should be turning on
>> allowTipSHA1InWant, but it really doesn't make sense to. We _do_ hide
>> some internal refs[1], and they're things that users wouldn't want to
>> fetch. The problem for your case really is just on the client side, and
>> this patch fixes it.
>
> More broadly, I think it is desirable that any commit that can be
> reached from public refs can be fetched by an explicit sha1 without
> allowTipSHA1InWant.

Just a side question, what are the people who use this feature using
it for? The only thing I can think of myself is some out of band ref
advertisement because you've got squillions of refs as a hack around
git's limitations in that area.

Are there other use-cases for this? All the commits[1] that touched
this feature just explain what, not why.

1. git log --reverse -p -i -Gallowtipsha1inwant
