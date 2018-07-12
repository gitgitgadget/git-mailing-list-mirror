Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442DD1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 13:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbeGLNlB (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 09:41:01 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37686 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGLNlA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 09:41:00 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8-v6so24266215lfb.4
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rwxo3SHyLKktDUvfAre2soN6fybVBGw5Q4UcNv4t8Ow=;
        b=Bj8qf0JJzrXVW+VhMR3uyWTivrkYKkKklOBZA80lpWeveky4fY4lhXLuCGmqIR/A8p
         aGIAxiPNyPhqv7vW7heRKtook6+njYeVJo9DyQi+SRDw2pTAh1QMpkuvrJWt22/vaXOA
         ak8j4L6+RsTOrr/xFtt/vCovvWb4J9wJp0My/ApEe4Yv6915cWghMzqVB27lahAq1KM3
         jHTJ7xgc6YCpA8hO2MGvNM9k8YPo2TT3khaG3CKwkq63powgNfQ9VsNUHK6TESSwKJCP
         y6ig2Cd01mqLEZzLjj9OEzwSonHRag4FTZxavvPfw0CPgJQlHve9HOT8n3cP/ugtyQDG
         QWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rwxo3SHyLKktDUvfAre2soN6fybVBGw5Q4UcNv4t8Ow=;
        b=hTFP0q/6z4Tpocm5s7fpimfXq3hb8NR9C/HXBeSucXX3ZUvaXjkhE+trfyGHfMgTmz
         /IrLO32nUd+3ZPY1jU4zwmPuJsZTrH2s/PFKjHwb8v6+rxuEevW48LleciGX27r1x8mt
         ltBqAKUOenLbbZ2EWe0Mre8jwKlONL3p1wzICIl2wSkL85fCypQm8EqU8Q8TWcm7kG9Z
         8MKQXRlCofmTe4nPjeDYYR6pGj6vx8F1KMH2SYjK7NMlV02AXj1/CM5qRCEWEST5+CW6
         XDnuiVhyJDWdkniyBnpHj18bUFpJ5vnHFKNyp4mfY2NyxIaxEt5zHUI7qCds0T2VNK6f
         Wtlg==
X-Gm-Message-State: AOUpUlF3O+r7eKqAo1ndrw4tCObpqcF6bLPVdWyFCHveOMPvWBcy8Abs
        tBy5PDIMNCm0tfdjaM+ATilN+kbG4WCZRCCAG8cQYw==
X-Google-Smtp-Source: AAOMgpe3m5glKcF22s7A7cSKBwj7F3ILSNNWSJXAcGsQQw0Gn69tbaZCUZdJ0bk9gXAeC9/vrUyXS+DtZk+ZEJAMY2E=
X-Received: by 2002:a19:10c4:: with SMTP id 65-v6mr2050443lfq.113.1531402284956;
 Thu, 12 Jul 2018 06:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-17-dstolee@microsoft.com> <20180711094858.3230-1-szeder.dev@gmail.com>
 <dd2f774d-a217-0273-efbe-d133ae23c5bc@gmail.com>
In-Reply-To: <dd2f774d-a217-0273-efbe-d133ae23c5bc@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 12 Jul 2018 15:31:13 +0200
Message-ID: <CAM0VKjkuC5Qc6HtQZP4dpHE4CcCvNkg1D8_AFw7+PQDU6bU5Wg@mail.gmail.com>
Subject: Re: [PATCH v3 16/24] config: create core.multiPackIndex setting
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 3:01 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/11/2018 5:48 AM, SZEDER G=C3=A1bor wrote:
> >> diff --git a/Documentation/config.txt b/Documentation/config.txt
> >> index ab641bf5a9..ab895ebb32 100644
> >> --- a/Documentation/config.txt
> >> +++ b/Documentation/config.txt
> >> @@ -908,6 +908,10 @@ core.commitGraph::
> >>      Enable git commit graph feature. Allows reading from the
> >>      commit-graph file.
> >>
> >> +core.multiPackIndex::
> >> +    Use the multi-pack-index file to track multiple packfiles using a
> >> +    single index. See linkgit:technical/multi-pack-index[1].
> > The 'linkgit' macro should be used to create links to other man pages,
> > but 'technical/multi-pack-index' is not a man page and this causes
> > 'make check-docs' to complain:
> >
> >        LINT lint-docs
> >    ./config.txt:929: nongit link: technical/multi-pack-index[1]
> >    Makefile:456: recipe for target 'lint-docs' failed
> >    make[1]: *** [lint-docs] Error 1
> >
> Thanks for this point. It seems to work using
> "link:technical/multi-pack-index[1]", which is what I'll use in the next
> version.

It doesn't work, it merely works around the build failure.

The generated man page looks like this:

  core.multiPackIndex
      Use the multi-pack-index file to track multiple packfiles using a
      single index. See 1[1].

And the resulting html page looks similar:

  core.multiPackIndex

      Use the multi-pack-index file to track multiple packfiles using a
      single index. See 1.

where that "1" is a link pointing to the non-existing URL
file:///home/me/src/git/Documentation/technical/multi-pack-index
