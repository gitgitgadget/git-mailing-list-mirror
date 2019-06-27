Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E6E1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 13:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0NXZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 09:23:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41589 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0NXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 09:23:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so2544879wrm.8
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1DPoFun9C+9ZkZtUO8EI29oT4j3upY3JKlybVf0Uxxc=;
        b=Ib5mJobiT60LRxSZZDE4XhmdocktOQokjaW0vgwsYysazNqXfIrBLSvEImefC4NlJ3
         bhRbgdXuFy5k4P3bSCOW5E/yqNQiZUoOEn2TisPonLawuzKSH3Ch02ztXM/uGjESoyoB
         lbdm9ijVnscbxEbBY5AUUdyxj524ccHuPelKFDLWd9toJR0m8UOob0FLpFlx3N7GZsNl
         mT8CmMJm79rDIdPON3UFgdN3AT52rC/PwDOw7fPgNeDW9qa9CQ0y2bPyRx8VAMy0oJ/k
         aih1jGQxS2P+lmtpjxBa5RN3Og876QT1ZoY8Oppib8xjqBJNp8t6UIBapVeL0QukK2AT
         gKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1DPoFun9C+9ZkZtUO8EI29oT4j3upY3JKlybVf0Uxxc=;
        b=a2Gkl/GTfIK2sDeCYpUuMp57R4TFYWbTs96donDsQfSOzswk8iSs/HVn2ZF3FAxZg0
         Hr1C5gJz/32xf306zdUBEx0Vq7BT/GmeA1zd7xhx305gSOTLJwPmnC5MxMM6GtsnEBBE
         8QgwBNPPr+2DPsVriRlYktmaEmV/jKBoJscXOWYQP53o+U8hkQAEhUzGzDX0NsTzHEBZ
         8Uel+4q5UPoYZQhsw4NtU4pjtQS0ktuQsPkwpq2QF37XpazuNG6ZevGt9E5vvQUxDatR
         VtogkIyYlvOhygicLjLxpIid3Rh1fj30MLTcFRlPHjf+RqVF7x4rAEdkwMwEtLItzu0E
         2zyQ==
X-Gm-Message-State: APjAAAVcz/y9syEl5fZ/TPJij8ZKopBYtP/aXYOVHhFWzUxWOS0Ce8mq
        g6xD1oqDjcJzvu4Tsd+Gnos=
X-Google-Smtp-Source: APXvYqzecejALS5GaCEPAkexlqeb8tMXwcwtVAie8ADVYn6cUDtubVsW9smUIO52BEC6RQEOkSWSNg==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr3517841wrw.81.1561641802872;
        Thu, 27 Jun 2019 06:23:22 -0700 (PDT)
Received: from szeder.dev (x4d0c4603.dyn.telefonica.de. [77.12.70.3])
        by smtp.gmail.com with ESMTPSA id m9sm3276607wrn.92.2019.06.27.06.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 06:23:21 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:23:19 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Travis not looking so good
Message-ID: <20190627132319.GB21574@szeder.dev>
References: <nycvar.QRO.7.76.6.1905302125190.44@tvgsbejvaqbjf.bet>
 <20190601004143.GN8616@genre.crustytoothpaste.net>
 <20190602112239.GO951@szeder.dev>
 <20190626203559.GA71590@TaylorsMBP3745.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626203559.GA71590@TaylorsMBP3745.attlocal.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 03:35:59PM -0500, Taylor Blau wrote:
