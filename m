Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B8311F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 22:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeKYJJp (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 04:09:45 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43873 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeKYJJo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 04:09:44 -0500
Received: by mail-ed1-f41.google.com with SMTP id f4so12823259edq.10
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 14:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=TKi8kP1Q6Cjc2MfuuvXeg42OzxTpZ2BtVg8EIp0eukY=;
        b=iURLR8SzUwinXehWmyUoAK0xxLEqONdncFsHl9YxN4BdVg7oW7ZLmagF7SOY4lbzJ2
         k47rthpPV/wbvvxyPgxzPdrwwGwlR9N7hdN32mpE528PQfU8dAxtjdxvKLkx14bHcO3q
         Lkd3/x4Prhz9YDfLId2dFz5imMi//Ne4ZRQtif+idRW84FrbYo4s8CpRDdqvQUGPnAvk
         9OazEG3kAb7iR43zXaMT4hb+7qW8jiJSsmKW5ngGgP8i9DdFPbn4QHvFI8AfJM4Wm/Q1
         S0b2V0Oa4CQFh8dpbpzAoxKxwHxcJvl/u5TJOl675FPM5HBMY21ArVTTPFabiNoBZBFV
         o2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=TKi8kP1Q6Cjc2MfuuvXeg42OzxTpZ2BtVg8EIp0eukY=;
        b=ioWbglwD46wzjdkHl4eQDKOSvaSRuJQxsouMF++HlleUCpHFBl/YhOKS0Ay56dNbw/
         OJEN9/3VYUomVtS1YmX78j+uuD03SnP8A1tndWvcmV6mOo7SyBTyIGzcAmUwfPZKqnGI
         WhLfSF5fL4LD/D57h5HXmEjZAngf68G69XIrhKrZPVN1A8s+pZCNvgyrgBYrvr52KFGn
         OkHVZ6ezP8JjkxvcFj3+KF+nQ0yMujBnk9TKlDzsUlK8EQDWtjFEPjo6sETSoZWQ/g2O
         p+DgKdFKBlPxhLLWPum5Lb+9CknKAxDzwWsqu4vPpQOu0vNfDbd4LuuKzZFLn5ZDGKJp
         Vo5g==
X-Gm-Message-State: AA+aEWYzJ1WbZgYGC58vsJJqNWdMm3XyaMxoRnxqpOhHayW1DIKBRlsi
        +vkR0vcMhtabDDsYpFRUIS4r8iZj
X-Google-Smtp-Source: AFSGD/U9FfN4iSItB+ajwfpsbKEFuQLq8dWmgtyHTJCrBwEgvT+I+qnQB2uNHwq1n2Azb4959lPHTA==
X-Received: by 2002:a50:8b41:: with SMTP id l59mr10592117edl.44.1543098015495;
        Sat, 24 Nov 2018 14:20:15 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id gk8-v6sm9356345ejb.42.2018.11.24.14.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 14:20:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     git-packagers <git-packagers@googlegroups.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: GCC Compile farm (Linux, Solaris, AIX etc.) testing of git.git
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Sat, 24 Nov 2018 23:20:13 +0100
Message-ID: <875zwm15k2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've had access to the GCC Compile Farm for testing on various
architectures for a while. Around the 2.19.0 release I submitted some
patches / bug reports found there.

I've now improved this to run it via GitLab CI & made the output
accessible. Outline of how this works at
https://gitlab.com/git-vcs/git-gitlab-ci/commit/497805b18f

https://gitlab.com/git-vcs/git-ci/branches is a repo that houses a merge
of {master,next,pu} from git.git and that git-gitlab-ci.git repo.

There's still plenty of rough edges to it, but
https://gitlab.com/git-vcs/git-ci/-/jobs already has some useful
results.

Right now this is all pushed out manually. But I'm planning to get it to
a point where soon after Junio pushes changes out a run will kick off on
all these platforms.

The machines it's running on & their build / test configuration is also
something I set up as a one-off.  The full list of available machines is
at https://cfarm.tetaneutral.net/machines/list/ and I picked some subset
that looked interesting (outlier platforms) at
https://gitlab.com/git-vcs/git-gitlab-ci/blob/master/.gitlab-ci.yml
