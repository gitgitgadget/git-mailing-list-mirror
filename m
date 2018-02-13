Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCA01F404
	for <e@80x24.org>; Tue, 13 Feb 2018 12:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964842AbeBMM72 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 07:59:28 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:40421 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964803AbeBMM7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 07:59:23 -0500
Received: by mail-it0-f42.google.com with SMTP id v186so5480558itc.5
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 04:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ItukO+QZSBRQsUWjeumElQJ2AZnnY8gV8kDVIQOqcNc=;
        b=adIBBEP6HqKmuQWLN92O4YyMBTohJBa66eIX+twmSrAtnZ0V8e1LZhSW3+eh539ujX
         Vt+U8T/VMZUpsBUi4mtKCX3fuO/6UdPRX5GDR05OMvQfC5iW/LydHWGnpLm6TxfXbp9I
         xLzI9WlsgYYjdfQiDw8zAKB+IjPig+2656CoI3BgL9/DWMR70WnfTH8ueiPziHVInwvm
         Gf3rWHlWJXbwuov9zRWaxfNiyuu5aJ/P1Z9HF2hDfTgFp+r5XorAItmeIgnf+RD5/oFn
         mKmPnU8RptUP56kcwyXppOo49B3Iow3GFIDEjhFAAVcqDjFewObiRRxqKf8fQsm95onL
         i4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ItukO+QZSBRQsUWjeumElQJ2AZnnY8gV8kDVIQOqcNc=;
        b=gOQsi8QXQDiLFFHr5aKvG59DNUSP9JmIXl3RZ+ngLkWqQgXoFQLxtFhPCKTdVMGJrK
         HaHwWt25wEAsWwAL/zXmC6UgD1RzPPNtP/+wnER1BVvR6YrL1rO4cmZNoikISSJR1mWj
         zatmP8G2qBG76rL52GtdRWtJuvHZuURxjOJOPK2WZgQrStyLReAxoyf3TL6AyG3jpoJe
         VeLySXXKtY5rmnVMhyengGQCF7UGLRqbCGAXCcD+vsXNF3ilQe7Ryb+4f6ssmmQF4kSc
         O5NzjkxkiRXAvT5dLX+yY3QglIfuH6Qf8QpdT+Jho1V+b1yRYtdFV169jK31ug8w74Ko
         s4DQ==
X-Gm-Message-State: APf1xPCuHNPNIvrorxWnLFiERwmFMU28FFDehtAn9BWpJntibVT9+sMT
        XWzoSFjxfJCMq8L4j7yBq0pB0Iq7xpW3FbRsr4qjkPYz
X-Google-Smtp-Source: AH8x227syowBnBPCPVeYand1MqV9a+bjuBSmD/dFhr8/U4BScxc5nEtEq+DTcy/TTZvLun6Z6SJ9IKqaDaWxwPW0qKk=
X-Received: by 10.36.192.131 with SMTP id u125mr1381702itf.119.1518526762769;
 Tue, 13 Feb 2018 04:59:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.150.155 with HTTP; Tue, 13 Feb 2018 04:59:22 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802130712260.15482@localhost.localdomain>
References: <alpine.LFD.2.21.1802091431360.10982@localhost.localdomain>
 <xmqqo9kyvthx.fsf@gitster-ct.c.googlers.com> <alpine.LFD.2.21.1802120522580.17810@localhost.localdomain>
 <CAP8UFD03TDGBU3t3+m2OmhyJt6sNcPhMZ2ejzufX3x-_1EEDHA@mail.gmail.com> <alpine.LFD.2.21.1802130712260.15482@localhost.localdomain>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 13 Feb 2018 13:59:22 +0100
Message-ID: <CAP8UFD0hRS_VFpHT-S=Sn7mr4pE+FseUm9nTVEOvLBF-dG9FPA@mail.gmail.com>
Subject: Re: totally confused as to what "git bisect skip" is supposed to do
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 1:28 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> p.s. i suspect i should RTFS to see exactly how git bisect does its
> work.

You might want to read https://git-scm.com/docs/git-bisect-lk2009.html
before reading the source code.
