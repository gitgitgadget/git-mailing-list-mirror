Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34951F597
	for <e@80x24.org>; Mon, 23 Jul 2018 20:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbeGWVGf (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 17:06:35 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:46315 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387941AbeGWVGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 17:06:35 -0400
Received: by mail-yb0-f195.google.com with SMTP id c3-v6so741717ybi.13
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 13:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5T802YQLyBiadVGK8P3AECW49cYlMbM4f944yzwzUak=;
        b=Xa/8sSe/yKBnFPHauldofrC5+R4mjDtFr2p+Y9U5ADZDI1LJ97mPsDrUz03Ix0/iDm
         32XnG4p5cD0cSrGh1fUgksOhpGFC7iSKKj2JEHYyD9QjPk6+nlSnDK+HjzCf1mdGrWxS
         3bS38PuozFbTeAVXK5NhpWIJszDhsaJ9//auuosHCvelOe7DvNtf/s9QfBtAxmUqq4Zg
         n44SYODgKkK+OUQROQpM/1wX6qzTNpCYAbJ9gHq+w3D9YhJh9aqw8bdZeCpXA5YF7+kp
         C/bYK0YY+2/9SNnGjsqPYgBZ2YQzng9UJ7IcyHFpPdHoih9FsDq4B8pIsrLPZVbDGbXP
         Oxmw==
X-Gm-Message-State: AOUpUlGrczx7d7YOlH/RYmy8kQaeWpb23ciLLX/L9/poQCFc/fvixYJl
        LwQ66mU3WP0S3JGIFmT80aT8VftbvQmgQ5/AOiY=
X-Google-Smtp-Source: AAOMgpd4fbd8G6jDAR4kovOGODDYeNu+50CZbUcFsYjtyW+OSQwyZdo/FzpN7C8eoTogAUoTHh6m9W1O3+frJ4YhN7c=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr7803398ybp.76.1532376227463;
 Mon, 23 Jul 2018 13:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com> <CACsJy8BgAMYykkNOJc5NgMj-X6SMyskU3iCzTKnL0CLRTdF2oA@mail.gmail.com>
In-Reply-To: <CACsJy8BgAMYykkNOJc5NgMj-X6SMyskU3iCzTKnL0CLRTdF2oA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Jul 2018 16:03:36 -0400
Message-ID: <CAPig+cTwZ2HCFgJmZR968uccsxfGndWKhOBPDrHsPhBRhLiogA@mail.gmail.com>
Subject: Re: [PATCH 00/14] format-patch: add --interdiff and --range-diff options
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 12:32 PM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 22, 2018 at 11:57 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > When re-submitting a patch series, it is often helpful (for reviewers)
> > to include an interdiff or range-diff against the previous version.
> > Doing so requires manually running git-diff or git-range-diff and
> > copy/pasting the result into the cover letter of the new version.
> >
> > This series automates the process by introducing git-format-patch
> > options --interdiff and --range-diff which insert such a diff into the
> > cover-letter or into the commentary section of the lone patch of a
> > 1-patch series. In the latter case, the interdiff or range-diff is
> > indented to avoid confusing git-am and human readers.
>
> I gave up after 10/14. But what I've seen is nice (yes I have a couple
> comments here and there but you probably won't need to update
> anything).

Thanks for the review comments.
