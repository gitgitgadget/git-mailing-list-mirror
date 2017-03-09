Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C79202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 21:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbdCIVCq (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 16:02:46 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:34040 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdCIVCp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 16:02:45 -0500
Received: by mail-ua0-f169.google.com with SMTP id f54so89264564uaa.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 13:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PH2eiJX4KiQAju7JnxHDYQJN7l+N0urY2EOdLJCBNCw=;
        b=DjUHYKagnglEH/6GNdY2KEujoBENmoolII11zN+2cennULdaI8LvE+/JAMysVj6KYt
         7AgzvnJE9U+ps9uOo5AwznkaKA5zumarwyNXJ5tZOh70f5n+DIgdgS1zgiyReavMcx2e
         gqj+VJ8jq+RgsewPq6mrpZsVk6ayFMj7xRuFBKrkHez0coLtIIawi1GlmoYh5xpiJgNv
         YQjUHMg3ToLL/ih1/PefXGWPkyLYO7FyLP/CyFMS5rosDEybGvdoolljaXYotqsWjX5Q
         PIK1AkARcIrMq/TG1Ckou1hv1xQD0bBkUc5XQZ+8nOi4xo0yA6EvcKNtZaRgK+cfye0Z
         XEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PH2eiJX4KiQAju7JnxHDYQJN7l+N0urY2EOdLJCBNCw=;
        b=Dj2l1Rff3ZkF04jFgj//+jISI8CUJvm+7F5vzm05YcX3vg/xhkN1pHqYHcKYMNNPxE
         xaSpLwsOH+t8U6hTby7p1yHE8jeiGh5ZPwTxfYbVyrxOxnpii479xIV+djQLGOl5hh06
         vhh6K6dO2M9gsuWGA2kGN88RnhYa8vNRcGPTrfHhrZNCVvR2zEnKykAd8oQuFIxG7hkn
         kC8MwP0l/6DEV+QB+yQ7k2kmwKa20K263tufcCJSqRSibd/6ZBMGNDVUbkyf9jpowh8M
         B01rN3IMvbFDNR9kiO5mG4yUGPwbAaVc2AGUiumTND/mBKTocWVP+DuqEPoRyLQW4oTG
         azFQ==
X-Gm-Message-State: AMke39nBHINVznh6M0a4BPrifKtJjbAWby5tZCVj5d6/SQDKceuLEqg8eKlSx0y92N6ytw+aA9388YgEU5tiVA==
X-Received: by 10.31.8.80 with SMTP id 77mr6490431vki.137.1489093330198; Thu,
 09 Mar 2017 13:02:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.80.114 with HTTP; Thu, 9 Mar 2017 13:02:09 -0800 (PST)
From:   Aalex Gabi <aalexgabi@gmail.com>
Date:   Thu, 9 Mar 2017 22:02:09 +0100
Message-ID: <CABRdPwCA6UR0kkZ2T8W4OYZ36oBwF9hw+SpJHXDE15CHyFiA8A@mail.gmail.com>
Subject: Git attributes are read from head branch instead of given branch when
 using git archive
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

git archive --remote="URL" branchname > branchname.tar.gz is not
reading .gitattributes file from the given branch but from HEAD. More
specifically export-ignore lines in the target branch are ignored.

The remote is using git protocol and it's served by Gitlab. I use git
version 2.11.0.

Is this a git issue? In that case is this a bug or a known limitation?

Best regards,
Aalex Gabi
