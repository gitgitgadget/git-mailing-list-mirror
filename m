Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0403020899
	for <e@80x24.org>; Tue,  8 Aug 2017 17:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbdHHROB (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 13:14:01 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36491 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbdHHROA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 13:14:00 -0400
Received: by mail-qk0-f193.google.com with SMTP id d136so3614284qkg.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kYr7aIgCqrJdWtI39mM+NhnJljRaFdcIqP5heR184Ac=;
        b=B4JS+QJPfol6hXRXN8xEj/Vv/Jbj9hrWIDYvQFHmqG8Y5Hgaqq4jLZRcEYT6A0LC2v
         BRZgIiotXSilKalaAYcTAlVcoMnoMW6FHq0HkRzGf10N6YZk36NxGZ4KRiiN6Am6jeMv
         G0QaeuA0ZY7+EV9Sej71GZlhAEikMVpJL9AhK66uPVH9IvCnZau4zjdPtT4KhjgWfDJH
         hSuBWxtXkcBWsuoSkPhRhWhj82n5uWEs51jo5gKm03VY+PGNr+/4hC/2HS4K5a6h/vm0
         yrEMWY0jZ6Wcqnu1cPgw58dTuVMJWLtdf7ydFC0wxMGBrD/Ui4FxdZzUx2M1b3W+cWK4
         dxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kYr7aIgCqrJdWtI39mM+NhnJljRaFdcIqP5heR184Ac=;
        b=XTUxuqNvd7OZC+zX7L5v3twgHyBVQuVwz3pHirFkWcJyPMkoKPv2aVhMlCwnBc5cPG
         O1MmI53Cs0Af2k6a4PrTj9lQc5zwQQKg5x+4TKFQ5kxW0Dr5DN9cufnXrpMOitd3umwM
         eg+udZ57wrg6KodZrCkeBCLNLv8xibBWHUSmWZicrWmoifpp1+Ba4m4Ne3/zZ+y65u0F
         X7HzTyU7+nGtwhaWe2MEnq4aP/43xj6iT8aBMMew/rTmf5fW6YRJLEGSJ+3DKPtEcyF2
         fYg8BKFhZ3NQVsKvVT1zfOhXKXT/1ajpighgFL49HCnMRtabiyjODwegUHBDx7D64lfE
         aZOg==
X-Gm-Message-State: AHYfb5iYdkz8CPx9xQd5bqeBLHa5V9yeYb9u2oS1lZLdAjuaxt6amWN/
        ZDictgspSSa21Q==
X-Received: by 10.55.71.76 with SMTP id u73mr6869832qka.25.1502212439314;
        Tue, 08 Aug 2017 10:13:59 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id n14sm1005370qtc.28.2017.08.08.10.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 10:13:58 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual invocation
 of loader
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com
References: <cover.1501111615.git.jonathantanmy@google.com>
 <cover.1501532294.git.jonathantanmy@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0bcbd46c-8b40-269d-f8d9-934fadd407dd@gmail.com>
Date:   Tue, 8 Aug 2017 13:13:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/31/2017 5:02 PM, Jonathan Tan wrote:
> Besides review changes, this patch set now includes my rewritten
> lazy-loading sha1_file patch, so you can now do this (excerpted from one
> of the tests):
> 
>      test_create_repo server
>      test_commit -C server 1 1.t abcdefgh
>      HASH=$(git hash-object server/1.t)
>      
>      test_create_repo client
>      test_must_fail git -C client cat-file -p "$HASH"
>      git -C client config core.repositoryformatversion 1
>      git -C client config extensions.lazyobject \
>          "\"$TEST_DIRECTORY/t0410/lazy-object\" \"$(pwd)/server/.git\""
>      git -C client cat-file -p "$HASH"
> 
> with fsck still working. Also, there is no need for a list of promised
> blobs, and the long-running process protocol is being used.
> 
> Changes from v1:
>   - added last patch that supports lazy loading
>   - clarified documentation in "introduce lazyobject extension" patch
>     (following Junio's comments [1])
> 
> As listed in the changes above, I have rewritten my lazy-loading
> sha1_file patch to no longer use the list of promises. Also, I have
> added documentation about the protocol used to (hopefully) the
> appropriate places.

Glad to see the removal of the promises.  Given the ongoing 
conversation, I'm interested to see how you are detecting locally create 
objects vs those downloaded from a server.

> 
> This is a minimal implementation, hopefully enough of a foundation to be
> built upon. In particular, I haven't added the environment variable to
> suppress lazy loading, and the lazy loading protocol only supports one
> object at a time.

We can add multiple object support to the protocol when we get to the 
point that we have code that will utilize it.

> 
> Other work
> ----------
> 
> This differs slightly from Ben Peart's patch [2] in that the
> lazy-loading functionality is provided through a configured shell
> command instead of a hook shell script. I envision commands like "git
> clone", in the future, needing to pre-configure lazy loading, and I
> think that it will be less surprising to the user if "git clone" wrote a
> default configuration instead of a default hook.

This was on my "todo" list to investigate as I've been told it can 
enable people to use taskset to set CPU affinity and get some 
significant performance wins. I'd be interested to see if it actually 
helps here at all.

> 
> This also differs from Christian Couder's patch set [3] that implement a
> larger-scale object database, in that (i) my patch set does not support
> putting objects into external databases, and (ii) my patch set requires
> the lazy loader to make the objects available in the local repo, instead
> of allowing the objects to only be stored in the external database.

This is the model we're using today so I'm confident it will meet our 
requirements.

> 
> [1] https://public-inbox.org/git/xmqqzibpn1zh.fsf@gitster.mtv.corp.google.com/
> [2] https://public-inbox.org/git/20170714132651.170708-2-benpeart@microsoft.com/
> [3] https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
> 
> Jonathan Tan (5):
>    environment, fsck: introduce lazyobject extension
>    fsck: support refs pointing to lazy objects
>    fsck: support referenced lazy objects
>    fsck: support lazy objects as CLI argument
>    sha1_file: support loading lazy objects
> 
>   Documentation/Makefile                             |   1 +
>   Documentation/gitattributes.txt                    |  54 ++--------
>   Documentation/gitrepository-layout.txt             |   3 +
>   .../technical/long-running-process-protocol.txt    |  50 +++++++++
>   Documentation/technical/repository-version.txt     |  23 +++++
>   Makefile                                           |   1 +
>   builtin/cat-file.c                                 |   2 +
>   builtin/fsck.c                                     |  25 ++++-
>   cache.h                                            |   4 +
>   environment.c                                      |   1 +
>   lazy-object.c                                      |  80 +++++++++++++++
>   lazy-object.h                                      |  12 +++
>   object.c                                           |   7 ++
>   object.h                                           |  13 +++
>   setup.c                                            |   7 +-
>   sha1_file.c                                        |  44 +++++---
>   t/t0410-lazy-object.sh                             | 113 +++++++++++++++++++++
>   t/t0410/lazy-object                                | 102 +++++++++++++++++++
>   18 files changed, 478 insertions(+), 64 deletions(-)
>   create mode 100644 Documentation/technical/long-running-process-protocol.txt
>   create mode 100644 lazy-object.c
>   create mode 100644 lazy-object.h
>   create mode 100755 t/t0410-lazy-object.sh
>   create mode 100755 t/t0410/lazy-object
> 
