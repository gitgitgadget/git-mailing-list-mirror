Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B052207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 23:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756480AbdD0XZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 19:25:08 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34093 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755613AbdD0XZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 19:25:07 -0400
Received: by mail-io0-f178.google.com with SMTP id a103so39766164ioj.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cadq0M5swM5n6rZutfJ4OwSC0+RZfAhpC8sBL1GOUTI=;
        b=I8N11dyqyxzQsDatRSEEydybOncVGYqQYLChbwXN7sPR6hU3UV578KoCF6PnVjAeN4
         E8s9lCj6z0QEa3rMKjH7JGvhokyYYL6RraepSDoain153AYI6JIY4QMKNUri9/wGZvMb
         NgCg9edEBT/d38gqi+sNe8BZ1ohbeQlIcczduPjA/5Fr0WKBpfYm8j/ca36B6GjLp0YP
         /IaCBqgm12V19n72H1JvBJfoY8ftlu+74D77HwGopID6oIsjFKdxEn9/S1tANrROjkf5
         9BWjl4fFuwH8S9YZmyXFZmROe/U9dq3npRf8vaLadAzcdYGGGg6/Hz0DNd9JRBMhyqYh
         idhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cadq0M5swM5n6rZutfJ4OwSC0+RZfAhpC8sBL1GOUTI=;
        b=BypBiLfSHC1tRHzZdZS995NpcbbuwpEdeLswvBvE881UCZj3F8GQc0plIS0I5ukOhs
         aXt57rbnGDaMySxQcbuIumM7KCii9mBzyr8gbYTEKqWN8Pvk404l2C0ELoKYt9R0AiDs
         YNP4FSFLTzfpBPxSj1DsT1eBh47X8+dAlo7UYN//vMq2NARjfOb5AbGADVat8iutlxjW
         I3s+PKbWPYHBU4NcTJt6vH8q+5L0e5N+/psCi+9RDs191s8/jh+qinMa7BQaqkPeVAxr
         zOmZakvirOYBW34BHKKLLoiJOkvDELfjnWWgO/+wjBdb7vS/tjerU5pOaXLgj7Ajenq4
         1zpw==
X-Gm-Message-State: AN3rC/42xp8nvIpwJwOPtjOu5rziAyDms9D+2BVpTPYi4/iv4lq6nowG
        S5QfRGxbCLX7JW2irplLjFcSMD8qOIjI
X-Received: by 10.157.56.196 with SMTP id k4mr3736058ote.198.1493335505874;
 Thu, 27 Apr 2017 16:25:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.11.27 with HTTP; Thu, 27 Apr 2017 16:25:05 -0700 (PDT)
From:   Erik Haller <erik.haller@gmail.com>
Date:   Thu, 27 Apr 2017 16:25:05 -0700
Message-ID: <CAJRbB6w2BnXXzA46a-uzpx9u554GndEXxZtkLVTc5XOXMn3kkA@mail.gmail.com>
Subject: git with ssh won't pull submodule
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Getting the following error for a submodule when using git/ssh:

$ git clone --recursive ssh://incense:/home/erik/git/nacl.git
Cloning into 'nacl'...
remote: Counting objects: 32, done.
remote: Compressing objects: 100% (25/25), done.
remote: Total 32 (delta 5), reused 0 (delta 0)
Receiving objects: 100% (32/32), 16.50 KiB | 0 bytes/s, done.
Resolving deltas: 100% (5/5), done.
Submodule 'vendor/golang.org/x/crypto'
(file:///home/erik/git/github.com/golang/crypto.git) registered for
path 'vendor/golang.org/x/crypto'
Cloning into '/home/erik/go/src/nacl/vendor/golang.org/x/crypto'...
fatal: '/home/erik/git/github.com/golang/crypto.git' does not appear
to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
fatal: clone of 'file:///home/erik/git/github.com/golang/crypto.git'
into submodule path
'/home/erik/go/src/nacl/vendor/golang.org/x/crypto' failed
Failed to clone 'vendor/golang.org/x/crypto'. Retry scheduled
Cloning into '/home/erik/go/src/nacl/vendor/golang.org/x/crypto'...
fatal: '/home/erik/git/github.com/golang/crypto.git' does not appear
to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
fatal: clone of 'file:///home/erik/git/github.com/golang/crypto.git'
into submodule path
'/home/erik/go/src/nacl/vendor/golang.org/x/crypto' failed
Failed to clone 'vendor/golang.org/x/crypto' a second time, aborting


The git clone --recursive file:///home/erik/git/nacl.git works fine
and pulls the submodule "crypto.git". Any ideas?

- The crypto.git is a valid repo.
- I have the correct permissions.
- The crypto.git repo is a git --mirror repo.


git version: 2.11.0
system: linux debian/testing
