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
	by dcvr.yhbt.net (Postfix) with ESMTP id 40EB31F454
	for <e@80x24.org>; Wed,  3 Oct 2018 15:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeJCVyN (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 17:54:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51384 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeJCVyN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 17:54:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so6043546wmf.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QaNQ5FyD4WwdxjNiDKqm1yR9hzMCE88PwkuHu1wzVug=;
        b=jkCusXeh91wLaUO1DKrmnPoiNjMZxf+65aJOyuRMt+RZW8QBxTv7dRA9QrzmwCYwue
         Ww7JJpOWglxw7GsnUnadiEkeA5DJvHBJpABQNAGhuF3G611M4tk1+6VmErKx26XhdsQI
         uuEYj9rrWcf89lyoREbfrB+uAcC3riBhqGsu8J4DUuVsqZbF2WOwnjNR/JabgszVAU15
         gQiYjdFhZ9IDaK8skO26efLvh3KvNXkrrRR2CsqiXU5LAKpkbxa1v6nVnNzuO7LDRWNR
         Fthx/+mLVxQUknO0r7ALyuXhGnXZ85pCgnw/wRV1Zo81GdvnByYr5ayhWGwI+Pc5WnHH
         aI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QaNQ5FyD4WwdxjNiDKqm1yR9hzMCE88PwkuHu1wzVug=;
        b=S15DiE0TuDrwboR9+d7IFb+oADG52JATEBxicBiOMF5RoyW2e9rL8PhKjyBjFmO8b9
         ECA5GHm8sugDDDA1aVB+aWGC39/4ZB4w8o8WqxDY0Y2i5cZWPNL0u1nL6svOgdZ82zv4
         nmld5AYRhivrL+h4NdeCTLjTwYqnUnbRnu+N3jc2mJwR6Zx/n6112rE6aKlQkewOHoKY
         B7EXbQwvTxV/iCSFFOtUvjk6sVwrcZOuC7ItWeJZcmVOuY4a648I60uiOabc3ifUEKVS
         b30uZZUj0E2L2R7HfxdSmRS+RN52RU2RJmPT+AFbJ4duHvcLu/TgoRtZtkH/TF2mUzu9
         0TuQ==
X-Gm-Message-State: ABuFfohu1FfCE9kKq6oPLQWxBVgLZhJfAHoZC1ab7pv7brYDXFpVmjH6
        jcVc6XPXQIJM8YUZhk+COgM2xpJu
X-Google-Smtp-Source: ACcGV62fhp9Aqkn/lY8nN7ujCvC5DyQT5bQBd7FZSntSN76wSfw9aJ9EhGQYN/++4OjSDa0D7sQc/Q==
X-Received: by 2002:a1c:7614:: with SMTP id r20-v6mr1874116wmc.52.1538579125599;
        Wed, 03 Oct 2018 08:05:25 -0700 (PDT)
Received: from localhost (x4dbea401.dyn.telefonica.de. [77.190.164.1])
        by smtp.gmail.com with ESMTPSA id w17-v6sm1798316wmc.43.2018.10.03.08.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:05:24 -0700 (PDT)
Date:   Wed, 3 Oct 2018 17:05:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] coccicheck: process every source file at once
Message-ID: <20181003150522.GQ23446@localhost>
References: <20181002191642.21504-1-jacob.e.keller@intel.com>
 <20181002195519.GB2014@sigill.intra.peff.net>
 <20181003101658.GM23446@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181003101658.GM23446@localhost>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 12:16:58PM +0200, SZEDER Gábor wrote:
> On Tue, Oct 02, 2018 at 03:55:19PM -0400, Jeff King wrote:
> > On Tue, Oct 02, 2018 at 12:16:42PM -0700, Jacob Keller wrote:
> > 
> > > make coccicheck is used in order to apply coccinelle semantic patches,
> > > and see if any of the transformations found within contrib/coccinelle/
> > > can be applied to the current code base.
> > > 
> > > Pass every file to a single invocation of spatch, instead of running
> > > spatch once per source file.
> > > 
> > > This reduces the time required to run make coccicheck by a significant
> > > amount of time:
> > > 
> > > Prior timing of make coccicheck
> > >   real    6m14.090s
> > >   user    25m2.606s
> > >   sys     1m22.919s
> > > 
> > > New timing of make coccicheck
> > >   real    1m36.580s
> > >   user    7m55.933s
> > >   sys     0m18.219s
> > 
> > Yay! This is a nice result.
> > 
> > It's also one of the things that Julia suggested in an earlier thread.
> > One thing I wasn't quite sure about after digging into the various
> > versions (1.0.4 on Debian stable/unstable, 1.0.6 in experimental, and
> > pre-1.0.7 at the bleeding edge) was whether the old versions would be
> > similarly helped (or work at all).
> > 
> > I just replicated your results with 1.0.4.deb-3+b2 from Debian stable.
> > It's possible there are older versions floating around, but for
> > something developer-only like this, I think "in Debian stable" is a
> > reasonable enough cutoff.
> 
> Linux build jobs on Travis CI run Ubuntu Trusty 14.04 LTS, and
> therefore our static analysis build job still runs 1.0.0~rc19.deb-3.
> 
> This patch appears to work fine with that version, too,

In fact, it works finer than ever, because running 1.0.0 with this
patch on Travis CI notices a possible memmove() -> MOVE_ARRAY()
conversion:

  https://travis-ci.org/szeder/git/jobs/436542684#L576

Surprisingly, running 1.0.0 without this patch, or running 1.0.4
locally either with or without this patch doesn't notice that
memmove() call.  Presumably that's why Jonathan could kind-of "revert"
my conversion from f919ffebed (Use MOVE_ARRAY, 2018-01-22) in his
6a1a79fd14 (object: move grafts to object parser, 2018-05-15) without
anyone noticing.

