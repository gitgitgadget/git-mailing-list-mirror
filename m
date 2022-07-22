Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4561C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 02:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiGVCj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGVCjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 22:39:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356141BE8B
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658457595; x=1689993595;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=kJ9f/wilVO6lTNiq/yvO9TZzhcIrljqGiq0Mo6UmpEY=;
  b=dDrlhAN5ejRqF12Qky1DCIDVf0svHmPcd3LL3Qm93zngwB+ERdcgXp+A
   QhXeaq2C0HdKULXhcOQjKRObosu1kFjwAJC3HhO9/WSvjzEa+Dot/2Le+
   50FtOERkaPKfe+BXdLr1rTPB3hYKzykHVJsxImXM5jByDYtGMlcLXVJx6
   IbjKD9h3Zi6ws8lUsCQtZgGDwLTyNfF+BaEpq7gNTL/lC43XdLpwmpn7o
   bw8rtNNIzExGH/Loda20aH5Zc5e9baVQnJyP7jUtSgIifW+3mPbCDJAgj
   JOe6sRoYUqqX0la2ax+CRaoNnwBjl8WGuhVd+BoXDguoDBzkMPTTUx6vh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="266996696"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="266996696"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 19:39:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="657027531"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.239.13.96]) ([10.239.13.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 19:39:54 -0700
Message-ID: <6cfda280-44bb-cdcc-a6fb-e0e4795edc65@intel.com>
Date:   Fri, 22 Jul 2022 10:39:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   "Wang, Lei" <lei4.wang@intel.com>
Subject: [Bug Report] The since date of "git log" will have influence on the
 until date of it.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The since date of "git log --since" will have influence on the until 
date of it.

How to reproduce?

 1. clone this repo https://erol.kernel.org/lkml/git/8/
 2. run "git log --since="2020-05-30" --until="2020-06-02"", it won't
    output anything
 3. change the since date to 2020-05-29: run "git log
    --since="2020-05-29" --until="2020-06-02""
 4. it will output the commits in 2020-06-02 (The until date)

Why would that happen, I just change the since date from 2020-05-30 to 
2020-05-29, why it suddenly output the commits in 2020-06-02?

-- 
BR,
Lei

