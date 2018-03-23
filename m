Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F60E1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 23:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeCWXGP (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 19:06:15 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:45817 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeCWXGN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 19:06:13 -0400
Received: by mail-wr0-f181.google.com with SMTP id u11so1302860wri.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JoI5ZYfb3e0gShH5nSel/ePPlaR4Vq9kJKPQM2m48og=;
        b=qX7GeX3Ig05FTZmdmIUJT8TOqOE343IDXtIXAkMASi3LO3ZtkHnK/cWK2l++OJiT3H
         YvDUKSgUPpOaPzGRh29qqgchfZm3DzjdaaZfGmJMWhcrKtxalBc3vh4Ax8/jgDuHDVCN
         Ik3FtbPs3E3l2pBhWo2rk7T1QM3XiniD14sGqrtJODPS4GfHF9aGX356EuCRXvuVawF4
         hWnASAhmPoOdq5Uq8vdZmmU4WkBFCwhvZfZV1jTZTQhLeGkQTT3fmZkWXe+oxodLQdZJ
         X3KMisaOKQdxt6ZOdfpzSy4O9ZoTM7JVWFFw/o47EILITrbri5SFHEUWlPx5gAKuJgBP
         /VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JoI5ZYfb3e0gShH5nSel/ePPlaR4Vq9kJKPQM2m48og=;
        b=nWcv8/Y8z9gtgMF3LmDXoEoTQT2m1Yhc+kpYEsY9bsG/fvh5naJbtUtORmmLhsfY0B
         ZUFWRbBHWUiQ+g9EexpLSTIsVg2FnMnqFSctbdYJcpOo4MwRSxqdMzgsz5xD0j9hw/gI
         L+zJ8tUbAXpRoFP4pJoo5TW8FjP/9GwedrSGSU8F5b8z+KIOuz7n5AucKz3QoonPAsbc
         EO8jCAnNYsmGAQhaUG14VZ22HCk8FOG9Zgth/zHccHkzUZD4ecQ118WV2vOeyJQGTJ6Q
         j8nLsjHHneDp7+cZfkbbrriAxxCSa4j7mkpfzCAlQj2jOoKDiJ4JIIVncKz7K0BiHtqS
         cHUA==
X-Gm-Message-State: AElRT7E7871cRi4qRsQufD2oPxdWef7VWIdJ6cj+jVC6pGT4nnd4ICFB
        TJmMq8p6Is9CDMjfTOHkKkek+Aef
X-Google-Smtp-Source: AG47ELsO9aXb2RQbYUHG153oVnQhm+ypPduZIbjDhC1k1QyyK6fXyizp/zdijVG2q4J7Hxki3QXGlw==
X-Received: by 10.223.161.25 with SMTP id o25mr13042469wro.137.1521846372041;
        Fri, 23 Mar 2018 16:06:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a72sm8557091wme.28.2018.03.23.16.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 16:06:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v5 3/8] Indent function git_rebase__interactive
References: <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
        <e893a9d550f4d09baf0d21adedca841b96feae0d.1521839546.git.wink@saville.com>
        <xmqqpo3uh26k.fsf@gitster-ct.c.googlers.com>
        <CAKk8israKrrF4PBH4csLQDyrQXwap0oZ3FkihswR1DUf8nqrxQ@mail.gmail.com>
Date:   Fri, 23 Mar 2018 16:06:10 -0700
In-Reply-To: <CAKk8israKrrF4PBH4csLQDyrQXwap0oZ3FkihswR1DUf8nqrxQ@mail.gmail.com>
        (Wink Saville's message of "Fri, 23 Mar 2018 15:52:04 -0700")
Message-ID: <xmqq370qgzod.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Also, I assume you want me to only change lines in
> git_rebase__interactive.

I actually do not care if line-wrapping is done; it is perfectly
fine to leave it for future clean-up and leave it outside the scope
of this series.  If you are going to do as a part of the series,
yes, I do prefer you limit yourself to those lines that are involved
in the series in some other way.

Thanks.
