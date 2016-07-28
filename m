Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00FE1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 22:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbcG1WUE (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 18:20:04 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36392 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcG1WUB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 18:20:01 -0400
Received: by mail-lf0-f51.google.com with SMTP id g62so59044916lfe.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 15:20:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vandien-net.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=J6CQIfb5LYrnoq1MCF5erj3oWhgg1ZyRUt9/2lzo2Ss=;
        b=1Rul/+EgEw944uhuWWGIS1ozJpPThjmLCcf9iAurNWJ+Zj+AyFlRb/bYyMwBKZBiuc
         yexw94ewT2pqhj68irvOAHKhMnSg7Rf3kvqeWdmUgHsC1iWVw6Uhdp4eId6H8CSIdmI9
         FpeisXeyz7k2SUG6D/7x1AXDlCCGPLzAmvRH9dESGCGCaDrCsnkqUQ183tsQRT/6IuJ2
         lU4wW9xz+vteNy5IrKk2PlwWUpzRAbPHMoWW34AB2if0Q2vxfI9BEN0Nfr+sWBJ8+buY
         hATMopPS6GKM63oBEr7pt+zUx5I+fZzLK5vPjLgyQFj2jHfmCaNuv8633vqqrzrBTBZk
         LCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=J6CQIfb5LYrnoq1MCF5erj3oWhgg1ZyRUt9/2lzo2Ss=;
        b=ONWw/My+7+gSP6nj0Cc2c5RBE1f/QMb7x1xy7Nx2hbH6AJAuxlzGI46V4eTdsqAVwW
         YLURnP9GQHn9Vz/WnrocKXIr4xhei2nsZxdEfsx+BwfX9yeSBY/g3NNBJHLzLffgM4+x
         j7bbYBWTPKzx5gZCui5gazGXOoyURimo+LzeNq66SchONOF5p8AiBV+szsA3WSD2UG29
         AIOzWl1QsBvwVEV/TE5Z2Ru6yfatPJoKmgARKJsJ1gteeys5NuwsRkedzTIFogPIVchE
         AxpGlkM6YHMDGKtz5WqYSoSr9e8/vYIciK5hRDBAcKas9FgqnTou3dcO7S7X/XZHdqPr
         ZUYg==
X-Gm-Message-State: AEkoouvzvpKirKuPcngIK/h87yBuPjIKvtwafNVFd60abC3SRf+fMz5n1bxdQyNQjeXx7A==
X-Received: by 10.25.144.8 with SMTP id s8mr14447639lfd.94.1469744398917;
        Thu, 28 Jul 2016 15:19:58 -0700 (PDT)
Received: from [10.0.51.101] (89-67-109-52.dynamic.chello.pl. [89.67.109.52])
        by smtp.gmail.com with ESMTPSA id h31sm2284001ljh.27.2016.07.28.15.19.57
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 15:19:58 -0700 (PDT)
From:	Thijs van Dien <thijs@vandien.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [Git 2.9.2] diff inserted by commit.verbose not removed when rewording
Message-Id: <539E05B5-13A5-4343-9296-19447BE14F14@vandien.net>
Date:	Fri, 29 Jul 2016 00:19:57 +0200
To:	git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I'm just a random Git user, not very familiar with the Git development process and so on, so please by gentle.

Setup:
- OS X 10.11.6
- Git 2.9.2 via Homebrew

Curiosity triggered me to enable 'commit.verbose' globally with 'git config --global commit.verbose true'. I have not configured it on the repo. It works as expected when committing; the diff is appended to the commit message template, yet doesn't make it into the commit when untouched. Today I noticed that when I then rebase interactively ('git rebase -i HEAD~2'; whatever) and reword a specific commit, the diff that is appended then is _not_ removed and _does_ make it into the commit. The template looks OK ('------------------------ >8 ------------------------' and so on is there) but it seems that the logic to actually cut along that line is not executed then.

I'm not sure what more I can say about it.