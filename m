Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12161208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 01:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733292AbeHGDbs (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 23:31:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54319 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733126AbeHGDbs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 23:31:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so15590705wmb.4
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vgNN7fPVfFqjNdpVpz5Cw0OJfX7q7586vTXVHA8GAnQ=;
        b=ULCeqxAA0tomx5YOjWOKw5cmkt/Pf1XvjV0H4+PQjdTTWOXLxkAwjbfXJw2bgJ2S8S
         dbUP4nzlt4FIkZZKWrRWtrIzQzHGBqvceDFnzgPUjmoS/97+uYaJMjkJuIKIxLRUMXHv
         3STDgTYfOOHzaQkV8uGqFzGLaLQ91QRubsQ8sAddvkI+UUSZA+w0Hyxvkixm3ymotJF5
         0hx4Uuu0Gc9R6xUT5SHJQ3Rc0yAYsqutwz6hQV29heFjtUcd38kfwAAq760VBFmOp6kw
         13e135pp73BKoRDyuJn9YWAORkby5iQkk2gQJxe0lUUoG7YEDIuaMQHyInotawU5ukj+
         SSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vgNN7fPVfFqjNdpVpz5Cw0OJfX7q7586vTXVHA8GAnQ=;
        b=JaeaLBG0ldRrGJiYFHNhWY0QOWwjqd6/RuLRqyBl1N52tBrIajqzx7CW1c5BPyqMv4
         fGyJ8F4cf6v9EKvCD/MatOh1Vbd1OvgPKY7V+2KrVkxlaRmZ5jXTJXNxgU5Ar2oXMddm
         Z4tGM+QRRLVEY7ztpuSEj4X/DYNG99l6DfiUuSP5FgslJDYkSfXMwgl3dsGibfH4vgBV
         HtGPkW4T6CNXtpFJhGYpZ0PFwdzyyhelZ7l1AZfj+QqdFfNv22gUhC1E+dv3Giq2r6ay
         YHOI0I4HGV375m33Jgd5kUMWrivwrnkqxw3n5/pZzjKP05KKR3on/SUop6kmc7XmNv0x
         15rw==
X-Gm-Message-State: AOUpUlHT56Zef8+KChhfz8ChRohXlwOxVr90cDlhjOtrlRiSApSMRcJM
        OCsyG8fQj107IThTHvsi5cEdhQnowY6rS3FDZiY=
X-Google-Smtp-Source: AA+uWPzUFvURHO1Q/Q2N82O7LgeL3ZRLObykrp6mQHFF7jqUK0TTKV3T0TxDXiQrlXuodweylGkf5Wm5ZJivijwRPz8=
X-Received: by 2002:a1c:1a02:: with SMTP id a2-v6mr252992wma.52.1533604799390;
 Mon, 06 Aug 2018 18:19:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ee10:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 18:19:38 -0700 (PDT)
In-Reply-To: <CAPig+cRe1R1YWpLaXVtTmwhaJiz2dONU83qtn_+XhaRevjn2fQ@mail.gmail.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <CAE1pOi3oeBEyD8skwfLAd7JviGYOUZaZwj3u9pznM4eLAR7fDQ@mail.gmail.com> <CAPig+cRe1R1YWpLaXVtTmwhaJiz2dONU83qtn_+XhaRevjn2fQ@mail.gmail.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Mon, 6 Aug 2018 18:19:38 -0700
Message-ID: <CAE1pOi3+FW8itk4AHhG+r02TGyGTeoZpq7S6HKXkQtOVqigWGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 11:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jul 31, 2018 at 9:30 PM Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>> On Tue, Jul 31, 2018 at 12:33 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > This is a re-roll of [1] which fixes sequencer bugs resulting in commit
>> > object corruption when "rebase -i --root" swaps in a new commit as root.
>> > Unfortunately, those bugs made it into v2.18.0 and have already
>> > corrupted at least one repository (a local project of mine). Patches 3/4
>> > and 4/4 are new.
>>
>> Does this also fix losing the initial commit if it is empty?
>>
>> git init ; git commit -m 'Initial commit' --allow-empty ; touch
>> file.txt ; git add file.txt ; git commit -m 'Add file.txt' ; git
>> rebase --root
>>
>> I would expect there to be 2 commits but the first one has
>> disappeared. (This usually happens with "git rebase -i --root" early
>> on in a new project.)
>
> This series should have no impact on that issue; it is fixing root
> commit object corruption, and does not touch or change how the commit
> graph is maintained or how the rebasing machinery itself works (and
> the --allow-empty stuff is part of that machinery).
>
> As Dscho is cc:'d already, perhaps he can chime in as a resident expert.
>
> By the way, what happens if you use --keep-empty while rebasing?

I was not aware of that flag. But, although I was expecting it to, if
I use it with the rebase, I don't see any different behaviour. I can't
really make out what its purpose is from "Keep the commits that do not
change anything from its parents in the result.".

But your suggestion did make me think about what behaviour I would
like to see, exactly. I like that Git removes commits that no longer
serve any purpose (because I've included their changes in earlier
commits). So I would not want to keep commits that become empty during
the rebase. What I would like to see is that commits that _start out_
as empty, are retained. Would such behaviour make sense? Or would that
be considered surprising behaviour?
