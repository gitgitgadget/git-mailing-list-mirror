Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DBEC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9549460200
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 16:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhJVQ7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 12:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhJVQ7T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 12:59:19 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Oct 2021 09:57:01 PDT
Received: from mailproxy07.manitu.net (mailproxy07.manitu.net [IPv6:2a00:1828:1000:1112::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2793C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 09:57:01 -0700 (PDT)
Received: from localhost (p200300ef4f226700021e65fffe229a84.dip0.t-ipconnect.de [IPv6:2003:ef:4f22:6700:21e:65ff:fe22:9a84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: u16723@rkita.de)
        by mailproxy07.manitu.net (Postfix) with ESMTPSA id 799E2C8848;
        Fri, 22 Oct 2021 18:49:41 +0200 (CEST)
Date:   Fri, 22 Oct 2021 18:49:39 +0200
From:   Rene Kita <mail@rkta.de>
To:     Justus Ranvier <justus@opentransactions.org>
Cc:     git@vger.kernel.org
Subject: Re: gitignore as symbolic link
Message-ID: <YXLro/8c1Feg6TcN@kitchen>
References: <fcf288fc-72b7-964c-e462-496066528c7b@opentransactions.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf288fc-72b7-964c-e462-496066528c7b@opentransactions.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 05:07:44PM -0800, Justus Ranvier wrote:
> I have several repositories where the top level .gitignore file is a
> symbolic link to the actual file which is contained in a submodule which all
> the repositories share.
> 
> This worked fine up to and including version 2.31.1 but as of 2.32.0 running
> any command which would cause .gitignore to be read results in a "too many
> levels of symbolic links error" and git behaves as if .gitignore is not
> present.
> 
This was fixed in commit a185dd58ecc17f2ea16985d59c9bb7b09bec7775 [1].

[1] https://lore.kernel.org/git/xmqqlf83h2a7.fsf@gitster.g/
