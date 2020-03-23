Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DB1C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A55320753
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 14:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCWOxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:53:46 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21177 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgCWOxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 10:53:46 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2020 10:53:45 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1584974316; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=iPIazSw3k4urtd4eWggtNEOSfYh+sO0JkxpItQqxBf4fhuTFzCac6RpmJT4LI+x3oOGvnaXYZzwVAn/MtxPY2cd5GxEQAG9AhDO4NBJZiQTbW3Y37RJMRgfqNA2zlAFranQsFt8u7MGY/5N6xUNjxKbMXwMbXQEroG4ifhrNqS4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1584974316; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=VOLf4XtCXd7p+Spen4K9MexEBeX0UMQAA9YgeJBnA90=; 
        b=I67G1D0+JruNpOci3KC9ClGU7J5LAZuvVXL43T+VxJUZj6Q5+g8Ouw22czHTcMcoB5ibOcuoHxtJZ/VPoZo09zWJFmerjQkqrhUokVwt61LkZ5UH5yrD1QGP/VqrFP+0hzCq/Ih7YQQvgMoTVi6/yerkIaGCmn7DS2rPc0+v78w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=jon@smalls.rocks;
        dmarc=pass header.from=<jon@smalls.rocks> header.from=<jon@smalls.rocks>
Received: from Genusers-MBP.fios-router.home (pool-108-49-187-119.bstnma.fios.verizon.net [108.49.187.119]) by mx.zohomail.com
        with SMTPS id 1584974314850554.8213101145143; Mon, 23 Mar 2020 07:38:34 -0700 (PDT)
To:     git@vger.kernel.org
From:   Jonathan Smalls <jon@smalls.rocks>
Subject: git > 2.10.1 fails to update index on macOS 10.14.5
Cc:     Torey Adler - NOAA Federal <torey.adler@noaa.gov>
Message-ID: <7b8b23f8-e12a-bde9-4b9e-ca8c908d1203@smalls.rocks>
Date:   Mon, 23 Mar 2020 10:37:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After upgrading my work station, I found in git-2.22 that git would not 
recognize any file changes until I ran  `git reset --hard`. I thought 
that it was a problem with my own settings.
	However I upgraded to git-2.25, and the problem actually got worse. In 
2.25 the index still failed to update, but `git reset --hard` no longer 
had any effect.

I have not looked to find exactly where the breaking change was 
introduced, but I have since downgraded to git-2.10.1 and now get the 
expected behavior.
-- 
http://jon.smalls.rocks
857 301 9231
