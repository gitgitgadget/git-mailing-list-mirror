Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623221F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeB1TCn (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:02:43 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36537 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeB1TCm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:02:42 -0500
Received: by mail-wr0-f196.google.com with SMTP id v111so3568359wrb.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W+ewCIUu0Hq2qxFYo/22XdDw4IjQ3E/T69w0FVkVD+o=;
        b=UqZwnLw038KYGiIuOwn3M8yOxEXf0SFqOsisIQg0XozPs4483/xHVYnznkjRC1RL1u
         O0yZj5c9qQ5yDZ3wONRkgQi2Zea0R/Kam4qlqY/4fIExnqDnSNge1m/3nZfILr6Ic6VE
         cRkQNCLUarXIRRkykR0PoVOQf9zFEVQFruhFoZViieTNVesHSolVBPFiC7L2n80rkLzx
         5TipvrHnaSx4Lq3uy86x4YnuLnal7vWkgueOxCGZNhxVvQ3lVeGGdgj1MAW2bbUeHasG
         sKAMsgxwJLpmf/TIX7oXv69bqmITUWaUzO8zMX93uuosZGDFLyou1ftYbhZBlJteUPhH
         NDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W+ewCIUu0Hq2qxFYo/22XdDw4IjQ3E/T69w0FVkVD+o=;
        b=UvoH15gwnYLfkiHT6V27JCH0Qp7fkrMDIanWeERIywmzZgBRcFh85rt6ltE5jMzNuK
         h1AM4oUURuMhuIJqBOOQq/r5wIfJS8v5ZunXCAn4zr4aIj2zqfgfDEpM+42QlqtuLrQn
         rO7MkywIzLjCI8Jc6euPB/1RgByW2B14NaOuj/8L4EVODzoH/EJl/r6X4Bj7Y/74t5mn
         v8AFu1jEpg3OY7s8/nPZxUEhWSkvwVmL01RO6ryJ7P5cdCbMSBE1Ejp9wPDonPAHR6+1
         B7ZJs7++EXXCFTIf+rr23ddKvcS1GV0l41qF3GWOBUXjIN+SadBoO5e9Gu5NheEinXlU
         LEew==
X-Gm-Message-State: APf1xPDqOVSkYQ9RxgFkPKB9xQ5qO907oAHy4ir40cN0BRQPMgZ6jjtl
        eKu50+Qd1zSCwzfiXlM/UMk=
X-Google-Smtp-Source: AH8x227z2aEa6mbmpmWInJabGwNT8n61mtWTtmMQ6x7hCA/Y79HeCwysONa8IpuwNBfgXXkl5Lob4w==
X-Received: by 10.223.160.67 with SMTP id l3mr15667316wrl.201.1519844560660;
        Wed, 28 Feb 2018 11:02:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v9sm2028443wre.8.2018.02.28.11.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 11:02:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH 00/11] Moving global state into the repository object (part 2)
References: <20180228010608.215505-1-sbeller@google.com>
        <xmqq371lm1zd.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 28 Feb 2018 11:02:39 -0800
In-Reply-To: <xmqq371lm1zd.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 28 Feb 2018 09:57:10 -0800")
Message-ID: <xmqq7eqxkkds.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> This applies on top of origin/sb/object-store and is the continuation of
>> that series, adding the repository as a context argument to functions.
>
> Wait a minute.  Is that topic ever shown to work well together with
> other topics in flight and are now ready to be built upon?  I had an
> impression that it is just starting to get serious reviews.  
>
> Sorry, but I am behind ;-)

OK, so I finally picked up the last round, which wasn't even in my
private build.  I had the previous round but hadn't convinced myself
that my conflict resolution with other topics in flight that were
still mushy was correct, so it was out of 'pu', but at least it was
in my tree, so that is where my impression came from.

I saw that the way a list-head in a repository is initialized has
been revamped in v4, which looked sensible.  Will merge it to 'pu'
so that I can pick up the ignore-env removal from Duy.

