Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C4020A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 06:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLGGtf (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 01:49:35 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34076 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLGGtf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 01:49:35 -0500
Received: by mail-qt1-f180.google.com with SMTP id r14so3439150qtp.1
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 22:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AjlsdesM9tQLCexaPytQ5GvjTc3CSZ7f0cmJwDjDhaI=;
        b=U1N4X57av5K5BxvV33yHylXna5crZuYlJdRTuY3MFIWC76JZiXwF27WtYYsY228kQg
         +CwHqsa3KyfbWRPrmKrw2SGVhVbyP/HthbX4cXEaZWpEWznD5iy82qjRScHpMQyhS7++
         hdH8mcdqZ3/loI8xjh2mTsDxeKdFFRG8eR8glNX/5Itr6nYx77X1p6gJyry9CyQAd+3e
         MjCruxlMJ7eDDVWwsP3YhIAzlIHRiHHn+3Hbo5jwUKulOyRv6nIbQHFiRXGxqdm5skeY
         2JzfBQGzc0XAMlH4dGIRxVCDF+PFrqUrBg5iEfSrCt8WwgUSAH3LbQLpK1qEDQWdwArD
         ++ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AjlsdesM9tQLCexaPytQ5GvjTc3CSZ7f0cmJwDjDhaI=;
        b=Abffo283nEDNKYZbd3y/POq9TbQ7MC8Yk1sfC0t2wDk3cibrTnY6/FVRvIupz9So7i
         d4aAZseQdiYPphypZCKdRjMdIeIgC3h7G/fXVM0XEhU1yM5OtWAvmgdfMMt64NERKOBz
         ex7xlBWe/pb2VLnOVl1f04PHkX7GMMq6wLpQ6BNpu7ZKKnXV1gMqRXSZNTUbD784Mvi4
         SR4aahEzV360dDTTyELOU0ugVTN///nSlYxj5iRcUEBAedkgBBgr9/Vx43hQGShkYaFZ
         Odpt8OPNpNyPlcV0f1lWmN9Gkl7IlURqaP2kDRAj+ql3Wo7xLscvn8iv3XUQdQiVm7Lv
         fQKw==
X-Gm-Message-State: AA+aEWbdQ33LxFMVhQIX5YGN+qlzZWZfBO4P0y05HWbdOs2BlSKlTSUW
        lM/5RzDAENyw45nBJe8CKke0z6sj3jEwofaU/VEeLCY=
X-Google-Smtp-Source: AFSGD/VDA74Axy/OeCvtFMTGM4leSwwJ9pyzvVvGOKpwLbPga2+0M8ou7AZA6EpIKJ7I28DGwUB5cM32ss0qAqBpawo=
X-Received: by 2002:aed:2342:: with SMTP id i2mr896077qtc.341.1544165374172;
 Thu, 06 Dec 2018 22:49:34 -0800 (PST)
MIME-Version: 1.0
From:   biswaranjan panda <biswaranjan.nitrkl@gmail.com>
Date:   Thu, 6 Dec 2018 22:49:23 -0800
Message-ID: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
Subject: Retrieving a file in git that was deleted and committed
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have the following scenario:

On a branch A, I deleted a file foo.txt and committed the change. Then
I did a bunch of other changes.
Now I want to undelete foo.txt.

One way is to checkout a separate branch B where the file is present.
Then checkout A. Then do
git checkout B -- path_to_file

While this does gets the file back, the file shows up as a new file to
be committed. Once I commit it, git blame doesn't show the old history
for the file.

I would appreciate if anyone knows how to preserve git blame history.
