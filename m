Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C271F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeHNWg4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:36:56 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:39537 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeHNWg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:36:56 -0400
Received: by mail-yw1-f44.google.com with SMTP id r184-v6so17129453ywg.6
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bxkMkgdqvux9KxYO1L11k658zJxzw56SB3IIN5vz7s=;
        b=KjLiI9tR7TYuxk/ApY9tPA9g/7ph8GZlToJPRDllTmAycClPMeKhUGSMzM0aH/hg+z
         bohQpgbzqbQqgh86sewrHpqguwsTklwkgJnE5f54Xp5BAZwDv2EXFI/XAvAvzrsHjeMK
         Z2C6TD9HmkXu78xlpr6ZhsEdajqakCem/Qi62Sph3kPlLRJYkqpaaSlUsr1pLbmBymg1
         ExO19PSp8h4keEH+cHeLc3cPaJmJKXS/1oyEAu/ZqwULCfUxLHmvUsl7I8pDekGdm312
         8e7CbbvnirBm5QsQGJbGF6pOmlJsJ3qZIBDb3Jrr9bBE+f/sSfISnVINYq2d0I7JRz0U
         CeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bxkMkgdqvux9KxYO1L11k658zJxzw56SB3IIN5vz7s=;
        b=S126IjoXTzYW9VACYcdFvHGKYNEzu6XN9V3nBTU++He/I+2O3S7u+P/3GrzjaisUno
         OYB7ko9SGi4H2wk5E4jKdxMeuL9D1OGjCrubCF3eT9K/JgAHfGLEWiWWCJn+k6NDDUzZ
         Qn5/vqzs5Z5+bNa6mHCJh645ZA+PBU118cJTFE3q8msO2l4nfjXQSg0Sb3MivbhmfJqo
         EztM98kPik29UeaOrHhX8XoaSLpmlPQ6pQZ6T8UvlAccieIghGVQ7gNCYnMNwKMqRJ8s
         8+HbwD7Fs8a0OBrhb8azZtFYM7rgv+rM5jArByDpcoLDBOrWeOiUFTHOlQ77FExoFTsE
         X9mw==
X-Gm-Message-State: AOUpUlH1yFoNpN/x7fULTL12AAZ4CIumLU+jJzj7g2yRiKcNApLbPR7+
        buwGbyQVnF+85fN2qtAr9/Un32U6sWm+y4fHt3kddw==
X-Google-Smtp-Source: AA+uWPz34RXaNnuCq7LO+RPYKr+HZDgbssBr3M6gD22ui4+9b0JIBEFQQ7pJc1mXfXENeLnSv+HebSgSI9MFZ4N1j3c=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr27090ywd.414.1534276090318;
 Tue, 14 Aug 2018 12:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180813163108.GA6731@sigill.intra.peff.net> <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com> <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net> <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
 <20180813215431.GB16006@sigill.intra.peff.net> <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>
 <20180814193646.GC28452@sigill.intra.peff.net>
In-Reply-To: <20180814193646.GC28452@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 12:47:59 -0700
Message-ID: <CAGZ79kZYx-BOpx8SWeaP2Zskw0-OsSSVPZB4QJerAu9ST2swaA@mail.gmail.com>
Subject: Re: Measuring Community Involvement (was Re: Contributor Summit planning)
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 12:36 PM Jeff King <peff@peff.net> wrote:

> Thanks, it was nice to see a more comprehensive list in one spot.
>
> It would be neat to have a tool that presents all of these
> automatically, but I think the email ones are pretty tricky (most people
> don't have the whole list archive sitting around).

With the advent of public inbox, this is easy to obtain?

>
> > 2. Number of other commit tag-lines (Reviewed-By, Helped-By, Reported-By,
> > etc.).
> >
> >     Using git repo:
> >
> >     $ git log --since=2018-01-01 junio/next|grep by:|grep -v
> > Signed-off-by:|sort|uniq -c|sort -nr|head -n 20
>
> At one point I sent a patch series that would let shortlog group by
> trailers. Nobody seemed all that interested and I didn't end up using it
> for its original purpose, so I didn't polish it further.  But I'd be
> happy to re-submit it if you think it would be useful.

I would think it is useful. Didn't Linus also ask for a related thing?
https://public-inbox.org/git/CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com/
