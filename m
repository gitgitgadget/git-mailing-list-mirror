Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F2D1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbeGaRtq (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:49:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34868 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeGaRtq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:49:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so17251345wrt.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qud1y4N54M1iPXrHg7qYc6DugupcDEI+Qlhe97e367E=;
        b=MLRT70sySsNewSerFp5MyVJUsqjsAP/53JWH0Ml6w9BbdhawQSmz1/oIchLeFb917+
         s0Du1Sn/x4Xcq+YGgnfFU/6Gsd4/7U3SLgW/RlbrPAraa5KOhlTxbx5GlUpxWcwkuWEi
         3vPnhbFH8hwLqFWbHBwT2gut+GyM+AcjF0WA8bExE2Y5U9m+g/80Bf2PjDKVelHInrtd
         oV5Bb8nDb2Fop1Q+k4rpOyMEKrYTLh+QQrP1KVUcOaTToK+8ddYhB4nuaViIuiVMvzDf
         wwXZUK3B5GjDCxC3S2qyK+rFiTwTIBWLiIKpIxCLnbRK8nzcvR939ERuC6Gg2PSSJ+FY
         gp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qud1y4N54M1iPXrHg7qYc6DugupcDEI+Qlhe97e367E=;
        b=fR5KEfVH7nX7ae2jvrnRdHuGCFgNPV4tEoRoHWI8VC29JYvPIXkS3pVWMuA5MtpsTj
         FYd8ZspSCQOG9jISkqlt6EZ0Wo52nYdPvBcXLoPZR9kqOXtucFsBZJvMXDq1C1H28UmL
         3hrJjclU+Za7eXRfIRT/xCeYasVAqZfvr6GnMwrzkMwAdx1GSWgQe6AXXgQ6NUjFeA1T
         O+jVVAtl3P0+kCtUDCtp+ciQa30Fu+Ga9jk21KslZuBlwILaDpzBpXo4786A3Q+os+FP
         xXRvNl43FXUhyreI+408C1KS1nLqnyLR/yIAb1gdJJnHEUo33YRA7su/a+nbCbOYCilK
         eG8A==
X-Gm-Message-State: AOUpUlGiJWH317KQZsfFUqw1bGa8Wctb1IDI1lxrLx8BzY/0bWSpF9t9
        AcSEDaV8emk0M974t11+ppM=
X-Google-Smtp-Source: AAOMgpfbKWhDC2Y1Ocq87N75PTnBIwjEFPMIEqG2pTcOG4fPXFl9foCALAyy1blleh8WJQTsHF8Byg==
X-Received: by 2002:a5d:6601:: with SMTP id n1-v6mr20056766wru.281.1533053324744;
        Tue, 31 Jul 2018 09:08:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m68-v6sm4396554wmb.10.2018.07.31.09.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 09:08:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     George Shammas <georgyo@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
        <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
        <20180731155027.GA16910@sigill.intra.peff.net>
Date:   Tue, 31 Jul 2018 09:08:43 -0700
In-Reply-To: <20180731155027.GA16910@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 31 Jul 2018 11:50:28 -0400")
Message-ID: <xmqqlg9rcrqs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The problem introduced in that commit is that each iteration through the
> loop advances the tree pointers.

Ah, indeed.  

The original used tree_entry_extract() and update_tree_entry()
separately, but the update does tree_entry() on both sides.

> So the assertion in that commit message that "the calls to
> update_tree_entry() are not needed any more" is just wrong. We have
> decide whether to call it based on the "cmp" value.

Yup.
