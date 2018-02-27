Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4FE1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 19:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeB0TNs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 14:13:48 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:32942 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeB0TNr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 14:13:47 -0500
Received: by mail-wr0-f172.google.com with SMTP id s5so26039848wra.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=STKPl1/RCptSkhJFwEU9VmKMe7VXXoJPo2toWhpwq0A=;
        b=PSvKbUfoC5LemLpXYJQ0DrokJmd6nmXG8Wqym3wXZPHh61Gs2OFArSYsfaRoHlazIW
         rTvtcov4qN/nxtmeKQP7ohXfxKG+svhOPExB32qOrugfZpaQvLRPF/6/BKrSP6Jwce4X
         aY2AxjCQB6HueLwmWg3/Qlp5fUhawHM5Yu66OABpnBbNEXxu+Byo69pBr6yT1X8ON+wi
         CGEuJbMaG0H15JImKpzyYwZKGktQx05Bf8w7HNZSdcEGg+N/59UWYSnBMpf0x6n0ev+D
         KOR2RyC5RebTLLqEFLX6/ktn500nQtBYe7PmNbLRIywGQLCe1gF3rwcnsr8Wcoo1OL86
         PCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=STKPl1/RCptSkhJFwEU9VmKMe7VXXoJPo2toWhpwq0A=;
        b=MXzx4x/qskvW6QW2itXvNBsLgFOc9VWnllzVDlFnC5HT6qz0AWaSeWDEp+vfIppAVN
         5tAl/kN3dG7pX91nB1fSNceLU6D3XfXXvhKcyVhfwTDgHRW1Aci/iqEoeaq03Gsbtk5e
         snt7PQXFOQiYmnJawDLq1B7ZOIpRcE9YpXQUv5B+71es6Rzx9wi+ErsYd8oQVgVkVf/g
         1tCojxQBUCcg4X2hcdaYyDNy1gsW38ELX4uCWP68F5D2EFnysSpw18HpJqkkRdlULl3S
         /XpedO+Hemc9SJ1tKd/NSqHWHAG19lNmUVhnep5aPQJjXS1i+k/OVjq66CCTpQCiUTbz
         Qm4g==
X-Gm-Message-State: APf1xPCm2oszuK0GUk9RHaGB725T34AcCube28FFusuXKmzCiUfrsLOe
        FCp0ZNt8OOw+DCE9l+SXVFI=
X-Google-Smtp-Source: AH8x227PkLkPLD2N1Zd7x9nv5dTKPcWK2C4yyoeagdxQfyCkD0McF2OeYd9WoYVxSKCRipCoLtHFCw==
X-Received: by 10.223.189.8 with SMTP id j8mr14758040wrh.20.1519758826010;
        Tue, 27 Feb 2018 11:13:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u20sm13232997wru.94.2018.02.27.11.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 11:13:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEZ+a4aKvMbQpSeJWh5v_o+BAHhO7Az50Dr4nahH67y=g@mail.gmail.com>
Date:   Tue, 27 Feb 2018 11:13:44 -0800
In-Reply-To: <CABPp-BEZ+a4aKvMbQpSeJWh5v_o+BAHhO7Az50Dr4nahH67y=g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 23 Feb 2018 13:09:12 -0800")
Message-ID: <xmqq7eqyqm8n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> patches.  It's a trivial change and squashes cleanly, but if you're
> merging this series to next, I'm curious whether I should submit this
> change as a new patch on top of the series, if you'd prefer a full
> re-roll of the whole series, or something else.

If it is a trivial squash to just a few steps, sending them alone
and having me squash them would be the simplest, as that would give
a much better visibility to the last minute clean-ups these fixup
patches make to the reviewers than a reroll of the whole gargantuan
series.

Thanks.
