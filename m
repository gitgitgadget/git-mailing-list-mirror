Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297191F404
	for <e@80x24.org>; Tue,  4 Sep 2018 16:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIDUtO (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 16:49:14 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:37640 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 16:49:14 -0400
Received: by mail-io0-f173.google.com with SMTP id v14-v6so3498612iob.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHyq+v/FmAiTCdntGg+ZrOo5WI95jQZ4O5kmbd03spk=;
        b=gR9+SaOWgXMPYVGtstL6CINsVyYf/wd6D/eJTyrxyYKhaUVtT/BFSArKN1F9hxLAGf
         2lB9hNIj6UO8fAs9/Rm7kGWptzulwV9IdKWu8fU4tQeP77GjZu1s4gKUV8LtopwvWAok
         +pUWUMG3wa78tIZOJqS3h9KTZsX9faH7Wx5rJneH+fUC57E65MznQoiI6X95XPaFa0HW
         3P8VM0Llrik54o5TTnCVvr0m6tpJqUp21v0e4rb+pvDPoR/98esvD4+wqu4RhlFCfO61
         GJlIMy235yFymJ5aYEB6pQwk1l02GTNwgjH7S85m0KnCR8dsOI0zoUah+m7V2VeykeHo
         8yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHyq+v/FmAiTCdntGg+ZrOo5WI95jQZ4O5kmbd03spk=;
        b=FS9YQMHVZ+mkBu0g3smTWW+eO7+Nt6E4EcoZTdPu6rVD/MHPucTvIS0hNwe2LaVc+3
         1MMCmVHuCklhXJDEMhhYRiCxN1gN7UKUVqlhE5NfYRnhroCskAT/jUEC7B4+OXXAp/kN
         eteMLAcHVRSK0fAj/xAkWHNtPRjJrT/7rHwk6bs1TXBBn9u1Ajm3hPgje0SPrHVvfzpG
         cQIEmK1niVcScCDfJ0uG/cWLzyZaKnzPCVHHHTVZtxpA4JOkr+rU/S9KLWGgyajOIhIY
         19M0kOFCEaycbM0jPgnikvvWjMfdDXuPKoZ/I0/oikvBGxpMW/pcNwNrVoudUb5tGQgF
         yfjQ==
X-Gm-Message-State: APzg51CdVDd3VxUiTvADIb0Gfm4I8YDD3liYupcIohceBNUC9U6RN8O5
        9lp7duAmcVSRcSviHGAEs7aR5UgXl1jZNdxqhIE=
X-Google-Smtp-Source: ANB0Vdb6smOJHQ0scfhnaC8WvGtKmbJJTaszb/p2mwsYEP01c7BNu8LFK3QywvtL6F3g8YLC9QcqoQGY6sMIOvSHyo8=
X-Received: by 2002:a6b:294b:: with SMTP id p72-v6mr21766664iop.17.1536078203948;
 Tue, 04 Sep 2018 09:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180903232515.336397-1-sandals@crustytoothpaste.net>
In-Reply-To: <20180903232515.336397-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Sep 2018 18:22:58 +0200
Message-ID: <CACsJy8Ak3Gba-z09Gz8iFrRyXoLbR+jW0tGuPnwCLpxVZWfMtw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Hash-independent tests (part 3)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 1:26 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This is the next in the series of improvements to make tests
> hash-independent.

If it helps, I looked over the series and didn't find anything questionable.
-- 
Duy
