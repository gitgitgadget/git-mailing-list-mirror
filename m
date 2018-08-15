Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E70B1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeHPAiI (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:38:08 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:46527 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeHPAiI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:38:08 -0400
Received: by mail-io0-f179.google.com with SMTP id x5-v6so2199518iop.13
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B8v2JwJHO2vihg2ZLdbjuSexrX6T7vK8AX6J/3amGFc=;
        b=O8g7YKlTSYi0aJIFyh/bxixtmpV87lMqT8EStenUma1ygT7FaKX32ooyO1gCgySNjp
         p+jotkOXUKwfCOiRvLvQTlxUvE45wvKSYadWDcH5LfZ+YFcgAo7OnSOmJ+vLxcSLrdGE
         cVcUbFDarzrtnHuTABQUIxcwpp9mIOmquZe8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B8v2JwJHO2vihg2ZLdbjuSexrX6T7vK8AX6J/3amGFc=;
        b=KsS+gnNjQb92Fz9J77tVlENRS2nvn+xDaRQzyKSDwB2i0ZRE0Lg/kpvcumRMp9Zrvh
         qSbgRf58tWb6Bxf4EOAxKaKkt/oRFQglotKIACnK+vH642roCXVd3HH0brMvnME3qJ4c
         1/NxSffk6OoPbbmfa93t3IdYGoGsFU906nLCNSHueKfQRIN6Iw2K8V2aoXiK2EfCongm
         oJ7l+QlwIixYKrUnsoueMzuqd1ghhEapwRlCYVRWdUJ6hnJX4xrKfWpD9o+tScr9BOMi
         4t5mbG9H8ULVorTGVD/PWuwaQub/ioDtmpKJfSzCTKyLch3O0HXAZJvnX+vxjkDzMtYL
         dzlg==
X-Gm-Message-State: AOUpUlE+BZ7o9A/4zPCkQCRodlt+bZ9EocI6endSZem9AX48DOwO6ozQ
        MMzYYnl3HGJE6+yyED3QDa5GH51JXaRx+fJlWM8=
X-Google-Smtp-Source: AA+uWPwsvW+SBKNTciGdlXakXlN2iOlcX6d+p6lnOWku8QlBKaQrNdgsNtjiR5RLvEFcYFpyWwrDBd9+6jQNk9Ok7g8=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr6971078ioh.259.1534369449373;
 Wed, 15 Aug 2018 14:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
 <87k1orqpxj.fsf@evledraar.gmail.com>
In-Reply-To: <87k1orqpxj.fsf@evledraar.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 14:43:57 -0700
Message-ID: <CA+55aFzC79rRMgTdxGJV0g_ABW28OBGR=y4owp1OWMLWree0Ng@mail.gmail.com>
Subject: Re: "less -F" is broken
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, bug-less@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 2:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> FWIW they're not linked from
> http://www.greenwoodsoftware.com/less/download.html but you can just URL
> hack and see releases http://www.greenwoodsoftware.com/less/ and change
> links like http://www.greenwoodsoftware.com/less/less-530.tar.gz to
> http://www.greenwoodsoftware.com/less/less-520.tar.gz

I should have just tried that. I just downloaded the ones linked to,
made a git archive of the history, and started bisecting. Which was
all pointless extra work, since it was in the last release, but
whatever.

> > I've reported it as a bug in less, but I'm not sure what the reaction
> > will be, the less releases seem to be very random.
>
> Via bug-less@gnu.org?

Heh. Another thing I didn't actually find. No, I just emailed Mark
Nudelman directly, because that's what the FAQ says to do:

 "There is a list of known bugs here. If you find a bug that is not in
the list, please send email to the author. Describe the bug in as much
detail as possible, and I'll do what I can to help resolve the
problem."

and it doesn't mention any mailing list.

> Is this report available online somewhere?

It was not all that different from the email to the git list - just
giving the trivial test-case and my (limited) bisection result.

The data you dug up is much more useful.

            Linus
