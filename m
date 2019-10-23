Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5797C1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 00:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbfJWA03 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 20:26:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54705 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731883AbfJWA02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 20:26:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id g7so1135244wmk.4
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 17:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UXAdJBAtryvwju9W//m9OwaThLBfFAZNVJIL3WkEsQg=;
        b=GXIdbYiN/xS5Jhfl1L0+O5c6dX494QL0jojsfTgG/LAU2ftmXMNhRRxbXVh4VHyRjE
         t5xmvm2eD3SUfCt6imuloOvQF5IsDwKrHGy8s+i3F7KPv4zPrxHUl1ipFl+nYs30hJjc
         oQ9L5iE2Zsx5j59DWqVjrY9DTN1HrFgHbtmYb2+99mwZg2uP4q4GuR/op9795fDUKE2v
         0wGN+eQ0vhBa7eq8y7cGeI/FKUut5EE8cMMmxUm4cRHYgKmgzoPjIgOdbsulIZXV0Cu/
         CAYQOO7i18ii0UC1q3S16S+5VwQQULz4qERk+OJ7TPld4j+WqS1Ny3+ofxuRqkM7ENeE
         tRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UXAdJBAtryvwju9W//m9OwaThLBfFAZNVJIL3WkEsQg=;
        b=CvKtWY6Lsd9d2mgzFbZdXW8Jl3G8WfI04eY9zYlclShRXIitUrrqZ8OQJ93TZB5n1/
         4VLgtdi6mGluXb/zqT8kdz6GrRuIB8+4SJczLTBqK4oHNDwnYzMfISJqbCVJacRDJDGR
         K/zPuLONrML7Uz9wnlBQBKiKKzfxUBN6w1cCXF8LKgW+7LUnyfJX6cKlP5PJTbQZQQih
         hbgmXx8+zWOSi5GpNFbtDTUQykPT5kq2L6WWB0DKavxjbskFZdbEGH3qWbcR8ihJwE5e
         VdPqyo+P1szaOF7dDYU+fKkfLgElFXjRN1sjoXQvMUOZjAbOG/5Zg/Q1szhO5HXHBaef
         pOMg==
X-Gm-Message-State: APjAAAWWGpT7C9pGvZHoUjW/blUwEHmdBfYd0hiKtuUGmiGyPqpkBP/4
        hPPOLFL0AdG8QKlRmj8vOUU=
X-Google-Smtp-Source: APXvYqwpdU9HdVM6ouVuyKoGWzvNH1VEc/sM+tm5CTzaBEx/P4KUA7pvjISR4v8zHFc3uCWcCDnJNQ==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr5215345wmc.139.1571790387273;
        Tue, 22 Oct 2019 17:26:27 -0700 (PDT)
Received: from szeder.dev (x4dbe0456.dyn.telefonica.de. [77.190.4.86])
        by smtp.gmail.com with ESMTPSA id b62sm28070115wmc.13.2019.10.22.17.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 17:26:26 -0700 (PDT)
Date:   Wed, 23 Oct 2019 02:26:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] ci(osx): use new location of the `perforce` cask
Message-ID: <20191023002624.GG4348@szeder.dev>
References: <pull.400.git.1571160721.gitgitgadget@gmail.com>
 <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
 <372ab24acffbc956407cd93ed34135f83156e10d.1571316454.git.gitgitgadget@gmail.com>
 <20191018105143.GY29845@szeder.dev>
 <nycvar.QRO.7.76.6.1910222120090.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1910222120090.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 01:23:25AM +0200, Johannes Schindelin wrote:
> On Fri, 18 Oct 2019, SZEDER Gábor wrote:
> 
> > On Thu, Oct 17, 2019 at 12:47:33PM +0000, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > The CI builds are failing for Mac OS X due to a change in the
> >
> > s/CI/Azure Pipelines/
> >
> > Our Travis CI builds are fine.
> 
> For the moment ;-)

Touché.
Believe it or not, I did wrote "at least for now" at the end of that
sentence, but then deleted it.  Serves me right, now there is some new
breakage with gcc@8... :)

> If you don't mind, I am going to copy/edit these three paragraphs into
> the commit message,

Sure, go ahead.

> > In our CI builds we don't at all care what the checksums of the
> > Perforce binaries are, so I would really like to tell 'brew' to ignore
> > any checksum mismatch when installing 'perforce'.  Alas, it appears
> > that 'brew' has no public options to turn of or to ignore checksum
> > verification.
> 
> Sad, yet true, that we indeed have no command-line option to say "you
> know what, your checksum possibly mismatches, but we really don't care".

Actually, 'brew' does have some undocumented options, but I didn't
even bothered to check, because it's not really sensible to rely on an
undocumented option (especially when even the documented options break
every once in a while...).

> > Now, let's take a step back.
> >
> > All 'brew cask install perforce' really does is run 'curl' to download
> > a tar.gz from the Perforce servers, verify its checksum, unpack it,
> > and put the executables somewhere on $PATH.  That's not rocket
> > science, we could easily do that ourselves; we don't even have to deal
> > with a tar.gz, the 'p4' and 'p4d' binaries for mac are readily
> > available for download at:
> >
> >   http://filehost.perforce.com/perforce/r19.1/bin.macosx1010x86_64/
> >
> > And, in fact, that's what we have been doing in some of our Linux jobs
> > since the very beginning, so basically only the download URL has to be
> > adjusted.
> 
> I'd rather not.
> 
> Just because there is no better way on Linux, and just because the
> current `perforce` cask recipe happens to just download and unpack that
> file does not mean that this won't change.

Yeah, I'm fairly sure that the way Homebrew installs Perforce will
change, but if we download Perforce ourselves, then it won't matter at
all.

Downloading the Perforce binaries with 'wget' worked fairly well for
almost four years, except from that server glitch a couple of weeks
ago; I think downloading the macOS binaries from the same server would
work just as well.  OTOH, this is the fourth time that we have to
tweak how we install Perforce via Homebrew.

FWIW, it looks like this:

https://github.com/szeder/git/blob/ci-osx-wget-perforce/ci/install-dependencies.sh#L11
