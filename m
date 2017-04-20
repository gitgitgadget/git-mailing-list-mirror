Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F356F207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947794AbdDTVY2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:24:28 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37728 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947792AbdDTVY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:27 -0400
Received: by mail-wm0-f41.google.com with SMTP id m123so3033478wma.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Z9SIsuUAGes2VsNbvDIC1JZ9m5adftNo2M4UDJTKsM=;
        b=E8MIyoFytoMsv4eqV7nec96T78P1qGPCn/r8gVyDw8W+f/tQyLQNSaHdj5cInLwRYd
         OZc1HWmLRDEwWxGscuW1enBrgDWIqADfr65878K2D1RBKCI/uAV9AItPHoIEaxWGLjF8
         GrOtp3Yl3eMRA7XCE8lw2GhNeYEBQb4gAR/ihDaE6g1Xt4lppnGeBxb9nqdA2pGMuIfR
         Y54VW/L/awmGMmLDP8VRhkoxHF4S18/ZhwB1nAfgplWeNhuRdfiGWYGWEvMWyYuyFNrs
         FY+ELNhuGL9CkfESQyAkVA3cTPGQgR3AVZg5O1+AxQLQH5p/N/d7Lld2gzBUIUYarGOb
         6P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Z9SIsuUAGes2VsNbvDIC1JZ9m5adftNo2M4UDJTKsM=;
        b=oh3EDcT4BW78JMnuiIsKHul+8xJFWc41+bOAzoFuIODOr8DZk4NrvopI06SnrgDxWr
         7hj9qHRH+DE2fFCczDoH5dZlQ4gFHeh2fFaEAxk/vppms92ugW/I0ghp6CZjqAtT80dv
         c7ZYDoZUl58uK9fR1WTs9jgr8WORmcZaRXhRYQyBS1Kgc3sJWS2xZu1ZoHBmkGa6edlA
         9RVyX8E/MvYzsCpl1GGGaBl6w1nNIOwdOhDpDTAcGyUHCYwBpPravYgueUb80XboL5dg
         7gY1LEgj/5HtEUM3CTP2S7UyDKEV5Vs3jaZPUtMXqvVYyQbcvMcLXfSaqp6KPpYIccdS
         z/DA==
X-Gm-Message-State: AN3rC/69VlmVQqglkuaUX3kB48QjdY1t2h5ZXyGigVol0ZlMwJzEcAUL
        zSFhga7oLs7WHmR4g/c=
X-Received: by 10.28.52.66 with SMTP id b63mr5309278wma.30.1492723465697;
        Thu, 20 Apr 2017 14:24:25 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id p101sm9048542wrb.64.2017.04.20.14.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Apr 2017 14:24:24 -0700 (PDT)
Date:   Thu, 20 Apr 2017 22:24:36 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
Message-ID: <20170420212436.GC4989@hank>
References: <20170420205214.GB4989@hank>
 <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Christian Couder wrote:
