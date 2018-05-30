Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA92E1F42D
	for <e@80x24.org>; Wed, 30 May 2018 17:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbeE3RQF (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 13:16:05 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:41318 "EHLO
        homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753591AbeE3RQE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 May 2018 13:16:04 -0400
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id F1672258067
        for <git@vger.kernel.org>; Wed, 30 May 2018 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=novalis.org; bh=bOPMMW1q/CYpDdhcTEw
        3/AXvfIE=; b=fjCBQL4Seim0iRcHXRYGIGDTsiFzHzBkGFDR68H5/AOx3fs2LFH
        aZHZ9OYrMEkGZoWNOr1KTHASVl4pX1Ok0IsZidd+dkWmyI/vftkZpwQ3TIG0vqLP
        KVtjKGG/HwNYl93sUcvcX+YcYd9wIbJCFeKY68Wb5Jnp14U2PoD0/1+o=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id A4C4C258066
        for <git@vger.kernel.org>; Wed, 30 May 2018 10:16:03 -0700 (PDT)
Message-ID: <1527700562.4289.87.camel@novalis.org>
Subject: git push requires a worktree?
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org
Date:   Wed, 30 May 2018 13:16:02 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am doing a funny thing where I do git -C .git/modules/morx push
fleem:fleem.  This is failing in the case where I have a sparse
checkout and the worktree directory "morx" (which is where
.git/modules/morx/config's core.worktree points) doesn't exist.  

I don't know why git push cares about the worktree -- it'll happily
work in a bare repo with no worktree at all, or if the worktree is an
unrelated git repo or whatever.

I can work around it, but if there's a bug, I think we should fix it.
