Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DE11F404
	for <e@80x24.org>; Mon, 26 Mar 2018 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeCZU6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 16:58:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37629 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeCZU6g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 16:58:36 -0400
Received: by mail-wr0-f196.google.com with SMTP id l49so11126467wrl.4
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XurKKITK7dDHoleT4UbAP58qdF2x4wskzc/gd0yfgpU=;
        b=g54gJ1zDAmcZQDm/kfH75ipw+wzbfQj4Hnff9b2wN+pjlA6vWop2k+C48/KC0HhkGH
         J36nJCxxVzovmH1lLWvd7O0JHzkEt54F7w+4bRAtZEmu2HGUnRoM27vXmr6dhIKkv9P8
         TLXVzPvD/HneogUle0o5RM8v1fkZsyfgHbc2pX2DM1hkLXkaBJzExMPCNZa9vNF44WSR
         MbJv5t9sPwteZOIJMHYw7G58g8OhMxuRXvlk7R4VRPPU7G408y6vuA6g5e2hyveGb1ib
         9FgExbDFT39INQbYScb5h/ozRt2NAVJhKUuCHODpppUZ5ArM9pyRDdjUyC1J52hbJmTw
         eFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XurKKITK7dDHoleT4UbAP58qdF2x4wskzc/gd0yfgpU=;
        b=StCTinN7KwsibPfX7miFERSglGeOUphyCOyAEafREoRoSXiNUG596RKqPgISshmSm6
         Gsovo0pUv3Y7i8Pq7GP2jZ8iH6lnHgKyknZ9oLjMctCe5cX1Bktk8GSUNuIsZZr7L7sW
         YZ9vXbw0uaMBHJ24rzo5umcezFYMDzyobAYkE6cCyIjupSceUTKvTzdUa9OfCP/fSoAu
         2ym09NmF1zcOpx7rBAMWoTRO5iXQjTiDq7xF8X5ac4kv1TmTEItcZGT+bw7JdvMTJkTo
         YjBCXVcY8XySxNaI8gJ0eBkwFZYVZHyw0HC2H09Js33VtHNO/vsFOnaSLHcKX8cusmGL
         F3zg==
X-Gm-Message-State: AElRT7ENy9p7oeuTGXtYg+J7wzcH5LKV9da8VxW8OUcfb4BS7ap+qUjE
        nPWyyWJuxj8ufLbwzm/YEgg=
X-Google-Smtp-Source: AG47ELsY3p7ziNWiCD80F3fuOzqJehcQFhD+Ssl4d+3DgDUCIVxzms60KEQz7m8mBkXXcPH7eqqEkw==
X-Received: by 10.223.210.82 with SMTP id o18mr12015449wri.85.1522097915276;
        Mon, 26 Mar 2018 13:58:35 -0700 (PDT)
Received: from localhost (162.191.201.35.bc.googleusercontent.com. [35.201.191.162])
        by smtp.gmail.com with ESMTPSA id z8sm9277121wrh.78.2018.03.26.13.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 13:58:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Joel Teichroeb <joel@teichroeb.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Remove contrib/examples/*
References: <CA+CzEk9QpmHK_TSBwQfEedNqrcVSBp3xY7bdv1YA_KxePiFeXw@mail.gmail.com>
        <20180325204653.1470-1-avarab@gmail.com>
Date:   Mon, 26 Mar 2018 13:58:28 -0700
In-Reply-To: <20180325204653.1470-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 25 Mar 2018 20:46:53 +0000")
Message-ID: <xmqqpo3qbll7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> + * Doing `git log` on paths matching '*--helper.c' will show
> +   incremental effort in the direction of moving existing shell
> +   scripts to C.

It may be benefitial to remind readers of "--full-diff", e.g.

    $ git log --full-diff --stat -p -- "${foo}--helper.c"

here.
