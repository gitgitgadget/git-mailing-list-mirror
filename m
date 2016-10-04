Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C552820986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbcJDVum (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:50:42 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35122 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbcJDVul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:50:41 -0400
Received: by mail-yw0-f169.google.com with SMTP id t193so64725581ywc.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uwIgLpBtfcC2QyPfJ4TbjjZTatHHVlr5NJihYvFep4E=;
        b=HPvm8xV5b+FuRS6hrVY7q0SSWn7Sd/F4TvOBQ2c4NApgW/c0wfJQ3acJ0gPHWTqPj7
         ++pghGcfI8UAupGRLKwml13E8YtcZF1g15KZ+b8NDaIAq95wofEVwrC73e/ANueqWhnr
         JSKGgNoWSiOhbtvSXEuINF2DBThlFMc50087DazslDsk7oLJiXbvf2UhA1OEMw8PKsYq
         IwfH/Np3h/HF23DzPmzVyaq1oe5fgS9K/JGRhS/XlSFeT1b2LB5yST0mzPN4MMuIaIUJ
         itkdFYJuBhXa/bNzzAhvJuo7JP4FxCcvWG1JJfG5IfCo2OIHRqp2vVh/XXd8lrtIGssE
         3HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uwIgLpBtfcC2QyPfJ4TbjjZTatHHVlr5NJihYvFep4E=;
        b=G4kIDf2YTyj936Tdp+AjQhlBzeM7yQgYR7jJA3oCDqeMrYWwfUGBLr3Qtcc5lHnu9s
         gyVy6jAqBcEUZhLSZ5z21MW2fc+owd7UNevnEOLD3Ks8HbdpOKakI4PIJWq4cki5H+Ek
         t3UO3HN/tT5KVQ0rqxuJjvK9zmH/PYWSJZGiTTRvtuXQDATUwPpuFKRsiYbKCRBbtZjT
         0M4aMSEeLj1ZtIKoThbtC5mfo1ozkcIGWn9ZYtFFbZ64al6NLm6pZGzvEd+znhb22GTd
         ofrmduBHouDI+WPyMuxQvJCSirHPynAFYqVEb7PP8888aF08lfgDh+5DdS+FvehKNVkM
         Srog==
X-Gm-Message-State: AA6/9RmlU5nGUMOhz+Q1kuulZbVw3YbDUmNidhJ5BonPup05UHyzUBhdLgtJ+NiMXDGFbYF9FB3/TpgUNDqDnQ==
X-Received: by 10.129.177.3 with SMTP id p3mr4635406ywh.318.1475617840548;
 Tue, 04 Oct 2016 14:50:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 4 Oct 2016 14:50:20 -0700 (PDT)
In-Reply-To: <20161004214914.kgkot337awszhojs@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net> <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net> <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
 <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net> <CA+P7+xo3nxy1EOjDqHvKQuK128c=b73XN=6qqn6g6oRGh2VdFg@mail.gmail.com>
 <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net> <CA+P7+xoDz2sOPrDrJhAhrqDQsRR8NVU-8kh6+G=8FJeXEJ1dtg@mail.gmail.com>
 <20161004214914.kgkot337awszhojs@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Oct 2016 14:50:20 -0700
Message-ID: <CA+P7+xqzqWk5ddZLjSmmfOMJ+QOW=J6S=8WSiCPYK_VE_pHLiQ@mail.gmail.com>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 2:49 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2016 at 02:43:24PM -0700, Jacob Keller wrote:
>
>> > Hmm. Now I am puzzled, because I _did_ line up them specifically to make
>> > this clear. I put the numbers under the ">" of the arrow. Did I screw up
>> > the spacing somehow so that isn't how they look to you? Or are you just
>> > saying you would prefer them under the "-" of the arrow?
>>
>> I bet they line up in a monospace font and I just happened to be
>> viewing this from GMail which isn't showing it in monospace and so it
>> doesn't line up. Ignore me and carry on
>
> Oh, good. I was wondering if I was going crazy. :)
>
> -Peff

Only one of us is going crazy, but I'm not sure who ;)

-Jake
