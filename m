Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019CB20248
	for <e@80x24.org>; Sun, 14 Apr 2019 10:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfDNKmU (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 06:42:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46898 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNKmU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 06:42:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so16030298qts.13
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iC4nb3GbzYiTfjHw7Wfi/VSWBzK/6U2ZpKHMhml3IA=;
        b=HpQ7mrUmDnkNhi+p3rO17KTTNkAskn9tDtfQsrRDlvXxqnvnTgv/xRsEHs9xzUYH7C
         /93sR1oE/FppBWC6tcsWVbW0vtIQVIRoFJiZ2aLHdBhFeyMADwPvPLmbEJ/f5QFs3+ew
         D1m7hKyropzLwWpHeF751gyDvKT8NNRsSuAaJPm3XmbIp3C/9XSnjXSg7CZXWAJJQkqo
         KPf6t0MAsxOWUmsrRmeq+Oh8o6b5LyQu+eBudZXUfOaHaw2wOXqk/GMJU9O529UgMEnc
         F6xyK25CdwHQFkNOsxC6179ZfMtEUO7xc0up5By9n50ULfcndG0fYfwpE5L7MmRCIC14
         ctWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iC4nb3GbzYiTfjHw7Wfi/VSWBzK/6U2ZpKHMhml3IA=;
        b=lPrx2IlyHJ0x6zo0pZ2FLbr7Cqn8IUmto8fP8Y1F2tNfe6Fw11199kJIy73S23vUps
         dnIV06k5E0i753WynfW+RUJKDsEI9n6TzyfaSoEddXfxA2LyHb6BDWI0TgGH1ml5wwma
         KkTEPot1anpobXwXLa5Xmy3oCrRY5oOQsmzxtQmunNgxjsZUKfD3OvZYEVWdsiImt30q
         p4xvOFU/ctnGfDKxJO/0Dyx30bClQRXDdj5pSZJfPSiBcbfwdkvo2aJqPSSKi6gFA5ge
         sPYU5yZrPGXfiDQ7q0bB8cM298ud2rue8WLRLLXfBPZ4QsS0oCO0NSPEnbo2Ftr+7zcA
         GL1w==
X-Gm-Message-State: APjAAAXxE0fg0cdTZEQs2jXTIpwUuGnRrRKJG2yIcxDcVk/yMQo8znad
        5eGSnzYRRTDTseFE4F3LZ2AVe/RSeqb7p/DcMdbbsNpvMAk=
X-Google-Smtp-Source: APXvYqwcswfPsfF+ysI1ZjdtiI5Dze98xERRJDp55BDbAvgAj9CE0q1ICYHXu/tNnsuTeJSoe/oyu+TzI2gFCtWjOqA=
X-Received: by 2002:ad4:42cb:: with SMTP id f11mr55743249qvr.53.1555238539738;
 Sun, 14 Apr 2019 03:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190410162409.117264-1-brho@google.com> <20190410162409.117264-4-brho@google.com>
 <878swhfzxb.fsf@evledraar.gmail.com>
In-Reply-To: <878swhfzxb.fsf@evledraar.gmail.com>
From:   Michael Platings <michael@platin.gs>
Date:   Sun, 14 Apr 2019 11:42:08 +0100
Message-ID: <CAJDYR9Q-ixsxWyMrm7aCojTv33SOj3+ALPwJYo9DJE7vLU=DEA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] blame: add the ability to ignore commits and their changes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Barret Rhoden <brho@google.com>,
        Git mailing list <git@vger.kernel.org>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +     the `blame.ignoreRevsFile` config option.  An empty file name, `""`, will
> > +     clear the list of revs from previously processed files.
>
> Maybe I haven't read this carefully enough but the use-case for this
> doesn't seem to be explained, you need this for the option, but the
> config file too? If I want to override fsck.skipList I do
> `fsck.skipList=/dev/zero`. Isn't that enough for this use-case without
> introducing config state-machine magic?

The difference between blame.ignoreRevsFile and fsck.skipList is that
ignoreRevsFile can be specified repeatedly. This is useful if you have
one file listing reformatting commits, another listing renaming
commits etc. Or maybe a checked-in list of commits to ignore, and a
personal list of commits to ignore. However sometimes you're going to
want to *not* ignore those commits, so you need a way to discard the
previously specified options. To accommodate all operating systems an
empty string seems the best way to do this.
