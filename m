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
	by dcvr.yhbt.net (Postfix) with ESMTP id 11C4420248
	for <e@80x24.org>; Tue, 26 Feb 2019 11:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfBZLgc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 06:36:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39180 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfBZLgb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 06:36:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so10434573edc.6
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 03:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aGcxJmRbEKa6NWDBjiQNRTnG4t8UMlt0VBF83uVUByc=;
        b=iHDXxrVfLAigEFdAbAlKiUvmZhk2/72cAIJ/3JCP4MeBnQibMsHABmny3Rqb4bqleU
         wMQgWDlDnWfQQkaNxVuDfTGH7tuKXui//NgEn0CtPs5uviuHmZuAQgJXuA4v/ZlvnZyA
         bynttZ4a/4ailKlm9Qd7UJkvkxfbxPKZhe5Al2TBs1OXNEW2YaZyWZzt1M0BNHq4WdLr
         5fX4fIbTQdg2fV2N3AoU1BBO6XNRpbWmQvyAQu+z57nOjcyGX/SCANqXCY5WpS4QOe7V
         D8pVDyzhGNS5yKEgn+i9/uPVFX0SL9DSFTH7r3UE+N2FTapXnaqxMLPG8B7crIrJxAhv
         Pdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=aGcxJmRbEKa6NWDBjiQNRTnG4t8UMlt0VBF83uVUByc=;
        b=SmWxupa5dnuBmBw+GjdK3Rwb7fEE32/JTACaK3lzu5K8uxSkCKhZJvM1gVfRrgbNH3
         uxR4LXI9mu3+pEThjh2CW0UY2pJkbfV9bg0vklBHGovJRBVxotwfLA/wgJgg3mtHj9k3
         1ZNPQ9LbPBDRXK/vrB4LcJG6RX/+/5vTip7TGrVeenRjMH5mdjQfdwFP/v7OA4Zaj7iI
         PiarlLjU507xUz8MTPEsLZJpo9bKmwLZlSmoO60YwGnTvvYFKyLDKe2VwWj+R5+u3Fy1
         4xCOMdZ4clcTPknZKeQET2eifrjvFqIqCEOPa9FDbZhpU4l1rJDIq9k2q8D/NrYRquhJ
         4P7g==
X-Gm-Message-State: AHQUAuaFpivh+hzb3NRx0RVdOuLl7JJOOoRjVzXrwaiPl25c3Yy28Ih0
        tf4mRuFr0gsqn/VKQqBjWLY=
X-Google-Smtp-Source: AHgI3IbiMu19UiXMCLHXlN711eSfhdCT0rrkaOXvyI/BsRhygDiVBvEd6Pn5dnGtuuQ+d8XxXQgu4w==
X-Received: by 2002:a50:b527:: with SMTP id y36mr19027774edd.83.1551180990031;
        Tue, 26 Feb 2019 03:36:30 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id gq12sm2173015ejb.21.2019.02.26.03.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 03:36:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP RFC PATCH v2 0/5] clone: dir iterator refactoring with tests
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190226051804.10631-1-matheus.bernardino@usp.br>
Date:   Tue, 26 Feb 2019 12:36:28 +0100
Message-ID: <87va16vl1f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 26 2019, Matheus Tavares wrote:

> =C3=86var sent v1: https://public-inbox.org/git/20190226002625.13022-1-av=
arab@gmail.com/

Tip. Use --in-reply-to with git format-patch, then the whole discussion
goes in the same thread on the ML.
