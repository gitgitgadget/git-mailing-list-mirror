Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20262022A
	for <e@80x24.org>; Sat, 29 Oct 2016 17:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756678AbcJ2RHD (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 13:07:03 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36382 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753538AbcJ2RHB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 13:07:01 -0400
Received: by mail-oi0-f43.google.com with SMTP id v84so3138367oie.3
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XrJQg+5Bfi8RBIeY2MQGhkZrrqNlNJxSwfpPWoHmCMk=;
        b=SRhwwnV9Nz7kgboguaTf6YhnqepkTMB9GxebQQt87M2S2cXAD4l9viyC0fC1LHK0Cj
         qY8Agmq+C/VaogdX6wa09X3F4cK8+NonZ1vaJR+113kGpBGRaDPYOQ1RTAsQlcyk0EZu
         4sdxi6w6fzoEH5PER7uRmVrS69rMiBqxQMqfJsrqr6k/HBt2E0ajSQ6UJGdADONGpVik
         VsmJv377Az96DvHuB7WgFbgMDTto4lvjcCM21YWmEqiPxHTFeixZOqbIhcDM1Wjp90rM
         7lMKXApqni6GYlfVh4MKrysFcVAzSb99qsH+4jJ3Jx1WoLF3OsM7g+YzfWT2XL1vprwl
         hhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XrJQg+5Bfi8RBIeY2MQGhkZrrqNlNJxSwfpPWoHmCMk=;
        b=lnJcHdN7U/aJxbGog9DBDGnoR/QLGcZIV/4UYz4XhAIAqf9fD0JhWIh4byWgORIyPT
         vg0tF2GGPtPDyeFTZuCSqDNyo7SE5nW9xHMtdZniAskpfnp8An3mJnr25UhmKE8NKGji
         nNpYvePW+lfQ3FK7ke/kR1e2cREfjA0ZAKRKzGJEEDmjVRKfibXGepME1BUGSvUFkPXJ
         HLFAlcDOME5rGWBul5DHhedUamTtHM5KQ70p07Ph1mOl9rwWzCFt+9xizbW8Qsq8DUwl
         QcaCV9TAoqZ0yDkem+jJb1UugPido5vCWAMO9HDvG24WvXZ2LFjukuWUZtDwRhUZ3yYY
         aDxg==
X-Gm-Message-State: ABUngveZ4L6vDPYki1t4hdB1HChgoxKrHg6Vm5VYYRvR1wlQgrFxe3otcA08uFeaYBfp8ueS7KF5pjH0tG7oLg==
X-Received: by 10.157.39.2 with SMTP id r2mr15553725ota.103.1477760820891;
 Sat, 29 Oct 2016 10:07:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.142.104 with HTTP; Sat, 29 Oct 2016 10:06:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610291022120.3264@virtualbox>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
 <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net> <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
 <xmqqoa254czs.fsf@gitster.mtv.corp.google.com> <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
 <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
 <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com> <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
 <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com> <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610281306320.3264@virtualbox> <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
 <xmqqshrg1ksv.fsf@gitster.mtv.corp.google.com> <CA+55aFwUEzfvWVSZfhBi85QaKWSo-gVMOk1BJFrR0ZsdCRHRsg@mail.gmail.com>
 <xmqqr370vtba.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610291022120.3264@virtualbox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Oct 2016 10:06:59 -0700
X-Google-Sender-Auth: bMke4KgAhhZy_HNjEytC6WDc-MY
Message-ID: <CA+55aFxsjiuR8cp9SiPS88OnzmCiNN3B-gybz1CS71avsU8OOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2016 at 1:25 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Correct. We cannot change an open file handle's state ("FD_CLOEXEC") on
> Windows, but we can ask open() to open said file handle with the correct
> flag ("O_CLOEXEC", which is mapped to O_NOINHERIT on Windows.

Ok. So then I have no issues with it, and let's use O_CLOEXEC if it
exists and fcntl(FD_CLOEXEC) if O_CLOEXEC doesn't exist.

              Linus
