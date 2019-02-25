Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D395620248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfBYUT5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:19:57 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:44028 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBYUT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:19:57 -0500
Received: by mail-ed1-f53.google.com with SMTP id m35so8679073ede.10
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=trhnJal1ds+eXYhPvLBfVVxlCh65dOK4tRrfuBGPJLo=;
        b=jE8z99SYCC/JR5eJp82l6XjuLWwb+Owmc2SP0M4I/baKclPCUBZAY9sn2p0efIk5mq
         SR926OBxHPmi1BuGVehfQhZi/WB6wQdj+ImAYdCPs/LST6IpNhCc8Y8zDBLzDx1v8c9k
         xFcE7AMle3Y9NJPjSyZ+fcD3FD1n7nKT+D1enbGD229EgbDn7OApYDndTca5+mRDouB0
         r9hcoMPmWr1lLyQEVJvgXWir9q1wkYFrBmQEED4L7+wIA7eT/X6uuPxfHnd9j2cWrTWV
         L0M0q6FHalMA568ulDH80Hg3K5FAMcQNTSLvg0lzgqiYqGZ3/54iL8d6xrYaPAb/9QTF
         f//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=trhnJal1ds+eXYhPvLBfVVxlCh65dOK4tRrfuBGPJLo=;
        b=KANEiFO1WwmX9kPuZ0xdPCYpWvM1Qd1t/z/0O0PhprlCg1UraW5t/S+XrTXLLjYS06
         xyw5xyeem4i2ww2Kt9kJ/DeCZMikcLjSwt3mnTIMN+DEJF/yuBAaQH5g2EDvWGwKbxAR
         0GUDxjJT/GT1CKSwgKFg41t6YesxKHqjxkT8Buh0qNmDyq4Fbyl72uEdbZqSWRpHBQqN
         FbgBUSjGFG61mVJDVpIOEnlwoTVe/ZlgQO2ngtb80Xjqs7VwV3P2xe3kEby+jjQ5vSBK
         BUhPZOIJNkz7OuBY+OxvaTeAVs2hZxZjXntuUXqgyewYBvN7NNcm+8EN3h0y7wQAYXW0
         UCUg==
X-Gm-Message-State: AHQUAubfjsysv4YeVy0Do81WR8C4Fa1eHC0M+2uOJ2DB6mSA6V0I1WI2
        cavIZveD31afQIBsss/wuDbhEG8B
X-Google-Smtp-Source: AHgI3IZ+Qob/Wlz3Zz9gEfHVZ847dQ2gIpxvF6SFThyttyJpYPPSnreP9hywMDsY35hFGzJeE4M9Sg==
X-Received: by 2002:a17:906:5849:: with SMTP id h9mr14166106ejs.118.1551125995078;
        Mon, 25 Feb 2019 12:19:55 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d15sm2847053edv.20.2019.02.25.12.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 12:19:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Compile error due to po/fr.po on old gettext in v2.21.0
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
Date:   Mon, 25 Feb 2019 21:19:53 +0100
Message-ID: <874l8rwrh2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a NetBSD test box I have with msgfmt 0.14.4 v2.21.0 fails to compile.

I didn't spot this in rc2 because b3225a4183 ("l10n: fr.po v2.21.0 rnd
2", 2019-02-13) along with the rest of i18n updates gets pulled in after
all the RCs.

The error s:

    $ msgfmt --version; msgfmt -o fr.mo po/fr.po
    msgfmt (GNU gettext-tools) 0.14.4
    Copyright (C) 1995-1998, 2000-2005 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    Written by Ulrich Drepper.
    po/fr.po:22482:4: parse error
    po/fr.po:22482: missing `msgstr' section
    po/fr.po:22487:4: parse error
    po/fr.po:22487: missing `msgstr' section
    po/fr.po:22492:4: parse error
    po/fr.po:22492: missing `msgstr' section
    po/fr.po:22497:4: parse error
    po/fr.po:22497: missing `msgstr' section
    po/fr.po:22502:4: parse error
    po/fr.po:22502: missing `msgstr' section
    po/fr.po:22507:4: parse error
    po/fr.po:22507: missing `msgstr' section
    po/fr.po:22512:4: parse error
    po/fr.po:22512: missing `msgstr' section
    po/fr.po:22517:4: parse error
    po/fr.po:22517: missing `msgstr' section
    po/fr.po:22522:4: parse error
    po/fr.po:22522: missing `msgstr' section
    po/fr.po:22527:4: parse error
    po/fr.po:22527: missing `msgstr' section
    msgfmt: too many errors, aborting

It's "fixed" by:

    perl -pi -e 's/^#~\|.*\n//' po/fr.po

I.e. this is because of the comments being parsed (fuzzy comments).

The 0.14.4 gettext release was back in 2005, so presumably this is due
to some GPLv3 allergy of NetBSD's. The OS version itself is 7.1,
released a couple of years ago.
