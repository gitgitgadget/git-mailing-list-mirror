Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13D120248
	for <e@80x24.org>; Sun, 14 Apr 2019 03:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDNDpl (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 23:45:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33481 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfDNDpl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 23:45:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so3434728wmi.0
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BnDYf7ghYvxX+rnTHybJv51ORQWGCZv1Uq2EMLHJxGM=;
        b=q88zgRGeMCASOAcsUbV1VBjSKE4RcVi2Td7ofOS9lXVcdsPu7uJMz7CME3NAeXusan
         VO12FlZYcAHsiIszYbaMjcg0/9XUiXzADqABjnqRDOXh0A358lD5OVyzWO9DS2zjZ5ul
         /oaLqHJ65y3bdXlcw0LFH1OOHefxpT7h5Jrwh2Fe5Ntevfa+KvFfvbh4td+hIBK7S5q1
         rHxHxdi2lUWxBQKhDVTRLUupNhMWQdCrMEuQMUd/mpylgvaqroqiJw2aTFWc5paRFxZJ
         0YYcWmY4pMhE61XBo4bD2rFH/j1DDI01Dc2bdxsHeAeG+kzr6nfVdZISu5gEKKgbfAHi
         d+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BnDYf7ghYvxX+rnTHybJv51ORQWGCZv1Uq2EMLHJxGM=;
        b=hjuxa0NUHBJNLm3muaFR6sxtlYCjhh7vaV/OM7fOAbJ+p2a4OPH3MAuIgHweexQFg0
         QgSl7t17t5BUlwgjyfyi6BsnHuSeog5x2tmZDbz6gJndpGN+hUIHV86d4BrcXceTmMWB
         u+bumft+mi5HwJTQiwnOLPXKPplg7t9EqDjA79Svfq6edKXYLv9XI7FP8aMeZYlTESav
         uztwSPh9Mpn3VHkUJOBDfMOP7mrfWs/iRgwvCR0c+9d16SZBuhWJZWuiV34tm6mYMmwP
         50xmgT9lscWzC0td0A3Z96GHj0i/v/Z7f5ftvw0/gUCV7+n4xUGfPnu3MFTeYCcqG7rJ
         cxUQ==
X-Gm-Message-State: APjAAAUyTu+/gepIrv3hgbc/IFd/m5GJ51qXvAY5TLUoSB6I3wLguQKZ
        dZ02hFBa0cHgKu885QnI40w=
X-Google-Smtp-Source: APXvYqwd0M+N0IFnPT8AtvfZEY3aGaW/hWkqQWsjiDUYWQYXm92a25ha3PoseaxITgPjggnTo60pKg==
X-Received: by 2002:a1c:20cf:: with SMTP id g198mr16686709wmg.42.1555213539374;
        Sat, 13 Apr 2019 20:45:39 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x18sm14762154wmi.6.2019.04.13.20.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 20:45:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Subject: Re: [PATCH v6 4/6] blame: add config options to handle output for ignored lines
References: <20190410162409.117264-1-brho@google.com>
        <20190410162409.117264-5-brho@google.com>
Date:   Sun, 14 Apr 2019 12:45:37 +0900
In-Reply-To: <20190410162409.117264-5-brho@google.com> (Barret Rhoden's
        message of "Wed, 10 Apr 2019 12:24:07 -0400")
Message-ID: <xmqqo959w8pq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> Sometimes we are unable to even guess at what commit touched a line.
> These lines are 'unblamable.'  The second option,
> blame.maskIgnoredUnblamables, will zero the hash of any unblamable line.
>
> For example, say we ignore e5e8d36d04cbe:
> 	e5e8d36d04cbe (Barret Rhoden  2016-04-11 13:57:54 -0400 26)
> appears as:
> 	0000000000000 (Barret Rhoden  2016-04-11 13:57:54 -0400 26)

Wouldn't this make it impossible to tell between what's done by such
a commit that was marked to be ignored, and what's done locally only
in the working tree, which the users have long accustomed to see
with the ^0*$ object name?  I think it would make a lot more sense
to show the object name of the "ignored" commit, which would be
recognizable by the user who fed such an object name to the command
in the first place.  Alternatively, perhaps the same idea as replacing
one of the hexdigits with '*' used by the other configuration can be
applied to this as well?
