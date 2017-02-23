Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107EB2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdBWTrT (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:47:19 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34279 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBWTrS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:47:18 -0500
Received: by mail-oi0-f45.google.com with SMTP id 65so682382oig.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UXFS29gmPi7ka7lS8rnN38Vu8nQWdLd7wr/1w+6z6Xo=;
        b=R3sJ+ootbfFJm4yWtipZJ1icoRTU88dJRn9Vibbv4Wx18sYVzfJ0KlAdXFbrOEqIwb
         duuDalqHkthsSeLfjcEPpqCdPStstuDv1Rjs9tId02VLLOmRRcub1UyU/0uG5MKn+BAQ
         R7VJtLD7Om6B53muYKZ6dmdOvVB9wgCWyu4QXSt0CpbWZAJTCCB4pRZEGn2wd2L7mdER
         Tte6iz4wZVEjMhFxG+zbGsGMKfN+5BjkdCwAFkBhsQXotjiAg8AyYhLgmGNJrwH0axWQ
         nVNZg4D+aaxSYdegv8EEEHPihM2BSh2DCB2VAOjmivuxzh0xW6sJHpV2bKM/rmp3Ndr5
         jq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UXFS29gmPi7ka7lS8rnN38Vu8nQWdLd7wr/1w+6z6Xo=;
        b=KmtAaOfQZYNe+zA368+fdlMQgqV9MbQij6R0TGNvZzmpVTgv7zuBrR/pk/ukF6Ilg+
         p6JYOj7Q6OmKMatyxGSOJrPqS3AH5atV20hWqKFX93n8NmTj9TnCdscosmQtwEZA3VT/
         2H6+sdXy/k4FS+qz2mm2m3QnndCuReTUUa2mo3UxyYbSoqNzf5kxVcm88cgbhpZmKyGp
         WvuucPyhX6Hi6fZDI5rZWr9s3Xt5REmiJwY5Kh6NwXHVE0Qx/MZPHf3JLE5iSoOtJepd
         ysvWLET479U0eWa186b7IqtRo37Ysj5n0T/9TzootMwXpaRHH08BtCNEvKp6yuD7Wllc
         KWnQ==
X-Gm-Message-State: AMke39lfPNzsVKtNVMx1yoIAFMr9sni2XDt5vtLqmDf77NQ5gT5dDacwaeQylzcjd9st5Gyb7tWDSuEbcXoH9w==
X-Received: by 10.202.244.193 with SMTP id s184mr7515236oih.142.1487879237360;
 Thu, 23 Feb 2017 11:47:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 11:47:16 -0800 (PST)
In-Reply-To: <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net> <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net> <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 11:47:16 -0800
X-Google-Sender-Auth: D6jrEp-flW0GvRBggMHZlT3Pnis
Message-ID: <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 11:32 AM, Jeff King <peff@peff.net> wrote:
>
> Yeah, they're not expensive. We've discussed enabling them by default.
> The sticking point is that there is old history with minor bugs which
> triggers some warnings (e.g., malformed committer names), and it would
> be annoying to start rejecting that unconditionally.
>
> So I think we would need a good review of what is a "warning" versus an
> "error", and to only reject on errors (right now the NUL thing is a
> warning, and it should probably upgraded).

I think even a warning (as opposed to failing the operation) is
already a big deal.

If people start saying "why do I get this odd warning", and start
looking into it, that's going to be a pretty strong defense against
bad behavior. SCM attacks depend on flying under the radar.

>> So a very powerful defense is to just look for those bit patterns in
>> the objects, and just warn about them. Those patterns don't tend to
>> exist in normal inputs anyway, but particularly if you just warn, it's
>> a heads-ups that "ok, something iffy is going on"
>
> Yes, that would be a wonderful hardening to put into Git if we know what
> those patterns look like. That part isn't clear to me.

There's actually already code for that, pointed to by the shattered project:

  https://github.com/cr-marcstevens/sha1collisiondetection

the "meat" of that check is in lib/ubc_check.c.

                  Linus
