Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C8720248
	for <e@80x24.org>; Sun, 14 Apr 2019 11:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfDNL1l (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 07:27:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41301 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfDNL1k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 07:27:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so16128518qta.8
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBicTFNG6UxbF5v9A4Rli0DmkGswb7NuR9Sxe9fkQEI=;
        b=ct4uQQToweJ0nXn7+ByfZJxWQvyrLzEywzZa5ZD9IeRY/oXOPgU01Ac8oS3iqvVa4z
         n1XpPDYcveO5CFyH8SMEoAITAxS+BZFZCCuCzGbzRvd4HPvQWcGrmjvyr35HboxWPZ0A
         /G0UNtBT7Wjy57lVT2A3CCDrGWQk7nArrOIs6mNFZ35WrBTWcbJS57ULMymF++I5iD8Z
         McLdyTLLCjS+VF0bAQqEIZXJsa4AG5tAwvQNK5POTH6l3wyQauZBsMGBzEIbrvxZERQt
         +l6Xq2YLv+b3RmRvgPlfYCXdcbPBaf3Nh89B9Ge9rDyhMr4LeXrQllTa/qgJhUGwUQk+
         J03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBicTFNG6UxbF5v9A4Rli0DmkGswb7NuR9Sxe9fkQEI=;
        b=iZupTJs7uBo8OfUH6yxKZIERWykUOKPmBNYYrBbCs4g/yyEKtLDqdy4heZnFOq8Ud2
         XElI1DCse+hBTDRNVoRXr+QaNovYrqGgyr+1jwW4C/j5zTVb20qqOsgo+RN084O0oTrY
         eM71pnbjOBheqGP6l760rK+lJn1wU+em0UPAaxeaqjrYAo1W7cdbiBXnl/cVPorywFB/
         rklo4WBAi3IUGjAleQjuFfp/RsjrQ4dfa4RLUaIcZ/YXQ/YBK1yOa+wR5sbFSPX14nYs
         RmNHSa69e8YRAvKkjZG86bbIbMMUMT/1MnqGYnInfmBO+QS/eMoTo4Rd6i3Nvoy6iAr1
         kkdg==
X-Gm-Message-State: APjAAAX3BL90xMOwtrgVX2eLkWeBspSr1Ta8ctz21XzIWeXGPykJxWwK
        a31za67J1G25OTJpmTuxVnbmBtLhjQ/dKFaF654=
X-Google-Smtp-Source: APXvYqyIIWnXvXU96rpaEJrego8SbQakdcP54CNfg/9C1gNd7v/MTK42N0jMTNsKQ2B2IICjVtCaQVZaY3vRwwsCUSo=
X-Received: by 2002:a0c:9246:: with SMTP id 6mr55443739qvz.194.1555241259934;
 Sun, 14 Apr 2019 04:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190410162409.117264-1-brho@google.com> <20190410162409.117264-5-brho@google.com>
 <xmqqo959w8pq.fsf@gitster-ct.c.googlers.com> <CAJDYR9S8XFH=JnQX8WcfgOZ7cr+X6kk45k9g8t3u5aP5wwdu0Q@mail.gmail.com>
 <xmqqbm18x4tt.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm18x4tt.fsf@gitster-ct.c.googlers.com>
From:   Michael Platings <michael@platin.gs>
Date:   Sun, 14 Apr 2019 12:27:28 +0100
Message-ID: <CAJDYR9TRk99Kwq5S7udVqYsXnupGD=t3o_Ss8ewvwWuTQOy_YQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] blame: add config options to handle output for
 ignored lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 14 Apr 2019 at 11:24, Junio C Hamano <gitster@pobox.com> wrote:
> > If you only enable blame.markIgnoredLines then the hash for
> > "unblamable" lines appears as e.g. "*3252488f5" - this doesn't seem
> > right to me because the commit *wasn't* ignored,
>
> I think you misunderstood me.  I was merely suggesting to use the
> approach to mark the line in a way other than using the NULLed out
> object name that has been reserved for something totally different,
> and hinting with "the same *idea*".

Hi Junio, that paragraph wasn't targetted at yourself, more a comment
on the functionality as it exists in the latest patch series. Sorry
for not making that clear.

> the "^" marker
> that is used to say "the line is attributed to this commit, but that
> may only be because you blamed with commit range A..B and we reached
> the bottom of the range---if you dug further, you might find the
> line originates from another commit" is the origin of the same idea,
> and this topic borrows it and uses a different mark, i.e. '*', for
> the "we are not certain---take this with grain of salt" mark.

So it sounds like we have many types of blame to consider:

1) This commit is truly the last one to touch this line, and you
didn't ask to ignore it.
2) This commit is truly the last one to touch this line, but you asked
to ignore it (AKA "unblamable").
3) This commit is at the bottom of the range of commits (^)
4) The "true" commit was ignored but we guess this is the one you're
actually interested in (*)
5) The "true" commit was ignored and we've reached the bottom of the
range of commits (^*)?
6) This commit is at the bottom of the range of commits, and you asked
to ignore it.

> If you ended up hitting the commit the user wanted to ignore,
> perhaps you can find another character that is different from '^' or
> '*' and use that, following the same idea.

I personally don't find the "unblamable" lines interesting enough to
justify giving them a symbol. But if Barret strongly feels that such
lines should get a '*' then I won't fight it - these lines tend to be
as simple as "}".

> By the way, a configuration only feature is something we usually do
> not accept.  A feature must be guarded with --command-line-option
> and then optionally can have a corresponding configuration once the
> option proves to be useful enough that it becomes useful to be able
> to say "in this repository (or to this user), the feature is on by
> default".

In that case we definitely need a --mark-ignored-lines option to git
blame, and I would strongly prefer that we also keep the
blame.markIgnoredLines option as I for one will be switching it on.
