Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BCC20D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750912AbdE3Fw7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:52:59 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35190 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdE3Fw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:52:58 -0400
Received: by mail-pf0-f170.google.com with SMTP id n23so62165091pfb.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 22:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cHBzEnjfbUENOVa4uxalgcWeteX6Tz51e0QOkxB5QAE=;
        b=QMRRFSWODs5CLULHNa237v0ebw9QBB0lEWduVs9G3Z7FvX1e7hl0zJZ1UfoAE+RrdG
         UY28bjCdLijU3Gf9oGYavWR3T/3kJM7rLLdPkGXcQfNBKin859tGB9censK1TfOca05W
         5zKKlVV4qarRwmNDIv5sHzUWGVFmTd5Rj3dyH6U8ShwEggzH6rFgecAxBwa5NCS5Oi3u
         lJlrSilDHo5pn+cIBjWJqNRwSwoZju0tPYELMTVoG/GEJq6R7HVQ7oMqnMZswymTeRaC
         OVe3MBFLqkgWn1GExqO771nPIbIHh8FhyVU/8e6jTZOVo7EboIUchGw7lcnvu58Z59I8
         XcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cHBzEnjfbUENOVa4uxalgcWeteX6Tz51e0QOkxB5QAE=;
        b=BwD67o0roKNrt57JoCieH9PPU6TMY3+yHRKXZpTpHIGAVWYPSYVDDh67+r8SSGkxOQ
         dX/R5iyVqIYdBPZnakpyFI/3v/3xEVXZofj9XkQVPYjy5kXqyUlvwleoKb1TbdmTiM3k
         zemw8OdngtEU9tSmddFPKLT4i5gRK80az9FBcPLJXRMoLieiy0DjwOm775EJts/1ibjM
         h23/G3efzNzsNmM/TqtSw6OKC6l/YQTmv9DEB0Lzv+zgIPnXv18bK6xnpVv5W/Bs6nme
         UIaXI7ASvO3NSXeE3fQ7kp+Gtv7hbYyKldVDkGd083NeWdzY35EmBU/NVAlC547iaGud
         7jKA==
X-Gm-Message-State: AODbwcCR6nQPSXirBRmaeOM9T7sGqZSVSanoPUVrJX9RbuRoyjzC+kEs
        5e/6qhRi7iI7oA==
X-Received: by 10.98.139.21 with SMTP id j21mr21827952pfe.5.1496123577924;
        Mon, 29 May 2017 22:52:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id i17sm1107532pgn.60.2017.05.29.22.52.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 22:52:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] consistent "-h" handling in builtins
References: <20170529114518.dwlyayg5kfjjwtpx@macports.org>
        <CACBZZX4kfNhEOtgpFkWtuTZshJX+tX_Dogd6tk6qEuGX07JqiA@mail.gmail.com>
        <20170529153250.zq4qz3s5fmztc6ih@sigill.intra.peff.net>
        <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
Date:   Tue, 30 May 2017 14:52:56 +0900
In-Reply-To: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 30 May 2017 01:09:49 -0400")
Message-ID: <xmqq1sr6dh6v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The series was pretty straight-forward.  Thanks for working on this.
