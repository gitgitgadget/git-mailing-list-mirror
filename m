Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E74120248
	for <e@80x24.org>; Tue, 16 Apr 2019 04:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfDPEKk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 00:10:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38974 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfDPEKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 00:10:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so23217883wmk.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sZ4VdHBlsw97S+m0JQve9n/IBeragAZn3pzFY39oqT4=;
        b=Ub9Z+mKSh+tk1/YgEb44Zvj85h4zUWeeArIHrGRATF9cJwREKWTP3Z+naCn0HIKXXD
         SlDm/YcYgGH7vFNs/yxLEWeVzkXTuu2cVLSBuHPnLAypCV1XGuaVr5H5f6ltr3RAw8ke
         Xjy1FpTWXXYaWSTYv1G+sCPpeT8F+TywY1VjO86QfCdHP2SYrMO6ZZbHovjl7uvggH1a
         qby3tPuUPHRP7HY8UdRU4GM8L/IqowsOt86Sz3rzQmULEUIWPv64Op8jIzBZkcK3MZ0M
         dNnJbd1pdGU8ZMPUchdz9tE2KLubIqdpQrxkYtol0TYhNxrTogNmtxNADjYeiYp3WlHl
         CAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sZ4VdHBlsw97S+m0JQve9n/IBeragAZn3pzFY39oqT4=;
        b=G+vH08TI1HLCNJAuU94DQAXL3fJY3zEsF8B6jH/4iD41SASdN04dNkWQTtIFavs29j
         ASuzHkUkLdHQgqIP212QfWlWPkCC6l2RD9Q2is5BbYqlBtzl8RvVFVEKXV1NN/lvdwxq
         LbYFiBB/nDr+QwdnvWnVAaNUAaHZ6yzHNiOyB11YEKdxvFNoDCczulALLuREf1qbHmbP
         msbJONIaV7H/zaa+GZOsWlEu6DZVM7tY1gS0dwLuP47WTEoQsjUdZ8w/gZ1inMiHxI0g
         /F02h0xAXq3ZinWqA/RfOjY5Qw1aMP1msk49gYkPu78MEG3ozkAXHJrCmX+jHdb2NBwf
         puzg==
X-Gm-Message-State: APjAAAXKHw5lslXDOriAcs6XNFMxkYPhFdMjg2CgOyW6uGG8bkZuzqvH
        1RpNtu/eGsisLIfsXd/bp8w=
X-Google-Smtp-Source: APXvYqw2MMa8Fx1PvsV/A2y7KTYyOfK1ICwc0aQ5mBrdzqsAo8Zs5c7cuDew8tHnNLaHBcsMmrKWUQ==
X-Received: by 2002:a1c:4d02:: with SMTP id o2mr24558873wmh.134.1555387838389;
        Mon, 15 Apr 2019 21:10:38 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d14sm71660904wro.79.2019.04.15.21.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 21:10:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Michael Platings <michael@platin.gs>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v6 6/6] blame: use a fingerprint heuristic to match ignored lines
References: <20190410162409.117264-1-brho@google.com>
        <20190410162409.117264-7-brho@google.com>
        <xmqqk1fxw8ad.fsf@gitster-ct.c.googlers.com>
        <4c7bbc6c-805e-da7f-593c-e73989fc37c0@google.com>
Date:   Tue, 16 Apr 2019 13:10:37 +0900
In-Reply-To: <4c7bbc6c-805e-da7f-593c-e73989fc37c0@google.com> (Barret
        Rhoden's message of "Mon, 15 Apr 2019 10:03:10 -0400")
Message-ID: <xmqq1s22r3nm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> Though the old heuristic is pretty basic - really just a couple lines
> - 
> and it may help to see it before looking at a more complicated
> version.

OK, then.

Thanks.
