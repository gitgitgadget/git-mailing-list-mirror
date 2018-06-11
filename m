Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2747D1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 20:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeFKURZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 16:17:25 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:45373 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbeFKURY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 16:17:24 -0400
Received: by mail-ua0-f178.google.com with SMTP id k14-v6so14387976uao.12
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mmftc+Dc5k8olM0c/qbUG23PoA9lcSbQrV5Hd/nahvY=;
        b=a4r5nYob+I9UelpN++T0NYdzsfgMk0MzPi7XXNw7rpZfKTqcbtToOfoU8LfpRzqsRI
         P1PagFN8Uk5d15pVeYoREJf08xpGE/BgsL/RW6vyGyFniiZgchYe8jYzPORm5O4tWEB5
         3N9uNis8INa+uQ7CVp4lPXfIhhJ7POMIo/OTQb8DjAgTC5VNZKeud4dBowLPhAhoqltT
         Mta8/m7gOQNHYMulQ8m7TeCEDP+aFZERZSP5uBqp0TMvHB68V8m+bIs1WqrJzwxRuDtD
         LgOKzhpkYD5Y09gO+F88sW9+5TlQ6566HyFuhwA8KGEu6jjd0m54znpwBDlb59mU/2W2
         y9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mmftc+Dc5k8olM0c/qbUG23PoA9lcSbQrV5Hd/nahvY=;
        b=rYBNYfcIWOtQsXx0avi/jP81hQpC0oX85MvRnH/HCwGBpcl50koHP8t9yI1YdHf0Xe
         VSTXcr5EG2zejB/0ZxYRMgsS0FlOZWoqPIv5hgj/ZkWYq5J2a6udRvOoanqAcKkPFLTP
         kzyUcq+Whd65jukZEyRLnmXw6hQgcqiVBFRtqBzxHVAP06RdgpwLCFTA6dTNIjKxnc3Z
         77DqAhrIdsPOVC5R+diqD5bUpCZE/13t/c12dRBos9J8ZfjVGpFdA2mdJ8iC/DS/DdoN
         bXPdOxLlAT+rdr/oybqrOytnnI14HW+Y06siG2yl3XH1o8z29jpsH3sF4wPnSY7Ta68t
         SZCQ==
X-Gm-Message-State: APt69E1s77X/2VW5vshF0+RXzzjzFU+QBZOAhD177WC5XejTmsHDDB9b
        YDCmmC4W6eViBbH1mKpOhruTEp10+pxXhJeU+Fs=
X-Google-Smtp-Source: ADUXVKKSDFp5KUuNAyFhZvQw1ut3e8zFNfV0avL9lGhLuyIATqbSm308tBUAEgHPMfcqhYmJBNclOCx0/bsbbq5Kg4A=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr406836uae.199.1528748242318;
 Mon, 11 Jun 2018 13:17:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 13:17:21
 -0700 (PDT)
In-Reply-To: <xmqq4li9cj52.fsf@gitster-ct.c.googlers.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <xmqq4li9cj52.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jun 2018 13:17:21 -0700
Message-ID: <CABPp-BF4gbwVRHA3D1vqXuSnh3aS9XVLqtEUEmfmLDKPccyxtA@mail.gmail.com>
Subject: Re: RFC: rebase inconsistency in 2.18 -- course of action?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Jun 11, 2018 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> In short, while interactive-based and merge-based rebases handle
>> directory rename detection fine, am-based rebases do not.  This
>> inconsistency may frustrate or surprise users.
>
> FWIW, I actually do not quite think it is universally a good idea to
> infer that I would have added the path X/F I added to my branch at
> Y/F instead if I were on vacation while somebody else first moved
> other paths X/A, X/B, etc. to Y/A, Y/B, etc., and I would even
> imagine that I would be frustrated if my X/F, which the somebody
> else wasn't even aware of, were moved to Y/F without even telling
> me.  So in that sense, doing such extra and unasked-for "moves"
> during a rebase may be a bug, not a feature.

So...I'm a little confused.  Am I correct to understand that you're
arguing that directory rename detection is an anti-feature and it
shouldn't have been merged in the first place?  Or that it doesn't
give appropriate output/warning, and it should have configuration
flags?  Or are you trying to make a distinction between am-based
rebases vs.any one of rebase -i, rebase -m, cherry-pick, and merge [-s
recursive]?

I was leaning towards "this inconsistency is no big deal; we can
address it later", but now you have me wondering about a different
angle.

> In any case, I think I'll have to delay -rc2 by a few days to catch
> up, so I won't be looking at any topic (including this one) that is
> not about 2.18-rc regressions for a few days.  Please do not get
> upset if people with RFC patches do not hear from me until the
> final.

I emailed about this rebase inconsistency because I was worried that
*an* inconsistency between the various rebase types was bad.  But the
more I've dug, the more I've found they are inconsistent in lots of
ways anyway (levels and types of output, reflog entries, automatically
dropping became-empty patches vs. halting and asking the user,
accepting commits with empty commit messages vs. requiring an
--allow-empty-message flag to do so, large sets of mutually
incompatible options, etc.)  Adding one more inconsistency is feeling
less worrisome to me.  I'd still like to lessen all these
inconsistencies between rebase types, but my current opinion is that
it's not that big a deal and my patches can all wait for the 2.19
cycle to start.
