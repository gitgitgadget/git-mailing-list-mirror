Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5460E1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 14:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeJ0Xi5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 19:38:57 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38380 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbeJ0Xi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 19:38:57 -0400
Received: by mail-it1-f194.google.com with SMTP id i76-v6so4964536ita.3
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcYFRuN3EVBVZcMredBrFuFqjAKG+ADPGorGqJKhPkw=;
        b=eTYB68sIXT2CqHTrbuHAWdtHbR0TuLOhix07l07r02MvRL4CnRVGZAx3nHZXSNZ+EE
         Fq00i0rzYMuecc/rgyekjmz+SELBfFQ2n4E9+4NQik/4piquCl+7sJJg2kc0tVhpJe3D
         RwCLF2Kwf++9nTe6H1sSsBgZ4YuK0lzV7TbiFe2Qy3Y36umnKl5UiXBwmAEoOUtQenhw
         15M/o6i1coih6y5fTZfRDbPQUmsfAf6a8yFQksd6X/6iIfhCsI50Kwvb8SYmWGP9/or7
         ynVga+D9y8BZ3MeLxW4WAQREHFDja9Al78JLTAIsFqacOm1vf+wSvyXwqqnRDu//u5cR
         tygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcYFRuN3EVBVZcMredBrFuFqjAKG+ADPGorGqJKhPkw=;
        b=PbovVuJLu3DY0RQ/wINsVVNDl8Q13g2fIBb2cp5lVotRaUU1imczlOOmSK3pNrNDj+
         4OxLHo4N+87PMifMFpCQjM95xY0X22XdTiFXzBqQuTVjkXls30/fG4TDaXI+McN12s5N
         JIaxqusNJzHzbemL5icMbRPcRbdmopucXpdH+JrdrvcvqqaBwbBdaYjSEqI9vFs664tZ
         ZQdl020MC5bbIo8DjTBPPAzS0jkdXCcahoR1FNk+ZUf1As6UfuJXg/NS35WZown+rep/
         VtWReGZBCsoGqf+4PH0bZLtxUJFK/cr9zf9+XSN6U5ZKIB5SYth8riD8Gu4+tYW9XD2T
         O3yA==
X-Gm-Message-State: AGRZ1gLzxgEwgZ3/Q0yyiWaybYf5VWz2LV4gTS/TyrSgr14ORFfZh11x
        A2QnRARzuUjAx9usu5/rW2ZO5JdsRHDTXUpiwE1sIA==
X-Google-Smtp-Source: AJdET5c75APSFfIXmkbeToEWrrEOxoTWljGJwRjkC6ma+bs1XcCoJIY/lC7tj+Y3gNOgFCftVfIbwvFOSr2QETac5OY=
X-Received: by 2002:a02:958a:: with SMTP id b10-v6mr5599389jai.130.1540652261230;
 Sat, 27 Oct 2018 07:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAGOLd-7Hi+tssj4ozKPd04squ-PuFwtt6f2nhbZp-zKwy62pVQ@mail.gmail.com>
 <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
In-Reply-To: <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Oct 2018 16:57:14 +0200
Message-ID: <CACsJy8A83_Jh4GmVYXS-zk_6Yro6eeB9i_J7xh3VMTkr8JVDvA@mail.gmail.com>
Subject: Re: bug?: git grep HEAD with exclude in pathspec not taken into account
To:     Christophe Bliard <christophe.bliard@trux.info>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Rafael Ascensao <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 4:55 PM Christophe Bliard
<christophe.bliard@trux.info> wrote:
>
> Hi,
>
> I observed an unexpected behavior while using git grep with both git
> 2.19.1 and 2.14.3.

Quick note. I confirm this is a bug in tree_entry_interesting()
perhaps being over-optimistic. It'll take me more time to familiarize
myself with this negative matching in the function before I come up
with a fix for it. Thanks for reporting.
-- 
Duy
