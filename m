Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB6C1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 17:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfAaR54 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 12:57:56 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:38068 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfAaR54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 12:57:56 -0500
Received: by mail-wm1-f52.google.com with SMTP id m22so3554610wml.3
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zOgkaZDn3ZLp52e5OHf2B3fIdyWqQH7SkDZB6QieCic=;
        b=cZF28EUlHZ6RWU+HWYs2jkWSN2PrJ+T+AikMDj1Kk4pkufQUj0ecizMOhE5GL3z7ZV
         e2g/ocsayygyeRk9wbLpk3znAkV9lCr3QASX9Z3laDnLTb6niFTgx7E99x9y7NS7DwTL
         Ld8FxjwzZ1noG145SXhgclm5lFBBWe0ni0aIHdDP9bsKM4ezseubhWa5JuchbcCrwkBH
         P4W5krWb0vePSZAm0HdgmmvUlWl9rEQTXblwJFPpLWNYJCBiWWUuFnj7y5/HaLWccH+I
         RyELzz26pfHRiU2Y2XN813eqQjaMa4t6FcQp27xVJ47tTqkQ1ozWQrYe9Jgs0AAZr+iG
         j7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zOgkaZDn3ZLp52e5OHf2B3fIdyWqQH7SkDZB6QieCic=;
        b=HaFKd0MtLETzAh+ZZhZYGpKSCPDa53wPx2wBu6Zt2o+TbGQmlM4jO+tYJhLso6JfgG
         mmP35nBk+AwTaWszXhqGo7BHjTzEqZx3L0342gksEJXo20U+qvoif9pidvpUbXxVphbc
         8HTCY52ylEAV/3vvAR76stsXAvIcod/028NfKcB/6sz3LE7mFtYNj8n8Tdwp9LhftLZN
         FsaTEI2g6bmgdRRib3+90/EasManBGQ009t7b0xzYrIqvkCe4e91+KfIRHB1BpZYYU2o
         iJGj276uPwlqesP+HpX/zBFledFpd2dP1FLhz/Ag1AONnhcWKU2tglbgElw24HUjcdkF
         KJRw==
X-Gm-Message-State: AJcUukeKkydy7gdScH7RODdQaxO1n4rK34gWWi0R1VfJ+Jg9wbCDk9ol
        HcryrzPWKPOW5rgz4yyFEYM=
X-Google-Smtp-Source: ALg8bN6IKOX7vUWnKLV0oaCxP7yN+XC65QxjiRr64/AZ9/yZBO2YOI2cQAaj+/MFBOaw+gkjTWqDeQ==
X-Received: by 2002:a1c:e715:: with SMTP id e21mr30637374wmh.101.1548957473422;
        Thu, 31 Jan 2019 09:57:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d4sm7841128wrp.89.2019.01.31.09.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 09:57:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches *.S on case insensitive filesystem
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-2-jeremyhu@apple.com>
        <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com>
        <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com>
        <nycvar.QRO.7.76.6.1901301340270.41@tvgsbejvaqbjf.bet>
        <8B5241CB-2E1E-4521-8FE1-A84C4896AE82@apple.com>
Date:   Thu, 31 Jan 2019 09:57:52 -0800
In-Reply-To: <8B5241CB-2E1E-4521-8FE1-A84C4896AE82@apple.com> (Jeremy
        Huddleston Sequoia's message of "Wed, 30 Jan 2019 11:13:36 -0800")
Message-ID: <xmqq4l9o4sm7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

>> What you probably want instead is
>> 
>> 	# Accommodate for case-insensitive filesystems where *.s would catch
>> 	!ppc/sha1ppc.S
>> 
>> after the `*.[aos]` line.
>
> Thanks for the suggestion.  I didn't know that was possible with
> .gitignore.  That's a much better solution.

I still do not see what problem you need a "solution" for in the
first place---I saw a few comments asking it in the thread, but saw
no answer.  ppc/sha1ppc.S is already tracked, so any modification
you make in the working tree can be added to the index with "git
add" and "git status" would report when you have modification to
that file in the working tree, without any such extra entry in
.gitignore, no?