> Hi,
> 
> On Thu, Apr 20, 2017 at 10:52 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Hi,
> >
> > I just tried to run the test suite with GIT_TEST_SPLIT_INDEX=YesPlease
> > and noticed that a few tests are broken both in pu and master.
> >
> > Below the test failures on master:
> >
> > Test Summary Report
> > -------------------
> > t7009-filter-branch-null-sha1.sh                 (Wstat: 256 Tests: 5 Failed: 2)
> >   Failed tests:  4-5
> >   Non-zero exit status: 1
> > t3900-i18n-commit.sh                             (Wstat: 256 Tests: 34 Failed: 1)
> >   Failed test:  34
> >   Non-zero exit status: 1
> > t5407-post-rewrite-hook.sh                       (Wstat: 256 Tests: 14 Failed: 4)
> >   Failed tests:  11-14
> >   Non-zero exit status: 1
> > t3415-rebase-autosquash.sh                       (Wstat: 256 Tests: 19 Failed: 15)
> >   Failed tests:  4-17, 19
> >   Non-zero exit status: 1
> > t3404-rebase-interactive.sh                      (Wstat: 256 Tests: 95 Failed: 54)
> >   Failed tests:  18, 20, 22-24, 26-43, 45, 47-74, 84-85
> >   Non-zero exit status: 1
> >
> > Bisecting between master and v2.10.0 leads me to the merge commit
> > 94c9b5af70 ("Merge branch 'cc/split-index-config'", 2017-03-17).
> >
> > Unfortunately I don't forsee myself having time to track the bug down
> > soon.  Sorry for not noticing this earlier in the cycle.
> >
> > The bisect log is below if someone finds it helpful:
> >
> > git bisect start
> > # bad: [6a2c2f8d34fa1e8f3bb85d159d354810ed63692e] Git 2.13-rc0
> > git bisect bad 6a2c2f8d34fa1e8f3bb85d159d354810ed63692e
> > # good: [6ebdac1bab966b720d776aa43ca188fe378b1f4b] Git 2.10
> > git bisect good 6ebdac1bab966b720d776aa43ca188fe378b1f4b
> > # good: [733671b0fd2fb03edb05273f36ec70bd624e544f] Merge branch 'maint'
> > git bisect good 733671b0fd2fb03edb05273f36ec70bd624e544f
> > # good: [04b4f7d579056cedaae2de0a019e5993b4d9c2d0] Merge branch 'sb/submodule-update-initial-runs-custom-script' into maint
> > git bisect good 04b4f7d579056cedaae2de0a019e5993b4d9c2d0
> > # bad: [af6865a7f1e1d915d3b63e998226028ca4abb6ee] submodule.c: convert is_submodule_modified to use strbuf_getwholeline
> > git bisect bad af6865a7f1e1d915d3b63e998226028ca4abb6ee
> > # good: [3f7ebc6ece46f1c23480d094688b8b5f24eb345c] Merge branch 'jk/tempfile-ferror-fclose-confusion'
> > git bisect good 3f7ebc6ece46f1c23480d094688b8b5f24eb345c
> > # bad: [94c9b5af703eb70adba349cfbfaaa3029849744c] Merge branch 'cc/split-index-config'
> > git bisect bad 94c9b5af703eb70adba349cfbfaaa3029849744c
> > # good: [36d5286f6815542761dae92fdcdce8db1556727f] Merge branch 'ax/line-log-range-merge-fix'
> > git bisect good 36d5286f6815542761dae92fdcdce8db1556727f
> > # good: [c3a008250272295271584c6303463ffb9b055cbc] read-cache: use freshen_shared_index() in read_index_from()
> > git bisect good c3a008250272295271584c6303463ffb9b055cbc
> > # good: [228b78752de9d759839665764391262c0ec156cf] Merge branch 'jt/perf-updates'
> > git bisect good 228b78752de9d759839665764391262c0ec156cf
> > # good: [073778017158ecf3153b050776029907bc75826f] Merge branch 'kn/ref-filter-branch-list'
> > git bisect good 073778017158ecf3153b050776029907bc75826f
> > # good: [b46013950aff31b6626af96ccbf2c48469e36c66] Documentation/git-update-index: explain splitIndex.*
> > git bisect good b46013950aff31b6626af96ccbf2c48469e36c66
> > # good: [32c43f595f93cdd4ed5305aef97a3f6aaa74ed72] Sync with 'maint'
> > git bisect good 32c43f595f93cdd4ed5305aef97a3f6aaa74ed72
> > # first bad commit: [94c9b5af703eb70adba349cfbfaaa3029849744c] Merge branch 'cc/split-index-config'
> 
> Could you try with the following patch:
> 
> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/

Yeah, I tried with and without that patch with the same result.
Unless I'm screwing something up when testing I don't think this fixes
the issue unfortunately.

> Thanks,
> Christian.
