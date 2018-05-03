Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136AD200B9
	for <e@80x24.org>; Thu,  3 May 2018 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeECQ4N (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:56:13 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33063 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECQ4M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:56:12 -0400
Received: by mail-wm0-f52.google.com with SMTP id x12-v6so3741768wmc.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ln6dQSMXacp13ABjMiHw4dQgzZ3jffNR6zZEBCQ4//o=;
        b=BEGFPZm/TCt8gTXWW2ntwsOwyUPkEK7fYLgb3s1q5Ye/Cr5P4tDkDzVqY1LhXxKK+Y
         C5+jp9UbGBDkHQUTr8CEgq4juON0elOQa8nhpuQnsdIhGXn1Pc3YZ3zF5x4PleYRaFGD
         T0uoz13R36fpHx2IIuA+58Bdmhur57yZ7n0W10zccM7mRu8rU6CkIt6ndmoQSU+ctNJC
         +1aJRnVhgX6aVBQjDC5eHFB6EuNAxl4nH6RpQ3dVEm5gDtpKuwm7/hOLXOf4EZ/jjpzc
         wAwrK4AVW1Ar6ISbAx5+32qMmfnhK6+FzYupkrl4nEkqQPXIxL0Iktt8jvcaxrsmW/N8
         AwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ln6dQSMXacp13ABjMiHw4dQgzZ3jffNR6zZEBCQ4//o=;
        b=oKPVU6QowH5ImyagnHi4I8aXky0ksNBESSQbzKgLrhOrXpQNN5NpFWKaLynOiTF1yD
         EvtKQkqvhbxolPDbbwKMk/odfnpiVdIpOyrHk6JiArl5IJUihf2zVg3RS/Q85lCtrrmK
         xjCqsTDeeW9gbgtZeLgeMAcetdQ/4sCkmoTswDasr6pOAKwjdONa7VbuclxsGjPoYiAv
         QE1J8PyA240yXi10m+AQ/yOX3enV57eA9arUjtoRrx+ML697FRg1bfD3xmmS5TIacUcO
         9pvsEDwpyVhCdORCWqn5wZ9+Gaat+Tmsz0xLjk+8iD4q8ISljLWNxjAJCLd3bdYVFbUt
         WuUQ==
X-Gm-Message-State: ALQs6tA1iWN+AkikQSx+QVWPwMEkIutPVh49XcHWEAL62wVz6IRyPX/T
        oh2+TstrK2b7fEXWojjcy5s=
X-Google-Smtp-Source: AB8JxZqRzTJfgQMAMjrVrTTZyqXAERqIbHc3wRws/Mu8vl7KlEKaab9HMmRaE1xeJI/rnwtX1+3KQw==
X-Received: by 2002:a50:a58f:: with SMTP id a15-v6mr31721177edc.289.1525366570721;
        Thu, 03 May 2018 09:56:10 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b4-v6sm7556588edr.29.2018.05.03.09.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 09:56:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 11/18] branch-diff: add tests
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <fe12b99a0b4f78ab75fcfbcf51c5edffb190c4e8.1525361419.git.johannes.schindelin@gmx.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <fe12b99a0b4f78ab75fcfbcf51c5edffb190c4e8.1525361419.git.johannes.schindelin@gmx.de>
Date:   Thu, 03 May 2018 18:56:08 +0200
Message-ID: <87r2msy8yf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 03 2018, Johannes Schindelin wrote:

> *before* the existing emtpy line. And apparently xdiff picks a different

s/emtpy/empty/
