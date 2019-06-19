Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBAD1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfFSPdB (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:33:01 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46431 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPdB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:33:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id z197so8089579ywd.13
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8Iq/5VZrH/M1mLnwf1z8pc0xkJ0r/wk5h6C6vyXIbM=;
        b=TLxcnO4g8/IjT94Cm12M0mkAZ3Bv1aPlFGZcpo3O7RA2TIp+9HopdnOFJ2f0LAojwQ
         RUY0629vlYv8nCHSR1J9PJw18pbc4+M8mHj/W9+O2JjzYaxL2dDVsI8BebOh8vuUMEQU
         HTABTfioCH1OaZuGxMTnsWIqim8oSPGcbqnbCh1QSzhDaqGD83NkJRWhgFwqS6M3pKKd
         GH5TUjl8ahz6GsmTUEOSneRDgc/MZT8LvCgOjOuPrMVaQx8QXai6AOMA9Kwt7uBCKtHV
         KOAHqxJI9tWbZWkAMq2aZWaCI+27BVDGp+xTxzmgSjTiEcBE+FXy9Xj8J3V+s0j63x9D
         HDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8Iq/5VZrH/M1mLnwf1z8pc0xkJ0r/wk5h6C6vyXIbM=;
        b=YFyaEHbX2O4YMr7OjeSQCj87YpHqAMsxpdf8XalrULs97xsMqNeKYYB7gKTMLnne3U
         44pQbyHLbBHUa4Ctl7GPcOc+jM+PvlaPvX0/NhOchw5d03fqvwjjyhL+XW2IhsDuv08p
         NuMoTANUn4Z2HLldHP9OQd5QT2gDuk1KsYJLd1c+YlhvkQRekdPdtedJ1lfqDGqyHV44
         3KKCGsJUpVZaSQR21XQblhq9btj96fLM+qQrMmCs1swpd6YTWPZhL4rA5MXNRmFwJRBa
         ixBUUlVt89OwUVZdRWNbDHIUT+2kJtHprWJhCM361t9nNmcCjtDOiLhebFJYzboHlvpW
         moYA==
X-Gm-Message-State: APjAAAVltMADOas/qBJHJkWKIFh8/6BN0dKOJLWt4UQMo/2GgNjsi6+O
        lRXi6WgvtpdwKx9275wSUx2svpLR+j8b9mPQonTdAg==
X-Google-Smtp-Source: APXvYqxZBuMdT+g0qIh8+E6Apty/R1sZT3mEM0G841khdhkcCM7IWbeAkxotwujbHX1ik2JMRjOcIkYN+4T+0L7vOLI=
X-Received: by 2002:a81:22c1:: with SMTP id i184mr67150255ywi.292.1560958380587;
 Wed, 19 Jun 2019 08:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190617165450.81916-1-liboxuan@connect.hku.hk> <20190619035857.GB515@sigill.intra.peff.net>
In-Reply-To: <20190619035857.GB515@sigill.intra.peff.net>
From:   "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date:   Wed, 19 Jun 2019 23:32:19 +0800
Message-ID: <CALM0=-=4b4j1brRN=Jnq4N+f+_vJXrL-JBAOxaLw0FgugNqX5w@mail.gmail.com>
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 11:58 AM Jeff King <peff@peff.net> wrote:
>
> While having separate lines that get joined here does make the result
> easier to read, I think it creates some confusion. diff.*.xfuncname in a
> regular config file _doesn't_ behave this way (it's the usual
> last-one-wins, so we expect a single string). You've handled this
> specially in your code to read this file, but it's confusing because
> this test otherwise looks exactly like a config file. And thus somebody
> might be tempted to copy it to their config file and modify it, but it
> would not do what they expected.
>
> I don't recall how well our config parser copes with embedded newlines
> in values.  I.e., if it would be possible to write:
>
>   [diff "foo"]
>   xfuncname = "the pattern starts here...
>   and continues through newlines!"
>

If I recall correctly, the above version wouldn't work, but the
following version would:

[diff "foo"]
    xfuncname = "The pattern starts here..."
"and continues here! But the indentation looks ugly,"
"and we lose the ability to add comments inline (within pattern)"

Actually, at the very beginning, I was imaging some syntax like this:

[diff "foo"]
    xfuncname = "The pattern starts here..."
    ; using '+=' will continue the pattern above
    xfuncname += "and continues here!"
    ; a '=' symbol will start a new pattern
    xfuncname = "This is another pattern.."
    xfuncname += "and remember, last one always wins"

The existing config parser does not support "+=" though, which is a
nice feature to have in my opinion. Maybe there is a reason?

By the way, thanks for all the reviews! Especially when I found more
lines of reviews than lines of my code.

Best regards,
Boxuan
