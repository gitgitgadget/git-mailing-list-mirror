Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2301F1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 20:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfIBUMi (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 16:12:38 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:40339 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfIBUMi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 16:12:38 -0400
Received: by mail-vs1-f41.google.com with SMTP id i128so9861622vsc.7
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxdQDlAlNsxt4j0ILxG8k5xxFQsQEe0z5vnpaS7RBmY=;
        b=F8W8YK1v2IOgfEw+ymAW8hWdE/JEHUd5+4bK5E5fLzJuSl1LJjZk+8NuQ39nNiK+F7
         kxh7HUIgoEWGgS0BCt/wjZThEkVVppwHrbXAohe+JS7z6eWy+XiwwiwNasieho0krRPZ
         8V6E1JM+3797WxXvVneRBREuAyL53y/Vm8npyTr0+pACPVqrHEz1ckRhPdQLSW1DHe4V
         MYGuDFbw6OdVCYOhiV3uKabfe81RY7KubjsU4RvtAoTX4uxnAfVpdDEcUL6p6y2Uol47
         xgOsG0uB2lCW6zNAKD0u5SNUV9Sc9VysmhxHL+HZ2VqI1aL3TNaO+xl85m4WBsnY1piL
         5pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxdQDlAlNsxt4j0ILxG8k5xxFQsQEe0z5vnpaS7RBmY=;
        b=tW7GOTAsaDQlfFFej7mn5FiC5+eeIiP1u9dYVqKcUrz6HGwM9LKxZY5+u3dhRqoYpW
         A4j1Yc2qZ8K26x4yRFySW5pDFW+DGdxfUp2bkcYaiD2RAPMz0HNBVA1LwPs7B8U7MWDs
         I9lr4X5eK0PwshKnXZ8cU38BTs6cH7+vJcW7zQUCbjTfEMPA4AfxXPunZIGuJZ2Li4/u
         atQdkVdZRSwCeCSlOHe2kTsC3QGkgfsT2CajiIa4WNU7T4sd4QjH7Fg9vZiOu7Y0Ef5/
         //NCT8CkeONiCGbDobWQ5cmmwWNNLUJ5+SGHNSzvU1WATiHE0VYzScs4jxf71Zcaxqzh
         OrDQ==
X-Gm-Message-State: APjAAAWDcdXNuhvTNJKVGoNUlLJMMT1jSLKCN4bLet60NLbmnYcKOMyt
        8Ssv3JZeeLZi+j1rZozhrcW1RgzbxVB7hWSFdJjnPilR
X-Google-Smtp-Source: APXvYqx81cMRbVx769OWRw7oRxUHZo/up8zJ6kQI+S8qSdTogm55/banQRINUDry+lZu6QOy0LBfnCfowGxodgdn3vQ=
X-Received: by 2002:a67:2241:: with SMTP id i62mr9035325vsi.85.1567455157105;
 Mon, 02 Sep 2019 13:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com> <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
In-Reply-To: <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 2 Sep 2019 22:12:25 +0200
Message-ID: <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 2, 2019 at 9:49 PM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> Hi Bert,
>
>
> On Mon, Sep 2, 2019 at 8:08 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > I think with your "focus" patch, this is not needed anymore:
> >
> > After focusing the commit message widget, you can focus the radio
> > buttons with Tab/Shift+Tab and press Space.
> >
> > I think this is short enough, so that wasting a Letter is not justified here.
>
> Pressing the Tab key while the commit message widget is focused
> inserts a tab in the commit message.
> (Again, I'm on Windows so you might get different behaviour on Linux)
>
> If the Tab key acted like you suggested, I agree it would not be
> necessary with this a hotkey like this.

can we try to figure this out, before going forward with anything else?

Thanks.

Bert

>
>
> Best regards,
> Birger
