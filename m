Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C1FC49EA5
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 01:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DB46115A
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 01:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhFYBs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 21:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFYBs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 21:48:27 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Jun 2021 18:46:06 PDT
Received: from act-MTAout3.csiro.au (act-mtaout3.csiro.au [IPv6:2405:b000:e00:257::7:39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF3C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 18:46:06 -0700 (PDT)
IronPort-SDR: i8swQmeYCQoE5JYeZ9cHGgjFcIQXQoT6+gcgSKxGmIpAuyNiwWPlTNrBkFCwnehWj6CZuBA2MF
 v7WDdKpdT0wA==
X-SBRS: 4.0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ae6nTa68nRdnVFogtOr1uk+DoI+orL9Y04l?=
 =?us-ascii?q?Q7vn2ZLiYlEPBw9vre/8jzsCWetN9/Yh0dcLy7V5VoOEmskKKdg7N+AV7SZm?=
 =?us-ascii?q?nbUQKTRekJgLcKqAeAJ8SRzJ866Y5QN4R4Fd3sHRxboK/BkXCF+g8bsb26GX?=
 =?us-ascii?q?aT9IDj80s=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HzAgBGNNVgjA9OdpJagQmBVwKDCxV?=
 =?us-ascii?q?XhTOJBIhLm3uBfAsBAQEPNQwEAQGBXoVnJjQJDgIEAQEBEgEBBgEBAQEBBgQ?=
 =?us-ascii?q?CAhABAQEBKUOFaA1DARABhiMVG1sCJgJsCAEBgm0BgwcPp26BMoEBg0sBgRq?=
 =?us-ascii?q?DY4FcBoEQKgGOIIFVRGZWDAOGDQKCLYJKgmQEgi93gTMioRpanEIsB4MiBIE?=
 =?us-ascii?q?pC4hek18GDgUWEJUNkGqiA5hXgVSCFTMaH4M+TxkOjiYSg1eKazRqAgYKAQE?=
 =?us-ascii?q?DCYdXhCsBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HzAgBGNNVgjA9OdpJagQmBVwKDCxVXhTOJBIhLm3uBf?=
 =?us-ascii?q?AsBAQEPNQwEAQGBXoVnJjQJDgIEAQEBEgEBBgEBAQEBBgQCAhABAQEBKUOFa?=
 =?us-ascii?q?A1DARABhiMVG1sCJgJsCAEBgm0BgwcPp26BMoEBg0sBgRqDY4FcBoEQKgGOI?=
 =?us-ascii?q?IFVRGZWDAOGDQKCLYJKgmQEgi93gTMioRpanEIsB4MiBIEpC4hek18GDgUWE?=
 =?us-ascii?q?JUNkGqiA5hXgVSCFTMaH4M+TxkOjiYSg1eKazRqAgYKAQEDCYdXhCsBAQ?=
Received: from mail-server.pawsey.org.au (HELO prod-mail.pawsey.org.au) ([146.118.78.15])
  by act-ironport-int.csiro.au with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 11:44:50 +1000
Received: from [192.102.251.102] (unknown [192.102.251.102])
        by prod-mail.pawsey.org.au (Postfix) with ESMTPSA id 851183227385
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:44:49 +0800 (AWST)
To:     git@vger.kernel.org
From:   Kevin Buckley <Kevin.Buckley@pawsey.org.au>
Subject: Definition of "the Git repository"
Message-ID: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
Date:   Fri, 25 Jun 2021 09:44:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

raising this on the back of a discussion over at the Software
Carpentry lesson about Git,

    https://github.com/swcarpentry/git-novice/issues/810

I used the book to justify my claim that it is the .git directory
that is the repository, but I do have to concede that the way that
the text in section 2.1 of the book reads, does suggest that one
can refer to the working directory PLUS the .git directory as a
"repository" as well as being able to refer to the .git directory
alone as the "repository".

In the way I think of it

git init

initialises a Git repository, however, the only thing that changes
as a result is that a .git directory has been created, ergo, the
.git directory is the repository.

Furthermore, the fact that one can take the .git directory, move it
to a new directory and start using it there (very much a nice feature)
also suggests to me that it is the .git directory that is the repository,
as distict from a working directory, under Git control because of the
existence of a repository within it.

Interested to hear any thoughts around the semantics here,
Kevin Buckley

-- 
Supercomputing Systems Administrator
Pawsey Supercomputing Centre
