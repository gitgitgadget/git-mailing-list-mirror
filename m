Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_RP_RNBL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442CA1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 22:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfBSWYm (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 17:24:42 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45169 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfBSWYm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 17:24:42 -0500
Received: by mail-ua1-f65.google.com with SMTP id e16so7518579uam.12
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 14:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8TRICOrAr1bWM6XboCbqMvYcF0cj9rAmSB4jMJ9FWg=;
        b=afXP5gEvJ3hIJfIvBPRJ+cTRKQMNQJvSYf+JBxb4noNBxtJFKb4xc2Ll77SxqR5W81
         QnWWnbiXXR1DKtfUFynI+8AHip88mk5y7bdu8GOz2xa/TyMDmJss5Eg1XSvXcIWQS+tb
         rV1ioRFrYMK0pdqZYdMEFSb8g1UGchgCgImIiZUq1uRFvx+v0xK+Ffm3wt5Wck8D8YC7
         sFciCFiJCUsuSB6Rlzr4Kjd4c7LYXFkevHqQKQ87rUl57ywpYzniU9rAfh6dnNl/eHpO
         FFJ24pwr9A5HKd9uAgoH9I6nGFeYIX5TumKjxXJO5MXy7VtGTSshfqV6MIDAcbmfUZti
         Uzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8TRICOrAr1bWM6XboCbqMvYcF0cj9rAmSB4jMJ9FWg=;
        b=rjFckms4v0dEHzJnqsX+TSEkR2860qT38Iirp3sHuTcb8eJ5zQ7iHq4PS+35Aa7Q51
         PPaSzwRL4in2js80nFUgB622YYKAl1nuuBuzLSVjGPv7Yc1/Fw6AM93Sgnie4bqpN30z
         R84rqUlA2W8gfRIM6W+rPKXfdNDVdQM4RdQeS6TAHsqpWRdqLOMzeeM8XBegclTPzI6D
         ECdxxjd5dPqImZiBw8B2PdamOIz+xjFkcGk8jazEvdMu3UhYkbE4nGAndCtRbYIuspjk
         1STkyFnfRcSzvrQDQec72ySuaxqSw/W2JX9GUnVn8/Kk3RsCYD+Fz9z68mOlaKtpBUHb
         Pt9w==
X-Gm-Message-State: AHQUAuaIC2Lhn83cS+1R2MldFgYhm6PJDIM0tdV5XTtKBvRMQJ8z4Eo8
        97pO9W83GGw97b78hvPB05RW3h7/yOUPmnDGjqc=
X-Google-Smtp-Source: AHgI3IZwZ6WgovouzX2p8fodwtSQnC18LjKxooYZ9JHXEziVixvOGBfNlkGR2eqRpiEqWElntMwetxOoK3gXi89DwFk=
X-Received: by 2002:ab0:2046:: with SMTP id g6mr15788196ual.19.1550615080680;
 Tue, 19 Feb 2019 14:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
 <CABPp-BGkJOgKqE_vHsA1fkjQ80U10Hv7-HCvScq7WOgj1UF9=Q@mail.gmail.com> <xmqqsgwj1ts9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgwj1ts9.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 19 Feb 2019 14:24:28 -0800
Message-ID: <CABPp-BGp53DrP6=FpYpxy5cmWkcygCz_nrunXisC55KV1ydyXg@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 11:07 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Overall this looks good, but there's just one part that confuses me.
> > Here you seem to suggest that if you pass --source but neither --index
> > or --worktree that both the index and working tree will be written to.
> > Why are "restored" changes considered ready for commit?  That seems
> > confusing to me (and was one of the bugs of checkout, IMO).  See also
> > second half of https://public-inbox.org/git/xmqq1s6yezk3.fsf@gitster-ct.c.googlers.com/
>
> As long as worktree-only mode does not lose track of a
> previously-untracked path in the index (perhaps use the i-t-a bit),
> I do not have a strong objection against making the worktree-only
> mode the default.

Could you unpack that for me a bit?  My assumption is that
worktree-only mode doesn't touch the index (other than maybe reading
from it), and treating the index as read-only means by definition it
can't lose anything from there -- but then you mentioned using the
intent-to-add bit, and I feel like I'm missing an important puzzle
piece somewhere.  Trying to make sense of it, I'm wondering if you are
objecting to using overlay mode in general, or are trying to connect
this to the new "precious" concept being advanced, or if there's
something else you are considering here.
