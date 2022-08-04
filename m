Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18BAC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiHDBZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiHDBZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:25:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC97422DA
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659576305; x=1691112305;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=mCweCo8v4ERfRet0zc2BHqFk8CFodk60ohE/dK0myo8=;
  b=XVKSUygff+P3fvpEvlwPS9XTimdqsFrZH+oIEZv3QeoDehKSfuhHTMW/
   YxeoXCzigwgEgwi36aQzqByPi2DJqGBiYh8FAgOcf0RkCj4LoMvWVndur
   +7LNPKjcAz5ux8U+8E1IY6S3OIIpaJ+YEFpKDV/sD7BMwKbuAuP2DO6h2
   G9r8PI6wLET3pojoNJKGq7Yi78uWk/ZcBlnvOwVNRrNBJ9pQKwVrPA9p4
   PNnbg+cdvF/vSpAxilme53PQgE07hkdUUglGuv6FtFaSGP7emCEtl8IrC
   P3pI4cWUc/bJP7E2OuRKhM+KMEqQr6uKpwGQuWsbzYCFknQw+fMIa9yfv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="276731544"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="276731544"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 18:25:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631374145"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.238.212.63]) ([10.238.212.63])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 18:25:04 -0700
Message-ID: <e564b1e3-0f34-dce3-400d-439a40ec4d48@intel.com>
Date:   Thu, 4 Aug 2022 09:25:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   "Wang, Lei" <lei4.wang@intel.com>
Subject: [Question]: Question about "cherry-pick" internal
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I heard that cherry-pick is just a kind of merge, the difference between 
it and the traditional merge is that it treats the parent commit of the 
commit you want to cherry-pick as the merge-base, then it will diff both 
the current branch with the parent and the commit you want to 
cherry-pick with the parent to generate 2 diffs, then it will try to 
apply these 2 diffs to the parent commit. If the diff modified the same 
line, then a conflict occurs.

If the above is true, but why when I cherry-picked a commit, a conflict 
occurs even the 2 diffs didn't modify the same line, they modified the 
two consecutive lines (line n and line n + 1), so what can be the 
potential reason for this?

Looking forward to your valuable comments!

-- 
BR,
Lei

