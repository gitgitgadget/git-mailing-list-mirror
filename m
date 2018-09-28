Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F59D1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 21:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeI2EH4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:07:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37245 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeI2EH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:07:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id y26-v6so3521091wma.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S0e5AEFFhZkeHuSDMP8n1DRcGvZYt2rOakKzvo9ojSY=;
        b=dzLUoocu+CFGqlJ8CAO1jlyH7l2XMzv0IFYL1+fJfySDRIyHQSgzXqhwyHqLXa92HC
         6qVnKYGXf9v3DhzHBjZoFTiS/omyhozmXk3lZnINzNRNoRiKdALd/HsaAKlbmLQX6E7Q
         DtQBQYMmyqRVyAfT3kHCBQyaFIEnDkqr1nmqZL7x5xJX+sBmYs3eF2RwOaT77vZWB32r
         jwEi75gtlSAHeF5yd/oDQmCnk60T94weCjN54twPaXJ/V9y6IwxCIEPS6+JR8ESE8tF8
         R+qbpQ0te6HIyXC/BtiynIt+CyIQ04mpXunZYgNveWS/cu1oE4jH7XRRqRUPhmhg6XEJ
         Acjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S0e5AEFFhZkeHuSDMP8n1DRcGvZYt2rOakKzvo9ojSY=;
        b=hKoWSSVwvjjARGn3/t5stlpJ6XlaQ62aE03jhnjdsZKMmsFn5uTh7Nc0qFIwpOQkV2
         4wJpqdtwseATMf9TSnPe7oOy5yY8bL9DM8LhaoUOMhOQ3UR7mqF06jH0Ylhfpk6xDEqX
         nve1beL0iA86ffoY1L2gNkJbwYJEBuSFy8/knu3iyjd8utDFUdmn2ayvdZ6val+JIQaT
         OXRsQ+nDtenkQK/0fQbM+oL3fumvym7WaflXeCFD1Yy7t3vYZN+/CPyJ2Nehfftrs/ef
         pK3jBU4/i2+hOqlfmovBdZm9rDZFrr8MUWn2OD+/fhIKWjgspMAV/eBS34Rf1niH8s2l
         Azdg==
X-Gm-Message-State: ABuFfoiD2F1YN2T1DmEiTb2KGAYkSFrlgdQP5Fpi9XHXnINxC2ZlaYzK
        fSyp05uemFwgAagLfrSFkrY=
X-Google-Smtp-Source: ACcGV62wt6ODERTxuPga5HsSmU68dxlH/XG6D2gtwd80RDSBp8gpu7VsesXChvh11wzWV5FeuT9maA==
X-Received: by 2002:a1c:dc45:: with SMTP id t66-v6mr2832968wmg.148.1538170934738;
        Fri, 28 Sep 2018 14:42:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y12-v6sm4196983wrq.33.2018.09.28.14.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 14:42:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH] strbuf.h: format according to coding guidelines
References: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
        <20180928173033.159192-1-sbeller@google.com>
Date:   Fri, 28 Sep 2018 14:42:13 -0700
In-Reply-To: <20180928173033.159192-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 28 Sep 2018 10:30:33 -0700")
Message-ID: <xmqq4le9b8p6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The previous patch suggested the strbuf header to be the leading example
> of how we would want our APIs to be documented. This may lead to some
> scrutiny of that code and the coding style (which is different from the
> API documentation style) and hence might be taken as an example on how
> to format code as well.
>
> So let's format strbuf.h in a way that we'd like to see:
> * omit the extern keyword from function declarations
> * name all parameters (usually the parameters are obvious from its type,
>   but consider exceptions like
>   `int strbuf_getwholeline_fd(struct strbuf *, int, int);`
> * break overly long lines
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Maybe this on top of Junios guideline patch?

If we were to do this, I'd rather see us do a very good job on this
file first, with "We are going to use this file as the best current
practice model for an API header file" to begin its log message,
and then recommend its use as the model on top.
