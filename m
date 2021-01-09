Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6957AC433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 11:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3279723A23
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 11:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAILa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 06:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbhAILaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 06:30:25 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459CDC061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 03:29:45 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id i18so12603524ioa.1
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 03:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=sRufU60U5HNS7UEexacmERfa4s8oMUlQen7p9SYB+2k=;
        b=n78dTdRGfdoMP+lNCQha6kuMDFNoUIOaywitjsEmCTOBRYznKt3C7K/Wh2kF6NgyrK
         Eiewf8gJQJiun8q9BBzQB3ovk8AipxZy7BxR5hYROMbKAgVN8jw80gcCiQU8vZhariLN
         kJ4i+hWFeaxRlMO3svjp3J+Y64EQS6/DvVUXNWQomFkiEJePkxATXYu9FBjFADnhUnpV
         7+Wv9aAY0RTjIzegxgZrHjIzOXi3j744Jd7CilBvvw2FgUwCgQdPPPVA8svEVNS2mkiF
         OZw03coCW8SxCUReMZcoa9aq2r1wga4vIyaABVc3NvYFuwtzGIbUeqjd0ufT1eXx0BPE
         IHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=sRufU60U5HNS7UEexacmERfa4s8oMUlQen7p9SYB+2k=;
        b=e3HYucw2pRSQfrIu3bNqyqe7HwlFEekCJUaiKL99wvx8Jtok+HVx30LQX+9inLveZ3
         fJ+sClHhgmu3qFzLB/nttxV7sYDXqqENRqTa1NimuDDrpMChFEN/p7XzGsnRxiGv6eYP
         oA1djuyIUlL/c9YtCZzJieRTyz2b4sqx6lVPk62ohfoqfoPTcWA0b6unpchi8LJ3+d7P
         aRuZTvdo4KuqbTCZDUkNBEIMPive7IgHiKmQ6f4NQDKuDYCYhCuCLlY5t2b/WTPH18w3
         VLG/djrAuY8S5g4aEDyAqagMnpy7EWEXZoJ07CaaHXYIVnEbQFTLjLV05eEgGyCmetba
         Jmpg==
X-Gm-Message-State: AOAM533q4LziFAACMT+aZLe8P8u1EAymgMXoVyl3EeBGtUOaY3N14Gy5
        qcTT3d43P+olBoP3n/z7MmE2Djd1Hp6zyGvSLXvfdiDpGe8=
X-Google-Smtp-Source: ABdhPJyMfk/bBdCsx3qAlda8MJzjfonmv0fFRN2NS6s1k/71w74nYbS8+fIqh2khvb7nAaQqWUCQZf5lz5ppTNte97s=
X-Received: by 2002:a5e:df0a:: with SMTP id f10mr8894319ioq.66.1610191784390;
 Sat, 09 Jan 2021 03:29:44 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 9 Jan 2021 06:29:33 -0500
Message-ID: <CAH8yC8mmox3fZTRO7W44whHhT0aPcNUXxrBVg1R7ttwUfVgy1A@mail.gmail.com>
Subject: Git 2.30.0 and failed self tests
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm seeing a failed self test with 2.30.0 on Alpine Linux 3.10,
x86_64. Alpine Linux uses Musl and BusyBox, so things may be a bit
sideways because of them.

*** t4129-apply-samemode.sh ***
ok 1 - setup
ok 2 - same mode (no index)
ok 3 - same mode (with index)
ok 4 - same mode (index only)
ok 5 - mode update (no index)
ok 6 - mode update (with index)
ok 7 - mode update (index only)
ok 8 - empty mode is rejected
ok 9 - bogus mode is rejected
not ok 10 - do not use core.sharedRepository for working tree files
#
#        git reset --hard &&
#        test_config core.sharedRepository 0666 &&
#        (
#            # Remove a default ACL if possible.
#            (setfacl -k newdir 2>/dev/null || true) &&
#            umask 0077 &&
#
#            # Test both files (f1) and leading dirs (d)
#            mkdir d &&
#            touch f1 d/f2 &&
#            git add f1 d/f2 &&
#            git diff --staged >patch-f1-and-f2.txt &&
#
#            rm -rf d f1 &&
#            git apply patch-f1-and-f2.txt &&
#
#            echo "-rw-------" >f1_mode.expected &&
#            echo "drwx------" >d_mode.expected &&
#            test_modebits f1 >f1_mode.actual &&
#            test_modebits d >d_mode.actual &&
#            test_cmp f1_mode.expected f1_mode.actual &&
#            test_cmp d_mode.expected d_mode.actual
#        )
#
# failed 1 among 10 test(s)
1..10
make[2]: *** [Makefile:57: t4129-apply-samemode.sh] Error 1

I don't see a log file to offer for this one:

    $ find . -name '*.log'
    ./config.log

Jeff
