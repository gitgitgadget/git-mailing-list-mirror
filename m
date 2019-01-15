Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E684B1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 23:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfAOXzw (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 18:55:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39195 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfAOXzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 18:55:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so192801wmi.4
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1ZYeunoIwYdpMjjPVaf93ieLBWkJY65bMK88BJxs2dw=;
        b=QyXaeE4f337VAc/VCOi8JnzA/4UgBRbkh8SqR37zhJRB6o0enoqTTsoX5HUlT77FX+
         1d77+uGyJ1TrHNeTmBcz4gsXfd7prrlkejGztQETc6ECsZmr6d8K8cWn4cVU5nZogf11
         e2z5s2K3Bfn8xjwewlvQ7+hS5cDqRCNQ0OZHpJtZbleQ+2EauF3jWTiI5yp+cgiELkpM
         Lkv94wZx9AaWTqRwic33TH5ORst9QKnM4oh8ET9cJGwxzQt0YbYXoa7eGKJeA9WTB2ma
         HlI7Vumo+bodAkoRIDD6JqFUNo5X0APVwC0YEVymOvwbO0Q0TYWbgdd4YVI4xGijBbhK
         Nk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1ZYeunoIwYdpMjjPVaf93ieLBWkJY65bMK88BJxs2dw=;
        b=k5MnAezf7go3EdQiclPYQl2h1scks0KhycQwuYclAdVO/A2Lrgyd+8i6uOOUIN4mZw
         jMOR4b3hY4X9wJPqNwIvpMq8RtHD1nQLG0An3ebt0thCgn4lpqQ1FnzMq7h6m4LmMqvT
         GIzbNSHn/3yu4eyxpgzrbUR0gf5te/1HXXOfjYY9XDnUtdpP4go2S++80AAI8Dxpgaub
         B9VvIZebIiVIuVfTBFhzROetnI6yp6Z227WY+P4tPL22Wrcd86aISaD+V5KG5MECmCpQ
         ShvEWflUfahtuHFLvYHe5XgNZtFASMcal9p2tWez/3LA1cSgNwxEbXpp674dT7Py9ZTc
         YckQ==
X-Gm-Message-State: AJcUukf8ILfW5s0iRqTWhfkxRLMLBJ+oBcxfSZRTMXkl15kVomJrx+DQ
        jpX62DEhlJ0UcM0RtbAJ5Rs=
X-Google-Smtp-Source: ALg8bN6Hmnf7GltnnHRxQgv0gpG0kWscIusqudYlK+cY43dEDbxDxwURnjOvZRCcwlQKE14MJBqSdQ==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr5227430wmd.36.1547596549809;
        Tue, 15 Jan 2019 15:55:49 -0800 (PST)
Received: from szeder.dev (x4db54f87.dyn.telefonica.de. [77.181.79.135])
        by smtp.gmail.com with ESMTPSA id v12sm57569696wmd.27.2019.01.15.15.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:55:48 -0800 (PST)
Date:   Wed, 16 Jan 2019 00:55:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] compat/obstack: fix -Wcast-function-type warnings
Message-ID: <20190115235546.GF840@szeder.dev>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20181220162452.17732-2-szeder.dev@gmail.com>
 <87zhszeqsr.fsf@evledraar.gmail.com>
 <xmqqef9k1a4n.fsf@gitster-ct.c.googlers.com>
 <20190111003743.GA840@szeder.dev>
 <xmqq4lafysve.fsf@gitster-ct.c.googlers.com>
 <20190111185118.GD840@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190111185118.GD840@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 11, 2019 at 07:51:18PM +0100, SZEDER Gábor wrote:
> On Fri, Jan 11, 2019 at 10:03:01AM -0800, Junio C Hamano wrote:
> > SZEDER Gábor <szeder.dev@gmail.com> writes:
> > 
> > > On Thu, Jan 10, 2019 at 01:22:00PM -0800, Junio C Hamano wrote:
> > >> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> > >>  ...
> > >> > I.e. is this another case where we're blindly fixing bugs but should
> > >> > just re-import upstream's code instead?
> > >> 
> > >> Good point.  I am inclined to queue the remainder of the series
> > >> without this one for now.
> > >
> > > Note that without this first patch the linux-gcc build job will fail
> > > with the above compiler error, and that's the only build job that runs
> > > the test suite with all the misc test knobs (split-index,
> > > commit-graph, etc.) enabled.
> > 
> > I know.  
> > 
> > The point is to give more incentive to try what was suggested
> > earlier by Ævar (in short, "try to do the right thing, before
> > hacking around locally in this project" ;-)
> 
> Well, first I'm not sure what changes Ævar meant to be backported.
> Back then I briefly glanced at glibc's gitweb [1], but didn't see
> anything remotely relevant to these compiler errors.

So, I looked at the gnulib repository, where glibc got it's
obstack.{c,h} from, and it does have a fix for this issue in commit
127ed6a3e (obstack: avoid potentially-nonportable function casts,
2014-11-04):

  http://git.savannah.gnu.org/cgit/gnulib.git/commit?id=127ed6a3ea9c46452f079dee50382dc1f70ea796

It chose basically the same approach as my fix, i.e. storing pointers
to functions with different signatures in an union.  However,, the
differences between our and their obstack.{c,h} are way too big to
backport their patch.

> As to re-importing obstack.{c,h} from upstream, we've made some
> portability fixes to these files, and neither of the commit messages
> of those fixes mention that they are backports from upstream.  OTOH,
> one of those commits mentions platforms like
> "i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1, SunOS 5.10", which makes
> me suspect that the re-import will be susceptible to those portability
> issues again.  Therefore, I think re-importing these files from
> upstream is beyond the scope of this patch series (and might not be
> the right thing at all).

gnulib's obstack.{c,h} doesn't fix the issues that we've fixed in
3254310863 (obstack.c: Fix some sparse warnings, 2011-09-11) and
d190a0875f (obstack: Fix portability issues, 2011-08-28).  So if we
were to re-import from gnulib, then these two patches would have to be
applied on top yet again.


> [1] https://sourceware.org/git/?p=glibc.git;a=history;f=malloc/obstack.c;h=1669641983512d64f66c1ad659562f77ef48adfd;hb=refs/heads/master
> 