> Hi Gábor,
> 
> On Sun, Jun 02, 2019 at 01:22:39PM +0200, SZEDER Gábor wrote:
> > On Sat, Jun 01, 2019 at 12:41:43AM +0000, brian m. carlson wrote:
> > > On 2019-05-30 at 19:32:41, Johannes Schindelin wrote:
> > > > Hi Gábor,
> > > >
> > > > do you have any idea why Travis is failing like this in the macOS/gcc
> > > > job?
> > > >
> > > > > +case "$jobname" in
> > > > > +brew link gcc@8
> > > > > Error: No such keg: /usr/local/Cellar/gcc@8
> > > > > The command "ci/install-dependencies.sh" failed and exited with 1 during .
> > > >
> > > > I usually only look at the Azure Pipelines (which gives me plenty enough
> > > > to do, what with pu's individual branches being tested individually), but
> > > > couldn't fail to notice that *all* four branches (maint, master, next and
> > > > pu) fail in Travis' macOS/gcc job (and only there, the Azure Pipelines are
> > > > all green):
> > > >
> > > > https://github.com/git/git/branches/all
> > > >
> > > > What's going on?
> >
> > The usual: Homebrew desperately tries to be overly clever and helpful,
> > but ends up being dumb and annoying. :)
> >
> > I was hoping that this issue will just solve itself, like several
> > other brew breakages in the past, but apparently it won't...
> 
> I have noticed this as well on my own fork's TravisCI builds.
> 
> > > I suspect if we want to use GCC 8, we need to explicitly install it by
> > > using "brew install gcc@8", or we can just pick the latest released GCC
> > > by using "brew install gcc" if we like that better. We will still need
> > > to do "brew link gcc" (or "gcc@8"), since I suspect Homebrew won't
> > > auto-link it since macOS provides a gcc binary.
> >
> > Yeah, installing gcc@8 or gcc works.  Back in 2c8921db2b (travis-ci:
> > build with the right compiler, 2019-01-17) I opted for simply linking
> > the already installed gcc@8 package, because GCC is big, installing it
> > takes time, and the macOS build jobs have always been prone to
> > exceeding the time limit.

Oh, and now I recall that simply running 'brew install gcc@8' back
then (or running it before 'brew update' nowadays) errored out with
something along the lines of "gcc@8 is already installed, you only
have to link it".

> > (Note that these packages provide 'gcc-8'
> > and 'gcc-9' binaries, not 'gcc', and after 'brew install'-ing them we
> > won't need an additional link step (I'm not sure why linking is
> > necessary with the gcc@8 package already installed in the Travis CI
> > image).)
> 
> I wrote something like this up in [1] before I realized that you had
> your own patches in [2]. This did fix things, but it's kind of awkward
> in the sense that we're not really "installing" anything (in fact, the
> patch in [1] incorrectly indicates that we are), but instead nudging it
> after it discovers v8.3.
> 
> 
> > Another possibilities are:
> >
> >   - Running 'brew link gcc@8' before 'brew update' works:
> >
> >       https://travis-ci.org/szeder/git/jobs/540027012#L139
> >
> >   - Not running 'brew update' at all works as well:
> >
> >       https://travis-ci.org/szeder/git/jobs/514960153#L179
> 
> I'd be just as happy to do something similar to what I did as really
> either of these. Getting rid of 'brew update' entirely would make me
> happiest, since it takes a *long* time for one of these to complete.

I would love to see 'brew update' go away, partly because it takes so
long, and partly because the update of Homebrew itself broke our
builds once or twice in the past (though they usually sorted out the
breakage in a few days) [1].

However, we've always used the macOS build jobs as "build and test
with the latest and greatest", i.e. they install the latest available
Perforce and Git-LFS.  To keep up with this tradition we'd need to run
'brew update' and in turn would need to 'brew install gcc'.

[1] See e.g. a1ccaedd62 (travis-ci: make the OSX build jobs' 'brew
    update' more quiet, 2019-02-02) or

    https://public-inbox.org/git/20180907032002.23366-1-szeder.dev@gmail.com/T/#u


> But, I'd almost prefer explicitly running 'brew install gcc@8' to
> running 'brew link gcc@8' before 'brew update'. The later seems fragile
> and awfully prone to break, especially when we are just doing it to try
> and work around a Homebrew quirk.
> 
> If you don't have any plans to send your patches upstream, and feel OK
> running 'brew install', let me know and I will send my patch in [1].
> 
> Thanks,
> Taylor
> 
> [1]: https://github.com/ttaylorr/git/commit/a20e34d143a4a15b6b15ccb5bfb996fab9551b76
> [2]: https://github.com/szeder/git/commit/ca29709d09a440d98857efb2575a3f92feaab29f
