Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2995B1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 02:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeHEEpj (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 00:45:39 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37779 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeHEEpj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 00:45:39 -0400
Received: by mail-yw1-f66.google.com with SMTP id w76-v6so2424775ywg.4
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 19:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjPVeHsUL498e1KBvgdS4TE5LVg+XWeEF6825HUYHGw=;
        b=ngkT9tvMI0qdGl94K297zoo6qxWPq0E43Jmo5DaQKHeXdZONpOm1v6rIM8CdnIpk+i
         j7uZqULSbn2EKv4FCt7y8D+pNTN6XTLHIVQPDcwx0SdCqwGgN2Ds58OK3n2RA716Ku4a
         /2u562KhO5UKhF93rlXeYW9EcDo4rUQquP9XlRHyXhB7If/4yguYguhiOtyWH4uEkdW9
         bZGY5YvXCfv9rytg73V1QSQQeWzJHqaVvdPMG+2McMnoKtD0fJSokln/p3LTnnOLCdBD
         gzgnipem+s6PMMLxxtFquk/IMeSu57pFZfOqDc1iiLBaSjyYksFKV6rNqN/th8gn5JOg
         HqNg==
X-Gm-Message-State: AOUpUlFKg5Bi5Rk0aEMjBi09AAhSySjdIP8iEZwYPsqFl+toLdz8sm1H
        iJLYYvrz07Z15h1SQdvePcO7M+Wi98y7TaC7YFU=
X-Google-Smtp-Source: AAOMgpc4acRO6i8Mfy7dtAKrTRtJjzwjj8vr3jm7tERGsg0bzSmZx9Bs42V6tSWMaYp6ZV2HL8joO4vQTkTE1koZxxs=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr5356116ywk.418.1533436965773;
 Sat, 04 Aug 2018 19:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180804020009.224582-1-sbeller@google.com> <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com> <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
In-Reply-To: <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 4 Aug 2018 22:42:34 -0400
Message-ID: <CAPig+cRA87UZsynme-by+s2ZmQW2Aus9KQscCU9mXmALCBKkKQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 4, 2018 at 2:38 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Aug 4, 2018 at 8:11 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > My main concern is not about them but about other
> > people building from source in order to run (instead of to develop)
> > Git, and by extension, the people they go to for help when it doesn't
> > work.  I have lots of bitter experience of -Werror being a support
> > headache and leading to bad workarounds when someone upgrades their
> > compiler and the build starts failing due to a new warning it has
> > introduced.
>
> Even old compilers can also throw some silly, false positive warnings
> (which now turn into errors) because they are not as smart as new
> ones.

And, compilation warnings are not limited to old compilers. Even my
fully up-to-date FreeBSD 11.2 installation is not warning-free[1].

[1]: For instance:
utf8.c:486:28: warning: passing 'iconv_ibp *' (aka 'const char **') to parameter
      of type 'char **' discards qualifiers in nested pointer types
      [-Wincompatible-pointer-types-discards-qualifiers]
