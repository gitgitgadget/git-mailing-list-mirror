Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04E82095E
	for <e@80x24.org>; Fri, 24 Mar 2017 11:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935887AbdCXL4O (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 07:56:14 -0400
Received: from giant.haxx.se ([80.67.6.50]:52756 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935564AbdCXL4N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 07:56:13 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Mar 2017 07:56:12 EDT
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id v2OBmcle019267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2017 12:48:38 +0100
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id v2OBmcHr019263;
        Fri, 24 Mar 2017 12:48:38 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Fri, 24 Mar 2017 12:48:38 +0100 (CET)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        gitster@pobox.com, sxlijin@gmail.com
Subject: Re: [PATCH v2] travis-ci: build and test Git on Windows
In-Reply-To: <20170324113747.44991-1-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1703241242210.17768@tvnag.unkk.fr>
References: <20170324113747.44991-1-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Mar 2017, Lars Schneider wrote:

> Most Git developers work on Linux and they have no way to know if their 
> changes would break the Git for Windows build. Let's fix that by adding a 
> job to TravisCI that builds and tests Git on Windows. Unfortunately, 
> TravisCI does not support Windows.

Forgive me for bursting in and possibly repeating what you've already 
discussed. I just read about the limitations for doing windows builds via 
travis so I thought I'd at least let you know that you can avoid those 
limitations without too much work:

Two alternative approaches would be:

1. use appveyor.com, as that is a Travis-like service for Windows. We do our
    windows-builds in the curl project using that.

2. run your own buildbot and submit data using the regular github hook and
    have buildbot submit the results back (it has a plugin that can do that).
    We do solaris-builds in the curl project using that method (thanks to
    opencsw.org) and some additional windows-builds thanks to private
    individuals.

-- 

  / daniel.haxx.se
