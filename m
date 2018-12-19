Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765301F405
	for <e@80x24.org>; Wed, 19 Dec 2018 06:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbeLSGAb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 01:00:31 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36590 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeLSGAb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 01:00:31 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so730782oix.3
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 22:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ew2PSQq1gQ0H9sjgL+Z47yrXkN8uvDf3Lj3vjJVRhM=;
        b=jG9g1dphrDrMcwBeUdHl5sSTDTS0D3FUoiONgiUW7fuWuQdOuYZUK7QSxYQmRbzDTA
         b5X8mDpGCn6Qzfqpdy2y0FhV2MtAzpeQZgABl9W28yhuJLTkHkT+MvfSz4cAWK1GTkum
         TSLb2qtRFenB3xLiLPc51Qw9Kj3oRKPD0AY/KSWTOXKhM64HdiQTjs9bl7Sa6a2hjWrW
         B5IAmLE3GA51rRL1mSHGv7nR14EqwckBHvAO8e/DDWb0fU+k8NaLh+upgqT9x42PafDi
         QimmRJ0hm0u+jnXzA80WGAirNK+vFFvG3R20HOptnn+8FpvdFG9jaZeNprFKY5Eoz685
         m7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ew2PSQq1gQ0H9sjgL+Z47yrXkN8uvDf3Lj3vjJVRhM=;
        b=M6BqXovA43QHe1VvTK5p/1PrXIhkfm6vb0s9fEq/KLZWlK6j16U0vUNfi97QgyKltZ
         If0iCwqBkx6F8a3/4rHMFIQsUS5dVAOt97uXeqnxE+e49p9P2ifAG+FQRPx3xzX/urO7
         +4tjT0tSM5epCr+YzRnAZU1ZkWmgXdW4qkHrJqPqQpNBae/AvsR7+9cKOwIlnJ5cepTo
         EoSlKORPeJOfXb/1Ku1psTyiY4sRQZ95/LEVhc/BgL2h232jnu3MuDDFKYSke/5eR0vU
         0PahTSa0XSkaP+Xr1YjB/X7Pz8GXpaobTRttFARxm51TuT3wYpuO+lm51cTPfJbAlGkq
         k3dQ==
X-Gm-Message-State: AA+aEWarr/eHBkNYLXZJorORtzLcEW3mpXWAThe9N8mT9kX5CruY/oDS
        iq0pdXSPFuWrlP8obMOSZ+ZBk5+7Mb0ZW8kJYwU=
X-Google-Smtp-Source: AFSGD/Vo1HKLvXSc4uXvg+pBF/kHyG5QZ3/uVm5lcMwto4VLxGfyn9R2AaxulREBtrlnzieu9scIMic/vC36z7LgRSA=
X-Received: by 2002:aca:3541:: with SMTP id c62mr337343oia.330.1545199230228;
 Tue, 18 Dec 2018 22:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
 <1544760713.970.1.camel@gentoo.org> <CAJdN7KjExd6T+H4-wEupO2dg_mMWzeA22oYaskkfhz+GuFbfRQ@mail.gmail.com>
 <20181217202406.GA12122@sigill.intra.peff.net>
In-Reply-To: <20181217202406.GA12122@sigill.intra.peff.net>
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Wed, 19 Dec 2018 00:59:52 -0500
Message-ID: <CAJdN7KixEG+VKJAZz281RFEiVPRpRz_fBy6J2dBJiJMYT1mpBg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Expose gpgsig in pretty-print
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexey Shumkin <alex.crezoff@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 6:10 PM John Passaro wrote:
> All seems to work fine when I treat %Gs as a detached signature.

In light of this, my best guess as to why the cleartext PGP message
didn't verify properly is that the commit data normally doesn't end
with \n, but as far as I can tell there's no way to express that in
the cleartext format. I don't see a way around this. However, as long
as the following works, I think we have proof-of-concept that this
enhancement allows you to play with signature data however you please
without leaving it to git under the hood:

gpg --verify <(git show -s --format=format:%Gs commit) <(git show -s
--format=format:%Gp commit)

On Mon, Dec 17, 2018 at 3:24 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Dec 14, 2018 at 11:07:03AM -0500, John Passaro wrote:
>
> > Then I might rename the other new placeholders too:
> >
> > %Gs: signed commit signature (blank when unsigned)
> > %Gp: signed commit payload (i.e. in practice minus the gpgsig header;
> > also blank when unsigned as well)
>
> One complication: the pretty-printing code sees the commit data in the
> i18n.logOutputEncoding charset (utf8 by default). But the signature will
> be over the raw commit data. That's also utf8 by default, but there may
> be an encoding header indicating that it's something else. In that case,
> you couldn't actually verify the signature from the "%Gs%Gp" pair.
>
> I don't think that's insurmountable in the code. You'll have to jump
> through a few hoops to make sure you have the _original_ payload, but we
> obviously do have that data. However, it does feel a little weird to
> include content from a different encoding in the middle of the log
> output stream which claims to be i18n.logOutputEncoding.
>

Thanks for the feedback! This is an interesting conflict. If the user
requests %Gp, the payload for the signature, they almost certainly do
want it in the original encoding; if i18n.logOutputEncoding is
something incompatible, whether explicitly or by default, that seems
like an error. Not much we can do to reconcile the two requests
(commit encoding vs output encoding) so seems reasonable to treat it
as fatal.

Updated patch coming as soon as I work out Peff's aforementioned "few
hoops" to get properly encoded data -- and also how to test success
and failure!
