Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DB220A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 22:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeLMWoD (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 17:44:03 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:52948 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMWoD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 17:44:03 -0500
Received: from [10.31.188.88] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gXZi5-0006Yz-73
        for git@vger.kernel.org; Thu, 13 Dec 2018 17:44:01 -0500
Date:   Thu, 13 Dec 2018 17:43:56 -0500
From:   Yaroslav O Halchenko <debian@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181213224356.GI4633@hopa.kiewit.dartmouth.edu>
References: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
 <20181211040839.17472-1-debian@onerussian.com>
 <20181211040839.17472-2-debian@onerussian.com>
 <CAGZ79kY17gmEh5Sawa+1fG5cXjOReOgCjDyEmGbbpJ5EE1APdw@mail.gmail.com>
 <20181213164217.GA4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kZb28bCvM7cOYHC4cpJWpA-3_gcbxS_g-rG0yy=9jXquw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZb28bCvM7cOYHC4cpJWpA-3_gcbxS_g-rG0yy=9jXquw@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 10.31.188.88
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

> > and kaboom -- we have a new test.  If we decide to test more -- just tune up
> > test_expect_unchanged_submodule_status and done -- all the tests remain
> > sufficiently prescribed.

> > What do you think?

> That is pretty cool. Maybe my gut reaction on the previous patch
> also had to do with the numbers, i.e. having 2 extra function for
> only having 2 tests more legible. A framework is definitely better
> once we have more tests.

cool, thanks for the feedback - I will then try to make it happen

quick one (so when I get to it I know):  should I replicate all those
tests you have for other update strategies? (treating of config
specifications etc)  There is no easy way to parametrize them somehow?
;)    In Python world I might have mocked the actual underlying call to
update, to see what option it would be getting and assure that it is the
one I specified via config, and then sweepped through all of them
to make sure nothing interim changes it.  Just wondering if may be
something like that exists in git's tests support.


BTW - sorry if RTFM and unrelated, is there  a way to  

    update --merge  

but allowing only  fast-forwards?  My use case is collection of this
submodules: http://datasets.datalad.org/?dir=/openneuro  which all
should come from github and I should not have any changes of my own.
Sure thing if all is clean etc, merge should result in fast-forward.  I
just do not want to miss a case where there was some (temporary?) "dirt"
which I forgot to reset and it would then get merged etc.


-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
