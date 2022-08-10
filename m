Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6FEC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 19:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiHJTOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 15:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiHJTOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 15:14:48 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59AEB1E4
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 12:14:47 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 27AJEc5d060381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Aug 2022 15:14:39 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Niklas'" <git@nwuensche.com>, <git@vger.kernel.org>
References: <20220810170319.mxd6h2p5tm6y5xx3@imap.mailbox.org>
In-Reply-To: <20220810170319.mxd6h2p5tm6y5xx3@imap.mailbox.org>
Subject: RE: Git-Alias is callable from outside a git repo
Date:   Wed, 10 Aug 2022 15:14:32 -0400
Organization: Nexbridge Inc.
Message-ID: <000c01d8aced$6f67f460$4e37dd20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG9blYYML1W3QDYXmZ3N+TR7MZmXK3e/Ygg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 10, 2022 1:03 PM, Niklas wrote:
>Steps to reproduce:
>
>1. Having the following global .gitconfig
>
>[alias]
>     f = "!echo "test""
>
>2. Calling `git f` in a folder which does not belong to a git repo
>
>Expected Behavior:
>
>Seeing some message like like
>`fatal: not a git repository (or any parent up to mount point /)`
>
>Actual Behavior:
>
>Prints "test"
>
>Git 2.37.1 under Arch Linux

I do not think this is a bug. There are git commands that do not require
repositories, like git version. Git has know knowledge of what your alias is
going to do without executing it. If your alias wanted to run git version or
git hash-object, it would not need a repository to do so.
--Randall

