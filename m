Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09471F731
	for <e@80x24.org>; Fri,  9 Aug 2019 17:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407372AbfHIRje (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 13:39:34 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38288 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406652AbfHIRje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 13:39:34 -0400
Received: by mail-lj1-f171.google.com with SMTP id r9so92793910ljg.5
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKqC8UmBE0bA/R0p7ECU2Lo6s1P9FlbL4vyaNhfUyDw=;
        b=ZGwEqu1wsjyq9xEZNSmwKqAvnEvQ5bOjMPRZnivKCz2Q15XNR9wS1/kJ3iDfPxviWJ
         Vw7PY5yVwG4WIkgUlPIsc8H7C+VPRHQoSE7KnJBj9llsdkwE/AoRm32APNRedmLmdMLK
         v3Qp3cYfFlNj+5McpvqPDuQPzEvXlfPOBPF6MIf39Zh/366uakfhpAjp6drkYYzLHEgw
         qf6t4oOpB14BQROFAXjPqCedvqLBxxVGqWwCIF63MQHAW+ryLm/WH9wOUo7sqHOFokbh
         NNKVX64VnhuslemRvNqDHYX6YilIo7BfXHriTJxNY6w1yuftibBRUG6aUb2T4KfN1cdT
         DGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKqC8UmBE0bA/R0p7ECU2Lo6s1P9FlbL4vyaNhfUyDw=;
        b=RFXqD56+3HsFNa3/PUWe40tf5IqWD9fCDG3NvM5y3OA+ITLxGSEsl4Yq7lOO643AlH
         jt4XKYMtzDbnNj+wcK80SykhihT1b0a/XsOJr+0ymypKWKUSZ5mP9Veis1QJ5Z3g+ptJ
         vURU308J7Iw8sjxZkny35eEnogUSE3dXJka16G+cgC8qWWhY/UA5zWC1U95P2rIFPpFl
         ZShpdEnJGZNfVfN2EYWHi072GJeeuuusMv0wipAoW8LqX7YkKqn9YDOD8E8Vf6kRBt9k
         YHSDoFgillburNXPYw2iQU25Ek+lQF0Wv2T4Oh/wC6LC+RYNRGrDCvhmBAVlnnUMvENj
         KDJQ==
X-Gm-Message-State: APjAAAWis/UboRvlKKGGB3t2PaVq+WZmNU3DbGsp4xedV4UW8F+CDuUU
        IoVT9s7jV6wj550fSeuUldVt1QBBfQxLOymTJWI=
X-Google-Smtp-Source: APXvYqxEpA7RZdJUoHtgBIzUsAJW8XNnPcML3kKlS+pO6j9pe0/wlfYoxhJLuN+GDx6pGYHYG9o2YzOFX7hJKmgH9Mg=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr12243841ljl.8.1565372372084;
 Fri, 09 Aug 2019 10:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com> <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org> <20190809020732.GA89008@syl.lan>
 <CABURp0oFNWfWEwnkjV1+Tag91HTRBCaJjyvc8CXtPGu78DhtSw@mail.gmail.com> <20190809114148.GB3957@sigill.intra.peff.net>
In-Reply-To: <20190809114148.GB3957@sigill.intra.peff.net>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 9 Aug 2019 10:39:10 -0700
Message-ID: <CABURp0q-gfXWiembsHYZb9bxhKrd6=zJA2bfQek0JDxeEP1HGA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 9, 2019 at 4:41 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 08, 2019 at 08:07:36PM -0700, Phil Hord wrote:
>
> > The long form you give there is to be used in case the old email
> > address is not a unique key. See 'git help shortlog'.
> >
> > The problem we have at work is that one woman's old email address
> > includes her deadname, like <firstname.lastname@company.com>.  I will
> > leave it up to her whether she chooses to be listed explicitly in the
> > mailmap.  I have wondered if we should permit hashed email addresses
> > to be used for this specific case, but this also has its drawbacks.
>
> Since the set of hash inputs is finite and small (i.e., the set of all
> emails in the repository), it would be trivial to generate the plaintext
> mapping from even a cryptographically strong hashed mapping.
>
> Which isn't to say it's _totally_ worthless, since that adds an extra
> step, but it really is just obfuscating the data.

Yes, obfuscation is all I expect. Someone who needs deeper scrubbing
will need to rewrite their history instead.
