Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670A1202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 16:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbdGMQcd (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 12:32:33 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35238 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdGMQcc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 12:32:32 -0400
Received: by mail-it0-f52.google.com with SMTP id v202so44154235itb.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t3DowLBUbVDLfqwm503SC828t0hf+EmNNlrIXo3LUS8=;
        b=Ac+QnnJeLBXUc9p8bv/xG6UlHU/3lRN3GPGbU+2U1fvSzc+L4OD1wcnRjuxLSC49Qw
         osvP5pCjiru9jZH2kCLaWUh2tr2yI7ZLRvYDKulKzbE5PwiiOhOlpeMxA1kOY8dVQNx8
         UiedJnup3pq1fWNN1zqWWyy0dr6V/YnpWYyxRzzhh6GaE7khZ4FPG4x2sxqklRK6MBrD
         4dIH7QEDueGETBn8Gem0wS9UImNp6xo4n2MHdXleGvNhgfGHUzhtn0QIV91q0mghvEUk
         OLDUFP2fpzItIFAarvspIUJUYeGbq5pS+s9orgvb1cZwzUZfAc46htyM0kX41SMgrziI
         xYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t3DowLBUbVDLfqwm503SC828t0hf+EmNNlrIXo3LUS8=;
        b=kxh9VilbIosR0teIThL+UJ2wjPekCSc+mxJnX/E1D9geYD/ZBzdQP1hwUZ0m/evjLT
         YWWZpUpfIqTzRtTcj2wVNyKXtLDQhW0vZyg4xTI5pK+UCswmVPtEJLGfUx6Ra93+z931
         VGG6JXaL2huOqyP6VSRLor/iOybzlnQG+rEIamHF92A0vbbTevmedlr3LnG0hs6KiqqS
         EvEea6T/Tk8TunBofJBt0Jb+lJL0QytWv/GAklDkYEkRMWHT1ZXUdTfT4jJS58/nQXky
         HW+DDSPJ6JZTQAhuIBvnBz6GIqR3WcP+Um0V0aoybaBF0k/8Vsd7R/AOccy0+XIQCUed
         CkkA==
X-Gm-Message-State: AIVw111tpZVRU2xz40A1nzcvmIbBdYUX3mDRULjxHIlF4LydQvLDf+7Q
        HIVukWyrhcTIvgoADpeGK09aovWwaQ==
X-Received: by 10.36.78.83 with SMTP id r80mr15105916ita.70.1499963551266;
 Thu, 13 Jul 2017 09:32:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.20.136 with HTTP; Thu, 13 Jul 2017 09:32:10 -0700 (PDT)
In-Reply-To: <20170713155313.whucxkoita6nvmhz@sigill.intra.peff.net>
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
 <xmqqzic8xsxd.fsf@gitster.mtv.corp.google.com> <20170713155313.whucxkoita6nvmhz@sigill.intra.peff.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 13 Jul 2017 09:32:10 -0700
X-Google-Sender-Auth: srRQwhUWH2PkdNHhqZ8LbH_ZJIQ
Message-ID: <CAPc5daVp5SY552ic+X_zjN3h5NOWY7M_QUcJpfOt1SvZ_3EGRw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 8:53 AM, Jeff King <peff@peff.net> wrote:
> So I'd say this is not really force-with-lease at all, but rather a
> special mode that is somewhere between a normal fast-forward and a true
> force-with-lease. I don't know if it would make sense to give it a
> different name, or just lump it under force-with-lease.

Yes. I think these are separate problems that needs separate mechanisms
to solve, and I agree with you that it is also a separate issue if a single UI
"safer non-ff push" that covers both (and other problems that will be
discovered later) problems is desired or if a separate options (e.g.
"--force=lease=...,reflog=...," with nicer names and syntax) is better.
