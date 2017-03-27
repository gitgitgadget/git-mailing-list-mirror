Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58371FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 21:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbdC0VI4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 17:08:56 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36292 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbdC0VIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 17:08:54 -0400
Received: by mail-it0-f47.google.com with SMTP id e75so35111722itd.1
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2h7duSOQ5iAbFAjh64T0D2BG66avnpEBx/nSe0q4GWU=;
        b=WSY8tpwiVZIodNGrfav1p60KomyyXXJrxGOqSE9amgD2MauTWNrkzFh9L0dpXdgtG4
         yyoTRRl5NSH+E21DbPYvQvGACIH7CsPEG7s//GSfGmV4RxWtreK4rbjMRWWXAyfaTbf6
         Bj0wtRy0CsZtJqH9kq9T/MMFQ1aJXsaGtiR9V7WvSa6YONr5kfl3jFGQldPcpVe1OPjN
         tiC3DZrnXFwnYMybb/ILGBCWrHFJZXKkwObR+cdchWutPkDdNn0QX4CwwkHBX9yRBmKe
         c5frEclrkiWTojvy4xOvb2BX0WFZXvlaZ7vSuPqAPAXPvisSy/JS8yzfMIUNIExQbYJL
         440Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2h7duSOQ5iAbFAjh64T0D2BG66avnpEBx/nSe0q4GWU=;
        b=mfs683+Svrs9HiIpO09Onjsfwrvmhl/apWImYjDobeCflqEy3CFXnPjPGQsuOhA4/1
         IN2Ss2+rBkrbe+cjYj7xiIXFHVGUWf5r1adP24tvNJ0MMfnGeWTFDEr5vAr/BwsAQyMK
         tEQWh6XzvwvVZxasNAOuqfBPUawdWagF+uknkXjNe+3ZL2twas3Vy9Q2gF9/wQ7oUjdu
         K7+XERYM4dCiZHTdksLxRnFqQsst+krs9QYOROk3OZDxV+iwFV4EB0Pbw/y3eGUpcAPC
         lPtoI5zcwqMsOZMgvVSVgUIu597CSmo6Rb1cMSsSqUxR398OCSYFCFablVJN+Pi/a3cd
         dnpA==
X-Gm-Message-State: AFeK/H0pNPPFSahcqHtnKAFESnw08ve5BmPaLN/NicuZlK6CtMv3h/D3tb772oByR1OwTQW09ahI2GTuKsCPbw==
X-Received: by 10.107.34.68 with SMTP id i65mr12182030ioi.147.1490648909379;
 Mon, 27 Mar 2017 14:08:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 27 Mar 2017 14:08:08 -0700 (PDT)
In-Reply-To: <20170106042051.nwjiuyyp7ljhs4sr@sigill.intra.peff.net>
References: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net> <20170106042051.nwjiuyyp7ljhs4sr@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 27 Mar 2017 23:08:08 +0200
Message-ID: <CACBZZX5AnG=hpnZCG3qFkLOO0gbgvt79ZYP3-oG5VjE8p284cQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] blame: output porcelain "previous" header for each file
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 6, 2017 at 5:20 AM, Jeff King <peff@peff.net> wrote:

> +for output in porcelain line-porcelain
> +do
> +       test_expect_success "generate --$output output" '
> +               git blame --root -C --$output combined >output
> +       '
> +

The --root option isn't needed here, the tests pass if it's removed.

Discovered while looking at the sorry state of our blame test suite
vis-a-vis tests for config, no tests for blame.showroot &
blame.blankboundary.

I'll submit that eventually, but meanwhile did you mean to omit --root
here, or is the test broken in some other way and it /should/ need
--root but doesn't?
