Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9B1207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 17:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933621AbcI3RyU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 13:54:20 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36514 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbcI3RyS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 13:54:18 -0400
Received: by mail-oi0-f45.google.com with SMTP id t83so138699398oie.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9ILMSiCGXbkyhRZDmAcr0hO7SSXL241XlWAlk5wLK9c=;
        b=gX1mBTNugStz8md8OmI+zMneuMybFDMuvZdMxMUJXKNG61pU35DRUxt63vuCx51B5V
         HWELHNA4EKRtGc3JUzWkbyLW6k3HLWcJWO82TMFzhpSV2A8sVvm2bMndjXbwTi2e4U3r
         PQDvWNGZkFxO17BThSXXQaD2hxDu9+wCtEjBRvr/suuVFs4QPyHffdysiRApltpSzpIh
         qf10uwrgJJMH/tfOoucIk+vIWcz4C3a3tbHoO5Gc776HKmxN7OGaCGd1cBazILC3mwf2
         MU3/bmL3fvZ5BI1QI8WMmgW1QsNfhsr7q8JkievAlLML9zEAnYkfttphD6tX7GfiwRpU
         nKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9ILMSiCGXbkyhRZDmAcr0hO7SSXL241XlWAlk5wLK9c=;
        b=kwwfcJgW7a1nXPYOGdvpQ99KdUWa7L0HGnBYXxZu0hX0HGbZszvQ7NsXPGP3QPNSVt
         MvLW6nw8oPDC4VzFwsch5RRnI2fLD7n3OksQsMryy1bunzM3s7imhK4SO/ZcxbVlTtZP
         zKYWddbPoqIeNYA5rb0AwW6WGj1F7quiDk/fGinv+W/KFKk9cJGB6twH63zdPopjeMip
         VszlR9r1kMezcl8XcqwKlX6qT1GAUFNvWeDPUnr7VuBt5uZGQHiksxPf+jdOlX7SoQ/u
         cWJp/Afsa5QZ66QMdujZ4MlOd7PEUqFvWhn95choeNbwSKSup6k5GNzbFWv5NMa91cJO
         1b9A==
X-Gm-Message-State: AA6/9RnhfaFXO7jNX4juFSuOGq3VLOqLicqpaw4RHqy+ZV4C412s9xnFVPJgHdBHcaPpiHEEEZIy/qBWUKwsrg==
X-Received: by 10.202.220.194 with SMTP id t185mr8238713oig.116.1475258057976;
 Fri, 30 Sep 2016 10:54:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Fri, 30 Sep 2016 10:54:16 -0700 (PDT)
In-Reply-To: <20160930080658.lyi7aovvazjmy346@sigill.intra.peff.net>
References: <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
 <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
 <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com> <20160930080658.lyi7aovvazjmy346@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Sep 2016 10:54:16 -0700
X-Google-Sender-Auth: S2vv1yIcB2kKt_msPJolsuSKwOA
Message-ID: <CA+55aFxW1S6FNUh8YjSXkfC8=F5dka1rY-As6PWfG2rqmrsXXA@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 1:06 AM, Jeff King <peff@peff.net> wrote:
>
> I agree that this deals with the performance concerns by caching the
> default_abbrev_len and starting there. I still think it's unnecessarily
> invasive to touch get_short_sha1() at all, which is otherwise only a
> reading function.

So the reason that d oesn't work is that the "disambiguate_state" data
where we keep the number of objects is only visible within
get_short_sha1().

So outside that function, you don't have any sane way to figure out
how many objects. So then you have to do the extra counting function..

> So IMHO, the best combination is the init_default_abbrev() you posted in
> [1], but initialized at the top of find_unique_abbrev(). And cached
> there, obviously, in a similar way.

That's certainly possible, but I'm really not happy with how the
counting function looks.  And nobody actually stood up to say "yeah,
that gets alternate loose objects right" or "if you have tons of those
alternate loose objects you have other issues anyway". I think
somebody would have to "own" that counting function, the advantage of
just putting it into disambiguate_state is that we just get the
counting for free..

                         Linus
