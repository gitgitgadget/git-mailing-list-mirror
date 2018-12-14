Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29AFB20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 04:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeLNEWL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 23:22:11 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:57520 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNEWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 23:22:11 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gXezK-0002cp-E4
        for git@vger.kernel.org; Thu, 13 Dec 2018 23:22:10 -0500
Date:   Thu, 13 Dec 2018 23:22:05 -0500
From:   Yaroslav O Halchenko <debian@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181214042205.GJ4633@hopa.kiewit.dartmouth.edu>
References: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
 <20181211040839.17472-1-debian@onerussian.com>
 <20181211040839.17472-2-debian@onerussian.com>
 <CAGZ79kY17gmEh5Sawa+1fG5cXjOReOgCjDyEmGbbpJ5EE1APdw@mail.gmail.com>
 <20181213164217.GA4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kZb28bCvM7cOYHC4cpJWpA-3_gcbxS_g-rG0yy=9jXquw@mail.gmail.com>
 <20181213224356.GI4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kaLpMa+AYwtNh+HUkYk3ORDephxZ74hcTbS=z1CQ+bf6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaLpMa+AYwtNh+HUkYk3ORDephxZ74hcTbS=z1CQ+bf6A@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [PATCH 2/2] RF+ENH(TST): compare the entire list of submodule
 status --recursive to stay intact
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 13 Dec 2018, Stefan Beller wrote:

> > cool, thanks for the feedback - I will then try to make it happen

> > quick one (so when I get to it I know):  should I replicate all those
> > tests you have for other update strategies? (treating of config
> > specifications etc)

> If there is a sensible way to do so?
> I have the impression that there are enough differences, that it
> may not be possible to replicate all tests meaningfully from the
> other modes.

oh, by replicate I just meant to copy/paste and adjust for expected for
--reset-hard test behavior (and possibly introduced helper),
nothing fancy, just duplication as for replication ;-) 

> > There is no easy way to parametrize them somehow?

> There is t/lib-submodule-update.sh, which brings this to
> an extreme, as it makes a "test suite in a test suite"; and I would
> not follow that example for this change.

ok

> > ;)    In Python world I might have mocked the actual underlying call to
> > update, to see what option it would be getting and assure that it is the
> > one I specified via config, and then sweepped through all of them
> > to make sure nothing interim changes it.  Just wondering if may be
> > something like that exists in git's tests support.

> gits tests are very heavy on end to end testing, i.e. run a whole command
> and observe its output. This makes our command setup code, (i.e. finding
> the repository, parsing options, reading possible config, etc) a really well
> exercised code path. ;-)

> There is a recent push towards testing only units, most of
> t/helper is used for that, e.g. c.f. 4c7bb45269 (test-reach:
> test get_reachable_subset, 2018-11-02).

> So if you have a good idea how to focus the submodule
> tests more on the (new) unit that you add, that would be cool.

no, not really any good ideas -- I am new here, but I will keep an eye open.

> > BTW - sorry if RTFM and unrelated, is there  a way to

> >     update --merge

> > but allowing only  fast-forwards?  My use case is collection of this
> > submodules: http://datasets.datalad.org/?dir=/openneuro  which all
> > should come from github and I should not have any changes of my own.

> So you want the merge option  --ff-only
> to be passed to the submodule merge command. I guess you could make
> a patch, that update takes another option (--ff-only, only useful when
> --merge is given), which is then propagated.

> I am not sure if we could have a more generalized option passing,
> which would allow to pass any option (for its respective command)
> to the command that is run in the update mode.

wouldn't it be (theoretically) possible, in principle, to pass
them via some config variable?  e.g. instead of  

submodule update --reset-hard

have

-c submodule.update.reset.opts=--hard update --reset

and then analogously

-c submodule.update.merge.opts=--ff-only update --merge

(--ff-only I guess would make no sense for any "supermodule" - a repo
with submodules)

> > Sure thing if all is clean etc, merge should result in fast-forward.  I
> > just do not want to miss a case where there was some (temporary?) "dirt"
> > which I forgot to reset and it would then get merged etc.

> maybe use --rebase, such that your potential change would bubble
> up and possibly produce a merge conflict?

that is a good idea as a workaround, thanks!

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
