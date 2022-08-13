Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69CEC00140
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 02:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiHMCGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 22:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiHMCGO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 22:06:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8280E1F615
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 19:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660356373; x=1691892373;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=rr/NEwdT5niGizXZln1/Y5sb4VYa0LUAkV/vQgNPp0I=;
  b=RmPUpoIgrbv6F6vhxKTzlpjeIQjpNf+C3Yr4NYE4HkrGn5wxsjML+ilR
   wleFfZE9Vr7Ac/eYDpkoQ/YQUKyj8jNKcBRUkTI16VHf3Brq3bQ5/SFVm
   9KzxkMC4s/sq2ObfA7TVyM0HUWp5kA9vo+IszDymoG4x+I3AxyRrKb9LF
   0YrcbOmRmGMfTyiQqhrdTiQZVEwfxIuUGmzKNMeuFaF54r0OJSSNQ+kXs
   oquSO2O22f4bFoam7b4sYLHo22a1MnsYkT9mRHfWWq2/LkMVEkyuD3ZWh
   FtNZSHSf/qO/H8otp0/0aCT/XLteXWjruUlPEs5buxTqpkCnfIr7n+WSh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291717459"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="291717459"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 19:06:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="666049149"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.254.213.221]) ([10.254.213.221])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 19:06:12 -0700
Message-ID: <20d7c54f-7438-1124-7a9e-fdc902a4cc18@intel.com>
Date:   Sat, 13 Aug 2022 10:06:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Content-Language: en-US
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   "Wang, Lei" <lei4.wang@intel.com>
Subject: [Question]: Does "git log" involve some stochastic operations?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a question about the internal of "git log". Each time when I 
execute the following command:

 > git log --numstat --since="2022-06-01" --until="2022-06-21" 
--no-merges --format=%n%n%s%n%H%n%cs%n%an\<%ae

The number of the commits in the output is slightly different. I didn't 
do any sync operation in the repo, so the only reason I can found is 
that maybe git log involves some stochastic operations, so each time the 
output will be a little changed. Is my assumption right?

-- 
BR,
Lei

