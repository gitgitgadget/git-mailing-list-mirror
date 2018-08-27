Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADAD1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 20:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeH0X5O (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:57:14 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46500 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeH0X5N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:57:13 -0400
Received: by mail-wr1-f52.google.com with SMTP id a108-v6so143751wrc.13
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1KNVNbyjFxklfHTcmRG7HmSxlV+nyC290N35QQt9kyk=;
        b=McbOQPDV9pfOO2O+pVU3ckp/ZTGljncPvywgIaafsYMKRCawpcMlei8zSFYy13AKvk
         x+5x0KgZQJq3hZmWDqdnDS42+daHt42RF+ElhpBNxtEj2D73rv0OXjqZNpOs/GpWniwf
         UETQXMH8RQUhCuDG2eArTeQKnV4zclGWVGgf5oWxlRag4/SujTIoYy9NK50Ia9Ey0g94
         ZxkIdt34XcawH02xJHHBE2rYEwTlu2vNmoRFhFXFfR2RNgVW6uy0oo3rFcSdJAFdZqiK
         7GFkdXqRk3Y9lzgSK9X/XpWnNvYPKbL1JTvJZcDfvshDZ8VMVlqaO/WtbU7Kpuut3p4b
         Gr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1KNVNbyjFxklfHTcmRG7HmSxlV+nyC290N35QQt9kyk=;
        b=dCh7gCdrIx41KmoXcxPh7exZhkk0WGDG7seb0GFqB/zZHNsW7VOHg3zIw7S6Ay//me
         Uc2U2ZzjkWFRDrKFilNtqYMKw/xYC5ckTitJfdE4JhNqoK2aHOikJ/268ZDNRtYmqbi7
         CJwRQzlSSq9Q6EvFjQh1DzwzeQAkjIQQ76r+tpLEOolvEQOGETlSvqixUnaD00ew9xNf
         Z/vZ6YHqxLCp9+s86UsfORiZUpO09JlSO3CTRjedkYpWgOyN9tKml7azxIfvadwG+cyc
         kEKN8Z1jgTJAM7KxOeroDF/wp9Nvyu3okC4PX7o/uMDDskwv7a2PWeB7BBpKOQ74nC0U
         aQiQ==
X-Gm-Message-State: APzg51C+g0AIAfOKXdZGtsrToviX9VzW//JkTERGKF6EDDKiw5C8VgVB
        5hEd56DZZ2zEY3Zx/81rLpo=
X-Google-Smtp-Source: ANB0VdaYyCoTTV5JtWRxyAKMAFJl5tmmetx2o3aklFnluZa+nFv4hfwf4Zw7ZvQtxSok+yxKZGW1Vg==
X-Received: by 2002:adf:9366:: with SMTP id 93-v6mr9018306wro.60.1535400545879;
        Mon, 27 Aug 2018 13:09:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x23-v6sm64179wmh.26.2018.08.27.13.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 13:09:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Scott Johnson <jaywir3@gmail.com>, git@vger.kernel.org,
        Constantin =?utf-8?Q?Wei=C3=9Fer?= <i7c@posteo.de>
Subject: Re: Would a config var for --force-with-lease be useful?
References: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com>
        <xmqqin3vk3yv.fsf@gitster-ct.c.googlers.com>
        <87o9dnegxi.fsf@evledraar.gmail.com>
Date:   Mon, 27 Aug 2018 13:09:04 -0700
In-Reply-To: <87o9dnegxi.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 27 Aug 2018 21:40:57 +0200")
Message-ID: <xmqqlg8rinbz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> This was after/during a long discussion starting with:
> https://public-inbox.org/git/CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com/
>
> It appears the only patch that got in from that discussion was my
> f17d642d3b ("push: document & test --force-with-lease with multiple
> remotes", 2017-04-19) (https://github.com/git/git/commit/f17d642d3b)

Thanks for pointing at the old thread.

As far as our documentation is concerned, the invitation to improve
the situation, offered in "git push --help", is still valid:

    Note that all forms other than `--force-with-lease=<refname>:<expect>`
    that specifies the expected current value of the ref explicitly are
    still experimental and their semantics may change as we gain experience
    with this feature.

But I do not think (and I did not think back then) there is a magic
bullet to make the lazy force-with-lease automatically safe for
everybody, so it may be time to declare that the lazy force-with-lease
was a failed experiment and move on, with a patch like the one
suggested last year in the message:

  https://public-inbox.org/git/xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com/

