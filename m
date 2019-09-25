Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8526B1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 06:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442304AbfIYGdj (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 02:33:39 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37933 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392834AbfIYGdj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 02:33:39 -0400
Received: by mail-vk1-f195.google.com with SMTP id s72so369695vkh.5
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 23:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbYShBXsHGZF9h5a92Uqjom17Ualom2OftzbLx4FZ90=;
        b=OJcdMYgO3kHxd3LxQPvUdeEZbCE6lIgtb65KCJevEPh6x9omC63BoZOF67PCgREoD+
         S24MEoEEE8gsoTj8yaQVhhxSl1lQ9Xfw6CmF6o74SCPeYhfo/oSoKnkgAsYpX9BOHGLH
         G9YkKJLGrsauH2GNXjiKi1uI34/WnEYsqc2nhnsZfF3F6r28F6AMrZlgs8jmAYANmuSL
         gyazoM00CX/902mH0ce+8BDQAUiOp4ytwErygw7t1v36zTknBTcFDMGGz06rK8jBdGqm
         PQPmbJVVfmqtgH1AM1WCs2yw4WspWVJqB9P3Se25jRVY+FKdOq4cUmCw8w5i9SWVi/l7
         GGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbYShBXsHGZF9h5a92Uqjom17Ualom2OftzbLx4FZ90=;
        b=CypipRylNm2b/phSeoaddjiHZ24IkTMA15oX3e9iIPmYYhf3hBx2T868X55UvEqHiV
         p1oYPAsUZB+VoUYiHxRi3ADNs+K4XM6aUCcyjppqidVdgGlupfwRhcemY7zC4mJJFvha
         Pi65inzWQ3X8vR0ANrto92DxM3ibY4WPM+8/xRhVNZh+2srtIwyJtJVxsUHTYZMgcEc8
         JoXUkuRort+936AYnOT6JeFSmR/G+C/nnNhIBXp/d6phlhZh2j7g/HFOLbk0IReTYG5/
         6Hw3nMLtFVfib82Xgw02vv79nYfKbBkvtZVclIYLAkcbE7wshktTgNCF4B0qA1l57VSZ
         cq9Q==
X-Gm-Message-State: APjAAAUlnAxjJe3k+AXk5di41QRTxlbzgg602RiPNeyGdokF44jCVbql
        UA6XJQFrsZS60W0P4Wqlr4k58+CpapjqR4/uuP4F57iA
X-Google-Smtp-Source: APXvYqyuaHajDGm/K7PXwAA3zlKTukSlIlL7T7XrQGxU1y3HVBPcALSubmWyvuCH8DfcEW79WTmWOO3byu5iYG3DHFQ=
X-Received: by 2002:a1f:78c5:: with SMTP id t188mr1482736vkc.87.1569393217805;
 Tue, 24 Sep 2019 23:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <b2f412e2-d95f-0f73-5341-73c19ee2c6f7@iee.email> <7baf2b10-56fa-1cb4-0571-cb3c6be8feb3@iee.email>
In-Reply-To: <7baf2b10-56fa-1cb4-0571-cb3c6be8feb3@iee.email>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 25 Sep 2019 08:33:25 +0200
Message-ID: <CAKPyHN2sORn_ivC33DDsGe5L5UbNDBc5W6m=h85KUCmBCFCdvw@mail.gmail.com>
Subject: Re: git-gui: failure to distinguish 3-way common ancestors in hunk
 markers (#2340)
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush,

once again, I had done this years ago. I may post an updated patch in
the evening:

https://github.com/bertwesarg/git-gui/commit/90ee4a8c260132a6b730040095929fd267cedd7b

Bert

On Wed, Sep 25, 2019 at 12:05 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> Hi list,
> cc Pratyush,
>
> [resend without attached png file]
>
> While rebasing an old series, I had a 3-way merge fall back that didn't
> show the `||||||| merged common ancestors` very well in git-gui.
>
> That is, the conflict markers, and common ancestor lines, are treated as
> being part of the current HEAD hunk, rather than being separated.
>
> I opened a Git for Windows issue
> https://github.com/git-for-windows/git/issues/2340 which has the
> screenshot of the git-gui markers.
>
> I've not had any chance to look at the underlying code, but thought it
> worth reporting. I guess the issue has been there a while.
>
> Philip
>
>
>
