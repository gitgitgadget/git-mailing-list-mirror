Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CDAC46467
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 17:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLYRn6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 25 Dec 2022 12:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLYRn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 12:43:57 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318A5FBC
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 09:43:55 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BPHhpOo066935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 25 Dec 2022 12:43:52 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@isandrew.com>, <git@vger.kernel.org>
References: <5b64c7f5-59e3-f319-4efa-4624907436b6@isandrew.com>
In-Reply-To: <5b64c7f5-59e3-f319-4efa-4624907436b6@isandrew.com>
Subject: RE: Theirs merge strategy
Date:   Sun, 25 Dec 2022 12:43:47 -0500
Organization: Nexbridge Inc.
Message-ID: <007c01d91888$74673500$5d359f00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHqZe7hG5dTYocn7Fo5EGBSHwQUkK5cQ9aA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 25, 2022 12:19 PM, Andrew wrote:
>Would it be possible to revisit the decision to not have a "theirs"
>merge strategy?
>
>I think there are legitimate reasons to use it, beyond the plenty of rope argument.
>
>One example is you're working with a successfully written and operating branch
>through multiple releases, but due to some external change (product direction,
>upstream changes) you decide that an approach in a different branch is
>better.  You want to use the other branch, while keeping the history of the
>successful prior releases, for all the normal reasons one wants to keep history.  A
>hard reset wouldn't help in this case.
>
>The decision to remove it was to prevent people from having bad workflows.  In
>reality, in lieu of theirs people use ours in reverse which is even worse.
>
>The previous discussion I found was at
>https://marc.info/?l=git&m=121637513604413&w=2

This use case applies more generally in some release workflows. A valid (and common in my world) workflow can have with multiple release branches, and the same pull request going to a selection of release branch. Conflicts occasionally happen in the pull request merge, but the pull request, in a high audit situation cannot be modified - conflicts are resolved later under a separate signature. The -s theirs permits the pull requests to be merged intact with no changes (as required by various audit rules).

