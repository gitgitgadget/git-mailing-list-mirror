Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3ED320248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfCYVqL (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:46:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYVqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:46:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so4012629wrx.10
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VMM1GgZrJgW1xp9OBBxNOEeGJMvscejLHMVIhrG0ax0=;
        b=K7LEklwSHv8irFWSPDhcjJl6ALKvKgD5RbVMV+Zbq0i9MKmuupLaM1NxHvigY1GP1y
         09c2+yy1tcZLQv6JKQRJ9qahAhTLix4ki5HUANnZoDTMI3t0dnDA3WwHv1lkFojuJ0/L
         RuVvwHg3DbmEihPr0wBiXXuG4i3QzmNpIvjeA2OjOIYBQo5lwdq0h+F4vQ6s/YKSK0XD
         Kau9KuYrNUSEbdOWhYeVQhvEsc8+tonb1O1+u7VseES2JstsL3lTSVnjzZtKc8lyOrir
         JMpIWQMt45raDzJ1RV3lzCTuVBsOXtXNRkZ+fZwI2hbuTORahSpv36lSz5Y4UswsSkcD
         oDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VMM1GgZrJgW1xp9OBBxNOEeGJMvscejLHMVIhrG0ax0=;
        b=NGZS+MuPsP/tgOFHwU+AZ/3dtDuV8jKKCkM1JQMgbrPhHG93AHDb2o4LrXYddP1p7K
         RpHETWYYK/Z1WVhaWDGUHo8EHbcdlQVPVdR16pWHvKGs7hiCgKXUjl7TZZSNY2ACjZWN
         TXIE1WfGlPfFWjhFCw3N4ZN+jl6JjxhBNLVWhRyBIqYoJKlYwvLKNp+VX6JHnBeD4fgD
         JI+PjfKDX3NY9g4QaXfGA+fmukF6fI06U+8UB4R3PVG5QVzZXU02oewoAXPLwdQk7boC
         uQHfGlanc0ktbuje7K9MrIWXYSaZFMBK/NlrqEaHuVjubkPKjAVEGeMHJf5F6BJs9T25
         yUBA==
X-Gm-Message-State: APjAAAW221cwdNMPvlV7fMJzqIHPTUl90AEwEO5WavvBpGbSJ3sAHIgn
        kNEmcwURJMfatzAfl7hBf2E=
X-Google-Smtp-Source: APXvYqwvkEx8WnDZQSySUpcK4kkCIuWbUE5SZLaoZZF+Tz7MVQMtX4Mq+3LSYiANioeA3Cik0BEoYQ==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr9686897wrx.0.1553550369949;
        Mon, 25 Mar 2019 14:46:09 -0700 (PDT)
Received: from szeder.dev (x4d0c296b.dyn.telefonica.de. [77.12.41.107])
        by smtp.gmail.com with ESMTPSA id f4sm14603064wmj.34.2019.03.25.14.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:46:09 -0700 (PDT)
Date:   Mon, 25 Mar 2019 22:46:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] ci: install Asciidoctor in
 'ci/install-dependencies.sh'
Message-ID: <20190325214603.GA1343@szeder.dev>
References: <20190324155219.2284-1-szeder.dev@gmail.com>
 <20190324215534.9495-1-szeder.dev@gmail.com>
 <20190324215534.9495-5-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.1903252221300.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1903252221300.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 10:28:21PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> I like the rest of the patch series, but this patch, I am not so sure
> about...
> 
> On Sun, 24 Mar 2019, SZEDER Gábor wrote:
> 
> > When our '.travis.yml' was split into several 'ci/*' scripts [1], the
> > installation of the 'asciidoctor' gem somehow ended up in
> > 'ci/test-documentation.sh'.
> >
> > Install it in 'ci/install-dependencies.sh', where we install
> > everything else.
> 
> The big difference you introduce is that asciidoctor is now installed
> with every job, not only with the Documentation job that actually uses it.

It is only installed in the 'Documentation' build job.

> Even if it affects me very little (because I don't pay much attention to
> Travis, it's been too flakey for me, and it does not test our Windows
> side, and it is too slow), I'd rather install asciidoctor really only when
> needed.
> 
> So I'd like to recommend to drop this patch from the series.
> 
> Thanks,
> Dscho
> 
> >
> > [1] 657343a602 (travis-ci: move Travis CI code into dedicated scripts,
> >     2017-09-10)
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  ci/install-dependencies.sh | 3 +++
> >  ci/test-documentation.sh   | 3 ---
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index d64667fcbf..76ec308965 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -54,6 +54,9 @@ StaticAnalysis)
> >  Documentation)

     ^^^^^^^^^^^^^^

> >  	sudo apt-get -q update
> >  	sudo apt-get -q -y install asciidoc xmlto
> > +
> > +	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
> > +	gem install asciidoctor
> >  	;;
> >  esac
> >
> > diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> > index be3b7d376a..8f91f48c81 100755
> > --- a/ci/test-documentation.sh
> > +++ b/ci/test-documentation.sh
> > @@ -5,9 +5,6 @@
> >
> >  . ${0%/*}/lib.sh
> >
> > -test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
> > -gem install asciidoctor
> > -
> >  make check-builtins
> >  make check-docs
> >
> > --
> > 2.21.0.539.g07239c3a71.dirty
> >
> >

