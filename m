Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851A51F453
	for <e@80x24.org>; Sat, 26 Jan 2019 00:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfAZAxB (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 19:53:01 -0500
Received: from mail-yw1-f41.google.com ([209.85.161.41]:34045 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZAxB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 19:53:01 -0500
Received: by mail-yw1-f41.google.com with SMTP id g75so4668754ywb.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=masternode.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=he9SDCoUIp9zpwmMMxSh3Fm9tKhR70JjYezuucyHBrw=;
        b=WjJddiImVaptrWCl5xwD+/IwlBvgfwitbJZ6Tbhqec8knbJ2YaYW85c3sbBWcKUTFR
         bsc+25ZQW9djzR7wA8WE+TYRwsmnHc2URRaZ8IQNbQ4gGuj2iOVrwiRCJxlYWvgHqEhB
         tggH/BwedySmm18FyOOXUm0abvbZFvmPVra0mXgknpdcua+O2jw61FJbQkTqGLm3myzn
         xwCzUs2PzNbrGP184ChXTIv5n8ypc/NaKmL4a66sCWBy63TJrc1V1j+rHxKJISoiXgVN
         YzkCVDxZiWuTT8hFlhxM1+WFez6dRZWdlSOF3w4ge8Wc55yOuTqqUNJ5P4PVxc7UScah
         zIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=he9SDCoUIp9zpwmMMxSh3Fm9tKhR70JjYezuucyHBrw=;
        b=s51rU3OBUujiswxBwxzmDAC3r1dIwmMq0FAJehhP/THfwMmK1rnt1abfVJ0UcEI1g7
         NdBT8Vl5BnqLOlUaKJqWGu5ZWtZDofSxvS/gysS3wkD4EUQvJaI5yrMDgNvfjMmV1IdJ
         cPE6uLX0Ny3rb6GvIf5GLfLlN+g28bc/qbY6TCLHvMzUN3R/JnODcZzQIeRJomKONeYn
         HxqS68WEUdQp93wYVDd626XCmM8kPoMzf+QnnKXqMrmF2Uo5+77u5yP8GaK1IKZpBYeZ
         4H2aSIuBTx684S0tCWiNX0R23vhBbSxw+E+hUPFnRPvOCIemfLxYqQmCwFIDD/Jd1Lsw
         ngsg==
X-Gm-Message-State: AJcUukfaWsEhlJsnMkVYjXPVkO5PAVNJa0tgIZlKpcT6fjiW7H/chbK4
        /OvWj4of+FAeeUPxAJmS86TXKOF1VAPHajBHAOdGXv5KrT4=
X-Google-Smtp-Source: ALg8bN7Hqk1RIvSqua4jUyXQ1qqfquUb4WRGTtqO7SFadRpBCbVQTmGNdANiBIGDdZp/22fEHfrBBQg7W8JueMe7VMI=
X-Received: by 2002:a81:12d4:: with SMTP id 203mr13311721yws.0.1548463980469;
 Fri, 25 Jan 2019 16:53:00 -0800 (PST)
MIME-Version: 1.0
References: <CANMbfiuUHxkw822AvA+y0cJ+ao=pcrza7w4fgMn7vVx8AZqCwQ@mail.gmail.com>
In-Reply-To: <CANMbfiuUHxkw822AvA+y0cJ+ao=pcrza7w4fgMn7vVx8AZqCwQ@mail.gmail.com>
From:   "Moocowmoo ." <moocowmoo@masternode.me>
Date:   Fri, 25 Jan 2019 19:52:24 -0500
Message-ID: <CANMbfitE+5HLo1sMowr5erJGwzLVv3Z9sHKEgvOeso5OeWVrBg@mail.gmail.com>
Subject: env GIT_WORK_TREE ignored by git describe --dirty
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git describe --dirty shows dirty when cwd not repo work directory.

Confirmed by osse on freenode irc #git

  ubuntu@wrk:~/tmp$ pwd
  /home/ubuntu/tmp
  ubuntu@wrk:~/tmp$ git clone https://github.com/ipfs/go-ipfs.git
  ubuntu@wrk:~/tmp$ GIT_DIR=/home/ubuntu/tmp/go-ipfs/.git
GIT_WORK_TREE=/home/ubuntu/tmp/go-ipfs git describe --dirty
  v0.4.18-381-gca77ecc76-dirty

  ubuntu@wrk:~/tmp$ cd go-ipfs
  ubuntu@wrk:~/tmp/go-ipfs$ GIT_DIR=/home/ubuntu/tmp/go-ipfs/.git
GIT_WORK_TREE=/home/ubuntu/tmp/go-ipfs git describe --dirty
  v0.4.18-381-gca77ecc76

workaround:
use -C arg instead of GIT_WORK_TREE
  git -C /path/to/work/directory describe --dirty
  v0.4.18-381-gca77ecc76

I tried to find the issue, but git's code isn't easy to grok in a few minutes.
Thanks to osse and gxt for their help!

moocowmoo
