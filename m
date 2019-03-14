Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D051020248
	for <e@80x24.org>; Thu, 14 Mar 2019 22:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfCNWbh (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 18:31:37 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:38243 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCNWbh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 18:31:37 -0400
Received: by mail-wm1-f49.google.com with SMTP id a188so4238048wmf.3
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfNctFMEAEmL7VX/TOceSsQaa/a2hSieeT9Vzt9wLnc=;
        b=JBhaJZyrKAT9KdxFbYkVxH1wl0bRcAKi6ztE9S+DcsdqX1bir6VZu3T0JKZvJKDZl8
         AwJinbPHsEigmYEVMYhqCwR3c9saPshW6R+QfgfpO5jyt1LC++9+RvoOxr96t6aTGRwK
         agIiF8G/t2Hc7BFi8l1bDWQPxMAA7iEwdBgNT0r/OMZXrxqigFFkikT4oG+GVIK9iMFV
         VZpECgQ93XVxc8CtFqxuPgWVMl1PvUF9fpWY5+ttJSfBbl5QI2iv2vKLdyx3lMRAJWYy
         ugbVRkXMv2fWow0tPKKMOnCQvrWnf7MdU7Lo/0gu1lUjB56iNkU8mKm48Ek50DiYRwKH
         lrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfNctFMEAEmL7VX/TOceSsQaa/a2hSieeT9Vzt9wLnc=;
        b=hYmiIlZWlj3VyNTRnapieCLCreoOlWTFLwjX+J1PZmzrh25w29sKqNfMuVM2r2jXt8
         du1X2D6fQG0fH43UsrzpSm7EjZ7boBJTL915SqDSAKeK5IDXHgSMPkGeWdjLR1FNrTv1
         7IZsJscpargFjYlKckVDTSoVU4eVykEkhJ1v8dPfGdbSfqML4NNetH1qboaj9eA5XbCF
         u8ajq4SW2i4xVeHufXhJCdUrFK9l+c4jNpsTvvH/0NDb8THXYP2B17PYxtazYprg2cIW
         gFtqUlrKuYswFTQwxX9Y7iQjmRpp3Acn6XUetO7j3uOXRkzIK/hSPY1fcsQrsxJnP1wT
         AwTA==
X-Gm-Message-State: APjAAAW4fnVbWe8My/TNd75HTfAh4h0X7ykKSg/btnNYKSsK8caMmt6A
        r9azD10SqVyKAhkWXC/D6rLEg6t5psUQh7yheV+062DAwHA=
X-Google-Smtp-Source: APXvYqzImwT2N56yeB7rgHjvVCYmiRreQPdJ3k2pwx/hTr8DTutfAl5vGpwnjYflJzUNppBfPv8mPcPa0VcRgBClu7E=
X-Received: by 2002:a1c:64c1:: with SMTP id y184mr34167wmb.0.1552602695095;
 Thu, 14 Mar 2019 15:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <CANSMLKFUXza=qj14gOd+jzX+R+R_JDO8XqmrjXYukB9s0FDhMQ@mail.gmail.com>
In-Reply-To: <CANSMLKFUXza=qj14gOd+jzX+R+R_JDO8XqmrjXYukB9s0FDhMQ@mail.gmail.com>
From:   Josh Mandel <jmandel@gmail.com>
Date:   Thu, 14 Mar 2019 17:31:19 -0500
Message-ID: <CANSMLKELiaTR81zscG6Or9psL2ZLizAtYEqT72WGHdY92sAFQA@mail.gmail.com>
Subject: Misleading error message with invalid filename on Windows
To:     git@vger.kernel.org
Cc:     Grahame Grieve <grahame@healthintersections.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running git 2.21.0 on Windows with certain invalid file names like
"c:\root.txt" (see https://github.com/jmandel/local-path-test as a
test case), I get an expected "invalid path" error when I clone the
repository.

But if I actually have a file at this path (i.e., outside of the git
working tree, at root of my file system) then I instead receive a
different error message:

$ touch /c/root.txt
$ git clone https://github.com/jmandel/local-path-test.git

> error: Untracked working tree file 'c:\root.txt' would be overwritten by merge.

This error message is misleading, in that (if I understand correctly)
there's actually no danger of my local file (which is *not* in the
working tree at all) being overwritten.

Best,
Josh
