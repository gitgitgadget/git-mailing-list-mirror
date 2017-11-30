Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AACB20954
	for <e@80x24.org>; Thu, 30 Nov 2017 09:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbdK3JzT (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 04:55:19 -0500
Received: from giant.haxx.se ([80.67.6.50]:57277 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdK3JzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 04:55:18 -0500
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id vAU9t7FE004612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2017 10:55:08 +0100
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id vAU9t7km004607;
        Thu, 30 Nov 2017 10:55:07 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Thu, 30 Nov 2017 10:55:07 +0100 (CET)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
cc:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Doron Behar <doron.behar@gmail.com>, git@vger.kernel.org
Subject: Re: imap-send with gmail: curl_easy_perform() failed: URL using
 bad/illegal format or missing URL
In-Reply-To: <44bbb765-fb0d-5b80-c697-76a9b6ff0811@morey-chaisemartin.com>
Message-ID: <alpine.DEB.2.20.1711301052350.30591@tvnag.unkk.fr>
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain> <20171130020445.GF15098@aiede.mtv.corp.google.com> <50fb321e-bbfc-adae-992d-eea1b818171e@suse.de> <alpine.DEB.2.20.1711301041250.30591@tvnag.unkk.fr>
 <44bbb765-fb0d-5b80-c697-76a9b6ff0811@morey-chaisemartin.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Nov 2017, Nicolas Morey-Chaisemartin wrote:

> It would make sense to have a way to ask libcurl to URI encode for us. I'm 
> guessing there's already the code for that somewhere in curl and we would be 
> wise to use it. But to work wqith older version we'll have to do it 
> ourselves anyway.

libcurl only offers curl_easy_escape() which URL encodes a string.

But that's not really usably on an entire existing URL or path since it would 
then also encode the slashes etc. You want to encode the relevant pieces and 
then put them together appropriately into the final URL...

-- 

  / daniel.haxx.se
