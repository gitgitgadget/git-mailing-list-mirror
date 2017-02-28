Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C28A202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbdB1W5U (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:57:20 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:34468 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdB1W5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:57:16 -0500
Received: by mail-it0-f44.google.com with SMTP id y135so3524301itc.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 14:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zaw49uulSF0wwiB8Aw2IavW0vTSsPfkXl24iQ/FvPEQ=;
        b=Nef4o5NHZ5+aCG70N4kmNOG1G1NV4pNmnjGP1vGDwo8B5VLhzofde6B+ZOA3xTMw4l
         0C3Whfhb/uFv1rhPj2gBVo4ysWb4+EKgk0+Z4TAl6t5BzGeW0jrvpPlvCCcQPhbF31g8
         IwHDPbzzvsR5tkmdndMbQVhMO/tm0k7MlAfORNSPRYfSaZHU0CJ9HVNIyKf5Ac/yzHEw
         zIxbb/DUFQmylCFzG8EuCQOAP93KHua9FGdqTfAKRrhmC7u6G+n3ISGtWToGvNnFb2mL
         tRbOX1hMz9s5+JDgW7X+V6L4nnV5+2EuQQcNIucJuz0fHHIlOdEtAOYQnWdDaWwrpFeF
         nn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zaw49uulSF0wwiB8Aw2IavW0vTSsPfkXl24iQ/FvPEQ=;
        b=TyN80IxbZcNfYXO/juI8XMRv4/5VIbsPSTIYNr2sjascCbYn5EqeiveyNpqfMMj6/w
         Vg8YjjTdMST/LBjnHYpGv5bBmOGFbfjnuBBxkIxOvx6kM7O0WUnh2j5jG6S+gzpm51d7
         9TZjx5Z6Eg1k13bGmsJYBcjmo3B2tjMrn6c4hMzY+QqGZ/QvZ6kK3Q3Ztx0v93jVefBf
         kM0GQYw8SMMvRjuOuMdZOwZsJQmU3WFvL0+rxo0tuZn6Bx9MvkyCCpy2Pm7YZbf2k+s6
         393Hi6YHotpif++jJZD+2ruSF4RWFr58Et89VfOBd0zkeqZteO5DUDkm0/D9nkKqVTyn
         Ua2Q==
X-Gm-Message-State: AMke39mRcXcexmTlhC4qostozEPNgNGRjgRELHJ2dUFw/JMwC02sGQnqTTkzUgDp8oACXQwgOaUmnyvIiTwsbQ==
X-Received: by 10.36.40.198 with SMTP id h189mr1231783ith.114.1488322600708;
 Tue, 28 Feb 2017 14:56:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Tue, 28 Feb 2017 14:56:39 -0800 (PST)
In-Reply-To: <CAJo=hJuB9JkTZSRbhN2DX0gBqpjddU=Sk8iRV9++TYRv4xKA6Q@mail.gmail.com>
References: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net> <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net> <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net> <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net> <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <xmqqefyikvin.fsf@gitster.mtv.corp.google.com> <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
 <CA+55aFxTWqsTTiDKo4DBZT-8Z9t80bGMD3uijzKONa_bYEZABQ@mail.gmail.com> <CAJo=hJuB9JkTZSRbhN2DX0gBqpjddU=Sk8iRV9++TYRv4xKA6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2017 14:56:39 -0800
X-Google-Sender-Auth: xO9coG_N-iUcb-gPUMGALIWtGQA
Message-ID: <CA+55aFxG_5KU54KXZdTMC0p0EF5ixmv0C6ccjnYcPUeN_kDREA@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 11:52 AM, Shawn Pearce <spearce@spearce.org> wrote:
>
>> and from what I can tell, the 'maski' value is always 0, so the
>> looping over 80 state masks is really just a loop over two.
>
> Actually, look closer at that loop:

No, sorry, I wasn't clear and took some shortcuts in writing that made
that sentence not parse right.

There's two issues going on. This loop:

>   for (i = 0; sha1_dvs[i].dvType != 0; ++i)

loops over all the dvs - and then inside it has that useless "maski"
thing as part of the test that is always zero.

But the "80 state masks" was not that "maski' value, but the
"ctx->states[5][80]" thing.

So we have 80 of those 5-word state values, but only two of them are
actually used: iterations 58 and 65). You can see how the code
actually optimizes away (by hand) the SHA1_STORE_STATE() thing by
using DOSTORESTATE58 and DOSTORESTATE65, but it does actually generate
the code for all of them.

You can see the "only two steps" part in this:

  (sha1_recompression_step[sha1_dvs[i].testt])(...)

if you notice how there are only those two different cases for "testt".

So there is code generated for 80 different recompression step
functions in that array, but there are only two different functions
that are actually ever used.

Those are not small functions, either. When I check the build, they
generate about 3.5kB of code each. So it's literally about 250kB of
completely wasted space in the binary.

See what I'm saying? Two different issues. One is that the code
generates tons of (fairly big) functions, and only uses two of them,
the rest are useless and lying around. The other is that it uses a
variable that is only ever zero.

So I think that loop would actually be better not as a loop at all,
but as a "generated code expanded from the dv_data". It would have
been more obvious. Right now it loads values from the array, and it's
not obvious that some of the values it loads are very very limited (to
the point of one of them just being the constant "0").

Anyway, Dan Shumow already answered and addressed both issues (and the
smaller stylistic ones).

               Linus
