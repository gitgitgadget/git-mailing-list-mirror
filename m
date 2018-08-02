Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF49D1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 08:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeHBKAB (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 06:00:01 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43391 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeHBKAB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 06:00:01 -0400
Received: by mail-yb0-f196.google.com with SMTP id y3-v6so495291ybo.10
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 01:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D6eC1ZIdLjEeZONOPNoxNy98SmnQIkv28L60mUvZbbI=;
        b=PYokraMuT4l0eJ0p8JpqCs1IPWvvrajbcWf+mSJD8Q8yLhBz9IaI5N/QMbjK2CHHg9
         UKdhAkllT51BSaAlIGP3Arlv+r5vxG9XG/WqL7Hc7hi2ZGVUCLpDGJpkK/OFwyb7O0Qt
         XfKe/7cL9bI6YORRRfJn0y6h6LlhbKLgZ7upnZfI+NoTgKVbyJmcI1f3xzcu53aQUAF8
         qypwLHYoNW8LDwKMB/9Vlp6rwDdrVxs+uy5M6nH+zPONQDY4EBL3fgvum3QJdus7CjFL
         YA+4q/Ckm9coJ4ukdf7ZmgLSaNFwpxN53xw2OKDPVk6Wk1VX4ZsgHQ/LgC5jUevObhqm
         G6yQ==
X-Gm-Message-State: AOUpUlHdJMWqvoMF1QE2foQfokQqCyIcAZtilc2qonhg7lRK5fhylSHN
        q3yVDcriAdh7sAbWz+F6uUbd/Bfwbl7xDAgaOr4=
X-Google-Smtp-Source: AAOMgpfRvWDR64/PWHRT+EfHF3RYhpk4HeP0rsoqtUlmtulVDBUcwZyFm+qxvlhqYcCOCsQFtVgbNJm4vaLUyuju7DQ=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr824004ybl.12.1533197401747;
 Thu, 02 Aug 2018 01:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com> <20180801232517.GB106068@genre.crustytoothpaste.net>
In-Reply-To: <20180801232517.GB106068@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Aug 2018 04:09:51 -0400
Message-ID: <CAPig+cSZa2a0raGr6z7WOi24gg4m=sc7k19=t2AYzPbeYNVfjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 7:25 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, Jul 31, 2018 at 03:33:27AM -0400, Eric Sunshine wrote:
> > This is a re-roll of [1] which fixes sequencer bugs resulting in commit
> > object corruption when "rebase -i --root" swaps in a new commit as root.
> > Unfortunately, those bugs made it into v2.18.0 and have already
> > corrupted at least one repository (a local project of mine). Patches 3/4
> > and 4/4 are new.
>
> I looked at this series and it seems sane and logical to me.  Thanks for
> acting quickly to fix the corruption.
>
> Reviewed-by: brian m. carlson <sandals@crustytoothpaste.net>

Thanks for the review.
