Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74878C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 17:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBER7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 12:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBER7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 12:59:16 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A74415CA3
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 09:59:15 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id bx22so6715162pjb.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 09:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfpHkE4NdRXsOCofA5aPe1c88CZUqqgh0D7/L01vqQ0=;
        b=CBh2xOcWhX4DrsamIaiglaAGe2KN2SGOWYMeOxh95EzoJ17I5UpxEO3IQszmNuY0Gf
         VNzgNo+/gGfpV/cGZfoNaf+nBslSAbvrjGDt47bhcS2NnOqmV3wkHYBbLE8KRFDe1Vm8
         nk6OpnQdh/hXjJ+PPxfNZQTJlqOLl17D2AgMa11B8v+IKEoyL9sNW9hNb4oWbC2ei/1S
         XYxdSzaJUlQTs9x/dTzaUJ+T9owQAndvLQujR9CI1wlmA9X+SIu/CgW506kNaBxWYjNF
         iaSZ9Uv76YFaOGmObuYht/h6vIItEWnRPn2QrW0Xwgvmk3xAe+sQRWYB2ZDX90VfBel7
         SLxQ==
X-Gm-Message-State: AO0yUKWOJVWS4wqAgp10q+jQl3uX9aLHrAcVfucU9GVdOg0lQg8Yd6dM
        p3sdtNoi9piSEbvszmw979AyKy/gjK+G9490WrE=
X-Google-Smtp-Source: AK7set/S+h2pnGSwJOXt7/VXDsgFcVz0KkffmnWQXsDY05kHFbywJSc2vi4kIITd60Ak/FaCZzyO+DhABDKARRAwwtw=
X-Received: by 2002:a17:903:243:b0:196:4e61:b6b5 with SMTP id
 j3-20020a170903024300b001964e61b6b5mr4468013plh.2.1675619954587; Sun, 05 Feb
 2023 09:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20230202202557.19297-1-kostya.farber@gmail.com>
 <xmqqa61vsniy.fsf@gitster.g> <CAPig+cTC4TUK2NXFmP6ymEYYjYAmCSd53dzFhKn0ido8x6uh1Q@mail.gmail.com>
 <CAPig+cR+1bxgitSmJ47PxD=CPxJjMh5Vm+zRdVU8iEo9pvtutw@mail.gmail.com> <CAPRQfCZUwaE4mko46n0wQbkKjpg4Tqxbg6eKLm9rFrBRj6sVLg@mail.gmail.com>
In-Reply-To: <CAPRQfCZUwaE4mko46n0wQbkKjpg4Tqxbg6eKLm9rFrBRj6sVLg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Feb 2023 12:59:03 -0500
Message-ID: <CAPig+cT-3GuGg91WDeMC__iQ7db0-1-q7-4z5jBFb19GC3E9mQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/t5000-tar-tree: add helper function
To:     Kostya Farber <kostya.farber@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2023 at 10:17 AM Kostya Farber <kostya.farber@gmail.com> wrote:
> On Thu, Feb 2, 2023 at 11:19 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Thu, Feb 2, 2023 at 6:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > So, t5000 seems to be one of those relatively rare cases in which the
> > > raw "test" command is more correct than the higher-level helper
> > > functions.
> >
> > By the way, although the change made by this patch is probably
> > undesirable, if you would like to try a different submission, there is
> > a bit of modernization that could be applied to t5000. [...]
>
> I would be happy to help and submit another patch for this test based
> on your observations above. Thanks for the suggestion. I am trying to
> get used to the development workflow of emailing patches and generally
> getting familiar with the code base and this seems like a small but
> important step in the right direction.

The goal of the microproject isn't so much to get a change accepted
into the project, but rather to get experience with the workflow and
review process. Responding to reviewer comments, as you did, is part
of that process, so you're doing fine.
