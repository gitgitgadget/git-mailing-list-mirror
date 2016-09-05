Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2119C20705
	for <e@80x24.org>; Mon,  5 Sep 2016 22:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbcIEWwf (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 18:52:35 -0400
Received: from mail-out.elkdata.ee ([195.250.189.24]:52798 "EHLO
        mail-out.elkdata.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932370AbcIEWw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 18:52:26 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Sep 2016 18:52:25 EDT
Received: from mail-relay.elkdata.ee (mail-relay.elkdata.ee [195.250.189.180])
        by mail-out.elkdata.ee (Postfix) with ESMTP id 1F8BF64EACCB
        for <git@vger.kernel.org>; Tue,  6 Sep 2016 01:42:31 +0300 (EEST)
Received: from mail-relay.elkdata.ee (unknown [195.250.189.180])
        by mail-relay.elkdata.ee (Postfix) with ESMTP id 1A034124E772
        for <git@vger.kernel.org>; Tue,  6 Sep 2016 01:42:31 +0300 (EEST)
X-Virus-Scanned: amavisd-new at elkdata.ee
Received: from mail-relay.elkdata.ee ([195.250.189.180])
        by mail-relay.elkdata.ee (mail-relay.elkdata.ee [195.250.189.180]) (amavisd-new, port 10024)
        with ESMTP id m1TzsM5H16IM for <git@vger.kernel.org>;
        Tue,  6 Sep 2016 01:42:28 +0300 (EEST)
Received: from mail.elkdata.ee (mail.elkdata.ee [194.106.101.168])
        by mail-relay.elkdata.ee (Postfix) with ESMTP id E6D8D124E6E9
        for <git@vger.kernel.org>; Tue,  6 Sep 2016 01:42:28 +0300 (EEST)
Received: from mail.meie.biz (unknown [90.190.182.21])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: leho@jaanalind.ee)
        by mail.elkdata.ee (Postfix) with ESMTPSA id E229367BF408
        for <git@vger.kernel.org>; Tue,  6 Sep 2016 01:42:28 +0300 (EEST)
Received: from [10.24.0.157] (papaya-vpn.meie.biz [10.24.0.157])
        by mail.meie.biz (Postfix) with ESMTPSA id B9BF314541B
        for <git@vger.kernel.org>; Tue,  6 Sep 2016 01:42:28 +0300 (EEST)
To:     git@vger.kernel.org
From:   "Leho Kraav (Conversion Ready)" <leho@conversionready.com>
Subject: 2.10.0: multiple versionsort.prereleasesuffix buggy?
Organization: Conversion Ready - Lead Generation, E-commerce Website
 Development & Conversion Care
Message-ID: <beba7c55-3f18-66a2-acd9-77f2a5cc55a7@conversionready.com>
Date:   Tue, 6 Sep 2016 01:42:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101
 Thunderbird/47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all


Here's the testing tree https://github.com/woothemes/woocommerce

.git/config has:

[versionsort] 
 

     prereleasesuffix = -beta
     prereleasesuffix = -RC

$ git tag -l --sort=version:refname
...
2.5.0-RC1
2.5.0-RC2
2.5.0-RC3
2.5.0-beta-1
2.5.0-beta-2
2.5.0-beta-3
2.5.0
2.5.1
2.5.2
2.5.3
2.5.4
2.5.5
2.6.0-RC1
2.6.0-RC2
2.6.0-beta-1
2.6.0-beta-2
2.6.0-beta-3
2.6.0-beta-4
2.6.0
2.6.1
2.6.2
2.6.3
2.6.4

Per documentation, I'm supposed to see something like
...
2.5.0-beta-1
2.5.0-beta-2
2.5.0-beta-3
2.5.0-RC1
2.5.0-RC2
2.5.0-RC3
2.5.0
...


No matter what I do in `.git/config`, RC goes up front. What's going on?

(Yes, this project's tag capitalization is messed up.)
