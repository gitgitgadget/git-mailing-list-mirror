Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951A520136
	for <e@80x24.org>; Fri, 17 Feb 2017 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934084AbdBQRiT (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 12:38:19 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33008 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934066AbdBQRiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 12:38:18 -0500
Received: by mail-oi0-f66.google.com with SMTP id s131so2322337oie.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FL7KdJYYjBn6ugG1N5a1NdiBYkXXW9Uu39J2egke8QU=;
        b=My4HCHTu83279A6H0qL4fMoK6CxCAZzSN4fCT/5pWnw8VeXcJohQ4jCvmYCboYN87A
         C5kj1pCGYKSMRI6x6yQ5rY3U4UYzzNBoCF4/iEAyDYKAJqsgocXxafQqMV3oYlGK/6qM
         Ac7oP7q61qSW5psA4026dFCDEgf5DXuaL3yEzanMMmkAmDD6dQL4mJv3WkAqEEZ1boZJ
         RPFCuTDc4+9HARmhEnkPEppaBOxw4vF7sDgIincLABWCo5V8GrGcRXUm2rxo2QOnLgIw
         Ti+KjY6txUj3Y/C4T3OaU5pN40yhoq490OJcZy3/o3GT8cPBFENa+7DoNRUgoKvUo1pW
         TGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FL7KdJYYjBn6ugG1N5a1NdiBYkXXW9Uu39J2egke8QU=;
        b=nJl/cL2xxuqwI7vJi0Nj3TEYKpUXlsCgk7qSLwJr9lpCNVRZbqCboXQ/L+O98TR+lS
         2YDmdcDCRZ5vJhfCCHGXcQtP4mtXB2YCFx70PJTiPvR7xA/U5NfI17shSa7p7yIvWTgh
         Y5KDjfSxpHvAaIm9eT6ufsvp2bOsT/hsd54NA0BwuY2RHy0RHoJMcR8kjJZvkVaggrMC
         tJHGVzxDd0sPgk/xcihbK6AMju8ys9QC4CTkc4+8C+4QWmIu0gxrAhAlrmyAZ/qatqBG
         1fwwPK2miPFydQguujvm71afMqoNJH/iXuuo9KsQ+nIpYnWYew2/RVJrMsddTEj7ym4n
         ATGQ==
X-Gm-Message-State: AMke39kGcrtVeLf0LfCQkjGvGKZ60X5RJ67KlqVmxwGSLvc1tz8XCDWajjywOEjuCwM1+5VkMvUndWEGnKtAXQ==
X-Received: by 10.202.197.135 with SMTP id v129mr4310382oif.131.1487353097663;
 Fri, 17 Feb 2017 09:38:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Fri, 17 Feb 2017 09:38:17 -0800 (PST)
In-Reply-To: <vpq7f4pdkjp.fsf@anie.imag.fr>
References: <20170216174924.GB2625@localhost> <vpqlgt6hug6.fsf@anie.imag.fr>
 <20170217110642.GD2625@localhost> <vpq7f4pdkjp.fsf@anie.imag.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Feb 2017 09:38:17 -0800
X-Google-Sender-Auth: q38GPByaYYW18V87uEdZ2zhj_2M
Message-ID: <CA+55aFxPsRXKn=4jXUdPy1hh3iHagjoxMcpA5K-ENA-NtdnF-A@mail.gmail.com>
Subject: Re: body-CC-comment regression
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Johan Hovold <johan@kernel.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 5:16 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> I mostly agree for the SoB, but why should a Cc tag have only one email?

Because changing that clearly broke real and useful behavior.

The "multiple email addresses"  thing is bogus and wrong. Just don't do it.

How would you even parse it sanely? Are the Cc: lines now
SMTP-compliant with the whole escaping and all the usual "next line"
rules?

For example, in email, the rule for "next line" is that if you're in a
header block, and it starts with whitespace, then it's a continuation
of the last line.

That's *not* how Cc: lines work in commit messages. They are all
individual lines, and we have lots of tools (mainly just scripts with
grepping) that simply depend on it.

So this notion that the bottom of the commit message is some email
header crap is WRONG.

Stop it. It caused bugs. It's wrong. Don't do it.

               Linus
