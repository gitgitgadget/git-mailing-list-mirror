Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15E1C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7973560FEA
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFSG2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 02:28:25 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:40795 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhFSG2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 02:28:24 -0400
Received: by mail-ej1-f54.google.com with SMTP id my49so19324732ejc.7
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 23:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAhLm3G0eYBVSvg0id6/Fh2PL7C/k8n0Dizc40WmRpA=;
        b=Pz00/30Rx9iUdGjmuqZtBH+dnGn5ojsFjWR4CRPGxjt+GZjl4+P2SfhX9741haDWz4
         /vxHwirwE+SS87oefTe97xII+IJ2yCKteGWgsjoGZoIH/7yAaaBAEA8ZiLpdkCmtSztA
         xTFZ0ZLwuWxV8cWs0lmUXbHB+e6Axj2zfcHFfXnOT/RUVvAvB0jhkhvzwOr1kqtgQTF0
         xLjqn142UUTsnWGjQTO4lQ779BfmzCrLjO4YlWgklZ0wBBuEv1aLzEFQxS75WBkUHruW
         YGkWvuSzzqNwVdmEHiE7Fsyq8r6XNDgJMmmSb4FMaygDK2lVCzCn8rmKD7PQYL/j6JVO
         Rv+Q==
X-Gm-Message-State: AOAM531GiouExHeV9Otk1HXuiWWKGd19diHnUXSYBM6ZTa/Op/4XkYfF
        8FkIl6dS7siWu6x0izjArPAcFPcFSkNK4DDQtZaifg8OapA=
X-Google-Smtp-Source: ABdhPJzjPOADGN5ozIwaXrAWQ6x+VhP7lXghEqBDJuuvc5bANHhtu/Zm0oI9WLAcL8ecuhSxugcC4jaZIhn716f5DGw=
X-Received: by 2002:a17:906:3d3:: with SMTP id c19mr2021265eja.202.1624083971964;
 Fri, 18 Jun 2021 23:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210615172038.28917-1-congdanhqx@gmail.com> <20210619013035.26313-1-congdanhqx@gmail.com>
 <CAPig+cR7tUXB4=j3fGHN07=tPJ-skGb_6M7SExTq5eAH7FSwOQ@mail.gmail.com> <xmqqfsxel6oo.fsf@gitster.g>
In-Reply-To: <xmqqfsxel6oo.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 19 Jun 2021 02:26:01 -0400
Message-ID: <CAPig+cQdDibt2K6jFKehaWyGdtb72pj7FQ9nGLJYEmqna3vf5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] t: new helper test_line_count_cmd
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 19, 2021 at 2:17 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > what I tried for the last version might be even better. So, for
> > instance, the name test_out_count() might not be too bad:
> >
> >     test_out_count = 0 git ls-files -o &&
>
> "Test out" to me sound like trying something out and the part "out"
> in the name no longer hints it is about "output"; you may have
> shortened the name too much to be meaningful, I am afraid.
>
> Is the helper used to check with anything but equality?  Otherwise
> you can lose "= " to make it shorter.
>
> Having said all that, as an external interface, I wonder
>
>         test_line_count -e = 0 git-ls-files -o
>
> would work better.  It usually takes <op> <num> <file>, but when
> $1 is a magic "-e", we shift it out and it becomes <op> <num> <cmd>...

Indeed, I have no problem seeing this as a new mode of
test_line_count() triggered by an option. In fact, I suggested exactly
that[1] when this idea first arose (except I named the option `-c`
rather than `-e`, but the latter is fine). However, my suggestion was
pretty much shot down[2] (and I don't entirely disagree with [2],
which is why I didn't pursue the idea in [1]).

[1]: https://lore.kernel.org/git/CAPig+cS4tkXZLPDEWgEytzEOCR7oGrXyg1CZVKVPSXuJOifLjQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/xmqq5z0fxlgn.fsf@gitster.g/
