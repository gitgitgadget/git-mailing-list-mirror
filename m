Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDE61F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeGLQoH (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:44:07 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55968 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQoG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:44:06 -0400
Received: by mail-wm0-f53.google.com with SMTP id v128-v6so6192906wme.5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QnRO2FlNwrbBtEUDVgMuczZ9z+L/UTAYxRvQa/C/Id8=;
        b=aXMdH/1ZMANU4aCRSy7VfUiyZJpSV6thwu4hdqlJr8wwgS9yyfOBjvWNekUWpIin4g
         ukFCGToOVgz+9NrrCjY87aYtPzq12ASM/M3B1eaOw/W2fr54O5hnIwdVQys9mbTaKvuM
         skD0VLnNu/94t0yd7IPNSvXKzJqgt2PJ8tMk/t2MwRUF7DUjASZNYicggBVo9xqAnpA7
         EIL0a88Gaal7Nav/FaCSYqnwwgKjId+msVk4G4ILOIoXhAo41MkAOr+JON+sgLwjUsGO
         WsOjeoYfPW2Kz6R9n5QhI9OqJ1UMmMnIKvmyaWy5x8CCCBcXPSWRHE4HV8/ATf8gFfEN
         QHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QnRO2FlNwrbBtEUDVgMuczZ9z+L/UTAYxRvQa/C/Id8=;
        b=c7bXB/NO/y8rwgm4JX5plpT15IofUacZA3LGHgD0LRWo5d+tJd6gYTUV+tgO8u66xd
         3SMXeZs2r+mCKNAmB2gnhj7ZCGzVx0EoMMzpbW5eAgfLK9MKTgCWWJVMDVgKk2p9oJqt
         8wrBsNoTJ3qDHG92ZvWr05LZpsIFiIZfqVTQ8HXPhK+Z9mz1ACK1ky3n2Xvf5wrHDHoj
         YcCpym9AtrmRKcCdm+OGHIxsJbZbzk2iMM6FqUBFcSFZ2eb3IReNO5sQdMoO/vDO7kae
         pVL40f2OGT4dHlUbEf1uIcVEU6XcsDKZ+KK3DkMZfO1IzHtwpRGg8ftAXHQMJm+qQZpc
         mikg==
X-Gm-Message-State: AOUpUlEGVCAe9+yojuN9KY3+C2H/ns61lXJUzBcFpcuihwetmWk866cz
        630gJhNrzZFPi7XJM+qNvec=
X-Google-Smtp-Source: AAOMgpeGXHmGY3TCm8kCn8VRuOyxFCMxfJVRfTnYrA1If5mn62j7+aub+A2cey9v/K8IrvVDXU/HQg==
X-Received: by 2002:a1c:1252:: with SMTP id 79-v6mr1750225wms.70.1531413228208;
        Thu, 12 Jul 2018 09:33:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j131-v6sm6162131wmb.35.2018.07.12.09.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 09:33:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v1] handle lower case drive letters on Windows
References: <20180711175420.16940-1-benpeart@microsoft.com>
        <nycvar.QRO.7.76.6.1807121556030.75@tvgsbejvaqbjf.bet>
Date:   Thu, 12 Jul 2018 09:33:47 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807121556030.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 12 Jul 2018 15:59:30 +0200 (DST)")
Message-ID: <xmqqh8l4za50.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So maybe a much better idea is to use our `has_dos_drive_prefix()`
> function:
>
> 	if (!has_dos_drive_prefix(Buffer))
> 		return error("'%s': invalid drive letter", Buffer);

"'%s': path without valid drive prefix", you mean?
