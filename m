Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26FFC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 05:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B832071E
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 05:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=embedjournal.com header.i=siddharth@embedjournal.com header.b="Ku9JCPzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfLZFNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 00:13:01 -0500
Received: from sender3-of-o56.zoho.com ([136.143.189.56]:21605 "EHLO
        sender3-of-o56.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfLZFNA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 00:13:00 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Dec 2019 00:13:00 EST
ARC-Seal: i=1; a=rsa-sha256; t=1577336275; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eboE+a0R0zQuAz7+XZXdJnC+ZJnul1l6xH02pICrc+utwk1y6E2+8IvWosfc9RWBcVSlALv25YB2Xyz4/zWU3Dk02VEjZvxVgUf8woufHZoX6GOVa6ZxkrjbXmF6MDlgShT0ST37ScNlV991j5/Yjvd6g+EXpf8z2/pNFETuimw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1577336275; h=Content-Type:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=BGgVN0cuFxJARK6hGcpDQf1LbBPN2KY8c7F0V10nc/E=; 
        b=YvR/xweBbjo1Wz+MWc/czP86p0V6ortTKM1UClEJpQX+J2Ec5mvrWfxxOaKYLlhJZD5Z++pNh1AeQIslHvNPbJE1Z1FNg/EPgXjbTGPt29oXCPb1ylTTe7kOMmy9mHLQJAklhu9Gfx2dK2PaTuULxAY54roKPE1XdIvJRjIUIoU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=embedjournal.com;
        spf=pass  smtp.mailfrom=siddharth@embedjournal.com;
        dmarc=pass header.from=<siddharth@embedjournal.com> header.from=<siddharth@embedjournal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1577336275;
        s=zoho; d=embedjournal.com; i=siddharth@embedjournal.com;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        bh=BGgVN0cuFxJARK6hGcpDQf1LbBPN2KY8c7F0V10nc/E=;
        b=Ku9JCPzPTf+x1BqM3D6Yzc9fohsFH1xVnST6GaHuZ8WSM/QoAFGF4OFByHC5OLSw
        vYb9SIVkHPaWEaH7YctuidEN9c1YAOHIX+FcpWaDbKUqHI4qxl9D7dmirhHzO0u6Xr5
        0WogkHRi8kmwy77lQfslrTwt4CeOPi79jSuSph0Q=
Received: from csiddharth-a01.vmware.com (157.51.212.19 [157.51.212.19]) by mx.zohomail.com
        with SMTPS id 1577336272374393.4856221603892; Wed, 25 Dec 2019 20:57:52 -0800 (PST)
Date:   Thu, 26 Dec 2019 10:27:43 +0530
From:   Siddharth Chandrasekaran <siddharth@embedjournal.com>
To:     git@vger.kernel.org
Subject: git cherry --help -- limit clarification
Message-ID: <20191226045743.GA8982@csiddharth-a01.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output of `git-cherry --help` has (last few lines):

> ...
> By specifying base as the limit, you can avoid listing commits between base and topic:
>
>    $ git cherry origin/master topic base
>    - cccc000... commit C
>    + bbbb000... commit B
>    - aaaa000... commit A

The output of `git cherry origin/master topic base` suggests that it
list commits between base and topic instead of branching point. But
"you can avoid listing commits" -- phrase is confusing.

Perhaps it must be reworded for clarity?

Sid.

