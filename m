Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2714C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 08:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiA0Iiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 03:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiA0Iiu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 03:38:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B93C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 00:38:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r7so1332719wmq.5
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 00:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=XFG4j0xjRYqEKn/CEy84tX1C3eqsPnPMS4cDPU7sp/Y=;
        b=ERh0OfGVQVgRud9a4eD4kEdedthCF7sfYDvFOAoeJGjobj3Qxey+4Fd7/FfJhWiaOm
         5GKNkhggjFFpwIbdp7EQHD2p9P7tHq6pv5YvxnvuxIRVBq/1byBo2ZJS3r+7AZyY4aR+
         83vPoQ/00TGRb32tCUPe5n+JMZYUyndMXJQfFHxaMfPCpqsSCDRqqm3liLtWpBwzSjDR
         kjdnT6HGxGZJD+MtGY3rzFMlbZJwxG9m1IFbo1rpPPhQ7+q/LEW40WEwlIoZ0wBE5al3
         iDIHEZ/vtnJl+eevGZXhvYyPB3YCEalgYasW/ENTp2vJG24Nplw9+Wv0BFn1wqLzkg+p
         mNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=XFG4j0xjRYqEKn/CEy84tX1C3eqsPnPMS4cDPU7sp/Y=;
        b=myJgd159c8sdHNGq3cNaBwIK6nxzmklI83Cayi8gYbDw9ugpds2R1i0web0/uqfoAd
         0z6N1uemeShbn/qV45I+QTNLMHbZhpwJyhhLK9qWiTGzWCRJXLmwmPzTjmWC2LRjT7N1
         zgroxUVTeOeh/vrRf5ZrIX3TCli8zHkPbgcMjskd6XC7RPH9tK9QWYXQco1yewA/Xym4
         X0UQ6v/vcbOKtp2/6xvD7LrhSjR9gBpCf1RUuQXXj6ympYRQgDrQWKCe2P8xlYfFSw/+
         O5eNYDUroF2zWkoE1a47tjd+1qyp8xgRhoSDLZ+tObDh/xvYJTX04mkXObwBVTm5TYT4
         Hrpw==
X-Gm-Message-State: AOAM531RgQftR7xu9UBRD+PRf2ULRvUNZfwSIpcpYGJPon89tGcOudqA
        0iAgY5zFo/BTnA5EVDWBdSEgsg==
X-Google-Smtp-Source: ABdhPJytIsU8bMV5ZQ+gpSPphb01XeNhGBjvulxWJTa7vFQkZYv4Ox9NXrRBWSUk/20xyuUCwLOJvA==
X-Received: by 2002:a05:600c:5118:: with SMTP id o24mr2311645wms.153.1643272729007;
        Thu, 27 Jan 2022 00:38:49 -0800 (PST)
Received: from localhost (2a01cb000f483e003b320a5f125af7b5.ipv6.abo.wanadoo.fr. [2a01:cb00:f48:3e00:3b32:a5f:125a:f7b5])
        by smtp.gmail.com with ESMTPSA id e10sm1853490wrq.53.2022.01.27.00.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 00:38:48 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 27 Jan 2022 09:38:47 +0100
Message-Id: <CHGBKD7TF1S5.3VUMATFQPY9TE@diabtop>
Cc:     "Git List" <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Patryk Obara" <patryk.obara@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Jiang Xin" <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: add option to interrupt pre-receive
 when client exits
From:   "Robin Jarry" <robin.jarry@6wind.com>
To:     "Jiang Xin" <worldhello.net@gmail.com>
X-Mailer: aerc/0.7.1-30-g7edcc9f79409
References: <20220125095445.1796938-1-robin.jarry@6wind.com>
 <20220126214438.3066132-1-robin.jarry@6wind.com>
 <CANYiYbGME-=w4raiwW3w1_gHzVpsvdStz7xVpKqAwx2r_Vezzw@mail.gmail.com>
In-Reply-To: <CANYiYbGME-=w4raiwW3w1_gHzVpsvdStz7xVpKqAwx2r_Vezzw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin, Jan 27, 2022 at 04:21:
> Can we use a flag instead of hook_pid to distinguish the source of the
> SIGPIPE signal?
> 1. "pre-receive" hook exits early without consuming stdin.
> 2. "pre-receive" hook hangs after receiving commands from stdin, until
> client quits by receiving a "ctrl-c".

Also there is:

3. the client has exited and receive-pack got SIGPIPE while forwarding
   pre-receive output in the socket.

I don't think we can differentiate from these three situations from the
receive-pack point of view.

However, using a flag in the signal handler to note that SIGPIPE was
received (for whatever reason) may be better than my current
implementation.

> Can we let the signal handler in "pre-receive" to do it job? And we
> can show some user friendly error message here. E.g.:
>
>     die("broken pipe: seems like the pre-receive hook exits early
> without consuming its stdin");

If that flag is set after pre-receive has exited, we can indeed:

    die("broken pipe: ...").

Of course, if 3. the error message will never reach the client.
