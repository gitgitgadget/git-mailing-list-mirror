Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E760BC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 05:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DCB606A5
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 05:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhHRFQK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 18 Aug 2021 01:16:10 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44578 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhHRFQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 01:16:09 -0400
Received: by mail-ed1-f42.google.com with SMTP id i22so1133317edq.11
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 22:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yG55uS/VxKRpavM2mJ0MvZqf6VjNXJiAeXkIUudgV6w=;
        b=t3gxL9gGI29agrHJ/yeud7+8WcPlaMlpiM8f5FO6+BkYXItRBOIoHq4+udnPorIxY+
         AA2y3wIcZjGMtW22+yKuPVjsy8p/z8kYvmjWvi88EFOchtoXjxRxjnzT90Mk0koIwKk6
         LlhxRAgPqy38RNYZ6iigaB7dIGE1HI0KaVxTghQR76m3ElZyPYV44adZz0//zCYgRowr
         qg8IzBSZfx1PuHK2Oe7lAZQO3RY3O4S+TQjqVovjspL5Ey0kvIp4fznMNqGCm/Il3EGf
         FkEh9F5avKBVg/O8oZC39kiKWsUgB9yfjN8FoumlsieFXfC9QITBnB7v3q8MKxNBww+H
         ReeQ==
X-Gm-Message-State: AOAM531J2fwWgmjSyyPlujJiDHlssA9908qPK2U5nwC3u1U9H545ssuj
        GCb+hDMmHhGigvl/eOH6pQGtv5NOk8m8i7blsC8=
X-Google-Smtp-Source: ABdhPJxaqemTe+aCEfaekvpAsWVDhsQHWEXCfwSZOFF7Z8TfzYR0OhBItGkSLDJCtq1gqwFrzkcMRVvIQlOGuJQIxCI=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr7965157eds.233.1629263734821;
 Tue, 17 Aug 2021 22:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv945ng61.fsf@gitster.g> <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com>
 <xmqqh7fonhlo.fsf@gitster.g> <7a4b1238-5c3b-4c08-0e9d-511f857f9c38@gmail.com>
In-Reply-To: <7a4b1238-5c3b-4c08-0e9d-511f857f9c38@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Aug 2021 01:15:23 -0400
Message-ID: <CAPig+cR0tkz+whu35oNVyPqvMKoi8mOOriF93DuvyzE+LvFvLw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 1:13 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 8/17/2021 12:47 PM, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >>> * lh/systemd-timers (2021-07-02) 3 commits
> >>>   Waiting for reviews.
> >>
> >> I'd really like to see this merged, there was some discussion a couple
> >> of weeks ago (cf <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>), it
> >> petered out but no one seemed to be objecting to merging it.
> >
> > Thanks for paying attention to this item.
> >
> > My impression was that everybody likes the ability to use systemd
> > timers as an alternative to cron, but as Derrick summarised in the
> > message you pointed at, I think the implementation is not quite
> > there.
> >
> > So "Waiting for reviews" is a mislabel; we are waiting for a reroll.
>
> I think a lot of our comments were "We would hold an established
> contributor to a higher standard, but this is sufficient for a new
> contributor. The rest can be forward-fixed." We also have not heard
> from the original contributor since that discussion.

Yes, this summarizes the situation well. I gave v6 a thorough
readthrough and although I found a single minor test-time bug -- which
Lénaïc addressed in v7 -- there were no show-stoppers at all. Although
there may be a few warts in v7 (such as non-ASCII comment blocks) they
are minor and can be addressed by follow-on patches (from anyone who
steps up, not necessarily Lénaïc who, as a relative newcomer, has
patiently re-rolled repeatedly).

> Perhaps enough time has passed that we can expect Lénaïc will not
> get back to us, I could give an attempt to forward-fix the comments
> with a patch series on top of these. We could then hold
> lh/systemd-timers in 'next' (or even 'seen') until it can be joined
> with those fixes.
>
> If preferred, I could restart the series by inserting some patches
> and editing some of the ones in the list currently.

That would be nice. It would be good to see this series land.
