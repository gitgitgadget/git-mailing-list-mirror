Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3B31F453
	for <e@80x24.org>; Wed,  3 Oct 2018 14:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJCVl6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 17:41:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35568 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCVl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 17:41:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so5974464wmc.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vbgnmM1pSjdLKoJ3FYDCrShqMC/9kmflLyyymVMwuAo=;
        b=eJsWwR3g0fBGBWw0PkZlKRSCufwSps9gtemdb2In1xu8yWVJHF80TF/5mFK8QpYF1p
         +PEUYJJ2qw3/fVlW+4I0SespGPz36BJ/KQlubW6ZvbkZyShq6IPBC6P4IzkOmMl7IXgl
         5MsZR/w9Kafpe83kUm2VnUHcRXYaXJbAfMpJxP5x4S7WFxEUn1L6z36pBaT2xbBte2hr
         sJR+lYHXvKdS3USdZmJ8f3tUpMNR14eN05+TAFSaTJ9/wXuOZSiWKBykT9ARKz5HjnSG
         ryqdgkmG228frWKosyjLQgQLzDUQ3vH0fvZELun/5XA4/mQPgejQkXMWVaOLgZPk9g0P
         t8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vbgnmM1pSjdLKoJ3FYDCrShqMC/9kmflLyyymVMwuAo=;
        b=byOh0Fug1qdtWtNd72hA3WrXecsrOTA6y7TTKONFBZBfEN/lxOxc/romSHv53oyF1K
         A4MH5Gln9qo/fV6/0+3ec1v8E1AlixQyVeznYuc6CAWKlK+FyOOZIG/+LyiY7byNgJJv
         PWtPPrnGzXX0ccaidpPw07fkaOyKkt7dvZRD38uRQKMdFJt047/93L/NgUBM0RBd4NgR
         6s34Kqxfj1/CNYHmYs3qIkV8E+x9n59H2hdb8c495er5W+Jqz6HnuSIXZKG9ncRJpQaG
         gqo3xi5N6/NtMO+ZkedFXhQ5CUA2Ms80YROXDqGb7twamtk3yxJAdBUJzwszykeWkFEe
         4Mlg==
X-Gm-Message-State: ABuFfohdNKeVb7lPqNBPOyCUW0lRPfr3ohgho6MzY+I/XsUeZ2YHSaDh
        0S0I9Ea3Tnh8jSxofUiEnNY=
X-Google-Smtp-Source: ACcGV63cgbISg1t8Qn/GkaOMMl4xnz4jr7MScOtZUu3Mo1tgybF4JQtpt5DD3piQTrZ8yFYm+VCXRg==
X-Received: by 2002:a1c:1b91:: with SMTP id b139-v6mr1743064wmb.147.1538578391979;
        Wed, 03 Oct 2018 07:53:11 -0700 (PDT)
Received: from localhost (x4dbea401.dyn.telefonica.de. [77.190.164.1])
        by smtp.gmail.com with ESMTPSA id 77-v6sm4052713wmv.6.2018.10.03.07.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:53:10 -0700 (PDT)
Date:   Wed, 3 Oct 2018 16:53:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181003145308.GP23446@localhost>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost>
 <87o9cbglez.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9cbglez.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 04:22:12PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 03 2018, SZEDER Gábor wrote:
> 
> > On Wed, Oct 03, 2018 at 04:01:40PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Wed, Oct 03 2018, SZEDER Gábor wrote:
> >>
> >> > On Wed, Oct 03, 2018 at 03:23:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> >> Don't have time to patch this now, but thought I'd send a note / RFC
> >> >> about this.
> >> >>
> >> >> Now that we have the commit graph it's nice to be able to set
> >> >> e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
> >> >> /etc/gitconfig to apply them to all repos.
> >> >>
> >> >> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
> >> >> until whenever my first "gc" kicks in, which may be quite some time if
> >> >> I'm just using it passively.
> >> >>
> >> >> So we should make "git gc --auto" be run on clone,
> >> >
> >> > There is no garbage after 'git clone'...
> >>
> >> "git gc" is really "git gc-or-create-indexes" these days.
> >
> > Because it happens to be convenient to create those indexes at
> > gc-time.  But that should not be an excuse to run gc when by
> > definition no gc is needed.
> 
> Ah, I thought you just had an objection to the "gc" name being used for
> non-gc stuff,

But you thought right, I do have an objection against that.  'git gc'
should, well, collect garbage.  Any non-gc stuff is already violating
separation of concerns.

>  but if you mean we shouldn't do a giant repack right after
> clone I agree.

And, I also mean that since 'git clone' knows that there can't
possibly be any garbage in the first place, then it shouldn't call 'gc
--auto' at all.  However, since it also knows that there is a lot of
new stuff, then it should create a commit-graph if enabled.

> I meant that "gc --auto" would learn to do a subset of
> its work, instead of the current "I have work to do, let's do all of
> pack-refs/repack/commit-graph etc.".
> 
> So we wouldn't be spending 5 minutes repacking linux.git right after
> cloning it, just ~10s generating the commit graph, and the same would
> happen if you rm'd .git/objects/info/commit-graph and ran "git commit",
> which would kick of "gc --auto" in the background and do the same thing.
