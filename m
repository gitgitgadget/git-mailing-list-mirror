Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4681F404
	for <e@80x24.org>; Mon,  5 Feb 2018 19:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeBETWL (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 14:22:11 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52618 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBETWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 14:22:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id g1so28238916wmg.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OQ3blhmE8dLFzlS5bOKPPlr57O/tA8wV1KfotFELlP8=;
        b=WA6WML61fZux9mRO47wVaY4+Ggd0oe6g5+E0sEp7Tv75pKMV9gm6PN66gd8OWhuNCH
         E7TgfmVk4vfLjnLfNx39t+l0PaoLM0u2zcS8bxNR/YsBykdW5z+DkITcnh7mz1+aZ1pN
         wLDgIV9DaOenlhgmTLO7Brysg2eeFgqFd1VPWs0pQwhiJ1M6C2dPZbfGjrQWOe638jEd
         jN0aHFVMZo+YmXIp8Acp7cwmZbnRQZHubxrBB+ZEhyOSqXiklGD9zXM+N+mKo4GCzpnL
         ZZfC5Dc4TWL752MO852pdHrN672eyeiQ7GYwvLkJa7vcI4AplAC4YSD2JRVRtCMTH6Yv
         YOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OQ3blhmE8dLFzlS5bOKPPlr57O/tA8wV1KfotFELlP8=;
        b=lG6IKjNsEK7ySAAdAY5KuMWk8A9GptELkUKeH9pQBpIFCB9LbnYk4xvA/SaQcFNUqH
         ceYoB0beCWKOw4bPzmsfbweKbyHsfd4aU2IWluV6vG2+M6H8WYKLzhn7cLQytmhUu0ln
         tPIIwb/5S2qkvyoiwYgi1kv1UWgnZbj6YgZ7TIjLALKKOHdKJiV75rN1rE4ekiTMdN9F
         qHVTY7GjjD6H6rwkZkUhxL4XXEzuXOCMZC3uAk0U2TNarKlsItSpI9wvOQZ0GFcFnvl2
         0X/750S9BIVbtuu+2y972CsbD2q/b8ueNZJHs91a6nLp/S2hFEtCT3IvO5lzDEvrOBdw
         0+Rw==
X-Gm-Message-State: APf1xPCYJNfE32FVbXctigS0RKMEqc09otOsTgHEooooZiWo8u70aMjg
        Utdr6fFqhHYixdWR34ZkDGg=
X-Google-Smtp-Source: AH8x225roR1oID8iUVMGfeM9LPKO7dLCY55TnsZ6kZ3P3m9aFPnNyoQWZDJDurgELnu65pOIUg9YWw==
X-Received: by 10.28.241.4 with SMTP id p4mr266907wmh.103.1517858527784;
        Mon, 05 Feb 2018 11:22:07 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v13sm9856724wrf.71.2018.02.05.11.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 11:22:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chen Jingpiao <chenjingpiao@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v2] commit: add a commit.signOff config variable
References: <20180205104059.4759-1-chenjingpiao@gmail.com>
Date:   Mon, 05 Feb 2018 11:22:04 -0800
In-Reply-To: <20180205104059.4759-1-chenjingpiao@gmail.com> (Chen Jingpiao's
        message of "Mon, 5 Feb 2018 18:40:59 +0800")
Message-ID: <xmqq4lmvb5sz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chen Jingpiao <chenjingpiao@gmail.com> writes:

> Add the commit.signOff configuration variable to use the -s or --signoff
> option of git commit by default.

This is a rather old topic.  Here is one from 2006:

    https://public-inbox.org/git/Pine.LNX.4.63.0611281426311.30004@wbgn013.biozentrum.uni-wuerzburg.de/

which was referred to in another discussion in late 2008:

    https://public-inbox.org/git/20081227070228.6117@nanako3.lavabit.com/
    https://public-inbox.org/git/7vabaijvxl.fsf@gitster.siamese.dyndns.org/

I am not sure if the reasons why the last effort was retracted still
apply to this round (the world certainly has changed in the past 10
years); it would be good to explain why this time it is different
;-).

Assuming that the new configuration variable is a desirable thing to
add, the change to the code looks OK.  Documentation updates may
need more thought in the light of past discussions, though.

Thanks.
