Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A851F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeH3AUq (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:20:46 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:42631 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3AUq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:20:46 -0400
Received: by mail-ed1-f45.google.com with SMTP id l5so2233032edw.9
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VS/4jsa5k7KsHr9DxXKWDzlOzOcTZuTMINtZ/g208tM=;
        b=FbaDxuzV+YMgjOWJ85DturthrFyYVOS5niwsgfRw1IG5N4QZQr5c57NJB2zvRf/xUe
         zfUew6/7mVWrq/fDvEFn/u/LEBQf70y6IjnqWOTB2S50BuXUhgXiTFJbnJv+ZeUUnExB
         kmGQXWm3DOTc3MSE2GmIyIMlLiZtsWcBI8LmA2n4PsB9fursKE+c1mtSZ7EmlY/tVdn5
         0KQUiAD24eWGqMHp5lKzWU3cVWqQcDocmJR/qcNNCngAFdNkKJCnk4tJpSfXKnpoLKTt
         fgoJ7ZJSBvyU64slKYTRaVXFq633y1YK7jWcz8PNwIVSiaoli5zmVGoUgO9hb56cHYCv
         ldjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VS/4jsa5k7KsHr9DxXKWDzlOzOcTZuTMINtZ/g208tM=;
        b=ODOrzok7FUzofGVNIcIIuFamiRisqXgnFJj6mpy6z/TManeGTK9RXwmDwNctMvbUAM
         wwIHrvrun6bxZyTIHidAt4PfdKLraNBNP81KJ0ILYMjv+xWTPVB2klRCjS3HnfRU5etu
         LgTbkBOuGAcN7+Wd5hecG3wZlWDyhTw1E/Lia8NBIVk+W+zJtEuk6UU4NPRetR9M5Uk0
         8kT7zZyD9UG2M5+CHwY83CTAGwICisZt1JeOcDG0ZWp9pRiwvS/o3lfTMBZ1L7YddLbh
         lWKnt7Fmp8n6HwmkUsoyyvurpOgRXVxyOTM6yEdJy43ZdTTxLSmcKZCmoab2j0gq3hUT
         YT3w==
X-Gm-Message-State: APzg51Dn9tM2ZjhIvON++PXlknJd4koxKebQ2bNS1gebeRrQ/tXcEHVH
        c60rElwEB9c8T33BeQPV7qph27q/4+zVcY7a/G5QWw==
X-Google-Smtp-Source: ANB0VdaqVTG5iyZZwXkOuUOCDbQ0/FPv75alIg81oKbpUxSsvl6djX9uxZA9g/J5NnyGH/rfVP2g5ga593aLQ6b4JuE=
X-Received: by 2002:a50:b0c1:: with SMTP id j59-v6mr9501250edd.267.1535573643851;
 Wed, 29 Aug 2018 13:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAE3VKEp3PJLCy3tL=K51nNzGry-HySb57QHemZzMtg3RkBmzUw@mail.gmail.com>
 <CAGZ79kakEYc954nQDThAZ0fSwbNp2-GGwthnevoQ4DxEUu4gZA@mail.gmail.com> <CAE3VKErGMSgB9gJAEnAuEDE51Yem6WUsg6fmOQELY1HCrALk_Q@mail.gmail.com>
In-Reply-To: <CAE3VKErGMSgB9gJAEnAuEDE51Yem6WUsg6fmOQELY1HCrALk_Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Aug 2018 13:13:52 -0700
Message-ID: <CAGZ79kZ1fcvBbJ9K+jw=wvCseSURSEKvnCDNFGsuZqcOfcZ7tQ@mail.gmail.com>
Subject: Re: Git Unrelated Histories
To:     me@tomaszubiri.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc the mailing list

> > >
> > > git merge development_feature_branch
> > > fatal: refusing to merge unrelated histories
> > >
> >
> > See the git merge man page for the
> >   --allow-unrelated-histories switch.
>
> I have tried that switch, however when merging a small feature branch,
> the merge tries to merge ALL of the differences between both branches,
> and they have diverged quite a long while ago.
> I am not getting the expected behaviour of just merging the changes
> from the feature branch.
>
> git-merge-base shows a common ancestor from 2 months ago,  btw.
>
