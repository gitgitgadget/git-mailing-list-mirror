Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F091F404
	for <e@80x24.org>; Mon,  5 Feb 2018 19:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBETzz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 14:55:55 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35978 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeBETzz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 14:55:55 -0500
Received: by mail-wr0-f181.google.com with SMTP id y3so21067972wrh.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 11:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wWh36EYCWR7S3v+GlooMeKBJslrkMkEwrzEt24kun7I=;
        b=TpqfWAurx+RtEIwGG8ld3gAERRa+CIilF/mreOk84Z7BgBkI8f3rDGYWg2f0pH2Ybr
         HsdY2UIH1OpnzNCmTH3QBX8CFhVR0MneKkoohGbO0Ej4dYvCu42TrAo0SLn9/V4Q0bG6
         nInsiWjRndb4dy79BnTBMlc8uSNhK+4GVqlGVtT4ZAy5onmPS9RVDkHJG6y6ucv0A6Fm
         nr68BVd/vnMkF1UtOzoKVq7twvZxQdjhicsY+sILPHx585RBTZusqZp6DSqLQzp+SiZ1
         GaLMayFaDKtKHEr4VyJg8rZUeOuaXjwz9o2q6PIb9O7P9craFj+gxNrdoa5+VdUwB2rT
         U2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wWh36EYCWR7S3v+GlooMeKBJslrkMkEwrzEt24kun7I=;
        b=HbuS/ctn6xk4WijYOqghS2iDsYzXne1+6qpRjBImpdZlzuzcJge0hEnj4b23SYlGVf
         qCpDfMuizDCZVfcPU+54jMkyoCHI3Bq3RO9TOH2rcAxKtec+0GtHqhXFOyRbL6Hch7za
         XIbTp6mbmEhsYsnH3ND1LVGckE/KLR8uufuJ4GbK9JRlEfdkVfgwvR6jyhDm/KtklUT8
         0ABMfbRIgOaTLZhn2+8wQQS7+uUVV6tC4odl+zmMosBF4qHcvpchBJ2Zw7+y430tH29Z
         cVBuCe8NoOsfs4KRNlwIwJApEdZRTBKHIcsCexQBJilIsq48qwjrjkH4l+OCyxLLoXxE
         +xFA==
X-Gm-Message-State: AKwxyte94QPNCxpUQQ4oh31HeqwHed0E/1psShO+bg60oIePaR7aHsV7
        hnWhd6hgqhJC9bB0oqpBl7OsY9YE
X-Google-Smtp-Source: AH8x225JGZiLPkb79/WNi6MI91LOQt8igU1cJKyNlMO6ce+gxTgAoyw5Jx4jbAwhkLF5J/fPw5QgVg==
X-Received: by 10.223.171.3 with SMTP id q3mr13770301wrc.64.1517860553551;
        Mon, 05 Feb 2018 11:55:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j31sm13179664wra.97.2018.02.05.11.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 11:55:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick '-m' curiosity
References: <87wozry7z4.fsf@javad.com>
Date:   Mon, 05 Feb 2018 11:55:51 -0800
In-Reply-To: <87wozry7z4.fsf@javad.com> (Sergey Organov's message of "Mon, 05
        Feb 2018 14:46:39 +0300")
Message-ID: <xmqqtvuv9po8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Isn't it always the case that "mainline" is the first parent, as that's
> how "git merge" happens to work?

You may not be merging into the "mainline" in the first place.

Imagine forking two topics at the same commit on the mainline, and
merging these two topics of equal importance together into a single
bigger topic, before asking the mainline to pull the whole.

    $ git checkout mainline
    $ git tag fork-point
    $ git checkout -b frontend-topic fork-point
    $ work work work
    $ git checkout -b backend-topic fork-point
    $ work work work
    $ git checkout -b combined
    $ git merge frontend-topic
    $ git tag merged

The backend-topic may be recorded as the first-parent of the
resulting merge, but logically the two topics are of equal footing,
so merge^1..merge and merge^2..merge are both equally interesting.



