Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5C620248
	for <e@80x24.org>; Fri, 15 Mar 2019 12:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfCOMOW (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 08:14:22 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:49878 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbfCOMOW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 08:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WmBalHmM8n5Ue9qgUJGdYRd/PVC8W/pltvV1PBF2VUc=; b=BV7yIz1qXUU9cmjTEHt5WSc62V
        jMees5TmlUX0FSd65/a/fbGzxlPiyPfDjwA1mUtb1do4Y4PXpyvLVppqVF4fNRMD8TWUdK5Fek8Il
        mecEhkUl7Is24yYRSmppyIGMZz45bUjj2qwsbrhL+UEEjwGf8ofo7YG+lohPTPEUAs+OOUDutPCXb
        8RjlPSK1TuFQM51QsC5sGeRb8/XjbhCcE6nVwBM6ak3+42zu70kD1czactEQVueWU//eXQjHjkwvT
        CZpseH/HDEftXkCO8VCgWhqVT7QKWBw1pA/rnyGF7nZNs72sEER/pm57s0vHoaxZWVujHgzL3TsCx
        oBQdJHsA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:60852 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h4lj9-006ZOw-KE
        for git@vger.kernel.org; Fri, 15 Mar 2019 08:14:20 -0400
Date:   Fri, 15 Mar 2019 08:14:18 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "git clone --shallow-exclude ...", fatal: the remote end hung up
 unexpectedly
Message-ID: <alpine.LFD.2.21.1903150809070.26709@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  probably doing something idiotic but i'm enumerating variations of
shallow cloning, and tried the following:

$ git clone --shallow-exclude=master https://github.com/django/django.git
Cloning into 'django'...
fatal: the remote end hung up unexpectedly
$

  it is entirely reproducible, and some googling suggests that this
represents an error at the *other* end, which in some weird way does
not support that clone option. that seems strange ... should this
option work? am i using it incorrectly?

  wait, hang on ... i just picked one of django's topic branches at
random, and this did succeed:

$ git clone --shallow-exclude=stable/2.0.x https://github.com/django/django.git
Cloning into 'django'...
remote: Enumerating objects: 33112, done.
remote: Counting objects: 100% (33112/33112), done.
... etc etc ...
$

but all this gave me was the master branch. i clearly don't understand
what this option is supposed to do.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
