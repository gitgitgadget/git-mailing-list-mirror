Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A4BC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718E4221EF
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIKQLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgIKPhL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 11:37:11 -0400
X-Greylist: delayed 279 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Sep 2020 08:36:13 PDT
Received: from giant.haxx.se (www.haxx.se [IPv6:2a00:1a28:1200:9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83955C06138F
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 08:36:13 -0700 (PDT)
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id 08BFVH6M025211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 17:31:17 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id 08BFVGn6025207;
        Fri, 11 Sep 2020 17:31:16 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Fri, 11 Sep 2020 17:31:16 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Jeff King <peff@peff.net>
cc:     Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org
Subject: Re: Git doesn't honor NO_PROXY environment variable while cloning
In-Reply-To: <20200911135928.GA1986935@coredump.intra.peff.net>
Message-ID: <alpine.DEB.2.20.2009111729530.6227@tvnag.unkk.fr>
References: <CA+B51BGRuLfF7FpiK93Wih0XhsC7rJLGjkF2CzrEsUkBEif+jw@mail.gmail.com> <20200911135928.GA1986935@coredump.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 11 Sep 2020, Jeff King wrote:

> So I dunno. This seems like a libcurl bug, but it's possible we're feeding 
> it data wrong somehow.

I didn't check very closely, but it certainly sounds like this one:

   https://github.com/curl/curl/pull/5902

Fixed in curl master in this commit (8 days ago):

   https://github.com/curl/curl/commit/3eff1c5092e542819ac7e6454a70c94b36ab

-- 

  / daniel.haxx.se
