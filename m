Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E6920A40
	for <e@80x24.org>; Tue, 21 Nov 2017 13:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdKUNlV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 08:41:21 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:40049 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdKUNlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 08:41:19 -0500
Received: by mail-io0-f175.google.com with SMTP id d123so3388056iog.7
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 05:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3G1KAVXUpt8iMOcUQ0yR7uhD9MV9SoqfZ7EjgjuaTe8=;
        b=QK9rRprqFtlA4vWI0Dqb8TzVqYX+E3mV5nKwcQOKVGiT/jb+5+lxmMQ5Toe2yqwl9O
         3IhGb3NemD8V8I5q27FxY7DF4nAaAM813lUph/FRFqGbJ0+vc6hTKv9FbLCw/jTljb/C
         M0pMukztrChvLmJbskGZ8VO2kvCALoUcvcCHyliM4MQzu2BAo9N3TxC7wavAhCXrR6lm
         GlZjjGMcBI04ZznIXo+B7/g79+1faEKINhAQJhjCahkYf/uLZLmG79/OuXVZFt77umou
         rhsN8awWocT1eYiRFhFIaimg/sBzX1thaE7s57j594rnZ+UNvzfyIzLtY+NUbkBpb+ym
         ffyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3G1KAVXUpt8iMOcUQ0yR7uhD9MV9SoqfZ7EjgjuaTe8=;
        b=F8zl+vBkor4bnUAqMuBoXv4QOdNeY9TtM4pDyoQAMYh7VCewiczT4ilZ42/6kG1BPI
         WMEa7iLk/lAYLoOYJAENQ7415GtWulm0+MKjzU+0MckANq+0jDsmf3ra3bsq1l2tNDsl
         osU/ckXHa1pQ8bBhZ0EDHrMpo55DnBGy4EAXKcgZRXEZsIPq0Ua+YTa5yutWiuRFZ4Nh
         5u++gLo5aEeXoPPNqTjBVjksgFtq74Xl+1SUsRsmwewf5b0JN+/Co+xyxv2kIWl/ueHM
         V7OVOKiHuCSWYH2Y1TQgrPZMdevFdy994p6ljp//W3UwN/mqXoeYh8ZJQ6PnrB7NibBH
         zFTg==
X-Gm-Message-State: AJaThX5lQsu6xbR2U2V9gvIMfmARt/ld+FeFvpZkQ8DKtCNUVUn3bz1b
        LW0jXM+W4w8oz5DpSSd9U2O5z1q/guCsHHe2JDI=
X-Google-Smtp-Source: AGs4zMa9cfgfqsO3N/mWCd7K4HNkpjBprrpCWWbpzTGTDVChQsvCgYi1+T44aQg3rMICUsBKNVa+C0vRJQ8NFQmM3Rw=
X-Received: by 10.107.47.234 with SMTP id v103mr9729882iov.96.1511271678875;
 Tue, 21 Nov 2017 05:41:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Tue, 21 Nov 2017 05:41:18 -0800 (PST)
In-Reply-To: <xmqqvai3zsge.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD0ggpUGGoOEjAt3sB9=ek+Av+6GemiyqZ4kTCHLC9dWoA@mail.gmail.com>
 <CAJYFCiOj1DwgMMrFRxV315CB7xuvXMFRbRAkbx6s14oPm3ui1Q@mail.gmail.com>
 <20171121011017.e2aac53zfo2n2whc@aiede.mtv.corp.google.com>
 <CAP8UFD0dN2V5GVokvMD-XLDEhPVJrE=m3h8oM5VC_Lq6x3=9=A@mail.gmail.com> <xmqqvai3zsge.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Nov 2017 14:41:18 +0100
Message-ID: <CAP8UFD3QdwnN3Mrc5Xx3C0ROxhm6eS9OFuiVxFTUSrXYknTOWA@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 33
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Yubin Ruan <ablacktshirt@gmail.com>, git <git@vger.kernel.org>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Ross Kabus <rkabus@aerotech.com>,
        Henry Kleynhans <hkleynhans@bloomberg.net>,
        Charles Bailey <charles@hashpling.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Tue, Nov 21, 2017 at 2:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>>
>>> That said, I believe that the gitattributes(5) manpage does an okay
>>> job of covering this and that that thread came to a clear conclusion:
>>>
>>>   https://public-inbox.org/git/20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com/
>>>
>>> I commented at [1] that I found the conclusion of the rev news entry
>>> misleading and confusing but it doesn't appear that there is anything
>>> I can do about that.
>>
>> Well, you could have provided a pull request or otherwise suggested
>> what you think would be a better conclusion for the article and why.
>
> I just re-read the sub-thread Jonathan pointed at, and to me it does
> look like the original request was adequately addressed and talk has
> concluded at around that article.
>
> I somehow was hoping that Jonathan's citing the above URL is a
> suggestion enough for the editors, especially given that the
> announcement for the draft invites a reply to this thread.

DId you also read https://github.com/git/git.github.io/issues/262?

I think I have tried to properly answer Jonathan's feedback there too.
Especially I wrote a pull request with a different conclusion
(https://github.com/git/git.github.io/pull/265) and asked Jonathan if
that was better, but so far got no answer.

>> Perhaps nothing was missed, but as the issue is complex, it is just
>> difficult to explain and summarize it in a good way.
>
> Perhaps you want to take a bit more time between a draft to the
> final publication?  I've often wondered if the time between a draft
> announcement and the release is too short for those who understand
> the discussions on the list well enough to give useful input to help
> editors regurgitate the issues to arrive at a clear summary article.

If it would take a really long time for "those who understand the
discussions on the list well enough to give useful input", can you
imagine how long it would take to write articles in the first place?

I try to write the articles in less than 2 days, so I think 2 days
should also be enough for people to provide useful input on the
articles.
Also I have tried at times to give one more day for people to provide
feedback (or more content) following you suggestion. But when I did
that, I have seen no change in the amount of feedback (or content)
provided.
