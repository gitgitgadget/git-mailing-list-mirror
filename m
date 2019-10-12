Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB64E1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 22:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfJLWbE (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 18:31:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37709 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfJLWbE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 18:31:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id n17so65956qtr.4
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=+DcXg6P5YJswP3f8iF8ZrA8auirdQXhfS4l5a7MdF0Q=;
        b=jOlirelfqPHoYjR8QlCKZYtgKI9crlPSJstXQhvoRB6/G3SoVB8KG2a3RsaUQVtHca
         TlNQrDLyr46KbXvxYqQoXcmVx3XMJE1mvkmeUHshT8aZfw5jxa/k4RrX9D2ydQ8vGKL7
         hqmbDWh9ZfLROXFfSN1JzIKG6JoShqoXr55DZbbf4ONtXpMWDVkKnp9BD4KJYOEFYK1j
         eVkLdE86k1y+k92PsILsfjk5p9cwt2uBYNRY3dXi03sfQyJN8pmDxuo61lWhvFWDLSL7
         yWlZwxnX7krVmxHOlAnM/RtyuviKo5gG/HixKgTiaa3QTJ8dVqAGdq267UiPTrgtlKSm
         V9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=+DcXg6P5YJswP3f8iF8ZrA8auirdQXhfS4l5a7MdF0Q=;
        b=egeQ+vYeDouy1bsK91Rmgm5BYkD5y8mWnuF469o25Y+XpOLCa0zzjChdgzOMcZLwES
         fZjQ2RbSUVVw/AgkvfVl7RbSKw12CB6f8IWSYOQ0Ej4UR1y1B6mRTxbz6xNRzXi4DTc7
         f0oPgRUB7T2VTiPaFf+vMI7shYPSmraPN14pzxv5FFXazdH7ybTLKNKVdwIptbrvttkc
         0EeUgu1GAgY1xGIcXV01+tAZqJilt8BWiMwDD2lPRePJoJYqkNnsXBz2bt1aHmb5wWid
         SwHGmVbOFDtRC03w/pev5ytLcw4wkws1zHkY6ZCQyoXo6NYzdGG91HoWXVf6wwpqz/fg
         UEfQ==
X-Gm-Message-State: APjAAAUUXaQ4u8zVq/6DvJLrGeyyuOkkDWk/ifRtNBCLaQVa7Ms44fSQ
        GbIwDhHmO/Zgx3Q0MJGLpmO/Cdge
X-Google-Smtp-Source: APXvYqxVwdiev8WL+dCjKF1RI9cD6S3XedvaZSEaZZaxNfY7TqfTTbwxUWbre7YCQyYayEpBzMT0og==
X-Received: by 2002:ac8:67c1:: with SMTP id r1mr21911943qtp.83.1570919463042;
        Sat, 12 Oct 2019 15:31:03 -0700 (PDT)
Received: from food (pool-108-5-136-214.nwrknj.fios.verizon.net. [108.5.136.214])
        by smtp.gmail.com with ESMTPSA id g192sm6498011qke.52.2019.10.12.15.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 15:31:02 -0700 (PDT)
Date:   Sat, 12 Oct 2019 18:31:02 -0400
From:   Teddy Reed <teddy.reed@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: Cannot shallow clone using GitHub tag refs after commit 34066f06
Message-Id: <20191012183102.337fe74d728a4942a7de5ab7@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I am trying to debug an issue where a shallow clone (--depth=1) fails when the reference is the tip of a tag on a GitHub repository.

The git client works on versions below 2.22.0-rc0 up until commit 34066f06, "fetch: do not consider peeled tags as advertised tips". That commit peels refs in the form of "refs/tags/v2.2.2^{}". My question is if the intention was to peel these refs and break this functionality? I do not know enough about git to understand if the behavior before commit 34066f06 was unintended.

Here is a method to reproduce the previous behavior:

$ mkdir test-repo
$ cd test-repo
$ git init
$ git submodule add https://github.com/gflags/gflags gflags
$ (cd gflags; git checkout v2.2.2)
$ git add .
$ git commit -m 'Add gflags submodule'

Then with git client version 2.21.0:

$ git clone test-repo test-repo2
$ cd test-repo2
$ git submodule update --init --depth=1

Submodule 'gflags' (https://github.com/gflags/gflags) registered for path 'gflags'
Cloning into '/tmp/test-repo2/gflags'...
remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
remote: Enumerating objects: 17, done.
remote: Counting objects: 100% (17/17), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 9 (delta 8), reused 1 (delta 0), pack-reused 0
Unpacking objects: 100% (9/9), done.
From https://github.com/gflags/gflags
 * branch            e171aa2d15ed9eb17054558e0b3a6a413bb01067 -> FETCH_HEAD
Submodule path 'gflags': checked out 'e171aa2d15ed9eb17054558e0b3a6a413bb01067'

And attempting with newer versions of the git client:

Cloning into '/tmp/test-repo2/gflags'...
error: Server does not allow request for unadvertised object e171aa2d15ed9eb17054558e0b3a6a413bb01067
Fetched in submodule path 'gflags', but it did not contain e171aa2d15ed9eb17054558e0b3a6a413bb01067. Direct fetching of that commit failed.

Thanks for the help!

-- 
Teddy Reed <teddy.reed@gmail.com>
