Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BC9C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 08:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD3760D07
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 08:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhFWIXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 04:23:50 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]:39576 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhFWIXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 04:23:48 -0400
Received: by mail-qv1-f52.google.com with SMTP id c2so979200qvs.6
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 01:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rr0qOI/YnRb9C4G7MItj6XNTuOUZ2GV8eIP7tf51CUU=;
        b=Gs7AXlqwUh6UG6TyMDhT+r6QRfTk1+eILHMXrxdm8X1OwMnWN183XN0bteiybqMo/N
         ip+Okxpbk0Y7MaBCTyawX1i6cSFHUKP1zfozFt8nixcxcGxJycElJVWy2AzQf+FfJT6D
         BC0YYzHRumScqXeMGyzDCPk32psNyOrg3mzOFgPkJzLM4tyvBqwfMoPnI8i375gKssOD
         IIMKR9uVW1l6SNlH7Gf7LXupwkd8kxNgoCHAyy959onI0DbAZUA0SPXtYXcf6P/UJmxk
         iUXD6mZ+KUew2L4TJAIFpR3wDUIYiIYFBtXo0eVQkBm8Pon6l5cGoz9lyvWLIzE9jydp
         Srww==
X-Gm-Message-State: AOAM531UvvKcT2h2Sal0K58Zz+XfM8wN9W7ZJgzCSIFL06hVtpRefgH3
        uJKn/7WBYl/r+zUa/dZ4hezzX6mJdbrD4g==
X-Google-Smtp-Source: ABdhPJxNnmvGOzBHxP1SfrBTHXSAu+zm1M88k6x+q8GdtZsOqcC6BXfFrw7NrILWXtJuPJgz4YtC2g==
X-Received: by 2002:a0c:e644:: with SMTP id c4mr3332055qvn.33.1624436490268;
        Wed, 23 Jun 2021 01:21:30 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id d20sm3343802qtw.92.2021.06.23.01.21.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 01:21:30 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id q64so3076273qke.7
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 01:21:29 -0700 (PDT)
X-Received: by 2002:a37:8bc7:: with SMTP id n190mr8689187qkd.113.1624436489747;
 Wed, 23 Jun 2021 01:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
 <2c2cfbc6-c428-772e-6ccf-66261cf0e331@gmail.com>
In-Reply-To: <2c2cfbc6-c428-772e-6ccf-66261cf0e331@gmail.com>
From:   Avishay Matayev <me@avishay.dev>
Date:   Wed, 23 Jun 2021 11:21:18 +0300
X-Gmail-Original-Message-ID: <CAJ-0OsyXuNoG04j6rPioMuegp2jtJT4gHE-m_9seQUix5Z3_LQ@mail.gmail.com>
Message-ID: <CAJ-0OsyXuNoG04j6rPioMuegp2jtJT4gHE-m_9seQUix5Z3_LQ@mail.gmail.com>
Subject: Re: Why empty subject? (was Re: )
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 23 Jun 2021, 11:13 am Bagas Sanjaya, <bagasdotme@gmail.com> wrote:
>
> Hi,
>
> On 23/06/21 05.40, Avishay Matayev wrote:
> > P.S. I am a complete newbie in regards to mailing lists etiquette,
> > pardon me if I've done anything incorrect
> > P.P.S. I CC'd Junio C Hamano because he signed off on (almost?) all
> > changes to `pager.c`, sorry if that was wrong of me (You probably got
> > this mail twice because of a misconfiguration, oops)
>
> Why did you send the thread with empty subject?
>
> --
> An old man doll... just what I always wanted! - Clara

Oh, my bad.

It was "Forcing git to use a pager without a tty" and I sent it with
my initial mail that got rejected because I didn't send it as plain
text. I copied the mail and fixed it but forgot to reuse the subject,
oops!

I'll change the subject in the other reply, sorry about that.

Avishay
