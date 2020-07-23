Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF01C433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4FB207C4
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgGWXqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:46:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46113 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgGWXqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 19:46:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id r12so6669832wrj.13
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 16:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cl+0h15jJcaiBUXr9prMswzo1P5PU+0q8jl2cU1Ccx8=;
        b=f/h+EqDVIHyfLPainQMryOVfzMC2bsSwsQA9YAZP1NXgNqFy9sAjJe3v9AUw1nJdJ9
         J2GqV1wLO+n3I03UXwDUK/xAVrWzyLrr53/wJORxRdBQa6ntpU2kldJ0KMJk70uAVCV9
         V238zJ6Au/L0hp6K0v1Qrl6ddRuX7/YKbgXWH4oSca97BpmVFCWXcyN9tqy18EovXkDH
         yF2dUrRtVvB2kVNkoNOLcyUbXZD6PI/VAtmWRZ2gmCZPYqWNlUfM3be+h2hILLUN9y09
         fJer0vGJKws5wNp4qUnPeLsVKg2xxZHuFe6jer0gqwUvMfdXWZbPO0skyWOpT+twRVSq
         VHpQ==
X-Gm-Message-State: AOAM532kmy2mErI+0vlI6iKGdYLjLL4BJHH3zj6xTXiXvD30Ngw1z4mH
        07wgvkB2tRITzkJvRwJmqBrQxHkcxrQ0exc/sy9jLmNs
X-Google-Smtp-Source: ABdhPJwlsAsjRBOL3I/xRyK+EhNmOztKXrNYLm4dbalQ/YT8vJMaertG0CNzHMubM9OucjS/y0mYJiSgMk75tQLCoTQ=
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr5936860wrn.120.1595548012556;
 Thu, 23 Jul 2020 16:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
 <20200723010943.2329634-35-sandals@crustytoothpaste.net> <CAPig+cT36rhfMzOTH8L59cyoBKQQoF92nJ-Unccm+yf9RCgXMQ@mail.gmail.com>
 <20200723233815.GB1758454@crustytoothpaste.net>
In-Reply-To: <20200723233815.GB1758454@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Jul 2020 19:46:41 -0400
Message-ID: <CAPig+cQPfAD8Jcm2WC4XCE+tFqQsV5e0yAtN0_Txb5ro1Rhifg@mail.gmail.com>
Subject: Re: [PATCH v3 34/39] t: add test_oid option to select hash algorithm
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 7:39 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2020-07-23 at 04:51:32, Eric Sunshine wrote:
> > On Wed, Jul 22, 2020 at 9:11 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > +               --hash=*)
> > > +                       algo="${1#--hash=}" &&
> >
> > Bikeshedding: I wonder if this should be named "--algo"?
>
> We already have a use of this in t5515; I appear to have accidentally
> sent it in an earlier series.  I can, of course, change it, but I don't
> feel strongly that one or the other is better.  If you do feel strongly,
> or you think it's confusing, I'm happy to change it.

I don't feel strongly about it and wouldn't insist that it be changed.
