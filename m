Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5AB9202C1
	for <e@80x24.org>; Sat, 11 Mar 2017 11:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbdCKLyf (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 06:54:35 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37182 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbdCKLyd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 06:54:33 -0500
Received: by mail-wm0-f42.google.com with SMTP id n11so11642937wma.0
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 03:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=Hnop/+2J7rZ1i30CP72GziqPROatr3jyNvT7AkmPST8=;
        b=cj5wAAZabYK2zJxaOsU2dT+voCLrJAHl2mS5VEJ4TdULWyqADLSrqwwDcctrcZZx4l
         jGo4M459sHT7qlRfWT9KLT2q38yl41xym/y3nYU4lB0sxOneZ+Uj74bvcFBC2sVPIdVz
         5jzw2neKiqTH3ydKYK2o/xU0sRQ6Jl8uyKFuahvL8z/a5zWER/9QnLhjjgN4RGCUh7k1
         K/xESha1pdiZakGKkVvBWE+1xk33mcs1iPyPjSd54THe3Egx+zhF1x0q/dECyix2zPKo
         DtWMBVgFA2hliR3bH789gz0q1dXAJPhZXqWeyQTeuJEkR8toKikm/4IlhdqsBTSHiFLM
         s0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=Hnop/+2J7rZ1i30CP72GziqPROatr3jyNvT7AkmPST8=;
        b=CwnmYk5Yhovbq3m1wUS37G3bG7IbQJXu2JPedQ+A/JhfKiKn2JY53iw+QRtrzep+Xu
         b/CWikoyU6LfwJBmkGKIaq3n7GFv7opkK/8uUi5aIfWm1d1UDEsp40J/E4eHbFUqFFvq
         1aHkQeKPwo0gZLuPwu0IqKxdQjWX3lI7lnkBSI79bkrXX3oGbXWmpSCCJ242t+4ETXeI
         ZHX/Kd9oRxNkKJXm3+n3RawH6+Mr1fqSEPk65X6VQ0QP/hKCayRbSvyucmfZzj4FYBGr
         vLc2Zt47kCgkEuUF6uAi/joz256o0kt36tflo57GbJoM7am9X1wpAgsEV+h6l9Tz4v3I
         Mnxw==
X-Gm-Message-State: AFeK/H2h4v9+LuiLGU/5RpVaxokeu4w/j0JnnvIFsXDIzFKqipD4zUQ3QCjwtGxvnwfBkg==
X-Received: by 10.28.197.133 with SMTP id v127mr2711236wmf.120.1489233271770;
        Sat, 11 Mar 2017 03:54:31 -0800 (PST)
Received: from ?IPv6:2001:980:9089:1:dd32:f578:40e:cb55? ([2001:980:9089:1:dd32:f578:40e:cb55])
        by smtp.gmail.com with ESMTPSA id b10sm3341620wmi.34.2017.03.11.03.54.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Mar 2017 03:54:30 -0800 (PST)
To:     git@vger.kernel.org
From:   Luuk <luuk34@gmail.com>
Subject: How to find the cause of 'git push' stopping on 'Writing objects'?
Message-ID: <05e6903d-336d-23df-a4be-13c4030c6c82@gmail.com>
Date:   Sat, 11 Mar 2017 12:55:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am new to GIT, so i'm playing around with a repository and git is 
hanging on 'git push',
How can i find out what i'm doing wrong here?

D:\TEMP\test\test>git remote -v
origin  git://mini/test.git (fetch)
origin  git://mini/test.git (push)

D:\TEMP\test\test>git status
On branch master
Your branch is ahead of 'origin/master' by 3 commits.
   (use "git push" to publish your local commits)
nothing to commit, working tree clean

D:\TEMP\test\test>git push -v
Pushing to git://mini/test.git
Looking up mini ... done.
Connecting to mini (port 9418) ... 192.168.178.50 done.
Counting objects: 9, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (9/9), done.
^Citing objects: 100% (9/9)
D:\TEMP\test\test>
D:\TEMP\test\test>git add *

D:\TEMP\test\test>git push -v
Pushing to git://mini/test.git
Looking up mini ... done.
Connecting to mini (port 9418) ... 192.168.178.50 done.
Counting objects: 9, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (9/9), done.
^Citing objects: 100% (9/9)
D:\TEMP\test\test>
D:\TEMP\test\test>git status
On branch master
Your branch is ahead of 'origin/master' by 3 commits.
   (use "git push" to publish your local commits)
nothing to commit, working tree clean

D:\TEMP\test\test>git fetch -v
Looking up mini ... done.
Connecting to mini (port 9418) ... 192.168.178.50 done.
 From git://mini/test
  = [up to date]      master     -> origin/master

D:\TEMP\test\test>git --version
git version 2.12.0.windows.1

D:\TEMP\test\test>

The git-server i'm using is on a mac-mini:
git --version
git version 2.10.1 (Apple Git-78)


