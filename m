Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE401FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 20:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757686AbcINU1s (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 16:27:48 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:48248 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756218AbcINU1r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 16:27:47 -0400
Received: from mb02436d0.tmodns.net ([208.54.36.176] helo=[IPv6:2607:fb90:290a:2a5d:e12a:8c93:e494:74c])
        by smtp.onerussian.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1bkGmW-0001G3-GC; Wed, 14 Sep 2016 16:27:45 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGZ79kbdfWHDGzoe21LVqt6naMJPWGf45S1oknrAp6=Z-Qm8dQ@mail.gmail.com>
References: <20160909221942.GS9830@onerussian.com> <20160914140318.GB9833@onerussian.com> <CAGZ79kbdfWHDGzoe21LVqt6naMJPWGf45S1oknrAp6=Z-Qm8dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
From:   Yaroslav Halchenko <yoh@onerussian.com>
Date:   Wed, 14 Sep 2016 16:23:56 -0400
To:     Stefan Beller <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <6B9620C2-9459-497A-BDF7-7A58A22C687D@onerussian.com>
X-SA-Exim-Connect-IP: 208.54.36.176
X-SA-Exim-Rcpt-To: sbeller@google.com, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: git submodule add spits unrelated to actual problem error msg about .gitignore
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 14, 2016 3:32:11 PM EDT, Stefan Beller <sbeller@google.com> wrote:
!
>I think we could chop off "2>&1" as that would have exposed the
>underlying error.
>
>Another way to go would be to use verbose git-add and grep for
>the string "add '$sm_path'".
>
>     if test -z "$force" && ! git add --verbose --dry-run
>--ignore-missing "$sm_path" |grep "add $sm_path"
>
>git-add already gives the correct (the same error message) for  the
>ignored files, so maybe we'd just do:
>
>    # no need for a if, but this single line will do:
>    test -z "$force" && git add --dry-run git.o >/dev/null || exit 1

FWIW Imho exposing error is good but not sufficient alone, since custom gitignore message would still be confusing.
-- 
Sent from a phone which beats iPhone.
