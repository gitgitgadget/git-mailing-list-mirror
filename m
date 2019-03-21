Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928F220248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfCUNqO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:46:14 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43605 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUNqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:46:14 -0400
Received: by mail-ua1-f66.google.com with SMTP id g1so1910598uae.10
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkKsE1kFn8u6mIAqpUBbeQcdXIAKiQqjhWVlDUwjaw8=;
        b=XRlmTm8aJKLTVk8dnBFgsqLPD1PH9JBUJYINZrZ8XBVCtiOjE0mqtGc4uCIaQ6zusC
         ZyRt2pjD5VqRjazS0zSr8w8gq1WFkufhMj2wnXjOq48Zux4snTkstyHw1xHECzifASvw
         yQWy1VDepA/8d4QKObU3X/lGDIH0R9uEFFTJwD7HQjfr7JUFg1ymABUE0jGddCVu5fsH
         pgzZFD4/YWq7VVn8+3mml90QUnWUGsyTXS1WZ6CvukFQudnDT963NOn754VCTL9N1o+G
         KBElL6z9leHv+zR+fvD6pErfWZswWecr+QgMDyt2m2vJvr/3DNBs1cvD75OfpKo2lsIG
         v8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkKsE1kFn8u6mIAqpUBbeQcdXIAKiQqjhWVlDUwjaw8=;
        b=s0Oi2UOGse9DB4hPeBNfsAWBTCDaMWqByrXKy7LQfy4ZlcnJKmGVpr4gONw3GIMJNr
         AqcI1YMKl6Y1kidXFBpzTjF9+yRiVreDPE7tfjwZOnohMKCvitWbESeUxhf1KLMg0y2X
         bPn19Z1yKep5+/oIXUNu++9HCOE9n2sT9Fdl69AXgTR9WWjoo+9nh/+/Kj7/OmGFLXVI
         e0W0HSwXntkwStfkw/xaZ60KGIuz+k5BuI8+ox8Zj9a/bBHMAVqmnEua5seCbBsr4CrW
         IUZgVFACNNRZNJOtR7FlzBIngdDZir+Hu19SZnDtD+LijvoWwhUO1rvTMtbjRuR6oLnQ
         treA==
X-Gm-Message-State: APjAAAWtFJBGmj3q9F60BCMZMOjvbX5PSveXu5toj1TpVxqHK002uxFJ
        1pLEtcV6VpQ/QFc1MWDXdSvdn9RwKdSLlspZKSo=
X-Google-Smtp-Source: APXvYqwawv8g//2mOcxBgKPcVcOh74AZw7B5W23+DbV7CYwWY+gBMQwHL6JyR6egWrd4z8zlaGLvi8h2u3diTH1Dnxg=
X-Received: by 2002:ab0:7817:: with SMTP id x23mr1705159uaq.35.1553175972719;
 Thu, 21 Mar 2019 06:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
 <20190319093910.20229-1-pclouds@gmail.com> <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BLxWea0ZrHkSU6+nE7dr5YvFNVH1tLhaqPRadi+2Hhwg@mail.gmail.com>
 <xmqqk1guwdeu.fsf@gitster-ct.c.googlers.com> <CACsJy8AUH4nOkt6H=yu=eRktK4me9kEkjqsC3zyNZDwUKXqCPg@mail.gmail.com>
 <xmqqftriwbz6.fsf@gitster-ct.c.googlers.com> <CABPp-BFB0jafua0CGEsr66EzQvHncLYvws8rt+LdkQ_LXcEq5A@mail.gmail.com>
 <CACsJy8BdPgPgaWW=3_y5peLdqo24-ozC=s90WW2DN9OsYe9v_w@mail.gmail.com>
In-Reply-To: <CACsJy8BdPgPgaWW=3_y5peLdqo24-ozC=s90WW2DN9OsYe9v_w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Mar 2019 06:46:01 -0700
Message-ID: <CABPp-BHsQqi1umpsr1LREzwea15zqn4pp4WjKsTx3APf-4rT5Q@mail.gmail.com>
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with --merge
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 7:58 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Mar 20, 2019 at 8:53 PM Elijah Newren <newren@gmail.com> wrote:
> > So, I think we do need something (eventually at least).  Would you
> > prefer we dropped this patch from Duy and instead made 'checkout -m'
> > abort when the index is dirty?
>
> I have no problem with this. Still scratching my head wondering if
> t7201-co.sh has a slightly incorrect setup, or aborting is actually
> wrong. You're probably a better person to understand that test case
> ;-)

It doesn't surprise me at all that some testcases would fail with this
change; it's a change of behavior from the previous implementation.
However, taking a look at that testcase, it looks like it's not a
simple change to make it do something similar because there's at least
one other bug that we need to fix first.  I'll dig in...though I
really want to get my
directory-rename-detection-defaults-to-reporting-conflict series
updated and sent out first.  Since Junio seems to be okay with just
taking your doc update for now, hopefully that's not a problem.  :-)
