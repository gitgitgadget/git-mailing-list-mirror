Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D154C1F406
	for <e@80x24.org>; Tue,  2 Jan 2018 11:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeABLz7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 06:55:59 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:40391 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeABLz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 06:55:57 -0500
X-Greylist: delayed 2402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2018 06:55:57 EST
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:35236 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eWKXz-0000ep-4K; Tue, 02 Jan 2018 06:15:55 -0500
Date:   Tue, 2 Jan 2018 06:12:35 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Stephan Janssen <sjanssen@you-get.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git removes existing folder when cancelling clone
In-Reply-To: <FE0E0877-B77D-4BD6-A513-435C251D920A@you-get.com>
Message-ID: <alpine.LFD.2.21.1801020610400.14363@localhost.localdomain>
References: <FE0E0877-B77D-4BD6-A513-435C251D920A@you-get.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-774076354-1514891557=:14363"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-774076354-1514891557=:14363
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 2 Jan 2018, Stephan Janssen wrote:

> Hi,
>
> I hope this mailing list is the right way to communicate this.
>
> I just noticed the following behaviour on macOS 10.13.2 running Git v2.15.0:
>
> 1. `mkdir new-folder`
> 2. `ls` - shows new-folder
> 3. `git clone [repo] new-folder`
> 4. Git asks for password
> 5. I cancel by pressing ctrl+c
>
> Result:
> `ls` no longer shows new-folder.
>
> Expected result:
> `ls` shows new-folder
>
> I’m not sure whether this might be a case of ‘works as intended’,
> but it’s not what I’d expect.

  i'm *pretty* sure that the optional directory name you supply is
meant to represent a directory you want git to *create* for you, not
one that already exists. that means the behaviour you see makes sense
-- if git assumes it was supposed to create the directory, and you
cancel the clone, it reasonably assumes it should get rid of it.

  i am willing to be corrected.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-774076354-1514891557=:14363--
