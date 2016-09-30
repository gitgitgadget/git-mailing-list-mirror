Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B3320987
	for <e@80x24.org>; Fri, 30 Sep 2016 04:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932259AbcI3E3w (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 00:29:52 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36764 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbcI3E3v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 00:29:51 -0400
Received: by mail-oi0-f67.google.com with SMTP id h186so2140428oia.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RS3BAmieAdqNuH9gnk0kRlxAkNGj09aQPAI66kYUEUQ=;
        b=oPTALjMKXQDZHnaafDRg7d2HAg5uipqQ+E++leuCiq01wu3m6XgBdLcXL3mr9AlJdl
         8zWUdxkNMl9RbnfOM45U+L5DoSpX0tX5WC3ynLxhcym1nJWpufMPtfTqBbz+zLy8K4Kg
         u56umpXUDd8n+hlIeRxc6zZqy2RKFDG6PnMwI3I1r+a7TN040DyyblW346XH4DfVMyM4
         VpIpOFWuOOAkSspPy0Y4iKT2cI570mbjRS8t2pqWZr/f7XJNJcgiOMvztKjd4FfpT02H
         qMWM5Bb6Bs0Z+DfQIcYXSn78j4aRRbhrckZTqu7OiWWk+5Ek5czupvZNYvAJQdYr+XTy
         NfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RS3BAmieAdqNuH9gnk0kRlxAkNGj09aQPAI66kYUEUQ=;
        b=Jp9j5haGXbmDjoEBQJlZa8gs39B8DDfn+CRmBf9YSEjMDTomACj+Aa4U2dBDJEkFAH
         uDqhsmbXzgA1S/wLRRM6ImtkwUM0JbKNS24BHgl3ihHNWlatSEquSwBw3Akp5nMnzasT
         lpqa3ceUR6GAIwOE7oO9/CV3X+mQNvS6ehrCjW6s+53uU1uJubC20pz2AHDiaWD8i0yf
         sQdXk6H6yLjejA9rrNbvRaxrTDq5quWuvdt0cWE6SohCncxYNmlUw2gMNKXpxZY+NQ4G
         tg+M+92rNiTGXxhRuqawRHaf6eMY8Q+HqtpB26twTn5MwBriU2C7yFkt3WgVR5F1rM/F
         n2Dg==
X-Gm-Message-State: AA6/9RnkAgqNoBmEuOgAcDoyRmiiENI5dICVU0c4ES2eckdHFsonLK8Z1BEFpQp+xV3HwXAt7kszNAjo/Xs+sA==
X-Received: by 10.157.39.2 with SMTP id r2mr3933356ota.103.1475209790231; Thu,
 29 Sep 2016 21:29:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 21:29:49 -0700 (PDT)
In-Reply-To: <CA+55aFw4=tGQZd0QO_8Zzs0AqPCpew_Wvnwft-JP2OzFbask8w@mail.gmail.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
 <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
 <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
 <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com> <xmqqoa36auyx.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw4=tGQZd0QO_8Zzs0AqPCpew_Wvnwft-JP2OzFbask8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 21:29:49 -0700
X-Google-Sender-Auth: tk9tKRnC2skRvZCRz5XoDHevxUo
Message-ID: <CA+55aFz4uEzVw4yc+2X4=UPaRewxBkO9gbfXAPQ96kauQ883Zw@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 9:18 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There are probably other things like that.

t5510-fetch.sh fails oddly, looks like the output is off by one character.

   not ok 77 - fetch aligned output

It has a magic "cut -c 22-" that expects the output at a specific
place, and now it's at column 21 instead of column 22. Strange test,
but it still seems to be aligned, just in a different column.

But clearly something changed.

             Linus
