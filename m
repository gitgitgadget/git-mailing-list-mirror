Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067A81F461
	for <e@80x24.org>; Tue,  9 Jul 2019 20:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGIUdq (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 16:33:46 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:40383 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfGIUdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 16:33:46 -0400
Received: by mail-vs1-f45.google.com with SMTP id a186so1235vsd.7
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oC3N6sct1cwFRErEuTz9uqco9iKuQqUd65sXo2uO/BQ=;
        b=RFxz1oYAIKxsqh12RnRK5L5zqnmHko0N0A0MiYrT6Q8IX4vIyFDnIQG7OrvkKYdrk2
         kM/77kHW04Sl0IfvzG/xwLWq6Uijb9xrf0XWfTJlgivTVmZIccc1E+RCX2GumqcDMisO
         9qUNLrTtrqc+uDxOAKmWmjOdn1mVOpVGmNT/Fhwmy/YwO4fj4lfe5jgC0nPZZ+0IIvYB
         +Cq+FBuyNeI0ValwRdznnfT9+GWCR3WbA3tXoJ0xNWeKup/4sUT3woZs9inmaOBsI1u1
         k/0eF0jJmBScRUosROFVTbq2kBBJvLPhvF3iGTGgmupIo9bMXyf45P8Vtts6LtAq1jJW
         XiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oC3N6sct1cwFRErEuTz9uqco9iKuQqUd65sXo2uO/BQ=;
        b=Vg2pEFKQD0N1cah8l5ADgB95jR7sL32LZTNO0rzyDfkkmb0GURP0YlLQ/xtUSIgiHB
         2TvBZQiX7eTMbjDoWFhXF6vUDKM8F6mZAvx1achG5PDhY0YOR9T1o3cVW5E/0geGYGv1
         Kc3vUyNM0pOYa4QsZBphZ2egucZaqdmbdlCLaRF8NciDfMhKMS5og2rjXF8ryIKmzHXA
         kwWP7QQQwbRmbJAIHnT7LA/M1slauTmrP0KfyJjcBUlCRhfqCvVet+UBlYSMF8bltK38
         t6CuA0vKKzG/VN5dBpw81EvQAEIk+tG/FYZf+kUp4m1UQbeFxNIOiMi30uWwwS6z70UA
         1U8w==
X-Gm-Message-State: APjAAAWuGaEHUJeJFdX+vc+Ajh6OdPiFO295QZND30X5AxCg04rW9j2g
        VnTKCQKx9MrECJ6JPl5IXbt0/ztDZVqGmxuacvY=
X-Google-Smtp-Source: APXvYqwIfolzciQa9COZcq//FRWKQ6E9R8y4N7Twcd+uXPzJ28LACEOAiIK2PAMvRHAFYeHqhrkqyyVqaHAwPIsL7wY=
X-Received: by 2002:a67:c419:: with SMTP id c25mr15247571vsk.136.1562704425582;
 Tue, 09 Jul 2019 13:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <423596682.8516.1562665372094@office.mailbox.org>
 <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com> <1152121968.7459.1562688927235@office.mailbox.org>
 <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com> <275487563.12198.1562691633735@office.mailbox.org>
In-Reply-To: <275487563.12198.1562691633735@office.mailbox.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Jul 2019 13:33:33 -0700
Message-ID: <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
To:     usbuser@mailbox.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 9, 2019 at 10:00 AM <usbuser@mailbox.org> wrote:
>
> > On 09 July 2019 at 18:35 Elijah Newren <newren@gmail.com> wrote:
> >
...
> > Hope that helps,
> > Elijah
>
> I hope this is not-top-posting? I'm new to this and know nothing apparent=
ly.

Yep, you're doing good.

> If I were to write a patch then I would very much prefer to implement the=
 behaviour that I expected and want to exist - either by a new flag and fix=
ed wording, or just fixed behaviour. I guess the latter is a no go. Could y=
ou point me in the right direction where I would need to start to add such =
a flag?

We can't break backward compatibility, so we can't change the meaning
of the existing flags.  However, I have no idea what you want this new
flag to do; what is the behavior you want?  The only three
possibilities I can think of are what the three flags we are currently
discussing do.

> Additionally I would also want to change the wording for --ff-only, as it=
 currently reads as if it only performs a check (which would lead to the ex=
pected behaviour) but does more than that, as it prevents "real merges" alt=
ogether.

You've lost me again, I think.  You expect --ff-only to only perform a
check, i.e. to not update anything and thus only report on whether a
fast-forward would be possible, but leave the branch exactly where it
started no matter what?

Or is it just still not clear that a fast forward by definition is not
"a real merge", i.e. it means to update using a mechanism that doesn't
involve creating any new commits?


Elijah
