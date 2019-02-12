Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D301F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfBLBR4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:17:56 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:44606 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfBLBRz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 20:17:55 -0500
Received: by mail-qt1-f182.google.com with SMTP id n32so1072826qte.11
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 17:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CViVh+vGbnbwFYmAejMyRfiVpl982Q7Nayf/RnoqZIg=;
        b=O6HTuLcRRW66r6CE8Df3pNTqJvaBzIItJoGjaNSe0oxtRy9AJ+GhP9EFiTTrGAZKBu
         UqWejxP5rkq55PrNaeB9pw+zmqTZXkLqdZN4/sJ3YrKFkqRqJMJiOiPUkZtpfEdLCKNo
         7XwKcpiez6HCQmNMas4U4Zl2q2uystqrAmZ+NTGeZkkAuvk2pboLaHux1+vFt0eTynbp
         K5PzsZG6uF/djcGCw1oc7MDPdGq2CRFAuJhutpgc+vuu5fv2RNtPC9ux1oL7SGp5cUKq
         3gG+AvOPojoGH/D+j3Di/dos2TwXytAfgmaF+vIMyeuxmdTrEh5aiiYC0kAqlwGp2yNf
         B8rg==
X-Gm-Message-State: AHQUAuYeZ17peJ6F4tb/eDdIcU/MNzpqCSUThIEzSeIr8dRC3IxqfN+d
        dVaHAPf0+AXOq8BqODsx+8Vpci8yrNvAFsxbWKE=
X-Google-Smtp-Source: AHgI3IZElqiLwk3fcxxl0p6+e7GNHBsxDqXZ2JhW2z0xnCx7E0epIbrX5UM0EIyvsKr58l+ZzlY8NR1vRa7xDdQ7QFA=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr895000qti.184.1549934275089;
 Mon, 11 Feb 2019 17:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
 <20190209185930.5256-2-randall.s.becker@rogers.com> <CAPig+cRARdkKN-wR4EzVSzxuK51VOPf-kFFG57kkEsnFBfe4TA@mail.gmail.com>
 <20190212003735.GH13301@sigill.intra.peff.net>
In-Reply-To: <20190212003735.GH13301@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Feb 2019 20:17:43 -0500
Message-ID: <CAPig+cQwh8RxVLgbBXR2WtE+k-aFAWnr12nBcTPzccQp_gdEZw@mail.gmail.com>
Subject: Re: [Patch v1 1/3] test-lib-functions.sh: add generate_zero_bytes function
To:     Jeff King <peff@peff.net>
Cc:     randall.s.becker@rogers.com, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 7:37 PM Jeff King <peff@peff.net> wrote:
> On Sat, Feb 09, 2019 at 09:05:04PM -0500, Eric Sunshine wrote:
> > On Sat, Feb 9, 2019 at 1:59 PM <randall.s.becker@rogers.com> wrote:
> > > +generate_zero_bytes () {
> > > +       perl -e 'if ($ARGV[0] == "infinity") {
> >
> > s/perl/"$PERL_PATH"/
>
> This shouldn't be necessary. perl() is a function that uses $PERL_PATH
> (so you only need $PERL_PATH when you're writing out another script that
> doesn't run in the same process space as the rest of the test code).

Thanks for clarifying. I either didn't know or forgot about that.
