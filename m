Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A621F453
	for <e@80x24.org>; Thu,  7 Feb 2019 08:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfBGIhU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 03:37:20 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:46501 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBGIhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 03:37:20 -0500
Received: by mail-ed1-f54.google.com with SMTP id o10so8245244edt.13
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 00:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=B/6r0+SK/cK9uMSsvSXpsH5mI5/WmeGT2tNB8T4vtHM=;
        b=LD3gqIrPwFVdnT8dFZpUm7ubvo1CBmT4iKhr0Y4g5OoUtDIwX9dwPBD7DMq6NwlHWl
         pF3ki8R3/pRTELRnl0ok3TLe1J2Pw0l5Fw9SsU5iGHOvzh1aaRDb5u4sHYLS8WnbCxJj
         U15FYuoELqoMIaI/irvcw980wnTepQj0Sfb/urCtu5Q86d+hcjiTvkA94Wnscj1cgLO3
         r1a6EBHIwCcQ4hxqaU2cKBdjlECIYYI1eJZ2yP4KyAaL5D8Og2BsLQz/EGmbhUF9b9nA
         DFRuVHIRs3OGV+IVSNdlRkfoiMHr5lb4XoOOWv2nCbLyScVpAH7R+vaA5gh1f9/NQ1Wp
         pHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=B/6r0+SK/cK9uMSsvSXpsH5mI5/WmeGT2tNB8T4vtHM=;
        b=BjpYcttXz2XzCZrjb/FstRslWwZqe59NgI23i5JykJ3pnA5MxTnYJAt0b1V9iX9m3l
         fdJ/yAZZ3L63OTZENgPPezOlcrFTtebw1/FsXBgrfWUjL7JcIBl+ovCB1/4oAoV7JYR+
         Rt+/MQ3JeGN2J4nB0WNv09D2dg4xq7PDMLvHjLd5l0xm7jqBbrsLsaCrbZa5Vyk3gibQ
         3gmqiS+JEfavi/JJxK1vEtafOVHvg9u7rHQ3IO6/hHhziVjVbpCuoKvjtywMK0vewo0H
         NmcPFCGWajguVIE3DYO9r417QwRXcj3A/yijpeFRQNYFl4QEbg1xOPqdgZVU9GukVT4u
         YLwA==
X-Gm-Message-State: AHQUAua0PIUxGUAjpE1xm4XO6GU2suJMq9o5UaSORC+jvj3EjosLp2IP
        qo7r++ISiUcodcm5zRLSHTSxU7Tm
X-Google-Smtp-Source: AHgI3IYTcuqEP9cNypVkFDFXpHjDoYuhXoWetzX8XiV+rD9QfrCu6fUHlNVMMYRqbk5B+HjPEyZsig==
X-Received: by 2002:a50:c11a:: with SMTP id l26mr11600390edf.233.1549528638436;
        Thu, 07 Feb 2019 00:37:18 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id i24sm6515028edq.0.2019.02.07.00.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 00:37:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victor Porton <porton@narod.ru>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: Output should push to different servers in parallel
References: <173ed6e2-7f33-62a0-e1bd-f4663e68490e@narod.ru>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <173ed6e2-7f33-62a0-e1bd-f4663e68490e@narod.ru>
Date:   Thu, 07 Feb 2019 09:37:16 +0100
Message-ID: <878syskn9f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 06 2019, Victor Porton wrote:

> I experienced a slowdown in Git pushing when I push to more than one server.
>
> I propose:
>
> Run push to several servers in parallel.
>
> Not to mix the output, nevertheless serialize the output, that is for
> example cache the output of the second server push and start to output
> it immediately after the first server push is finished.
>
> This approach combines the advantages of the current way (I suppose it
> is so) to serialize pushes: first push to the first server, then to
> the second, etc. and of my idea to push in parallel.
>
> I think the best way would be use multithreading, but multiprocessing
> would be a good quick solution.

This seems like a reasonable idea, until such time as someone submits
patches to implement this in git you can do this with some invocation of
GNU parallel -k, i.e. operate on N remotes in parallel, and use the -k
option to buffer up all their output and present it in sequence.
