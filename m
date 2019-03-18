Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3831F20248
	for <e@80x24.org>; Mon, 18 Mar 2019 02:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfCRCw6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 22:52:58 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51619 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfCRCw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 22:52:57 -0400
Received: by mail-wm1-f49.google.com with SMTP id n19so11454808wmi.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 19:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BNHvMQYtG7wtNO+Efh53/XLDEvM2hu/WA13HXBBbDK0=;
        b=l6oIIwi1XwLehE7oACdU+TcXrA4nOtQ6K1yWPRAHw8TqEC4TFjtTqbRfhXnrd2pPCA
         uaBF6iIxcT7+O0Atl/2lQcCBnPNZIFjE5aKu6IPS93AmfH+r+gxPI/wXchJw5rr3nHeY
         412SkxYSqtF/cHDQ6gQxnke5/yub+BHf5n7qWoUoqLilgYxD9z88lMvXmtOMuGdhJp9+
         6RQm/stz4oVhvnX0BQ4hzDIpLjFCPtXyZ318EDlMXu4I1hlD6GfEwJtw2ZAqmnI3wcQX
         7Niw2DnFVw2EisxNEoNJZT3r/DMlgengWiGPZe3c17zyHqmZC5MkM+sEWH9FPIC0LaCI
         4U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BNHvMQYtG7wtNO+Efh53/XLDEvM2hu/WA13HXBBbDK0=;
        b=n4Y1vdifXomsFFGJhsmCO/fp7FrBm6xN3CKTDrN3wSjfrKfsR6oyb4qX+mzZfu9Ngs
         HNH3y346fS86UR4Zi0mCDCi3obym8sHFhovzDLJQKGnMyh0nZMI+XU1SFc5VOGY91jFc
         kkMFTbrc1V5PtpF/J2mUROH6Hi+FuJaoN4pxFuqmXdxibxmDP0jPiG8zgyRtnxo5U5HD
         Ux1weoJnOzvs729NfM4n+b50RVul6d+mY92WFmnZIrvL/hRVTLdBmkdi3RyMnZCpzxKZ
         HYn+8xAlbOf7fopbOLjjAFNvW94OpyKhUeoN7yVgdwSGOBAoS4nJuO6iqXmup4wLVKjF
         mc5Q==
X-Gm-Message-State: APjAAAXmSWlOVNu44tq2CGjd0aTgpmC0PF5ZNX1md5Vr8ESO2FaavYZu
        dB4s0K4IkGtinGzC35y/fhI=
X-Google-Smtp-Source: APXvYqxJXMLHwrVrgEUgGTPBCURPJCNzMkk/OUI18MISWsQG0yYBRhQRphYSDIbrllwARB3DV7fgcw==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr10049211wmh.74.1552877575741;
        Sun, 17 Mar 2019 19:52:55 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d1sm8748813wrs.13.2019.03.17.19.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 19:52:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
References: <20190312213246.GA6252@sigill.intra.peff.net>
        <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
        <20190313193909.GB3400@sigill.intra.peff.net>
        <20190313201854.GA5530@sigill.intra.peff.net>
Date:   Mon, 18 Mar 2019 11:52:54 +0900
In-Reply-To: <20190313201854.GA5530@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Mar 2019 16:18:54 -0400")
Message-ID: <xmqqzhps6ghl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm. I guess it is still an issue in GGG. This thread has identical
> timestamps on patches 1 and 2 (and my server received them out of order
> by 2 seconds, so mutt orders them wrong):
>
>   https://public-inbox.org/git/pull.163.git.gitgitgadget@gmail.com/
>
> I do still think GGG has a more feasible path forward on this particular
> bug, though.

If the MSA is rewriting the timestamp (but why?  Is the original
date "Wed, 13 Mar 2019 19:20:12 GMT" malformed or perhaps in the
future or something?), then there isn't much the sending program
can---'git send-email' would suffer from the same symptom.

