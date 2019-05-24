Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA791F462
	for <e@80x24.org>; Fri, 24 May 2019 09:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbfEXJlU (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:41:20 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:36464 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389881AbfEXJlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:41:20 -0400
Received: by mail-it1-f173.google.com with SMTP id e184so12894608ite.1
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quROh7HKwQPZgIhbnNLp526tcwTuHqVzDlyRhxhwI0A=;
        b=j992nE9kcS9uWCLvy0WbD0RGd7mnMjo8NNirOaJUNba0Akwx3EOYe9znsFNmzzYI6D
         ck3pNHLsWyoXoxmCFz9onrJY+M8lXBIXbY+89SI5fNqEvs/mTzmkZgZTurxUTfsk1ipA
         78VoJa+hnDzhHy2GxZStv5wEK4Kq2ibsqn4JIPVb6KNN685K/6coDBy540NSNX0q32jc
         4IIl8q3Yjfhjbv7DSYFic+mmpxDFkUmJkq1OaGb4UEViVipins4eS2ynFDdHvEp2oAHC
         Xx9T3P9Usu7vFi6hue1YUOdsfKr+S5BcdqzqwC4RUDGI9lcp5o/FTlNzGM9Ql/9lda1/
         2Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quROh7HKwQPZgIhbnNLp526tcwTuHqVzDlyRhxhwI0A=;
        b=Ux1nADXeY7bHQVBENNqpAIIJmGiHY6T5SwkUOGdS+OZOpTBY0aEvAeMSoSP1VzTVWF
         2amAJ7Uzf5ZunrAXjPvnQG9sA0YhRhlKjJun9QvQlZ8YvBxfivuoa6rTEfv/eMPcxnHh
         dHD+4imiBRLyrMtPR1/hU/4jnWPfkVGgBEgfpmZgs82txjF4nTGedW+3zeqaeRVh5xsH
         uzEJg97NKWpkdAYm6zd6EWw1cZc4I++fs0KQ2HIEib38LZq1s+pLN8Jx79TEICfIlz7k
         SHU3USrHbAjJZX/dCAnWtpD8OTci7PFsSyq3LYsy1FSeBIQx1F6y8pbtdCANOMVA/Du8
         dB1g==
X-Gm-Message-State: APjAAAVOeSIbcBM4pqT0QZwhvTDYGWY+dQfIMM9AH/OMCxRg514OnCi+
        sTblJ9/OB7bWLL5PcGmvgdUWPJzyldaUkLX1UiveTw==
X-Google-Smtp-Source: APXvYqz/n2qBEfVq/3HfqxCZMn+ZGrYiHFiZVpslsZCHyj/jqKf/0AD30BuW9JTwKijJQe9X19qP4JhyG/vMJlDTOMc=
X-Received: by 2002:a24:e046:: with SMTP id c67mr15891225ith.16.1558690879203;
 Fri, 24 May 2019 02:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <82f79cd9-5273-b9a4-744d-f5fa95dd1f47@ramsayjones.plus.com>
 <CACsJy8BHeVDDnEYXaOAPtEoesTVNCiPGSgnJYjtL6aYSU0-J5A@mail.gmail.com> <791da98b-4065-e477-92cb-ceac80cc04e6@ramsayjones.plus.com>
In-Reply-To: <791da98b-4065-e477-92cb-ceac80cc04e6@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 May 2019 16:40:53 +0700
Message-ID: <CACsJy8AzY4EO_io_8R41uVDsbCj+_Fn8YOQ8e+JmAC27dFW7UA@mail.gmail.com>
Subject: Re: Incorrect diff-parseopt conversion?
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 22, 2019 at 7:35 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
>
> On 22/05/2019 01:11, Duy Nguyen wrote:
> > On Wed, May 22, 2019 at 2:56 AM Ramsay Jones
> > <ramsay@ramsayjones.plus.com> wrote:
> >>
> >> Hi Duy,
> >>
> >> I am in the middle of rebasing a long running branch onto
> >> current master (v2.22.0-rc1) and noticed something odd with
> >> commit af2f368091 ("diff-parseopt: convert --output-*",
> >> 2019-02-21).
> >>
> >> As part of the branch I am rebasing, I have defined a new
> >> OPT_LL_CALLBACK() macro[1], which I had intended to apply to
> >> the 'output' option to diff. However, commit af2f368091
> >> defines that option thus:
> >>
> >> +               { OPTION_CALLBACK, 0, "output", options, N_("<file>"),
> >> +                 N_("Output to a specific file"),
> >> +                 PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
> >>
> >> Note that the 'option type' is given as OPTION_CALLBACK, not
> >> as OPTION_LOWLEVEL_CALLBACK. Is this intended?
> >
> > Yeah I think this is correct (phew!).
>
> OK, I just had a look at the code in parse-options.c.
> Hmm, somewhat ugly! :-D

Yeah it's a bit hackish. The problem is parse-options (and also config
parser) does not allow passing user data to the callback. Changing it
would affect all callsites at once. It's just too scary for me to do
it and I chose an uglier way but with smaller impact.
-- 
Duy
