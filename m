Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C6D1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 16:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfFRQjI (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 12:39:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40222 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfFRQjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 12:39:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so3950558wmj.5
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=XRpG+IjQL6zLCUovBMiwlA8f/l+AxzE6S2IYdgLwO14=;
        b=GvdwdPxv4kW8uCtiGcoci0nB+CUVW/kHMj8BYnDT8IwtBeagGAqiADYH0xFkEieamb
         xA4aymQtP61/hffX70w9XemDYx1m4I8fgYCLjnxnoCHwAiBCha8fcVdx6fLlDR7W2dj5
         25VZLzaGlAqTUY5UCQ3kT4mBm1o5gFzkdzXU+gQIRnxEQ5Aio0wZh/VFPZqUs84dqE8e
         V5sWQevSePtCswu+s0HwlddIKf3+UhzWn+1wsf5Hbg5F+vsk/24R6A+M3x6yNSDAdsaC
         spYrT7WaPJMA8BOiCR9Wl8zrl1nl9NJ5Mp6SrVjWRLHsJwguuWoAk+02qDQgpWDSWSPK
         jMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XRpG+IjQL6zLCUovBMiwlA8f/l+AxzE6S2IYdgLwO14=;
        b=ie/NuQvtiS/yRxh6LRJNtIakTXSnVI6MuwCeZ8WKY255kHfxE3gMMshMvkHSYwYhyn
         5PtpVx517LuOrBSw0eFQONztCNCDOePL3xF/rm2J9Y0JZt+UmvHA/4FGj089HVnk4/8t
         IzW6PrDCvJOK8p62I/w5gSXZ6mh7t5hhj3Xl6eOJmD3UBqGJWyzZJicaq12+GHdkMdSD
         QyLC1DxEKKnxRI2nvFv6kTxnbpz64otC9NHoqJNrYqkqUOY5qiGKBI/wnTfymRRkCqsz
         3hN7GcrqOrsB6vHYd8+awpbvTZYvAbpVPx6h+XKs3bmxcsLqCCebRn4DWkatNfiw/Be1
         qSFA==
X-Gm-Message-State: APjAAAWUlfcuOy0bWLsUTT2gTV+QmUAoTBzYxjWfHOXQD3uiU/93HbAK
        CMML7nuJWWm/DMND07pn3hWmy4Xm7fQNJz4Ucp8QYUY4Q2o=
X-Google-Smtp-Source: APXvYqxayx84v4SaH35KZoJBnBGbc77OEnUqKXlVFxztTENhf0D3FXGqg2KELBD6n6RCHjnbtQFKN9aiOIQgwL7opz0=
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr4281581wmc.33.1560875945909;
 Tue, 18 Jun 2019 09:39:05 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 18 Jun 2019 09:38:54 -0700
Message-ID: <CA+dzEB=iOsfuZQ5Z8uXO+k6E3WczkLX64yWUpTm1NZBjdd47kg@mail.gmail.com>
Subject: windows: error cannot lock ref ... unable to create lock
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've set up a demo problematic repository on github:
https://github.com/asottile-archive/git-windows-branch-test

The minimal reproduction is:

rm -rf x
git init x
cd x
git remote add origin https://github.com/asottile-archive/git-windows-branch-te>
git fetch origin --tags

Here's the output:

+ git init x
Initialized empty Git repository in C:/Users/IEUser/x/x/.git/
+ cd x
+ git remote add origin
https://github.com/asottile-archive/git-windows-branch-test
+ git fetch origin --tags
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 10 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (10/10), done.
From https://github.com/asottile-archive/git-windows-branch-test
 * [new branch]      master     -> origin/master
error: cannot lock ref 'refs/remotes/origin/pr/aux': Unable to create
'C:/Users/IEUser/x/x/.git/refs/remotes/origin/pr/aux.lock': No such
file or directory
 ! [new branch]      pr/aux     -> origin/pr/aux  (unable to update local ref)


real-world issue: https://github.com/pre-commit/pre-commit/issues/1058

Thanks

Anthony
