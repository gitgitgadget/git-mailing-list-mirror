Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58ECE200B9
	for <e@80x24.org>; Fri,  4 May 2018 03:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEDDPq (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 23:15:46 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34340 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEDDPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 23:15:44 -0400
Received: by mail-qt0-f195.google.com with SMTP id m5-v6so25703784qti.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 20:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bwKs94udaE7upBVYproHNc/omf4b4oFuEn2RNWeH0+Q=;
        b=X6TNYzuXT077vB7DGz8Lc5qQZNusyLHgTtUsngBxBZ13AuXUp5oOkoYcz3ZQ0wI9S6
         sc+qE/cHp8Trl0E33JF4RLo8DhQ339pb6qawia4lj23PP63TLw3RykkY+ouuFNUJC3L3
         tHccZtl4AN5D/w1qw6ZMaq6Ljv4edfFHMJjojjUCwOXo14HpN/wvWM3NfUlMaEA9HMqW
         XzkOucQ1oIpTQACScGd+4PN86Vm5EGSk+gyWY7HbE88W1U3kqtk5xoM+KTJvTVuk13PV
         W9y7IPkUzFiEdJ2VTWNFVlWA1vAEeDuQO9lLYmbDDCooeiAUnhiVeG/CFVriTaQdCvk1
         swNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bwKs94udaE7upBVYproHNc/omf4b4oFuEn2RNWeH0+Q=;
        b=h3IsLi3SPhQn2b0PQOgfVgsnqfZRr8CuV5RY1G4zADXH8qhvxGPRLv1pIGkC1JZIPx
         Ppd+0k2HGQvs+mpV4y+zPjFmspE/mjcWrndSKC6/o2b/1cwiwpp7Me/kP0c6id46E08r
         jbx/muzYpaPxb6aVj0AqxxVwO/7HGenhRG2lyiCAdiYKRB/k7/6uD1Qi49o2+e80YaB3
         lyXB6Ow+YaHzudP1lVzfBm39T3wtUS88joUQKyliJ49BM/PH+NcLcVNZUmDa1HGZgnzW
         s2CEuriY0x/fdHPZcpzRvbgU0jRcz8h+Rb41yRSVqbSedet9A4gLz/12jFBRMruX6898
         Q/Tw==
X-Gm-Message-State: ALQs6tAPO2WFs26me5PMTF1nqm+JXZGpYfJS85rpE9KCxAACtOp8GcXO
        EPb+6JUX1TVdHkC0mv42OrbTLU6DIHsucST8dec=
X-Google-Smtp-Source: AB8JxZrB9VKNAUi7KZIg0AGA+adscxQYVcpjSwejyXH6HPt50dlEsmA4Wm0tJAdwoWyORu5ahJLTkQWQXPjRiu7TFrs=
X-Received: by 2002:a0c:b7af:: with SMTP id l47-v6mr6152973qve.110.1525403744159;
 Thu, 03 May 2018 20:15:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Thu, 3 May 2018 20:15:43 -0700 (PDT)
In-Reply-To: <CAPig+cQc-FXyZv=61GO7-6apu_avA-DhPkqJLC_1a5hKmq=bZg@mail.gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <141e5b63e4511c13380216fad9b8601d2bc6051e.1525361419.git.johannes.schindelin@gmx.de>
 <CAPig+cQc-FXyZv=61GO7-6apu_avA-DhPkqJLC_1a5hKmq=bZg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 May 2018 23:15:43 -0400
X-Google-Sender-Auth: 7-VWL7b99vs4n9R_E1gsVhWWrFI
Message-ID: <CAPig+cSzBY4gi_9b8NREeeOb0EA-wyKQusiDw6c3=FMaBoaUNg@mail.gmail.com>
Subject: Re: [PATCH 05/18] branch-diff: also show the diff between patches
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 10:51 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, May 3, 2018 at 11:30 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> Note: while we now parse diff options such as --color, the effect is not
>> yet the same as in tbdiff, where also the commit pairs would be colored.
>
> "... tbdiff, in which the commit pairs would also be colored."
>
> However, I don't see the --color option being parsed by this patch, so
> perhaps this "Note" can be dropped?

Ignore this latter comment; I missed the newly added call to diff_opt_parse().
