Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CCC520248
	for <e@80x24.org>; Tue,  9 Apr 2019 02:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDIC3k (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 22:29:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39268 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDIC3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 22:29:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so8384528pga.6
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QjbuJeAOaN27fBJid31TZfOEI8uCV2pzOGdnXf+QRY8=;
        b=QI4HE7sMGZy+uPyoRl7mL39mzfAWpu40az0KFs5Iv/cX7/yjb5zur45Qa9+IxMevSZ
         EPkzx3FDd5QYAN4FdR8490ijwESi9K1uTGQK2/HhKgRatHOIZn5qvMZ5Gx4rbDjOJC5O
         V1HrNHxO6Do50cM6CTsbE3t3VQZmRrBw+PppVUHsBwwf7rbPDwD6j6eLvB4OOs0RG9uM
         thmW9+xDevBWL6gWtkllGNhKVKsP/WvbTIGlUBntODpAT1VArmT5vMuFFs2uoZuQSbnU
         4CLnVexHxTw4SysbAZEK4KFZs68i4eK+YrjMMMTFdKXRby/cRQ3xg50ra2CpFXe6rg47
         x4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QjbuJeAOaN27fBJid31TZfOEI8uCV2pzOGdnXf+QRY8=;
        b=ZsJfIjH7R6VSy8I0F51SuRgqXIgd6g7kPjgyV/sRzCo5GIdeF78gDuOxw3rMcp/W8Y
         uVQYKy729i+Qvqs069uQw2CHlGBBRmleaDHxGLkocprsH1btMpYC61aFUU5UeCFTM7h8
         zx/7lgL2k1mLvydYLGynpM/jCRrJPZ9mCT/iAxA3ViM4Ndmy5JCPrmLEqYgwhqxFg938
         1je7rjZNPuUxnsRRf+NqX92IyL4UhGVDkQly4yfuVh+++krkGWUW1/79shzlQakq+pHJ
         UZqCW0vOWt5/6kUuFDpARfjIanlPwyCzSczDG9OR7Rk7ZajzCplTJRwU0DsALkFHKqYN
         7V2w==
X-Gm-Message-State: APjAAAVw/JJjpwrQTNtE0r62rDqyQyIKvibhQnbMxb/wtAIzcx73H0pS
        ZdfwSsOGlS45udM3OqfpFWPUEg==
X-Google-Smtp-Source: APXvYqykevNK5rMJjA3Vk6+jsC9xw3xz5LSXYtanyLbPpJbKmWgPBtIBTPDFFengx2slvIQ5NyEx3A==
X-Received: by 2002:a65:4341:: with SMTP id k1mr32353899pgq.88.1554776978456;
        Mon, 08 Apr 2019 19:29:38 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d869:cd1a:616d:3c11])
        by smtp.gmail.com with ESMTPSA id g2sm45660894pfd.134.2019.04.08.19.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 19:29:37 -0700 (PDT)
Date:   Mon, 8 Apr 2019 19:29:36 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190409022936.GE81620@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
 <20190405184229.GB8796@szeder.dev>
 <20190405185241.GG2284@sigill.intra.peff.net>
 <87a7h1a5uk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7h1a5uk.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Sun, Apr 07, 2019 at 11:00:19PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Fri, Apr 05 2019, Jeff King wrote:
>
> > On Fri, Apr 05, 2019 at 08:42:29PM +0200, SZEDER Gábor wrote:
> >
> >> > > Don't run git commands upstream of a pipe, because the pipe hides
> >> > > their exit code.  This applies to several other tests below as well.
> >> >
> >> > I disagree with that rule here. We're not testing "cat-file" in any
> >> > meaningful way, but just getting some stock output from a known-good
> >> > commit.
> >>
> >> It makes auditing harder and sets bad example.
> >
> > I disagree that it's a bad example. Just because a reader might not
> > realize that it is sometimes OK and sometimes not, does not make it bad
> > to do so in the OK case. It means the reader needs to understand the
> > rule in order to correctly apply it.
>
> FWIW I thought the rule was something to the effect of "we're hacking on
> git, any change might segfault in some unexpected test, let's make sure
> that fails right away", hence the blanket rule in t/README against "!
> git <cmd>" in favor of "test_must_fail git <cmd>", and "don't feed the
> output of a git command to a pipe" documented right after that.

I have some loosely-held opinions on this. Certainly knowing if a change
to git caused a segfault in some test is something that we would want to
know about, though I'm not sure we're loosing anything by putting 'git'
on the left-hand side of a pipe here.

  - If someone wrote a change to git that introduced a segfault in 'git
    cat-file', I'm sure that this would not be the only place that in
    the suite that would break because of it. Presumably, at least one
    of those places uses 'test_must_fail git ...' instead

  - At the very least, 'broken-commit' doesn't contain what it needs to,
    the test breaks in another way (albeit further from the actual
    defect), and the developer finds out about their bug that way.

In any case, these above two might be moot anyways, because I'm almost
certain that it will be a rarity for someone to _only_ run t6102, unless
it is included in a blanket 'make' from within 't'.

> > I am sympathetic to the auditing issue, though.

Just to satisfy my curiosity, I put git on the left-hand side of a pipe
to see how many such examples exist today:

  ~/g/git (master) $ git grep 'git cat-file .* |' -- t/t*.sh | wc -l
      179

I'm not going to claim that changing 179 -> 180 is neutral or bad, but
it's interesting nonetheless.

> > I dunno. In this case it is not too bad to do:
> >
> >   git cat-file commit $commit >good-commit &&
> >   perl ... <good-commit >broken-commit
> >
> > but I am not sure I am on board with a blanket rule of "git must never
> > be on the left-hand side of a pipe".

I think that I mostly agree with Peff here for the reasons above.

That all said, I don't really want to hold up the series for this alone.
Since there don't seem to be many other comments or issues, I would be
quite happy to do whatever people are most in favor of.

I basically don't really feel strongly about writing:

  git cat-file commit $commit | sed -e ... >broken-commit

as opposed to:

  git cat-file commit $commit >good-commit &&
  sed -e '' <commit >bad-commit

> >> > > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> >> > > dependency?
> >> >
> >> > Heh, this was actually the subject of much discussion before the patches
> >> > hit the list. If you can write such a one-liner that is both readable
> >> > and portable, please share it. I got disgusted with sed and suggested
> >> > this perl.
> >>
> >> Hm, so the trivial s/// with '\n' in the replacement part is not
> >> portable, then?  Oh, well.
> >
> > I don't think it is, but I could be wrong. POSIX does say that "\n"
> > matches a newline in the pattern space, but nothing about it on the RHS
> > of a substitution. I have a vague feeling of running into problems in
> > the past, but I could just be misremembering.
> >
> > We also tried matching /^tree/ and using "a\" to append a line, but it
> > was both hard to read and hit portability issues with bsd sed.

I think that all of this discussion is addressed elsewhere in thread, but
the gist is that Eric provided a suitable sed invocation that I am going
to use instead of Peff's Perl.

> > -Peff

Thanks,
Taylor
