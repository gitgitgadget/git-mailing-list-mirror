Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDAFC2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 07:35:07 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CA320774
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 07:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="BgeT/3pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CA320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgDMHfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHfE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 03:35:04 -0400
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074DEC008651
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 00:35:04 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4910kr1fkHz9sQt; Mon, 13 Apr 2020 17:35:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1586763300; bh=A1FEDKEnY9Nzwo946VepBVOykVMbOWfbNMsRjTmgP0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgeT/3pr4wwpKekIBpOzdUGOxYfeFLQ+tuYKj5nlssI+nhlqobJxla+EfGPVknt6S
         HY3n6JzVhIVKMVj/cwV2nky5CdbXqbdUDXXbPmwyINl4MRfZmlFAUDERhKIUWn0FiX
         Sod6QZLl6gT2Zef0ez3s2E78tTO94AQJ7HQjcN83wvJM4odxFOhFNX+6k64cMW7apv
         FpBn0EDLzEs8rXq43Ds5y8xu5lX8TlzXYfHeIMW4NUbJVL3utQXYVrvCyBi/I+WNCb
         5Hv58aRPdoMNa+MdZu0/IARIY1pPUBAM4hdyu34k24UcSTLQjQ5+OlBSbe9/0S1IVe
         mlxV/U6t0OMTg==
Date:   Mon, 13 Apr 2020 15:11:51 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
        <dpb@corrigendum.ru>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitk: fix the context menu not appearing in the presence
 of submodule diffs
Message-ID: <20200413051151.GB14888@blackberry>
References: <20191215182550.397-1-dpb@corrigendum.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191215182550.397-1-dpb@corrigendum.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 15, 2019 at 09:25:50PM +0300, Роман Донченко wrote:
> Currently, submodule diffs can cause the diff context menu to fail
> to appear because of a couple bugs in parseblobdiffline:
> 
> * it appends the submodule name to ctext_file_lines instead of
>   a line number, which breaks the binary search in find_ctext_fileinfo;
> 
> * it can desynchronize ctext_file_names and ctext_file_lines
>   by appending to the former but not the latter, which also breaks
>   find_ctext_fileinfo.
> 
> Fix both of these.
> 
> Note: a side effect of this patch is that the context menu also
> starts appearing when you right-click on submodule diffs (and not just
> regular diffs). The menu is non-functional in this case, though,
> since you can't run blame on submodules.
> 
> Signed-off-by: Роман Донченко <dpb@corrigendum.ru>

Thanks, applied.

Paul.
