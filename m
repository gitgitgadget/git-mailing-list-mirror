Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBFEC43333
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 17:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088C522B30
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 17:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAJRUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 12:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbhAJRUK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 12:20:10 -0500
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Jan 2021 09:19:30 PST
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B69C061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 09:19:30 -0800 (PST)
Received: from postfix01.mail.de (postfix02.bt.mail.de [10.0.121.126])
        by shout02.mail.de (Postfix) with ESMTP id 06BB9C01E0;
        Sun, 10 Jan 2021 18:09:25 +0100 (CET)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix01.mail.de (Postfix) with ESMTP id DD22AA004D;
        Sun, 10 Jan 2021 18:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1610298564;
        bh=eixCm12cLq0EKTGntBIBfqJo4GMpVlXlNduQORG+3d4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=4OTeL3V2cb63pQmTefAhJR/1GAmV9VeJqKwORVQIP0NkSq4+1CyhFcAXMYKrU1Emt
         76B2smZ8N6C9D+98sZcBdIeVD+Wshf4t/BPoYx8ZVl8LfA8ee6vM68OUb6uJVv7d0A
         C1CCaX2f3TA0cy/ws83JXUssbbjSZKG6sfXriEJS6KSMRjZikqCenWG/IksQuM6jNK
         XmWi+lvYGjxl2MawXBgZIi6hW08tzXm3T7TdN793M8rwpcIA3mJRAkKQgPlt9xgOeO
         SNHYhajEzk4zL/afJFbp2K7Ux1LCtdE/fGncw+Bfk1iZgdf7utgy2L2pbY9dM/GgWi
         /2GZoccHfszpg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id 88D05A009B;
        Sun, 10 Jan 2021 18:09:24 +0100 (CET)
Subject: Re: Git 2.30.0 and failed self tests
To:     noloader@gmail.com, Git List <git@vger.kernel.org>
References: <CAH8yC8km6mHsrCD6sW+Z2ERpyO_X8Xp6fJbYKV+JF2gaqYakgQ@mail.gmail.com>
From:   Stefan Moch <stefanmoch@mail.de>
Message-ID: <4d81f0f1-66eb-2aac-4eab-dc5508d161b1@mail.de>
Date:   Sun, 10 Jan 2021 18:09:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAH8yC8km6mHsrCD6sW+Z2ERpyO_X8Xp6fJbYKV+JF2gaqYakgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1043
X-purgate-ID: 154282::1610298564-000001A3-BA07D02C/0/0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

Jeffrey Walton wrote:
> I'm seeing some failed self tests with 2.30.0 on Fedora 33 x86_64
> fully patched. They seem to be centered around email.

I cannot confirm this on the same git version and platform:

    # passed all 174 test(s)
    1..174

Christian's suggestion from your other thread about running the test
with the options -i -v -x should also help here to give more
detailed error messages:

https://lore.kernel.org/git/CAP8UFD30et-kL8dFoWvh7aPf4AKbzGxSzTuA=B3YNHZL_1axFA@mail.gmail.com/

>     *** t9001-send-email.sh ***
>     ok 1 - prepare reference tree
>     ok 2 - Setup helper tool
>     ok 3 - Extract patches
>     not ok 4 - No confirm with --suppress-cc


Since the tests 1-3 do not call git send-email, but test 4 and most
of the following do, I suspect the system is missing some dependency
packages needed for git send-email, probably mail-related Perl modules.

Installing Fedora's git-email package is probably enough to fix this:

    dnf install git-email



Stefan
