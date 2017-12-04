Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA30520A40
	for <e@80x24.org>; Mon,  4 Dec 2017 09:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbdLDJnY (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 04:43:24 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43902 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdLDJnX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 04:43:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id n138so4567829wmg.2
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=qqxkYEGTJnNrr+0DANhf6JjqQYL8vv4dM5DoCbn1XAY=;
        b=AHKdHtkS9VssH8+QGlMKNgqwdauQ54PIzsKtr+RxjNDiD0oEOrWt6UZjrhDDZ3vbQi
         f3TbRqW/t7xATukSyO9Y28zE2F7FiLcQ1VLGLqVqVAzphrK94/4nRGKOpdpKdMLHXZ3X
         AdBF8opi9Y5f5IK9PkjHOS+fTOIDcXZX/ijjTNmkK81p4ZL73LdhyFryB2R8zYeaKYCt
         RmduJhsJH8ineNIvFQWGIsVptmypAFOp5wNIiXq734WRgjkfPK191LQxvkoqH+4kW23Z
         jeV6F06MGsZuTS5uC5R0+tRwSakgl30rVVSrEKlljjRXvmrZLdJwT1WeESHcCLFB+Cia
         DdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=qqxkYEGTJnNrr+0DANhf6JjqQYL8vv4dM5DoCbn1XAY=;
        b=YE2+eaQfL9I/9MuOQG4m6ClcMMPVy7KgqCsjiVVnCosQdjYRYt8HRAMsWRUODtcmER
         B3BVqJaVf0QyJLUcloaIxp6mYUxV1hCD9HlzbrNSx39aBu8aVnLy65+b+0pjaq1BqTaq
         mwb9jRQubVyTsxMkKAXR/ZJk4c7XCSwHHMMKfMgL5DqhFC7urtGIvw0QMppw56QytNVV
         /u/WBG6My6UJz9DBE57MED44s8aKU0Uq6TxpQqkYphDDxXJdOWAn60rnsJLeZwB8NoBC
         8UmzRQ/fiL6utZfBgMBnJXSQT8F5EmoGCTtAwPAh79fmi3W2nPCa4ipDxJMx4IwPzAQk
         ++lg==
X-Gm-Message-State: AJaThX6shwgBp8IBZL9HjejCcitPrgU1ZOpKSPJwTAzRyrabJojcFmGH
        49XMcVrlzO1rS2oKM0S79sO9IA==
X-Google-Smtp-Source: AGs4zMazqaCKfI5z35KViFUyDfvadwo7daPqyEKXexRIHeYlyJzhs5vqxsvYXWBfnbqQr0Y7yOE+YQ==
X-Received: by 10.28.217.144 with SMTP id q138mr7010585wmg.9.1512380602234;
        Mon, 04 Dec 2017 01:43:22 -0800 (PST)
Received: from localhost.localdomain (x4db282d3.dyn.telefonica.de. [77.178.130.211])
        by smtp.gmail.com with ESMTPSA id g68sm7666678wmc.22.2017.12.04.01.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 01:43:21 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Amandeep Gautam <amandeepgautam5@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug in git-completion.bash in __git_heads() function
Date:   Mon,  4 Dec 2017 10:43:17 +0100
Message-Id: <20171204094317.7344-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.338.g53352fef7
In-Reply-To: <CAEZzL1BOTLzrqZRehBzE8cwCvTY6qgrwZsbq5gcxWUbGyva8FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

>    This is the first time I am sending a bug report here, so if I have
> not met the criteria please let me know.
>    I found that at:
> https://github.com/git/git/blob/master/contrib/completion/git-completion.bash#L371,
> the usage of refname:strip=2 generates error:
> 
> fatal: unknown refname: format strip=2.
> 
> I am using git version 1.9.1. However using %(refname:short), I
> believe produces intended behaviour.

The for-each-ref format modifier ':strip=<N>' was introduced in
v2.7.1~15^2 (tag: do not show ambiguous tag names as "tags/foo",
2016-01-25) and the completion script started using it in
v2.13.0-rc0~46^2~8 (completion: don't disambiguate tags and branches,
2017-03-23).

It seems you're using an old Git with a recentish completion script.
You could either upgrade Git, or use the completion script that was
shipped with it.


Gábor

