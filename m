Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04E591F424
	for <e@80x24.org>; Thu, 10 May 2018 02:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeEJCAP (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 22:00:15 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:38048 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeEJCAN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 22:00:13 -0400
Received: by mail-pl0-f53.google.com with SMTP id c11-v6so345805plr.5
        for <git@vger.kernel.org>; Wed, 09 May 2018 19:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yTcThFniYl0bpYRLKWcw+/oaRFfn5TE4p805pFurS8c=;
        b=FdyIKHvpXu5fudrJJkb5/Uvs1auXkqRzovaQu+nl5TBDwe4PtzbFs65I2PIN/2DamM
         WQPXrXCwv5V0Awz9i5CkC6zuBnZOJTMQ53ykRRJ+ETXBe0f7hNg7qTNZxNjgdCnhspVU
         kHAEdO0CBXxOv/XIbXsukrbn3O7vqIHm5Z9hIsiNv3yX0Wkw8MnKCdNgmUQZ3nQEP56D
         /k1mQq3Hjt41H6qeNo4LuSWN4IGtadYpPAsgKGRpLatll+pYkA+FzpYRwAM2+YfzTR0A
         IMTSCWeMGboF9CtAh5Fx1GVQ658WhMzeNEyWctmRCwb4Ig+KmgMV1uC5P00YcnW7LNA0
         +ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yTcThFniYl0bpYRLKWcw+/oaRFfn5TE4p805pFurS8c=;
        b=ZXlcwjTfqNp5Q0dTTIwa9kdhZj5QzHJlp01xnugi7lDFPa9UH14xklUJDEa8piObQt
         DJ85nfvi0yDLtnGRuk3X5rH0hb30TY5JNkiUddIENAMIVOL83NgXNQ05DLFcwdh1dG+r
         PzqlX7i9Lz3yYWvuVB2T6PJIjAng9HUvEKsJ6dkpnD0eJ9vHUU19p/OCqatXMPx8v0iy
         DPdJDcZZrAAgPc/XFBqtLcbkikW2W/9+6gen06erxVbWg7E7CANEwJFj7wulH2fex2Oh
         7qSQwDXJfR+x4HkWxiekoytGuIMH/KB9oFiLQ+/8cHZWCdRHPtL4NzP4RQcMz57WUPqt
         3Tfg==
X-Gm-Message-State: ALQs6tBI+pxB8xe+U/E7iFL0WNlBEJqeFXDGT62cgt+ZS37Pf60FXFq8
        msx6j5cpCcajmtcL6hrtn5XTAA==
X-Google-Smtp-Source: AB8JxZpyVWnpponefKT6qd0r5QQ9crJ8Zt3xwOUQC5RChBuYwzcfnjtl+HlUMx+OuT8nQZt3stg0eA==
X-Received: by 2002:a17:902:8f84:: with SMTP id z4-v6mr29012575plo.194.1525917612967;
        Wed, 09 May 2018 19:00:12 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:eccb:c00:cd8f:fd73])
        by smtp.gmail.com with ESMTPSA id u4-v6sm5997423pgn.10.2018.05.09.19.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 19:00:11 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 9 May 2018 19:00:10 -0700
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/grep.c: teach '-o', '--only-matching' to
 'git-grep'
Message-ID: <20180510020010.GA5375@syl.local>
References: <cover.1525492696.git.me@ttaylorr.com>
 <c8b527c5de3b0e5422d2c1afb91d454d1e46fff4.1525492696.git.me@ttaylorr.com>
 <87fu36y4u0.fsf@evledraar.gmail.com>
 <20180508172517.GA934@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508172517.GA934@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 08, 2018 at 01:25:17PM -0400, Jeff King wrote:
> On Sat, May 05, 2018 at 08:49:43AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> > > +test_expect_success 'grep --only-matching --heading' '
> > > +	git grep --only-matching --heading --line-number --column mmap file >actual &&
> > > +	test_cmp expected actual
> > > +'
> > > +
> > >  cat >expected <<EOF
> > >  <BOLD;GREEN>hello.c<RESET>
> > >  4:int main(int argc, const <BLACK;BYELLOW>char<RESET> **argv)
> >
> > We should test this a lot more, I think a good way to do that would be
> > to extend this series by first importing GNU grep's -o tests, see
> > http://git.savannah.gnu.org/cgit/grep.git/tree/tests/foad1 they are
> > license-compatible. Then change the grep_test() function to call git
> > grep instead.
>
> I'm trying to figure out what GNU grep's tests are actually checking
> that we don't have. I see:
>
>  - they check that "-i" returns the actual found string in its original
>    case. This seems like a subset of finding a non-trivial regex. I.e.,
>    "foo.*" should find "foobar". We probably should have a test like
>    that.
>
>  - they test multiple hits on the same line, which seems like an
>    important and easy-to-screw-up case; we do that, too.

Agree.

>  - they test everything other thing with and without "-i" because those
>    are apparently separate code paths in GNU grep, but I don't think
>    that applies to us.
>
>  - they test each case with "-b", but we don't have that (we do test
>    with "--column", which is good)

Right, I think that we can ignore these groups.

>  - they test with "-n", which we do here (we don't test without, but
>    that seems like an unlikely bug, knowing how it is implemented)

Fair, let's leave that as is.

>  - they test with -H, but that is already the default for git-grep

Good, we can ignore this one.

>  - they test with context (-C3) for us. It looks like GNU grep omits
>    context lines with "-o", but we show a bunch of blank lines. This is
>    I guess a bug (though it seems kind of an odd combination to specify
>    in the first place)

I'm torn on what to do here. Currently, with -C3, I get a bunch of lines
like:

  <file>-

Which I think is technically _right_, but I agree that it is certainly
an odd combination of things to give to 'git grep'. I think that we
could either:

  1. Continue outputting blank lines,
  2. Ignore '-C<n>' with '-o', or
  3. die() when given this combination.

I think that (1) is the most "correct" (for some definition), so I'm
inclined to adopt that approach. I suppose that (2) is closer to what
GNU grep offers, and that is the point of this series, so perhaps it
makes sense to pick that instead.

I'll go with (2) for now, but I would appreciate others' thoughts before
sending a subsequent re-roll of this series.

> So I think it probably makes sense to just pick through the list I just
> wrote and write our own tests than to try to import GNU grep's specific
> tests (and there's a ton of other unrelated tests in that file that may
> or may not even run with git-grep).

I agree. Since some of these cases are already covered, and some don't
have analogues, I think that it is most sensible to go through the above
and add _those_, instead of porting the whole test suite over from GNU.

> > It should also be tested with the various grep.patternType options to
> > make sure it works with basic, extended, perl, fixed etc.
>
> Hmm, this code is all external to the actual matching. So unless one of
> those is totally screwing up the regmatch_t return, I'm not sure that's
> accomplishing much (and if one of them is, it's totally broken for
> coloring, "-c", and maybe other features).
>
> We've usually taken a pretty white-box approach to our testing, covering
> things that seem likely to go wrong given the general problem space and
> our implementation. But maybe I'm missing something in particular that
> you think might be tricky.
>
> -Peff

Thanks,
Taylor
