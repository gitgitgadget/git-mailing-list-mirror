Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17251F404
	for <e@80x24.org>; Tue,  4 Sep 2018 17:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeIDWVs (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 18:21:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38316 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeIDWVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 18:21:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so4896011wrc.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vDY+MP4wLLTDm6fkDvSQa2+k4RheAuZZZb2/pdxLKqY=;
        b=BcxbZMY0Bx6rtOm1BA+4xGjD7jT72h2ZInqEU5fwQEQBzncEQEqk9UZo8vAhCWmW6e
         cIkeuU1SfTKzGT1e/tGTbW9lBmx3aX89k/t9/jMpf110S4E9DxSss1ffSQS8CCjZTp0w
         fvjtmJvSSkPkj+SmkNeDUC+lUZSo+FM/wqrSsgI5iTFUF7M+Xifj2iCWvu57JmaUXYtq
         H/VlGZvFPxxGtVVfMGkIPlQ60pk6ufea2VPQhqfYVEaa/zpkejiH4oMBEhWcPo6d0HXg
         SLP6ZlDId8AHZ05BcOGaOHZBIQJy+hhYdwBjmkjASpGmIZouzzpEWo2oXGJ8B6p6K0kT
         KO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vDY+MP4wLLTDm6fkDvSQa2+k4RheAuZZZb2/pdxLKqY=;
        b=dwX25Ah/JYEab8QZPOcaGplfF15zSsRBwNKu2W8dtPDAy07xRy2gcMbNjtS4aW6/84
         ygLq662yb+xwrOzeCKhTZcVx/+GJnUTAW8nAQw04yhagR+fk72Zi/dHPArjnirTG3d1d
         ukZ+WtQa87ofMi/lRIUS5ibdtIpFYzXC2X/DgLk22IcJTzIcZ3kMwxugDhD8JLrf6TVL
         1urlQOr4VGJZFgdM+oDBbdgJGI84Vqb08xTqUoln8JON7OJwP/rH7RPtviQ+CCnEg8Dr
         3Rj5sVEu5oDcviy650H0qln65T0Gh6i4bSbQRQKBwJPR0SSYZ9NEZBJUR/du9WHi5di0
         FZSA==
X-Gm-Message-State: APzg51AxbmZxNZUze1T5cJqclJk2tBSq60yfgJ1JMK6CW52O3GtWobVT
        6+3A4GpBvaUbeSFCxpQYPeU=
X-Google-Smtp-Source: ANB0Vdb+C4pimAXj+4t/RGCe3aydmO42tOY19LhgGcOyVlm4wLabCE2fxBr/8nWUNDwAoQITYm3w7A==
X-Received: by 2002:adf:add0:: with SMTP id w74-v6mr24820162wrc.73.1536083736428;
        Tue, 04 Sep 2018 10:55:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 144-v6sm22257919wma.45.2018.09.04.10.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 10:55:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Allow aliases that include other aliases
References: <20180904173915.2393-1-timschumi@gmx.de>
Date:   Tue, 04 Sep 2018 10:55:35 -0700
In-Reply-To: <20180904173915.2393-1-timschumi@gmx.de> (Tim Schumacher's
        message of "Tue, 4 Sep 2018 19:39:15 +0200")
Message-ID: <xmqqsh2p9mg8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Schumacher <timschumi@gmx.de> writes:

> I submitted this as RFC because I'm not sure whether disallowing
> nested aliases was an intentional design choice. The done_alias
> check implies that disallowing is intended, but the direct
> recursion check for aliases that call themselves opposes that.

"direct recursion check for aliases"?  I am not sure what you mean
by that, but anyway.

If I recall correctly, it is intended that we disallow run_argv()
doing handle_alias() twice (or more).  But the ultimate objective is
to forbid infinite loops, "git foo" expanding to "git bar" which in
turn expanding back to "git foo", and the current "do not expand
alias to another" is a simple but too strict implementation.  As
long as a replacement implementation still forbids infinite loops
with reasonable cost and complexity, I do not think we would mind
such an improvement to allow alias expanding to another alias.  
