Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31EA1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 19:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfHOTuc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 15:50:32 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36291 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbfHOTuc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 15:50:32 -0400
X-Originating-IP: 157.49.190.176
Received: from localhost (unknown [157.49.190.176])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 293181BF204
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 19:50:29 +0000 (UTC)
Date:   Fri, 16 Aug 2019 01:20:27 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Subject: completion: checkout.* not being completed in zsh
Message-ID: <20190815185901.btf4d7c4ewsccxuu@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I just noticed that checkout.* is not being completed in zsh. I wanted 
to set checkout.defaultRemote, but zsh would not auto-complete it.

When I do:

$ git config check<Tab>

zsh does not auto-fill "checkout."

Doing the same in bash works, so the functionality is there, it just 
doesn't work in zsh.

Once I add checkout.defaultRemote to my git config, autocompletion 
starts working, but only for defaultRemote, even though checkout has two 
options: defaultRemote and optimizeNewBranch.

To make it clear, this is what happens once I have added 
checkout.defaultRemote to my config:

$ git config check<Tab>
$ git config checkout.  # Completes to "checkout.". Correct behaviour.
$ git config checkout.<Tab>

# Completes to defaultRemote, even though it should ask between 
# defaultRemote and optimizeNewBranch
$ git config checkout.defaultRemote

I tried looking at contrib/completion, and I can see that zsh completion 
works on top of bash completion, so I don't know why exactly it works 
for bash but not for zsh.

I am not too familiar with how these auto completion scripts work, so if 
someone can point me in the right direction, I'll see if I can figure 
out a fix and submit it here.

-- 
Regards,
Pratyush Yadav
