Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A75A1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 08:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeH3M6m (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 08:58:42 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37238 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeH3M6m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 08:58:42 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so8924836qtl.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 01:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQQDo8skKlyfTsYCE1D5rBDHgh4FYJ3TlOh5CUw+tWI=;
        b=PUPLlqGYhbAiraYcChwFORnLUh5S+rxHxr0VJTD/EnMGhLTAJgy1Rcxkhqo5ckRscS
         Gkjf/GsCOIwgmiZZ1pSfxVXTptfpeInazUFXBha0icVvWkPslqlbPA4vgn+gaLfDlAnH
         /xw++uC6Iocha/ID0KptQenMlnwuAUY8gDAis6dVtv1GwD6a1qETm+qh747Vxfo4F6Xj
         qX7OjmNNHvmfSZr6g51H/dAOf3N93eCyDsQkC051yj60+Ny/kQUs+7zUifgT3fpxPAaH
         VlhkJFRxWCRwlPb1k2k3kIPj5gOKnilL9I2Rir5oaHCSIHGlW/vm6zJNKuzXnQubOJ6x
         VqFA==
X-Gm-Message-State: APzg51CZQUiFfFZwoihWq/jrkJHudOTk9V8qPZiBU/8wSIZWFQcOYc/R
        8YsVPersqLaVc/yrhpAs4axBojgV/FRYk6mBmWY=
X-Google-Smtp-Source: ANB0VdYN+4RkudAuQn1P5h8Nbe/mQCDh3cg57ilmpqpDatV0MF1eX3cxTBjsKDmcrEFNORtMaGMjrRuAZZkV978odZQ=
X-Received: by 2002:aed:304b:: with SMTP id 69-v6mr10365030qte.220.1535619455936;
 Thu, 30 Aug 2018 01:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180828212026.21989-1-sunshine@sunshineco.com> <20180830075431.GF11944@sigill.intra.peff.net>
In-Reply-To: <20180830075431.GF11944@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 04:57:23 -0400
Message-ID: <CAPig+cQ1a7eND5dOK7AKffBoQyNYHCgeqr9wkhB0dch4iAn4iw@mail.gmail.com>
Subject: Re: [PATCH 0/9] worktree: fix bugs and broaden --force applicability
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 3:54 AM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 28, 2018 at 05:20:17PM -0400, Eric Sunshine wrote:
> > This series started as a fix for a bug reported by Peff[1] in which the
> > "database" of worktrees could be corrupted (or at least become
> > internally inconsistent) by having multiple worktree entries associated
> > with the same path.
>
> Thanks for working on this. I think this nicely solves the problem I was
> having.  I had a few minor comments which I sent in reply to individual
> patches, but overall it looks very good. I'd be happy to see it picked
> up with or without any changes based on my comments.

Thanks for the review comments. Hopefully, the series can land as-is
without a re-roll.

It would be nice to find a better way to format the hint attached to
the fatal message, but that can always be tweaked with a follow-on
patch if I don't have to re-roll for some other reason.
