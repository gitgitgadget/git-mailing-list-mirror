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
	by dcvr.yhbt.net (Postfix) with ESMTP id 121BA1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 22:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfBSWFJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 17:05:09 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35249 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfBSWFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 17:05:09 -0500
Received: by mail-ua1-f65.google.com with SMTP id k5so2713207uao.2
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 14:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uv4WO+LIujL4IosazL39DsWMt3jbAP48f4X4caFggMM=;
        b=LwHWLka2DK2g3U1fe0Sy6RyQfWKlRuQHYbVfDCxI9KACwyNqRRc2/rDwwYootUrTvR
         JxrT57goADMyRdT5XsRdxg9hzW3MT+FTVie8g8v9ThUlQRcY/lpfj0yBYuqbOB9g8BsM
         eZkmwbiuva8Zh15SGDzfj4XUwpQYTmALrsCvTiI2MxJHgzdCJkDknUt99YJQPbwqvdXX
         ATVFv/2dj2zQibPyo9ziGWbQ+zCsKBrW7AxQ60+unQYz951y10/epDhF9V0B/OOeqYRG
         /V4paN3hqOJjwN5U05Yf9+WDW9OcS6f0q9RcXW/8Ag57f3MRONsIDPSCaQFkUahKWkUp
         5yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uv4WO+LIujL4IosazL39DsWMt3jbAP48f4X4caFggMM=;
        b=dHgTuzvyA2GGewrUtTHcVpwthmHBhH7q2HdD+I4183Zb7VB/De03jpXzyoXYb98999
         al6L4zwQiqppemEJmASgNjD7KwxumMQjhqydbpqPUvUvPDomuzSgZGnmc+fhCALMoZG3
         ckblqYDYcPgghHpTqxhsENc0dQ8WYTFlTmxi/NV8za2VRe3dH42Okmv1nmzmVml3RgbI
         j7KZTc1ehUA3oQYXv7cbcHZt+TA6Tq8yTzjIejXZ0hjkEe5oYAAKtILg+A5+cXJl7557
         SqH2FUo+0pfk9xFJ+rgKyi4Vxg9Wze/WXO2hUmDgU8bqchpFr/wo2PTFRXMfVGkLx5Yy
         bCTw==
X-Gm-Message-State: AHQUAuYTF1qKfg5o+a4phPlB/htkagNdvTcrSgvf8yhgzI/89vUmUiVS
        p+jPCJHLWCuTStGgn8P9i7VFohUl43TsAxqxcMs=
X-Google-Smtp-Source: AHgI3IakqI8srVXCwlsV8QJPBaUxgSQOeDXcX0V7FvhLBWardNg2YBV2EqXOrNoXa42b3vql92cBm6I8cy6HH/tP0Fg=
X-Received: by 2002:ab0:7191:: with SMTP id l17mr16018121uao.28.1550613908131;
 Tue, 19 Feb 2019 14:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
 <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com> <xmqqo9771tnj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9771tnj.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 19 Feb 2019 14:04:56 -0800
Message-ID: <CABPp-BERuEtdjHhqaao+2=rsLXiPdkG4SbeULQ6=59hgWS5BLg@mail.gmail.com>
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

On Tue, Feb 19, 2019 at 11:10 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I am getting the impression that to save typing, you would want to
> > make "--index --worktree" the default (i.e. among the above, only
> > --no-index and --no-worktree need to be spelled explicitly), but
> > there is one glitch.  Updating from the index must be spelled
> > explicitly with "--no-index --worktree".
>
> And after getting reminded by Elijah, the default pair is
> <--no-index, --worktree>.

Why would you want --no-index or --no-worktree as flags?  That seems
to presume a default of modifying both the index and the working tree,
as these names imply undoing pieces of such a default.

I'd rather have a flag like --worktree which alone only modifies the
working tree and is presumed to be the default (but useful to be
explicit or as mentioned later), have a flag for applying the changes
to the index instead (--index?), and treat applying to both the
working tree and the index as unusual and require either both flags
(--worktree --index ?) or some special flag that likely has a longer
name (--worktree-and-index?).

I _think_ Duy does the latter reading over his manpage that he linked
to, but maybe I'm just reading my own biases into it.
