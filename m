Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD6DC433F5
	for <git@archiver.kernel.org>; Sun, 15 May 2022 16:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiEOQSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 May 2022 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiEOQR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 May 2022 12:17:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FCADF92
        for <git@vger.kernel.org>; Sun, 15 May 2022 09:17:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f10so337772pjs.3
        for <git@vger.kernel.org>; Sun, 15 May 2022 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4uT9YauBGtghILKi2pFNnRTU6C5kia7c+DPhX67K/00=;
        b=Ujw/Fe2yLu3VntfnVJoJdFMZsyAxWeZRdZofUO7jAcT15pl5FWS0iwpzbNqeVxnoPY
         4eAw+BmWUI+PLtkyfLSslGT0YBgKvrboLNbjMSeKdqd+5Vwdy2UTwxPxm3n+Svn/9vVS
         vFubm2uh2hiVjNxqD88iB28LW8FxrX98+wMkSlvFG3KNS90Y9DhTo7LdvEPpCiBfLXNK
         vwZa7gioF+dYFhZaWvI0CmRaKm0WYyh2402A0d3L1mw5QIbVknrwHs2EBl1ISPDRGgIX
         PN6nmQQkiuXKwYKcWhd0zSsYqop8oznnwJW4eBSS1CHq+EeqLIWPZiD7dU2MBU7tb2rX
         8JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4uT9YauBGtghILKi2pFNnRTU6C5kia7c+DPhX67K/00=;
        b=SjIRZkbJfoax6xOYL+8EM3Vx6nLxdkZEWodMGoqD5rGVyvwZskDDxvVJ+86E3H/VFU
         OQu+bPaG716SLUra++RNP/sZl5iHXT6P5FWFD9qXWvcUOZR8hMY59qM7pr5T3ayDrXy5
         Xq8pZy3zUDm83UV+PhfPxTGUP+FxAjGL3n6ct+xCRVtyfEqSlrks/Ly1j1R6AnCUBRga
         ydOMfEJlNhbWBmkDfJustUV6J4AwEUaCJAVnHWhP7A6p9LtWUf7XBLc9CjFkWlz1MsWY
         10LLz/Tj0nNYTL+M+bQeJteFgtlhJvwWI2RoHCH4Ei6EpHGgFLyc8sOYOI85xiTKJML0
         Ngaw==
X-Gm-Message-State: AOAM533myhLDkOJZLoDf7rZbkk8QPCC16wJBqqr4WfNKGG48evl/rTsy
        YaW0wTXta6PW/5SBTmD0tzg=
X-Google-Smtp-Source: ABdhPJy0jxt7A7qB4t2d+qfQSWxrSpGiqG9lIoQn+n/hDwtdk0BLCkPPBKW9vU/oe6w3RLjrotceIg==
X-Received: by 2002:a17:902:b703:b0:15e:ea16:2c6e with SMTP id d3-20020a170902b70300b0015eea162c6emr13757776pls.100.1652631475671;
        Sun, 15 May 2022 09:17:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:8cda:459c:1681:6fad])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b0015e8d4eb2e2sm5247468pls.300.2022.05.15.09.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 09:17:55 -0700 (PDT)
Date:   Sun, 15 May 2022 09:17:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Alice Merrick <amerrick@google.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
Subject: Re: Let's have a user experience workshop
Message-ID: <YoEnsb2UpDwdjDpd@google.com>
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
 <Ynndk0L6r9O7jLVU@google.com>
 <CAJoAoZ=t=BEfsfHBay1K7CY2MYEwcvPYKYxvgv_BvLL3SMcf_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJoAoZ=t=BEfsfHBay1K7CY2MYEwcvPYKYxvgv_BvLL3SMcf_A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(bcc-ing workshop attendees again)
Hi,

Emily Shaffer wrote:
> On Mon, May 9, 2022 at 8:35 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> 1. Continuing the conversation
>>
>> I and some others (e.g. David, cc-ed) ended the workshop wanting to
>> discuss a little more --- when deciding (1) what to work on and (2)
>> settling on a design for that work, what has worked well for us in the
>> past?  What didn't work?  What research methods have we tried?  What
>> would we like to try?  We mentioned wanting to continue that
>> discussion on-list, so trying that now. :)
[...]
> For all 4 of the above - I wonder whether it really makes sense to try
> and organize those things asynchronously. If I'm being honest, what
> I'd much prefer would be a monthly-or-so working group meeting with
> other folks interested in performing research, making recommendations,
> learning how to improve Git's UX, etc. I'd absolutely make time to
> attend such a thing, and I believe it would be the easiest way to
> organize research and concert our efforts. Would other folks be
> interested in showing up, too?

Interesting!  I'd also enjoy a meet-up, but e.g. for "3. Testing ideas
with users" I would find it worrisome if getting user input would
require reviews on a given patch stalling out until the next monthly
meeting.  (Reviews are already slower than they should be as it is!)
I don't know that that's what you meant to suggest; I'm just aiming to
understand what you mean about the "all 4" above.

> I'd envision it as something between a working group and a book club -
> we could learn different aspects of UX design and research, and apply
> them in various ways. It might be nice to have Alice along for at
> least the first couple of sessions to answer questions and help us
> learn in a bit more targeted direction than we got at the workshop.

Sounds nice to me.  If others turn out to be also interested, then
what would be the next step for making that happen?

Thanks,
Jonathan
