Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E291F829
	for <e@80x24.org>; Mon,  1 May 2017 00:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993668AbdEAAPH (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 20:15:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34340 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2993587AbdEAAPF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 20:15:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id g23so25905641pfj.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 17:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A70FX7xhItsNj0tc95TIjgMd+MAFoEa/3vkeIDWxhgk=;
        b=GFT9yDdT8cUCvmYU+G7Gpu1eWumtnR2H1y28B6/oXeuuVdEz8nY8aksVFxVfPzauzc
         L4gMe5cKiL1C3QYlwdkCNVL9rOq1sunSmg/6UaplxwrkMaNF64wmWUYLOtgOa6ozzhLr
         iynGPXJuE3axHjkTgDDa/jbVzDVYskuisLhPU+9kKM7Hc7WC7QOjwoCc2vkLkVQZupYF
         bFcFdP12K13xb4qGFIFC5vqvkcWl6HRPbO43HnJpXvsJs5Ong8yQD0b12ubACXJSeSQa
         1KIvzb8GZG01zvx3qKXgB6q7QK7PTuL/9LmC30eir02Rtao9RMUc7VKbb0mQIvx/xJbB
         ftdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A70FX7xhItsNj0tc95TIjgMd+MAFoEa/3vkeIDWxhgk=;
        b=Ti5A4LnLCfD/erLWM/F5bwmkssHGnVTAUzn0RVjEFagZFgUOaGcy1nlhnRW7/hKJ4N
         a81SM5GLaf6U3DxmTWyQZV8UD7sKm35NC+lwXX5q80WzFILb6xE04xlk7Xz5VpNVyEDL
         RjM80pAqJiLkjr6zDZyMnEyWX6htBMshLIZ33MUbjkyQELn+lcNBol1JWaP5eZ635vfc
         rQ9YAW69KDlmRKkN9oFNBtDfR9/QybvzOhQGMqGMc14jARPSJ3GXruvahtCsFw/3S1xy
         zML95wMUvGUIUpm9QhAizEbhIb4GPL5mri22yF+DpmEAzTMGDYureHEXmNfoElEk0I4u
         ThFA==
X-Gm-Message-State: AN3rC/6j6x51nSSsF18oEDNPI9gATua16Gm9o7+1Ah00XBLCaLa3n6AF
        LhtesPccXLeyhNEQjR8=
X-Received: by 10.98.144.155 with SMTP id q27mr23225299pfk.179.1493597704690;
        Sun, 30 Apr 2017 17:15:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id b5sm18637602pfb.21.2017.04.30.17.15.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 17:15:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Stefan Beller <sbeller@google.com>,
        Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Submodule/contents conflict
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
        <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
        <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
        <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
        <20170425032242.wlmqrkgkeg3ytfle@sigill.intra.peff.net>
        <B12D69ADE0C84BBBB9A35C50F1C74A01@PhilipOakley>
        <20170428083015.m2vowojjcdgfkcak@sigill.intra.peff.net>
Date:   Sun, 30 Apr 2017 17:15:03 -0700
In-Reply-To: <20170428083015.m2vowojjcdgfkcak@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 28 Apr 2017 04:30:15 -0400")
Message-ID: <xmqq7f21l9fc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Interestingly, I would have thought that the first update-index call
> would "de-racify" the entry by rewriting the index. But we don't
> actually write, presumably because we eventually realize that there are
> no entries to update. But it might actually be worth doing the write,
> because it avoids further file-content reads later on (and most
> workflows tend to do a lot of reads; every git-status is going to rehash
> the file until the next index update).

Yeah, there is a tradeoff of time being spent on writing the index
(which could be large) and having to rehash the content (which could
also have to happen number of times until the next index writeout),
and in hindsight I suspect that I got the tradeoff wrong when we did
the racy-git-avoidance thing.

