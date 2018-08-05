Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB53208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 04:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbeHEHB7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 03:01:59 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34334 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeHEHB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 03:01:59 -0400
Received: by mail-yb0-f194.google.com with SMTP id e9-v6so4150658ybq.1
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 21:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3S4Urs2mQSo/mk8YSRvVD3bCihacsmT1/A5jCN+m/zA=;
        b=GgkEzzGOsBG193byPmUsAKpAtMzWGWYJ+O4tLaWVXzXaERAKZwGTV+T1sKfgSHmKEd
         LJwGpNrPU+mXspC4uHHKj3Wm4D4NgCdT2z2wTq0LuxmPWniRYYRKiuBBXUKKZEnzRGNk
         yqV7kGheq95dzFKsW2sXNfrBr/NMJ+6YWY7mM+fmdQZsBeD2kXe8A0PaXCEYGBCtbgR5
         wlzwpjsLV/7hFNA0dUuVeaHOWa9Wztv6NYV2r/3ex54XlfiO3YANyrm71iRExfz9PeUf
         phJQoFH5IyOk7k2MGaHRel1C1zYumTnaSCxowdli8RKa4uG5ziPSu6IMg2MzXkWOhxWX
         FNnA==
X-Gm-Message-State: AOUpUlGwF6tHJ9ip3rGkjVAVySDwUDCPDjDUJOUYQg2AWVOFtHKyDczS
        r0p5jepkwJIevfq+nPwrL1igZ0di36ZPI2kmYvY=
X-Google-Smtp-Source: AAOMgpeJjv4o/t4v6bBUrgmt2qK2erdvLWgAXdoAtGxK0WDU7v4W957/ESLrQ0Q37ap4r356lOGxGgEgSZYG8IuI7ww=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr5182511ybp.76.1533445124686;
 Sat, 04 Aug 2018 21:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180804020009.224582-1-sbeller@google.com> <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com> <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
 <CAPig+cRA87UZsynme-by+s2ZmQW2Aus9KQscCU9mXmALCBKkKQ@mail.gmail.com>
 <20180805031709.GF258270@aiede.svl.corp.google.com> <CAPig+cRjxLgGZbROZAuH-VF3xLVUxQTRj7gKPFurypbwz2zzjg@mail.gmail.com>
In-Reply-To: <CAPig+cRjxLgGZbROZAuH-VF3xLVUxQTRj7gKPFurypbwz2zzjg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Aug 2018 00:58:32 -0400
Message-ID: <CAPig+cTEGtsmUyoYsKEx+erMsXKm5=c6TJuNAgeky2pcgw18JQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 4, 2018 at 11:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 4, 2018 at 11:17 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > So it looks like FreeBSD has modernized and we need to make that
> > conditional in config.mak.uname on $(uname_R).  Do you know which
> > version of FreeBSD changed the signature?  Care to write a patch?
>
> I'm not very familiar with FreeBSD-land, but I would
> hope there would be an easier way to determine when it changed than by
> installing old versions. Does FreeBSD have historic package
> repositories (containing headers, for instance) which one could
> consult instead?

I thought perhaps we could figure out the timeframe by looking at the
Git package[1] in the FreeBSD ports tree to see when they added,
removed, or changed a patch file for config.mak.uname, but that didn't
pan out since they invoke the Git 'configure' script which determines
OLD_ICONV automatically.

[1]: https://github.com/freebsd/freebsd-ports/tree/master/devel/git
