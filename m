Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D299620373
	for <e@80x24.org>; Mon, 13 Mar 2017 19:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbdCMTWx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:22:53 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33854 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdCMTWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:22:46 -0400
Received: by mail-qk0-f193.google.com with SMTP id v125so38215529qkh.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 12:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mgA5vOXkHd/3gu8TFSZnLx1WARMhvciO3OCt1zwojCY=;
        b=aBBH43dw1xmbnNmtbCsjYY1ktSoDped2k2K09F2gSXENYqNa7ADtLjjH8GhdZUUnk+
         2mYU3Bo4B8FaPLzTe2Cz1si33eCak7YTBwhuNjqABz9eel+SPa64UktSPoOg3exVKaez
         sMgx/yeZtyYo9Av5c+UrXVcJ/JmxgDBghe+i/mA9uJJfhTxr2QQwBUpA3UdM5ocfymD+
         1DfbwjWVnEXrIBkQSNRdNXwiyyMLZMmZCyZcwLiiAtUV/qtXlGd79m3adPKywgFiMIOA
         /Q38K2p72ZZ9enOJ7gpyJUrHeAppH6tH0UrhCLd+WfseoeI+qs2w3slXiymrVGsOcret
         AB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mgA5vOXkHd/3gu8TFSZnLx1WARMhvciO3OCt1zwojCY=;
        b=lCS/sfaRHam9ClfXnEhuiJN10S8Dby5h5e4meWZuv5XVHc8DgjZmR96yhfueVx7CPK
         gB7oRxERAe88z7nENdvs8+9pKc1HS9BZOT5Ddv7Kybe0wAKM/xZ9nj6+EjvnC9aXn+x+
         1LxHA+kRnF/64CX4+L0AVRmRV2UwR9tLNSxE2vv9xgR+5q1Yzkjx5HM1vbu0QEJ2Fimt
         3E7a/K9o4teTUs9bPuSfEc023R5ipS9XRtPtcTnyewhJUl+4CGxVXFwsdU7snhmOIdGx
         wsxSBHgdX9QOyZCAMcCdSs0blIzBwuOol73N9hr69JvOjq+Spf7u3XX5hvTwL3cGc47A
         wKTw==
X-Gm-Message-State: AMke39mFgusKZHol0Lphg8q73U2hPMtoNhuMP/laAzCTFN/9BiqYfwyGJp4m3XDLKjoqGQ==
X-Received: by 10.55.154.9 with SMTP id c9mr32512517qke.293.1489432945683;
        Mon, 13 Mar 2017 12:22:25 -0700 (PDT)
Received: from dhcp-ccc-4425.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.gmail.com with ESMTPSA id f28sm12808666qtf.44.2017.03.13.12.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 12:22:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [GSoC][PATCH 2/3] credential-cache.c: Make git use XDG_CACHE_HOME
 for credentials
From:   Devin Lehmacher <lehmacdj@gmail.com>
In-Reply-To: <xmqqtw6xrquw.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 13 Mar 2017 15:22:24 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <520738BD-E3D4-46C5-8A6A-A8D2AE6CD233@gmail.com>
References: <20170313172232.96678-1-lehmacdj@gmail.com>
 <20170313172232.96678-3-lehmacdj@gmail.com>
 <xmqqtw6xrquw.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  I somehow feel that the order of precedence should be the other way
>  around, though.
>
>  If somebody really wants to use the xdg location and has a socket
>  already there, using that existing socket would be the right thing
>  to do.  However, when neither ~/.git-credential-cache/socket nor
>  ~/.cache/git/socket exists, why should we prefer the latter over the
>  former?

At least to me the latter feels superior. It keeps clutter out of the
home directory putting it in a directory with all other cache files from
other programs. If we continue to put the socket at
~/.git-credential-cache/socket by default then checking
~/.cache/git/credential/socket seems useless since the daemon will check
socket locations provided with =E2=80=94-socket anyways and there is no =
other
way to create the socket at the new location.

To me it would make sense to check the old location and if it is not=20
there then use the XDG location to follow that standard.=20

I guess that this is not the same behavior that git config =E2=80=94-globa=
l=20
(it will only put its configuration file there if .gitconfig is =
unreadable)
has right now though so we should stay consistent and reverse the =
precedence
here.

Thanks for the feedback,
Devin
