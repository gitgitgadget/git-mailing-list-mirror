Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D0C201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 19:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdB1ToV (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 14:44:21 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:37074 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdB1ToR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 14:44:17 -0500
Received: by mail-it0-f54.google.com with SMTP id 203so16492814ith.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 11:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oJeXddgNPVzmpdUNqUGXuFUfzND8XRAv4VN2Gmc/1QE=;
        b=HxLp6Z9zFOKiqlKmm/nDSxWoOnjOj/wt0UCw1KwWgPLHozgwke9mTqVfQq8QtKrAV6
         rnXL2N/ZbVS7Y4XrnVYiTjEL2rfHydYA5jFSm8bpeSz1nujHjvnGCDsqXvnRNA/lC9XK
         iFTyhxRD5S0Mlbk2/blTyZC3YNWdyS7f43L5K2aq88upHBzHFZw3nhLJCe/x6rnVGx75
         bFt48CQ2ul1G2lYu8C/e4ohMoVJ86HPJF52bK0+w1pExu9Yo2h2GMwGpoGrfbb3NVkdZ
         mPINphe1fpFzHr9Mw+kZqLZjWwdnCo7XhCTLtVYMo9CTHhPdbhHem4EJlmb6JS4V2o6e
         J6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=oJeXddgNPVzmpdUNqUGXuFUfzND8XRAv4VN2Gmc/1QE=;
        b=fYGYcGCAThKqMpc0xApCRbSTewM1MeTGg/Km15ZjtnxgoIOFQ9RgSbIDpoppPqTg6T
         WmQpP0E1m02q7NQSWp+VWpuaH4TWcI/auyWlc/PK1AFTwfGAu3V+g2zMhpF1NFZSjByy
         NBRech6pDJUucrBJIANffqO7u/19JFNKRv/MQzlT4qBr1yW3Rqi8cErwzuGnfaA7uSBZ
         +rTv38oY992O28dDquYdY3fISPnJ+eM0IXW7ybDDk/HB23UMz142uUMbQu3aAelhANGt
         gvJGtXNmHHq1vqD8aCA8nJx9XIsOe7LGdkv5TGZIVUrC+EFDUHO6c1o/gfBA9MajN7V+
         nrBw==
X-Gm-Message-State: AMke39mkIyOYOwkwFDTEOBOnvfAOBjW++AEgUPkHutOsuYqK0kjNZCoM6wSbbbKqTaLNa6UQjmSX7pbgjllndg==
X-Received: by 10.36.225.13 with SMTP id n13mr355376ith.114.1488310456024;
 Tue, 28 Feb 2017 11:34:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Tue, 28 Feb 2017 11:34:14 -0800 (PST)
In-Reply-To: <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net> <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net> <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net> <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net> <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <xmqqefyikvin.fsf@gitster.mtv.corp.google.com> <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2017 11:34:14 -0800
X-Google-Sender-Auth: l_1sPayHFtOPLql27C65tIM_Evc
Message-ID: <CA+55aFxTWqsTTiDKo4DBZT-8Z9t80bGMD3uijzKONa_bYEZABQ@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 11:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> In a way similar to 8415558f55 ("sha1dc: avoid c99
> declaration-after-statement", 2017-02-24), we would want this on
> top.

There's a few other simplifications that could be done:

 (1) make the symbols static that aren't used.

     The sha1.h header ends up declaring several things that shouldn't
have been exported.

     I suspect the code may have had some debug mode that got stripped
out from it before making it public (or that was never there, and was
just something the generating code could add).

 (2) get rid of the "safe mode" support.

     That one is meant for non-checking replacements where it
generates a *different* hash for input with the collision fingerpring,
but that's pointless for the git use when we abort on a collision
fingerprint.

I think the first one will show that the sha1_compression() function
isn't actually used, and with the removal of safe-mode I think
sha1_compression_W() also is unused.

Finally, only states 58 and 65 (out of all 80 states) are actually
used, and from what I can tell, the 'maski' value is always 0, so the
looping over 80 state masks is really just a loop over two.

The file has code top *generate* all the 80 sha1_recompression_step()
functions, and I don't think the compiler is smart enough to notice
that only two of them matter.

And because 'maski' is always zero, thisL

   ubc_dv_mask[sha1_dvs[i].maski]

code looks like it might as well just use ubc_dv_mask[0] - in fact the
ubc_dv_mask[] "array" really is just a single-entry array anyway:

   #define DVMASKSIZE 1

so that code has a few oddities in it. It's generated code, which is
probably why.

Basically, some of it could be improved. In particular, the "generate
code for 80 different recompression cases, but only ever use two of
them" really looks like it would blow up the code generation footprint
a lot.

I'm adding Marc Stevens and Dan Shumow to this email (bcc'd, so that
they don't get dragged into any unrelated email threads) in case they
want to comment.

I'm wondering if they perhaps have a cleaned-up version somewhere, or
maybe they can tell me that I'm just full of sh*t and missed
something.

                    Linus
