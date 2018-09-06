Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDAA01F404
	for <e@80x24.org>; Thu,  6 Sep 2018 20:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeIGAld (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 20:41:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40439 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbeIGAld (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 20:41:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id j62-v6so9876506edd.7
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1O2i9KczsZbltwlzDgSarozhaCMONjOyEFYrHe8xj0=;
        b=Sa5ZuMF+VeFFYtk0M7BbadOw5U2oRLZCs0i4Yo1vhul2n9DcWD2V7f739RRR4Oy/Fj
         zKuqZRE7egIESXVVftjVthrMtqpnCmdRR/BikzTqryyr5KAXvaTh84VoKcr4nCPhpduK
         a3Yhx4xOg5aVD171hnvu8qB73gqFPETtNDANtRxfB4CqBx2t8bnjZYpDzMXagv/w2tjW
         uxIMRpXjQhHRXIw5Pf2yIm92U6LOGl/ue6u00i9J/gv1RRHOpoXdy5XgPfkIE1SegHGX
         +47GODAyoNx65/pzAT7KXqpmuSjC18pLkPKP4Jwsicc/u6qUzZFW3qymA9ZneSTmbTWt
         kh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1O2i9KczsZbltwlzDgSarozhaCMONjOyEFYrHe8xj0=;
        b=GYZkpL7kT6xsC7SGqqVHandwbpBv4DdFzZ9Ale1RmnoyG9c+o81j7xHP4+3Q/FL8y1
         10EWRP4mEREVrHL89d1VQwejEaGaq0g/Fx7+JFAHPQqSsfJL0jWLc04U4cDt4WZtnQe2
         pd3noiMZ3N5goGl20x0fn/35QXjdFzh+NsosLKTz3u7q+60mwHfWHRFxoi5s2dfK5AmY
         XikzW/s0+5M8raCUDJJ9En9KwwGGcDMZY7mCnJeEd8P3cvkwy/uClBkwvhQUwCz9QeNx
         STiOon9LMcFWHV3geTOD7DdgJamIHI9czBZ2mNIlh/gyUS2tWTv+QcHJCTpvXakplrzy
         gu2w==
X-Gm-Message-State: APzg51CGEjGGDrWEOke5r4ct+P8Z6JeA1Mc8XSQIBJS2bFPB8b7oYj0U
        uxzsTko7Dv9nQ2KtB6yHis6SXJr8Wn2wN+KbMchI1w==
X-Google-Smtp-Source: ANB0Vdb5/3066cyAoVxZVLK5jg720REwAmvJxc188SQdYiTyY/yKYVaA1r7Y1U6sDQ2M9PO0YrRvc9v46AhXyav26wg=
X-Received: by 2002:a50:90c5:: with SMTP id d5-v6mr5154678eda.76.1536264269107;
 Thu, 06 Sep 2018 13:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180906191203.GA26184@sigill.intra.peff.net>
In-Reply-To: <20180906191203.GA26184@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Sep 2018 13:04:18 -0700
Message-ID: <CAGZ79kbi=Ppkt4tYx+G_RDwp7e3+SU-LofZ-QzMsO2=zEPucsA@mail.gmail.com>
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, timschumi@gmx.de,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 12:12 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 06, 2018 at 10:59:42AM -0400, Jeff King wrote:
>
> > > +           string_list_append(&cmd_list, *argv[0]);
> >
> > This will create an unsorted list. You'd have to use
> > string_list_insert() here for a sorted list, or
> > unsorted_string_list_has_string() in the earlier call.
> >
> > It's unfortunate that string_list makes this so easy to get wrong.
>
> This is getting really off-topic (since it sounds like we'd probably
> want to use an ordered list here), but is it crazy to think that
> basically every use of an ordered string list could just be a hashmap?

Does a hashmap guarantee an order?
I thought we had an example of an ordered list in the submodule code
but could not find it, maybe it is gone already or did not rely on the order
as I thought.

It turns out we make never use of a custom compare function in
the stringlist, which helps gaining confidence this use case is nowhere
to be found in the code.

> And then the sometimes-sorted/sometimes-not duality of string-list could
> go away?

Sounds good, ship it. :-)

Stefan
