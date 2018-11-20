Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A671F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 01:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeKTLcc (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 06:32:32 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51825 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeKTLcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 06:32:32 -0500
Received: by mail-it1-f194.google.com with SMTP id x19so1019672itl.1
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 17:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZ2x9sS389TdfPq+z55ZmY33bZOYhxnlBMtUURvc16o=;
        b=TxZqs2zRFGlxf3IYvyaqSa+LJdy3j4u8Bm0S8hCLsCKYbgpbstchtCvbXXzefegL6l
         v+oA0g+GncwyLD8JhZHF2VNh/I+yNgQRjjV7uaT68ghbk/BgLAo02njlx8Xyz/zMzs/r
         xEPGWVhOIFgQWP6ukfQ+lqtcZYlXIx3SsYccTZwbh6VlJjc5C4eZA/5M28fHgcfFFLr3
         W87HJKaG8KeBR5s/3Mi9zhcMhyrHDdKZjmNWbwJjzVpshczWns8JLll/FEsWbGr32OOg
         odAgYeiuVRoNCpozlksHcGLMGfDWefpaPdHDmAPoOIkQLjb4SlIouqeNywVnmN+BaZ8r
         j8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZ2x9sS389TdfPq+z55ZmY33bZOYhxnlBMtUURvc16o=;
        b=mbOx2v68hy9tm/+0o1JdJJQ0rw+fHb6bnn1zws+JMX10Qpsxcnl2x1XuTwK/cePgY/
         4IOvnKLTId/efQI/gXPis4ni8WQmN6Dmdy27aBaDh68UrDP5uajDWRxkHSCazfZXFnA4
         3P0oz5SMPBclYM2RzYs7GGCYLENJDhk52BRdgZS01PfeLs6TWqUNmFxedzUTQjoRSf/O
         9q4h98MbGWsnS51iJzY7PubCgXR0koxhZRZMgKIS2igXOjSKWtZ7nrFtMN/d/pfgkFx3
         Qszo0v8s8sDl8xD7zYMO5I8q5yEld4MXm4sy9mvEgHH65Ox5HItQZrn+Oi+FPE80vAO4
         cZfA==
X-Gm-Message-State: AGRZ1gKzHtD2BtImhPlXeRK3vV4sXSSpFmhL17T0yjYL5EceZk0gFmqc
        yop0bcbAAdHutMQnHwsQwJuW5zeJNrZkI5UWzHfOOp4DGlo=
X-Google-Smtp-Source: AJdET5evtItMEZ1HGef0j0oXzvWvA+3JMgrZwY5rbKpcGZYbOR/yeQ0F/ZGsk9HWcDP2fdFsDEKxzpS0qWuKrYAq92s=
X-Received: by 2002:a24:7596:: with SMTP id y144mr445021itc.68.1542675965754;
 Mon, 19 Nov 2018 17:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20180817161645.28249-1-pclouds@gmail.com> <20181119082015.77553-1-carenas@gmail.com>
 <37b7a395-3846-6664-9c4d-66d2e4277618@web.de> <CAPUEsphrYOV64m08JY_tsVuJ-uwTv=o=m5LdCFOWd+8tWJP54A@mail.gmail.com>
 <CACsJy8A_c-O5DrZnMvEbsSa+YzatiLH3TLAy3OV1+AwY5rrCjQ@mail.gmail.com>
 <20181119210323.GA31963@duynguyen.home> <5ffa3a01-8b76-0b84-a21c-efe912e80333@ramsayjones.plus.com>
 <2a6cd6a7-1b6b-2669-c83a-be5483c52fa2@ramsayjones.plus.com>
In-Reply-To: <2a6cd6a7-1b6b-2669-c83a-be5483c52fa2@ramsayjones.plus.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 19 Nov 2018 17:05:50 -0800
Message-ID: <CAPUEspjRBkUhwAkc6B-=FHoryfMLyeKZTnkWUTMTSz2VTN2t8A@mail.gmail.com>
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
To:     ramsay@ramsayjones.plus.com
Cc:     pclouds@gmail.com, tboegi@web.de, git@vger.kernel.org,
        git@jeffhostetler.com, gitster@pobox.com, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ok 99 - colliding file detection

as well in macOS with APFS

Carlo
