Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88D220248
	for <e@80x24.org>; Sun, 24 Feb 2019 05:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfBXFa3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 00:30:29 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52145 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBXFa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 00:30:29 -0500
Received: by mail-wm1-f54.google.com with SMTP id n19so5194956wmi.1
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 21:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VUJa48/lFLN2cp71ff8WDAdsIKGOPW/OwX7TdPIFpOI=;
        b=tYrSh0usaQTYDFN0ymfF208A9dzn43iOIxmHLJMwVQUDK+J2VrQ3QyuTWHmCWOZ21d
         JeHYJbRBrSESwf3Yf5f8hK80DAzlXDNJEyKBaVlY/yw4WAm55i4QlviAU+/dSWLiupk0
         lMZmpfB0Gc4T4bcQlMJ3crACgpqWW5N+4tN+/WuK0qp6KytFL55Mb4FiAikUlNxYHlXn
         bzAAQKGSAQ61aKQIfvaQLU5Zt31heBeQmuZ+PXjZ24IKLPaaCVANfX4BRpqGXenSbauG
         SKlj0q7tmRIJIYL3nzoaT+1+DtOkJxWdqBTfucj0aF4uR8woxlCvxCzccfuxhbxkwE4s
         KyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VUJa48/lFLN2cp71ff8WDAdsIKGOPW/OwX7TdPIFpOI=;
        b=uSfnnezbSELcv1oduFQvn7ZvrMmdRwuee/gD4ZJ9IhMjy7Jo1psF+OHMGaizJtKEjh
         rcODASQli+FhPGU1vwx87OFpfsyfpx6NX4d3isVOUjROjHc/xD0SCuGPcNRfVNKeud7e
         TBY3SDh09V3JvTV4igerZ+1+gHgCbyaEsqgg4XODUUmPwtTzOA697XDhfMNqveS/AlJB
         L0D7Wld8MEyziQP4Vu5EDAgIi3ZGTLPbDOuM47gskPovbXNZPVIfus0wCB3wlqzJm+l9
         mPsSPK+mLherp+RhbTID/qfsbVugsezNGeIWNla3Za30bdrVZnJ7RtjEcKSUhHzhJHFc
         28aw==
X-Gm-Message-State: AHQUAuaFL4Rlb7qO3tNPaacJiYXFZ8vzQpowEYTlELokCTkijHN/m2sP
        mE4PXbyYnFdmBXt8QmFGZDc=
X-Google-Smtp-Source: AHgI3IZ/tcCOTLjH7bs9vNDoOhDsgHA+qiZw1ZnCAZinNRxX6jBaJHxUtDt9YoDUeJY13BQ6VbEgVg==
X-Received: by 2002:a1c:1a08:: with SMTP id a8mr6638263wma.37.1550986227404;
        Sat, 23 Feb 2019 21:30:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l130sm2946095wmf.13.2019.02.23.21.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 21:30:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: does "git clean" deliberately ignore "core.excludesFile"?
References: <alpine.LFD.2.21.1902231008530.28936@localhost.localdomain>
        <xmqqimxao76b.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902231905180.45@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1902231912370.45@tvgsbejvaqbjf.bet>
        <alpine.LFD.2.21.1902231328560.2222@localhost.localdomain>
Date:   Sat, 23 Feb 2019 21:30:26 -0800
In-Reply-To: <alpine.LFD.2.21.1902231328560.2222@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 23 Feb 2019 13:32:16 -0500
        (EST)")
Message-ID: <xmqq5zt9oirx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> On Sat, 23 Feb 2019, Johannes Schindelin wrote:
>
>> Robert, care to come up with an example demonstrating where it does not?
>
>   sorry i wasn't clear, all i was pointing out was that "man
> git-clean" *explicitly* mentioned two locations related to cleaning:
> ...
> without additionally *explicitly* mentioning core.excludesFile.

OK, so together with the homework Dscho did for you and what I wrote
earlier, I think you have enough information to answer the question
yourself.

That is, the code does *not* ignore, and the doc was trying to be
(overly) exhaustive but because it predates core.excludesFile, after
the introduction of that configuration, it no longer is exhaustigve
and has become stale.

Which would leave a small, easy and low-hanging fruit, I guess ;-).

Thanks.
