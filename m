Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20411F453
	for <e@80x24.org>; Fri, 21 Sep 2018 05:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbeIULTf (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 07:19:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37728 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeIULTf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 07:19:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id n6-v6so642757qtl.4
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 22:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRCHVCAG0OM84cdkzXKjY15QOsxmz4pOfiFhNNgD+Ho=;
        b=slFwqBk44vkSmfGHc38f+7wVDW61g4WGMvnGQo2tZpmvdyBq9OIpe97UkqhLzN7QLF
         BSCOD6jsMwdCbDFMs1GX/6aK+r6MB1WIL0ZtfhB7n+pdrCM6+fnvurB7evuveJvmo90O
         8G+oVZRiJcGB6vIHJQXpqgVeehDSkfSoeMIKLycVmTBgOd3Ep/e9zpUNKrhZHykbC5U4
         +tRdRN/dwraKgRRmWgLD6FCc1lT0Is326q+V9B1R34BkJo1co6XUrAKqbJNzCP8lVzaE
         INLEpa/T55m331LhCWqi+tiJFzQRaOO/U3NNoI3rxTGQwA8TqBp25wz1Uya8T3GisSKh
         MW2g==
X-Gm-Message-State: APzg51DxYvnPWBHX9LsJA+ow3lIKbgsn9mNscv3QLlw7zETVO1GakOWd
        v5bSboxWnTF+VExV5r+D7vo/1stRe4fYi/5WjBM=
X-Google-Smtp-Source: ANB0VdZQpELGlLQx5nD56LWEtAQw4SGwUoXMn4mCxVioUjbPJkLRT1QD1/dTBBvRi/may++LYv1sCDAkm5ZaAz7sqIM=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr30884239qtc.50.1537507943154;
 Thu, 20 Sep 2018 22:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180919201231.609-1-frederik@ofb.net> <20180919201231.609-3-frederik@ofb.net>
 <xmqqo9ct2ivl.fsf@gitster-ct.c.googlers.com> <20180920162302.GB13379@duynguyen.home>
 <20180920174722.GH22921@ofb.net>
In-Reply-To: <20180920174722.GH22921@ofb.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Sep 2018 01:32:12 -0400
Message-ID: <CAPig+cQA5O_Zhe0wKzpppaQji997z2hfevnRMLW2nLRgce-YzQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] git-column.1: clarify initial description, provide examples
To:     Frederick Eaton <frederik@ofb.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 1:47 PM <frederik@ofb.net> wrote:
> On Thu, Sep 20, 2018 at 06:23:03PM +0200, Duy Nguyen wrote:
> > On Wed, Sep 19, 2018 at 03:59:58PM -0700, Junio C Hamano wrote:
> > > > @@ -23,7 +26,7 @@ OPTIONS
> > > >
> > > >  --mode=<mode>::
> > > >   Specify layout mode. See configuration variable column.ui for option
> > > > - syntax.
> > > > + syntax (in git-config(1)).
> >
> > I think we usually link to other commands with "linkgit", like
> > linkgit:git-config[1]
>
> Thank you, then do I edit the patch and resubmit as PATCH v2 with the
> message ID and all that?

Editing the patch directly is not recommended. More typical would be
to use "git rebase -i" and/or "git commit --amend" to make changes to
the commits themselves (that is, rewrite history), taking review
comments into account (and generally polishing the changes). Once the
edits are complete, re-generate the patches with git-format-patch and
re-send the entire series as v2 with git-send-email (or some people
skip git-format-patch and go directly to git-send-email to both format
and send the patches as one step).

You can use the -v option of git-format-patch to mark the series as v2.

When sending v2 via git-send-email, you can use the --in-reply-to
option with the message ID of the v1 cover letter to tie the re-roll
to the original. (The message ID of the v1 cover letter is
"20180919201231.609-1-frederik@ofb.net".)
