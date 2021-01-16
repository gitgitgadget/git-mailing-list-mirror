Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E484C4332B
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F27C22527
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbhAPRN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbhAPRKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:41 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240BC0617A5
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 06:01:40 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4DJ08c14dbzQlTC;
        Sat, 16 Jan 2021 15:01:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m-reimer.de; s=MBO0001;
        t=1610805694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qfe8OEyOkEbWIR+hjzR8IqCMoCHskPnn0C+1IqpOp5Y=;
        b=z3JkRCSXzeKTlzxQNn43fca3+j8C7BBRCt9gmU+9CFSMxL454Xs6FZ/9XLeqAMju7FZkI1
        8xjYa0R1KtGCM0Jc39ILY3aihIzyPnQJm1/5OCA1JyI/0nkrGC4M1BqJTEXUEKYGtOnFwb
        KVVwqYZasrYolbC7XqHgHUC9jg9i3kPsdm0q9a44N6yowT22IPFDXpcAxVVPQdnP1IQu4N
        t/Apd1+gKE4BSfFa23SYbKT9SnlRADG2RpR3XEDqchJsxbqq25b0Rhq/e0FrC8UbsIaq1M
        hbh4z3f1ZFflPmDkhziUgPdoo+jIkw7oyndOp1oHSDqqFTiFvQ5uC7Y6UxmkpA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id WCD1oAgsqTcS; Sat, 16 Jan 2021 15:01:32 +0100 (CET)
Subject: Re: Repository of repositories without submodules?
To:     Chuck Ricketts <chuck.the.pc.guy@gmail.com>, git@vger.kernel.org
References: <CAHS-jcAxNgZq4UNxyooftPn_nA_935THGdNHGk65UKURfkoTmA@mail.gmail.com>
From:   Manuel Reimer <mail+git@m-reimer.de>
Message-ID: <c92b380f-08da-f31b-4dc4-ff43a1ac256f@m-reimer.de>
Date:   Sat, 16 Jan 2021 15:01:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAHS-jcAxNgZq4UNxyooftPn_nA_935THGdNHGk65UKURfkoTmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.69 / 15.00 / 15.00
X-Rspamd-Queue-Id: CF14D17B4
X-Rspamd-UID: bfbbd4
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16.01.21 11:39, Chuck Ricketts wrote:
> I am cross-compiling many Arch packages with small changes made
> locally in order to better suit a cross-compiling environment. That
> being said, I've got a directory of single-directory git repos that I
> would like to publish my changes to.

Seems like the common "several directory GIT" case caused by the fact 
that AUR organizes all PKGBUILDs in separate repos.

For me "git subtree" works great for this case:

https://github.com/M-Reimer/PKGBUILDs
or
https://github.com/M-Reimer/wine-lol

See the "pkg.sh" file which, to be honest, isn't even from me. I just 
adapted it slightly to my use case. Original came from here:

https://github.com/yuvadm/archlinux-packages/blob/master/pkg.sh

Every single PKGBUILD is its own "subtree" which can be pushed 
separately to AUR if I want to. Pushing this subtree makes GIT somehow 
"automagically" figure out a proper commit history for this subdirectory 
and push this to the external repo.

Manuel
