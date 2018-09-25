Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFF11F453
	for <e@80x24.org>; Tue, 25 Sep 2018 15:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeIYWGa (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 18:06:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52341 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbeIYWGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 18:06:30 -0400
Received: by mail-it1-f196.google.com with SMTP id h3-v6so16085977ita.2
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hMVxzssV4rp3LZrfen+wl5A0lppvdCKYa7/9nS2yw4=;
        b=WQG5TemYXa8wid6xFAWOWVyt/tBo/zldV4XAR9W+8ZTKTPnaZLvmZ9aHVIpcZ8CbeG
         r3X+iwL8FZKGgBzrOxYXVRzW84ra31oafGf5HZ5JezoxaDEDXVxQscAYeWaNna3B5hpu
         8gMCwtKmvoaKaHDTzKbTk1zR7c0hPcR+NurEzBLd/E+E9EFzmCUG5g5dOuca5Z5O+JT+
         mx6MTFmCg12w/pppp7Y50kB6aqoG0rm1yuZrx5QQVcjwGon9flMe3jx317GSFDqTCweY
         pwlh5t5qdauwQ7NvzIPMUPePYMkVDdN6dOpgPJt/FRI0MG38pesCnZN7jUQS1kYEC8jw
         xPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hMVxzssV4rp3LZrfen+wl5A0lppvdCKYa7/9nS2yw4=;
        b=QSXE4o1UJisYRdh8lL9H53hODm6m/knl7SK1uoiP+OkBjreEa0wupFIKkfAQnagWcC
         z+p7Kuat+opRgIM/7Sm8z4WQxrt09LwyYSMTUzSYkBmnOkJtmrTH6h58Edku6RjgEQBv
         CAnpjrlk7nStwj/kcV1DuPm9liv/InTX0WwC45nvq2ybdKk9ooa1R8avqcxhpztAApRR
         DzUT3sBzeCJSPWn/pmDKi35TAOefg3OGZ+v54Tq4kIdyo2Np9402mNwIi1cX80qj9d9H
         BEVcYzN60rDBjOZxRQ3YRZXVliMpVDQYcMZsm4rjTxByaIcNIJVZzyHOIHgKTjMO3fMV
         mlFg==
X-Gm-Message-State: ABuFfojXxUn880gyx79K5qCKEMG74JJsRwp/jdetbKKz1g/ldk03qry3
        WCG5BWnoRm16qZXDh34VlFgZ48bYVE161AYu1KAnYA==
X-Google-Smtp-Source: ACcGV63ad7KNQIhzcZRC2YXHh5L+ojpjDzG3iRo8Y5GTX57qab/J+/zxpiqyRdKdVTzufvZ74uV9RFFi7dFR2L5GW9g=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr1351271ita.5.1537891101665;
 Tue, 25 Sep 2018 08:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <20180924142143.GD68796@syl>
In-Reply-To: <20180924142143.GD68796@syl>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 17:57:55 +0200
Message-ID: <CACsJy8BFydQorJveGirFG4v3KLsF9bd3fALddJVU62BTF9UR2Q@mail.gmail.com>
Subject: Re: [PATCH] worktree: add per-worktree config files
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 4:21 PM Taylor Blau <me@ttaylorr.com> wrote:
> > +cmp_config() {
> > +     if [ "$1" = "-C" ]; then
> > +             shift &&
> > +             GD="-C $1" &&
> > +             shift
> > +     else
> > +             GD=
> > +     fi &&
> > +     echo "$1" >expected &&
> > +     shift &&
> > +     git $GD config "$@" >actual &&
> > +     test_cmp expected actual
> > +}
>
> This cmp_config seems generally useful, perhaps beyond t2029. What do
> you think about putting it in t/test-lib-functions.sh instead?

Good point. t1300 (and I think some t13xx) does the same. Other tests also do

    test "$(git config...)" = blah

which can also use this function to have better error reporting when
things go wrong.
-- 
Duy
