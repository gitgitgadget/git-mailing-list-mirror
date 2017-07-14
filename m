Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA0C20357
	for <e@80x24.org>; Fri, 14 Jul 2017 16:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbdGNQdk (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 12:33:40 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36045 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdGNQdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 12:33:39 -0400
Received: by mail-pg0-f51.google.com with SMTP id u62so47993170pgb.3
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WjOzjS+o2pzmpJptwjvSVvPcQjA9EmHhWoSz7QeO1aI=;
        b=p0itkeiUTWX1XOyn5RnJUOJh9CIKeWU3OncES0CKOy7kAYjzauA39ArgXmbDSRpl0H
         n0ZTDHHoNZ0+9zdOEw5a12VpHTZu4BH1y52Sh4/74AvlH5qn6KCh8G5SaSAjsIFC6GFu
         XFAYMFD9T0nnuSMsRJUWGGLnJyaN7BNC9K602/VU6y8I9LB+3qL0EQWlk/vPDM1jPA2+
         7wUN3n6jlLiF2y4mSQQmwEKVokYWmFP9b3M7LPjlPtaSODbKJhSiZpnVXGXZOoHctE9v
         nS+bzfPRrveFDbQlhGZY+Rt9g1F3DSWGBIdf6n7ZK6IddOnkk/ibSLpS56jiz8aqUixE
         /Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WjOzjS+o2pzmpJptwjvSVvPcQjA9EmHhWoSz7QeO1aI=;
        b=dbauyOX3qZ55Mmw+DmUqyQXrqAoMR6GBFR4Okm/7tQCGOgOEUBpyv4yGxqOPhyL5qc
         LUC1SWTaPPH6LSdv8d2rORI0CwfqgGS83C/WFtwLxBa7NMhULq1oUOpb43v8pBcQxhX/
         suPBSYb6f0Qq2Qgj8iwRiWn9Fszi9Ktblca1Zi44LEiTIlHM8eVa1a1FXuBJesKaNywY
         hYMIRFXJPd/xtM7lY9dS+fV0ARv34IffZTCiAaZKUt+0wAHXs9wF0MPVDGuz2SgPMrRn
         jvWW42BBE8/vxhNOUL+W4JB2oLOTlz2u/LenRbMYJ5unXKmpuN/SZdf1kukLENgYfJit
         SYMw==
X-Gm-Message-State: AIVw110X9OE5a38HWUQwYlNL6vommQ6+NdL9bqv2ynLomUdtaDJr0IDx
        rTEr3YiUhDbqM8Pj/zc=
X-Received: by 10.98.224.11 with SMTP id f11mr6239153pfh.118.1500050018447;
        Fri, 14 Jul 2017 09:33:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id z86sm22357959pfl.40.2017.07.14.09.33.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 09:33:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix regression: CamelCased aliases
References: <cover.1500021526.git.johannes.schindelin@gmx.de>
        <20170714090256.ne4gqgppt2qshtak@sigill.intra.peff.net>
        <xmqq60evrqyd.fsf@gitster.mtv.corp.google.com>
        <20170714153015.crklfqaa2qc573zo@sigill.intra.peff.net>
Date:   Fri, 14 Jul 2017 09:33:36 -0700
In-Reply-To: <20170714153015.crklfqaa2qc573zo@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 14 Jul 2017 11:30:16 -0400")
Message-ID: <xmqqh8yfq8pr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think there are basically two mental models that are reasonable:
>
>   1. Uppercase in key names is treated the same as lowercase. Therefore
>      we must allow "alias.Foo" to match "git foo", but "git Foo" can
>      never have a match (in the current schema).
>
>   2. Keys are case-insensitive, and anything that matches them is
>      considered case-insensitive, too. That means "Foo" and "foo" are
>      identical for these purposes, and you can never have two aliases
>      "Foo" and "foo".
>
> In either mental model, "alias.Foo" for "git foo" must work. But the
> reverse only works in (2).
>
> I think either model is fine. These patches push us into (2).

I've always thought that the promise we give our end users is that
these keys are case insensitive, and that the fact that we downcase
the key before calling config callback is merely an implementation
detail.  That is why I never considered the possibility that (1) can
be a valid mental model.

There are other possible implementations of case insensitivity.  We
could have been upcasing instead before calling config callback and
the users wouldn't have noticed.

So I'd consider that pushing us into (2) is a good thing.

Thanks.
