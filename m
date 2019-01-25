Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70DA1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 14:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfAYOFb (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 09:05:31 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36266 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYOFb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 09:05:31 -0500
Received: by mail-wm1-f42.google.com with SMTP id p6so6743917wmc.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blixt-nyc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=esPkYhEyIdNKe2v0Nv7U7ssLVYS2Ijn+hX3POjHuhgg=;
        b=cornYYnv5NvxbEAssw48yI4NlsrY2C0Yl4+epOMSdHpCPcWbthF0+ASGqk7VJFiZOl
         eYW2ehmnpAoDWfeQhWFi2LzJoeIJq/PnwDFNGPIMdLiQAuMxaN5Ap7dYZbOU+UMoZAC0
         msyVYjxq/VQk5cCYr8x5WiUm3MF5p0TfmBcLLY+jiPYNxqw/WU4I9JyojyFd8T/ItHHY
         BsPqqL5/DM6Tlh/CCsP4ox7HxXt9CZPAoEeNzehlm4VtkeMKDoW5Ie7YwD4wL1ck5qN+
         11ufl/HbcsElWoHQfySDOigpHi30L4UuWM3OEvN/YEow3e2RgDZMBQHqXvLLCuKzXw5/
         AwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=esPkYhEyIdNKe2v0Nv7U7ssLVYS2Ijn+hX3POjHuhgg=;
        b=X9kcEDRblP3+PY40z0A0tnpOnl3UqdBkaqNEy/Z9fWTQguJxjIEakknoIi//WThrqh
         ZG0tENzLhQt7EZv0wB70BIexVdpjr2zQwKxkWOheP6B0lectdhNaIYVNpRkuqLmJLNcq
         6Zxu06IQ1Cuj9Dd/uDsV90PCapzO16dwO0+jX6Urppa52quVbPOxtcnxqFBMsNtPRmei
         e3uFh18GrjW0ywi63q13Kv0t5Qc5i0b9+d3k3wHJojGlFsMrV6jzSF8RkI+rlhS5WgiX
         EDPr2fXO+OvJkDUc4U+VE0YhW2y35WKM77mtrz5neQSTBENBB/g+TiIBDYcTy9zMovcg
         bqng==
X-Gm-Message-State: AJcUukfl+Q5Y1u3muW//hE5uptGPNl4LRmiCRcitiYPjSzeUJgzmZ+cs
        irIlm85g3GgjxvqGxkN3hH5SUI1Me42qMd7nfPuJ3OzZGqgbwQ==
X-Google-Smtp-Source: ALg8bN4GVYPeH98G0tQShZSuQ72mH0NGqJSX6o6XKG8wxqFeJedcDIEzqAlykAbniZbnMr7Bgl0mt1p6vWQWdcOhdQ0=
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr7007648wmf.3.1548425129265;
 Fri, 25 Jan 2019 06:05:29 -0800 (PST)
MIME-Version: 1.0
References: <CAFYJ4vvGhwxd5wTq-yYeOy6Hq-GpCsTy6=jG-LoHn2mShM4_NQ@mail.gmail.com>
In-Reply-To: <CAFYJ4vvGhwxd5wTq-yYeOy6Hq-GpCsTy6=jG-LoHn2mShM4_NQ@mail.gmail.com>
From:   Blixt <me@blixt.nyc>
Date:   Fri, 25 Jan 2019 15:05:18 +0100
Message-ID: <CAFYJ4vur8KUbvnPaq2McR874K6o5YS6pCkKnihdwN758CKkwng@mail.gmail.com>
Subject: git describe --dirty doesn't work with --work-tree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a script of mine I want to describe HEAD without changing the
current directory, so I specify --git-dir and --work-tree. But it
appears the --dirty check doesn't consider the --work-tree value.

Here's a simplified example (on macOS 10.14.1):

$ git version
git version 2.20.1
$ mkdir test
$ cd test
$ git init
Initialized empty Git repository in /Users/example/test/.git/
$ touch test
$ git add test
$ git commit -m "initial commit"
[master (root-commit) 9fc4511] initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test
$ git describe --all --dirty
heads/master
$ cd ..
$ git --git-dir test/.git --work-tree test describe --all --dirty
heads/master-dirty
