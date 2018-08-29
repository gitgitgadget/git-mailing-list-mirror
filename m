Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8DAC1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 17:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeH2Vtf (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 17:49:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34663 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH2Vtf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 17:49:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so4402277eds.1
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fEwQx93PBooJWWmkXIWZZ6w81hxTBOWN3BdF72f40bg=;
        b=m17WeDY4BFs9sqWuof/dDzAdfvQdL03kklygzzCe8SeF5/Czk8CwJRNThLgKBBfYHr
         lAZjlrPa7uqKav3CgfL24C9SlcW7yrhQHnWycF3M+qVYxm0EygYhTzLAyd1MgzoQbski
         8OEzeR4dQ3INkrhAL78Fx0YhUyFXQXxKqc07/hQ2gYqD+fOkKvFI41AVJYU9bPLfh0CD
         fWOU6DBgUysV31gKzcKB3hcAvSLmBBnvBX5eMdWBoRB+pMY2FPwW/a5q4M2YVJvPQhqb
         akH4iS/qM4FJQYSPlLdPSNiufk3nK4vX2pKfK2D9qVDK+xRTl+IOuKpb/7HPHnicOyoQ
         FAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fEwQx93PBooJWWmkXIWZZ6w81hxTBOWN3BdF72f40bg=;
        b=lxUHcCVVx8lsEPBR6cL7dMjrX1EXcizanMiSTVEk/rC7a/XxglO3cZRN0Af6r2ebxw
         OXCFgWmQI3S3snkJ0mI/3YN2Ad0lLSmNmg0nxGX9Yg00yGrpxVV0NiLUBFAnFfoKRhh7
         yh3aTOFjQcdf5XWr+LVQM18aiS7twUdYJJrUSvcKgGfANCET8UnT4k4RAjAlkGntTjOu
         i060rGO4b7bnQwkKpQTvNEYUJApXai5L4Kjj0JGO3eYCErBbVgvCskjWGijVD3itEvU6
         csx62idYUiMriSQKO55A/YSMNqGFIT2MXVsPJeknUTHajyG2XlGT40fHext/baFE6CaJ
         nHig==
X-Gm-Message-State: APzg51CgldM7qfero+mwU6aIvyyrIWpwaqszmd4nJ3b90+ds1JaYo2/j
        O5qdUc3s4PDqrYb33Q+arbrJOXFX50xIjuD/WhfAtOki4a4=
X-Google-Smtp-Source: ANB0VdajM4xf6PPhR5QzvyjXXirgza9CHjPTjKmA9n1qUaAw3Pe6mJlZeSDDgxs98CMgRC+tQy7zGa751xHI7SA0vwY=
X-Received: by 2002:a50:b0c1:: with SMTP id j59-v6mr8986715edd.267.1535565093222;
 Wed, 29 Aug 2018 10:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <878t4xfaes.fsf@evledraar.gmail.com> <20180824014703.GE99542@aiede.svl.corp.google.com>
 <877ek9edsa.fsf@evledraar.gmail.com>
In-Reply-To: <877ek9edsa.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Aug 2018 10:51:22 -0700
Message-ID: <CAGZ79kaGb_TL7SiR4CFGFzrfy2Lotioy76o6sUK4=vZK5qwqNA@mail.gmail.com>
Subject: Re: How is the ^{sha256} peel syntax supposed to work?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 2:13 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Aug 24 2018, Jonathan Nieder wrote:
>
> > Hi,
> >
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >>> git --output-format=3Dsha1 log abac87a^{sha1}..f787cac^{sha256}
> >>
> >> How is this going to interact with other peel syntax? I.e. now we have
> >> <object>^{commit} <sha>^{tag} etc. It seems to me we'll need not ^{sha=
1}
> >> but ^{sha1:<current_type>}, e.g. ^{sha1:commit} or ^{sha1:tag}, with
> >> current ^{} being a synonym for ^{sha1:}.
> >>
> >> Or is this expected to be chained, as e.g. <object>^{tag}^{sha256} ?
> >
> > Great question.  The latter (well, <hexdigits>^{sha256}^{tag}, not the
> > other way around).
>
> Since nobody's chimed in with an answer, and I suspect many have an
> adversion to that big thread I thought I'd spin out just this small
> question into its own thread.
>
> brian m. carlson did some prep work for this in his just-submitted
> https://public-inbox.org/git/20180829005857.980820-2-sandals@crustytoothp=
aste.net/
>
> I was going to work on some of the peel code soon (digging up the type
> disambiguation patches I still need to re-submit), so could do this
> while I'm at it, i.e. implement ^{sha1}.
>
> But as noted above it's not clear how it should work. Jonathan's
> chaining suggestion (<hexdigits>^{sha256}^{tag} not
> <hexdigits>^{tag}^{sha256}) makes more sense than mine, but is that what
> we're going for, or ^{sha256:tag}?

The choice of hash seems position independent to me, so as a user
I would expect both to work at first. Though when looking at more
syntax of these expressions, e.g. b9dfa238d5c34~1^2^^, it is
read left to right, i.e. you arrive at the destination by evaluating
the next part of the expression and then jumping around based on
each expression. And with that model, <hexdigits>^{sha256}^{tree}
could mean to obtain the sha256 value of <hexvalue> and then derive
the tree from that object, so it is unclear if the tree object would also c=
ome
in sha256 or if we could just return the tree in sha1 notation (as it would
be correctly - though confusingly - described that way. The sha256
conversion happened at an intermediate step.)

So with that said, I would expect the hash specifier at the end of the chai=
n.

Would the position of the hash specifier make any difference for
verifying signed tags/commits ? (subtle asking to verify the sha1
signature or the sha256 signature explicitly vs asking to verify an object
that is given with <hexval> in sha1 or in sha256)

Thanks,
Stefan
