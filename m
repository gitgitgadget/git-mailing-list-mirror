Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCED520401
	for <e@80x24.org>; Mon, 19 Jun 2017 05:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750926AbdFSFSb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 01:18:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34115 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdFSFSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 01:18:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so14123289pge.1
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 22:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QqhDIGQWiPpoH1CBIWlkMt7FtjB5uCnsGOjdQxEwyE0=;
        b=cyjS6qS4fbBD1Osj5s5Z2a+u0cUBUu3VsYaiS3J1z29hE4Au96LZskzmVHTbDbMpaM
         Vu4RWy6gcF0mbRWHIYV8QGA1nSCL71pzM9MolkarbnlJdvJGJh/1cymCoyboe9WEEtHn
         SbGQZLuls+ISq06BoXHqxNROUc8illDprODacHkRLVIOd7tM36E0B9C87hNgCG6aIY8v
         mPZzhWDHhw4cLbF/oxpQsjFgQKmQCvSBbzKvjBZmTJ0m7hdqSxmBqhlAuq6qjcQhoAC2
         4va7mJLz9oI7kzeqC36Z3Gz64NOg7XKpvaGwUp94NZW2A/x/Yg7h7b3rTa4T4a6JRwem
         djFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QqhDIGQWiPpoH1CBIWlkMt7FtjB5uCnsGOjdQxEwyE0=;
        b=mfF8+4tTqEOF7YnEIUkPVnDk2EZd6+/TfmDhBoWs2BInSJWv1Er1rTz/u3x2jOKHkB
         e0as1Hd7YKFEhVWoK7c6F/RsJeZ9rHBDU9tgQK+KLJVu6sPRhUAJ7xy8vrxPOSQSVa3M
         k7fDqlCNwXMB6tFKejw5X509XlVByyhA5RrUL0jwR3W6RpJ4yCcelnOdExQ8dHxojqHN
         NzxImakB8iybZRd7gJbYmBjGZxU5lIJy4YJeLjunM998Irn8csuQ5BuWjLyBtQSpcgb4
         c69AfJ18e+N37nqGdlp+vyeOcD0qSktmJXpYeokGDVpvLitvBGJsluYqc6WFaiUG98OM
         FKhw==
X-Gm-Message-State: AKS2vOxovQD0R0gprQyZRz4KTAAhlWiqX+ZFCs1FxW9PHGiPEuy4iGvg
        gPzyFfoF/reHrHVGEI4=
X-Received: by 10.84.217.133 with SMTP id p5mr28313249pli.218.1497849509555;
        Sun, 18 Jun 2017 22:18:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec96:eb20:667b:9e2b])
        by smtp.gmail.com with ESMTPSA id m11sm18249246pfg.85.2017.06.18.22.18.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 22:18:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, houstonfortney@gmail.com,
        kostix+git@007spb.ru, peff@peff.net, sxlijin@gmail.com
Subject: Re: [PATCH v2 0/3] add stash count information to git-status command
References: <20170616043050.29192-1-liambeguin@gmail.com>
        <20170617223052.6580-1-liambeguin@gmail.com>
Date:   Sun, 18 Jun 2017 22:18:27 -0700
In-Reply-To: <20170617223052.6580-1-liambeguin@gmail.com> (Liam Beguin's
        message of "Sat, 17 Jun 2017 18:30:49 -0400")
Message-ID: <xmqq60fsv9lo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks; queued.
