Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB950C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 07:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8755761056
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 07:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbhIAHp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 03:45:26 -0400
Received: from mout02.posteo.de ([185.67.36.66]:39551 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242640AbhIAHpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 03:45:21 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0384E240101
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 09:44:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.jp; s=2017;
        t=1630482264; bh=zEHlV3JrppGGNjl1AmtR7tMeCxdjIf5NW7Yfx0WyLPU=;
        h=Date:From:To:Subject:From;
        b=a4nwNBcYaUEpgzVTwnIj0CeiuzwTkLA4stwnINxrF7hpAzTl/4JwbKEVUziooaGid
         zCaK2RvfN4gtSvp/hj98VscLnte5NZEZiXQK04oRv0HsBASO+UdC8AGRlwyKnko0Vz
         oqCIVRcc+G0VACZn1oPzBeCr//uATw103uscfBxddn9j5/cj5Rr0vH29WtHtTIo0MS
         ssLfTHJMEn3kBXN08Xzd8A2qZBE0GDd526c91lZ7/h4NwX1+LjbOhR+sjn9KEJpU0t
         4PUhoID8L8e1xQmG7SN5OlzL/ZdMfrMrfhngbc/UJ7I5fCFShO3qqixCgNxekGElpB
         GCJlqqbqlMmLQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Gzx0758F1z9rxb
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 09:44:23 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Sep 2021 07:44:23 +0000
From:   c.buhtz@posteo.jp
To:     git@vger.kernel.org
Subject: Concept question about push/pull stashes
Reply-To: git@vger.kernel.org
Mail-Reply-To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Message-ID: <8d2f05e6f4ff9855460402e8cdafd7e7@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
my question has to goals. I want to understand the design decisions 
behind a (missing) feature and and wan't to explore the needs of other 
users before I start to implement something.

There is no usual way to exchange stashes with other repos/users. 
Stashes are code snippets that are unfinished and not clean enough to 
commit them anywhere not even in another branch.

Why? What is the concept behind this? I am sure this was well thought. I 
just try to understand.

A feature like this is often asked by users when you asked the search 
engine of your trust.

One workaround is to simply commit the stashed code, push/pull it, 
checkoutit into the other repo and delete the last commit.

The other workaround is to create a patch-file from a stash. But then 
the question is how to exchange this file?

Why not use the git infrastructure itself?

I have workaround in my mind. I couuld use a script wich creates patch 
files for each existing stash and commit them into the repo. Thats all. 
To keep the repo "clean" the path files could be archived into a hidden 
(dotted filed) tar file. Or the tar file could be stored inside the 
".git" folder if there is a way.

I am interested in your thoughts about this.
