Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71288201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 13:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbdBVNMb (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 08:12:31 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35286 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbdBVNMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 08:12:25 -0500
Received: by mail-ua0-f178.google.com with SMTP id 40so1316489uau.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BDE7bkyDf9uaJJUEDXt0tR0qbjr30O/kuW2Sh01aLog=;
        b=kqwKAZw5JiUBsxvIh9vKJPViXp3Xuyj1c9eI+EGzDFhWorWwWL6inVkBidWSwvXEYw
         iGSoCDxDyP/xoMMPik5cq+5lzUZEwvYQdjwEJ227ov1pV8U2k6FJJTkYikm+PsEN9QXH
         Btb4VY8iMcD+KjjXjuxudVmz7Pg0/qe9IRvk8TQulPC9l9gIyggQPmW9sBpLjohm8uTv
         gguMqqniC12puE4urVbLnodLjo6aTpq6gBJUxLe3QsntHVYDvEdXpfbh8VbpXTGdR4T1
         PEwTO1YaqstAphVMzBOEFRCd6lNZsQDHCnTRi8454zrTVQBCt3c+RgXRI3PvIA3jBOMa
         9PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BDE7bkyDf9uaJJUEDXt0tR0qbjr30O/kuW2Sh01aLog=;
        b=uFDEqjIuwmVKdKOTTgtU1SGvXvoGCkrQfSPhzIdQ0yC5QTuwMt/EM+eX98n+NSxCaW
         tSaitc0krWzrLHkru0R+WCKSnvKCmzS41cAKP0XFBZ9Ws3gkh2ojRNJM2Wzh+5i2Cdtk
         CBfiP+b8p+L7pJP+PLgNPj67KG76x9MDNfZLlkJPvfmnqfJU/3zTJHcFxzs0W1U652gu
         2++6EZbNytyXbMGazpDokAZpGUbYx6Irg/8XIcBpa5I3zdM7k7D/tPxvDki5m1sR2GvP
         fZEMKxTW42jSGD0UddtfnLuXde0S8WigKrWh9900k5Lp7FFerA4Uke9KnWK1Ht32Pt06
         JahQ==
X-Gm-Message-State: AMke39kXxPdCr9cz4dmU6lewkzKyUj3EKdMKF+kC0fjwogIEUPJSEPMNIpBtA1Tg3U6vGFKi6oqXbinQcKeZVw==
X-Received: by 10.176.85.89 with SMTP id u25mr7348919uaa.82.1487769143098;
 Wed, 22 Feb 2017 05:12:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.221.69 with HTTP; Wed, 22 Feb 2017 05:12:02 -0800 (PST)
From:   Tushar Kapila <tgkprog@gmail.com>
Date:   Wed, 22 Feb 2017 18:42:02 +0530
Message-ID: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
Subject: feature request: user email config per domain
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can set my email via:
git config --global user.email tgkprog@xyz.dom

this is dangerous when I use this my office or in a multi repository
provider environment where my email is different for a few (like
tgkprog@search.com for github and tushar@mycompany.com for my company
private repo). I know I can over ride it per repository, but sometimes
forget to do that. And even if I unset it, it inadvertantly gets set
elsewhere when I make a repo and the site 'helps' me by showing me the
commands to init and clone my new repo.
I did an analysis on a bunch of company git repositories using jgit
(only master branch), and we have 57 emails out of 346 which are not
the company email. Also in there are cases when name is the same but
some commits are by email 1 and others by email 2, because of this
global config. As some of us work on open source and company repos on
the same computer.

Feature request :  can we have a config for email per repo domain ?
Something like:

git config --global domain.user.email tgkprog@test.xyz.com
testing.abc.doman:8080

git config --global domain.user.email tgkprog@xyz.com abc.doman:80

git config --global domain.user.email tgkprog@search.com github.com

So when remote URL has github.com push as tgkprog@search.com but for
testing.abc.doman:8080 use tgkprog@test.xyz.com ?

For me one name is enough. But can do the same for name if others need it?

Thank you.

Regards
Tushar Kapila
