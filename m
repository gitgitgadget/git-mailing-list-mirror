Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1D820281
	for <e@80x24.org>; Thu,  2 Nov 2017 18:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933839AbdKBSS1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 14:18:27 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:56438 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933807AbdKBSS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 14:18:26 -0400
Received: by mail-qt0-f170.google.com with SMTP id z28so471587qtz.13
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SO7YOWm4Z/9Y/Ml7O3ISOH1iqvytvhJW3HU41i6A8VY=;
        b=UMaIqRFhHvtRPeRNURUGSZP6eiBo7dJxX7D1MbSF2ZYEMvf/bLO8S7NGBdztDX6Gs1
         UFh+SbmixXhRrDnM/51rHDuX4nhggldJap5hHYy8n7IRM4028ZhaZuXvEWxVsugHmXHr
         hDd+nqAJv81986jL1tVgBnPv+DCU3wnqRBYT2MCWtSkykbCg0D/8IR8HTCZH4VcoegMw
         joubIoquhZnApuFzKxEbQDGMiIEQiyNN4e4toJegm/tWo4O0dS8Il0UFSWUC8u7zaJxq
         TvYCWW0UWc/s5/5BaImn+Xfcu4VfedQqSYIASfKDhIW0Eu+cXEL/RFBR4r/r4P5J7qgl
         jQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SO7YOWm4Z/9Y/Ml7O3ISOH1iqvytvhJW3HU41i6A8VY=;
        b=CeSb6UjbnUA+VnCjxbg5G2QOY2Uj4NB+3kq2GPSAFo1R8So/b6M6ZCtAFfh4aqbD/m
         VOiwIaBh+LPXcWz21TWBTHWoWXkOstMxl37y/zbUiuTUmBJyeqB80oECE9O6H+MavbRT
         BxHaFxm3l44mCibprk2V1/7ffxRGIX6851c2R0JsjTBXzmvm6HJLjvZMEFagrj7HQkhQ
         wilXN8B3OFieMWfxGKPv1wzybiuVAn3nhIVt+1ubHXwk1GiAL++jtqqqdBV/afU/LrJK
         NvElS62FTDFHwlQeJsw8kZsejNm7oqm/5vAR7PZnNj9iAHkZEsUnwn5KP8UqtkEx7L/H
         B6Xg==
X-Gm-Message-State: AJaThX6HBmR5h0I24HTh1tyvIowHD+yM0brZl7N9tYBOqLUeQ1p7I/M6
        tGsyRqG/U32lIKUDKleDDC0veXmXFGEUh29q2G6lVUku
X-Google-Smtp-Source: ABhQp+San/bKIBBpYa2zRllwXZi+1z29t/CbaVS1w0VSltxGi1EtmOIHKXZycJ0001g4m+ZYZPMdSE81GEg4BA8jmL8=
X-Received: by 10.237.34.201 with SMTP id q9mr6368145qtc.198.1509646705206;
 Thu, 02 Nov 2017 11:18:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 2 Nov 2017 11:18:24 -0700 (PDT)
In-Reply-To: <871slhm9dm.fsf@linux-m68k.org>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011329300.6482@virtualbox> <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
 <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com> <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
 <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com>
 <alpine.DEB.2.21.1.1711012340290.6482@virtualbox> <871slhm9dm.fsf@linux-m68k.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Nov 2017 11:18:24 -0700
Message-ID: <CAGZ79kZXLpwCyWs3_mfj7kL1qmM965V7vZZ2UH4-hqrfF5f+8g@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 12:23 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Nov 01 2017, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>> Sure, but it is still a tricky thing. Imagine
>>
>> - A1 - B1 - A2 - B2 - B3
>>
>> where all the B* commits have the blob. Do you really want to report B1
>> rather than B2 as the commit introducing the blob? (I would prefer B2...)
>
> What if B3 renames or copies the blob?
>
> Andreas.

With the current proposed patch you'd find B3, and then use the diff machinery
to digg deeper from there (renames/copies ought to be easy to detect already?)

So with a copy B3 might be a better start than B1, as starting from B1 you
would not find B3 easily.

For a rename, I would think a reverse log/blame on B1:path may help.

With that said, I think I'll just reroll the series with the current logic
fixing the other minor issues that were brought up as B3 seems to
be the most versatile (though not optimal) answer for many use cases.

Thanks for that thought,
Stefan
