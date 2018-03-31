Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B2661F404
	for <e@80x24.org>; Sat, 31 Mar 2018 18:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbeCaSlP (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 14:41:15 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54984 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbeCaSlO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 14:41:14 -0400
Received: by mail-wm0-f46.google.com with SMTP id h76so19799585wme.4
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KQCKIwTe2fqvi2LZHsyK8yl/3AEth9P1oifsH2jB11c=;
        b=UaIydrBep68aH+DukjkP1TVUbsnoxGfAfu6wriK22piV7HFTtofAX/B8nmhw6EF6On
         9z801fBTiZoYAArmfjM1gecBTB95q3xvXyJ5E+9eDBbodYtmv0f/NQ3Rp4qHLc40GrM3
         KGict891AQMA+a1kEoZPLP1+YAhe59QmyQOyIw7W385mHd3F5AlL3s5ev3ENQ5ItJvXe
         Fw1f9b+JS7ff5iM+ovLrnXjTXFWRsjqR22Uw2YbdZ3xetk6fMsMDZsLWDtV2jYZxPLD9
         UjyptQ3Dx4FoHR9EtQyMSjKvf4Vr+ng9X1SaZQ4mJDIF/EARIzjnUIX5AF6xgUH1p9qq
         i/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KQCKIwTe2fqvi2LZHsyK8yl/3AEth9P1oifsH2jB11c=;
        b=lald/uHDPOaVNfG37Ad69YFagOF9F/KKHWsIyQdNoN+qJ7srQtdOZ7ipgcGZIHxWxT
         BXV5qx1LasmH3XGwnyZzoP8JrC42qjiEZ7lBV+1D4MbN0m9o+wDCau6fURZtLGDQAdx1
         P2TV6bVs/kItF0tP/ZWOpvmVN2orFrbdw00L3Kn8dIiylxwNyM5dUU1ge0TrQfJZXQQO
         2xf29VZYLUA+VLCCurX2wE5JMz3KwMYJzxEmLRzSK5Y0QFNISmbE9x0CoUZtVLqcw9nH
         KIL8E4ox2UU8w6SKy/d9NPMSQhqGksTgZCxIYT4BIBk/e83I5nMpUNXuJ8F7L++cC/zh
         IvSA==
X-Gm-Message-State: AElRT7GqTLDDrcZMRkzX4mGMItFHPzmWjYKmzWYfEAJ/fGRyzwroinuj
        M+0QZzTYbNbC/LQnXleguek=
X-Google-Smtp-Source: AIpwx4+D6yKr/xIBsMq5hd9fDqo/XPSNBmoRnino9XSheFz2xxacDjnqRLJzViwMT9MHQKLw/FgXtg==
X-Received: by 10.80.151.167 with SMTP id e36mr7210786edb.210.1522521673610;
        Sat, 31 Mar 2018 11:41:13 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o3sm6749526edi.24.2018.03.31.11.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 11:41:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Daniel Jacques <dnj@google.com>
Subject: Re: What's cooking in git.git (Mar 2018, #06; Fri, 30)
References: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 31 Mar 2018 20:41:11 +0200
Message-ID: <87a7uow0jc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 30 2018, Junio C. Hamano wrote:

> [...]
> * jk/drop-ancient-curl (2017-08-09) 5 commits
>  - http: #error on too-old curl
>  - curl: remove ifdef'd code never used with curl >=7.19.4
>  - http: drop support for curl < 7.19.4
>  - http: drop support for curl < 7.16.0
>  - http: drop support for curl < 7.11.1
>
>  Some code in http.c that has bitrot is being removed.
>
>  Expecting a reroll.

This has been idle for a long time. Peff: What's left to be done for it?

> [...]
> * dj/runtime-prefix (2018-03-25) 3 commits
>  - exec_cmd: RUNTIME_PREFIX on some POSIX systems
>  - Makefile: add Perl runtime prefix support
>  - Makefile: generate Perl header from template file
>  (this branch is used by js/runtime-prefix-windows.)
>
>  A build-time option has been added to allow Git to be told to refer
>  to its associated files relative to the main binary, in the same
>  way that has been possible on Windows for quite some time, for
>  Linux, BSDs and Darwin.
>
>  Is this, together with the js/runtime-prefix-windows topic, ready
>  for 'next'?

dj/runtime-prefix look good to me (and I've been the reviewing it the
most it seems), I don't see any problems with js/runtime-prefix-windows
from peeking at it, but I haven't run it for obvious reasons.
