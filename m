Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314011F453
	for <e@80x24.org>; Thu, 21 Feb 2019 17:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfBURow (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 12:44:52 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34164 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfBURow (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:44:52 -0500
Received: by mail-vk1-f196.google.com with SMTP id k64so1627347vke.1
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcz3+uGYK+X0TCrpB3zemTqa4Suv9EN17+Lh3ETQqKk=;
        b=VIQDwAnif2i3xVSuFdBsnuleoLymXfyGwCPnEItaxuzTrFTkzUOy4yQCKz4Lr+bO0H
         cXb9sA3UphhKlmFkJempDTcnnY/CvkD+6n3IYBJByuNYmt7fOiV2dgT7hONhrMki0CxE
         0Sn42biBaPBukzoxFbE62JWyLRerNXoejqExZYu3NHRnBfiXWqkJC1kIUJJxaZI2yUIh
         RYfrSTbArYYv+sdduR3NdPztRCNI9AF4ucBR7a+8qZ3mmtQNoiWUTs0etRl7wi+nNMVL
         tpu/5R1NJmcTPis3xGoDz/AkioUZpavQRF9TKBBDpxg2hFxd6aK1JvhSBUjnBomJ0Otl
         06PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcz3+uGYK+X0TCrpB3zemTqa4Suv9EN17+Lh3ETQqKk=;
        b=ahjNJ1zAN2n9UZZI/X0P5xVI9NnWyYCmJVXvk77JGbGpEBptWKQojdJuhXRY8uBNvw
         hLtWL6ks1wEkJQuzuUu/eLGCe+RKlaGp2Yb1qgR+f6ypDR22TjeYTVGbAHIJLK3/91nn
         rBR4jGJwABXzQZqiriDXNxIO7gfr1qo44+vKLcuck6jCx/cCxMeaL30Buz0spmeQO0N6
         TMIaAGM8TymQlPocd1RM+gqGoWGcdkJAn+clL1INhBTeCBulrXg9i3IylQgmRPVkyHM/
         uv8dyxKFKqa6/GY/BmWrwH8kmVdwNb8NDaoYT1/RcBOABExWOaiwjPA2PDOq065JBqVL
         ryBA==
X-Gm-Message-State: AHQUAubSK59R/JQCzaTxvWOfow3WeC176dmHySg9335igKlI3NqiLjIv
        1qPMGU0sOQ5ixXI1gPQzYqtaGSDEevMjsYVZsZ0=
X-Google-Smtp-Source: AHgI3IbKqP6V3qc6204m83fa8mH6WZ6hHtwtBuHR/jC3gATHam+nmOdQJm/KDi9+BsJDBg9k6E+LkrPwxWFOjyOth2Q=
X-Received: by 2002:a1f:ab03:: with SMTP id u3mr4269719vke.1.1550771090229;
 Thu, 21 Feb 2019 09:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com>
 <20181211161139.31686-6-newren@gmail.com> <nycvar.QRO.7.76.6.1901211709090.41@tvgsbejvaqbjf.bet>
 <CABPp-BFrgjW-c8NKGYKs1VaH--Oc8yUu0enQMSp1pQVUwBOBwA@mail.gmail.com>
 <xmqqy37ce8ad.fsf@gitster-ct.c.googlers.com> <63822309-1c58-a4a2-fa2b-d694bd9b8663@talktalk.net>
In-Reply-To: <63822309-1c58-a4a2-fa2b-d694bd9b8663@talktalk.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Feb 2019 09:44:37 -0800
Message-ID: <CABPp-BENWQGSCj5F1FWm5s8vD6aYexJNbpGY8MGjs4AmZOnnYg@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] git-rebase, sequencer: extend --quiet option for
 the interactive machinery
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, Feb 20, 2019 at 3:00 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 22/01/2019 20:39, Junio C Hamano wrote:
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> Also, I have a fuzzy memory of discussing a very similar case with
> >> some rebase-oriented option and its on-disk representation, where the
> >> concern was more about users upgrading git versions during an
> >> incomplete rebase rather than power users looking at internal file
> >> contents.  And I think either Phillip or Junio made some statement
> >> about considering these internal details and that they felt the worry
> >> about upgrade mid-rebase was overly worrying.  But I can't find the
> >> emails right now, and it's been so long (at least half a year) that I
> >> might be imagining things.
> >
> > I do recall saying that mid-rebase upgrade is probably not worth
> > getting worried about.
> >
>
> In light of yesterday's bug report [1] about those other changes I'm
> more concerned about this change. We were worrying about whether or not
> to worry about a mid-rebase upgrade but it seems people can have two
> different versions of git installed - one bundled with something like
> tig and another they use on the command line. If they start a rebase
> with a version containing this patch and try to continue it with a
> version that does not then the older version will fail with a complaint
> about a missing quiet file. The other way round they'll potentially get
> the wrong quiet setting which isn't such a problem. It's probably a bit
> late in the release cycle now to change this? But we could flag it up in
> the release notes and bear it in mind when making changes in the future.

Thanks for the heads up; I'll try to keep it in mind for the future.
