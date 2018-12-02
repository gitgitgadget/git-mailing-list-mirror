Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48FB211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 13:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeLBNYD (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 08:24:03 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33019 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeLBNYC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 08:24:02 -0500
Received: by mail-ed1-f43.google.com with SMTP id p6so210168eds.0
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 05:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ZeehG1syCZ/1ygvYddlEOKD+xULRUCF7svYL9AezPok=;
        b=R5nzEdAIdRZvI9FWbqNpie5RKLjZuAfKc4DPl+HqHLQv0KeEEPDEQBG+bLfkx+4vCD
         7SpZvT2wQhot6rhkp7olbGYWqBpFm6IceVkKzE74Z61jcPlks4BfiAGAUfE3K3qdMq4y
         WSGEDshi9wbg1dZCR2duBpH8tKCW7+5BwWWh3XSGtJvDM+6ZXQ7QcOBHfIIk+ko0nVEA
         q3m/GVI/voVSZ1/jT0cLS9AZWr12bBKbVmh4oU9K6lJ0KtH9QD59t11T+DvzlxvDq/36
         dQBVs3gmuzjCIQ2a6EVggerY+HRKiMZt7YAFVgq3IDrO2WIv/iwiwOHxUh59+1IqHryG
         Qj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ZeehG1syCZ/1ygvYddlEOKD+xULRUCF7svYL9AezPok=;
        b=Jb+zRGkfbGT8Pp4VJtdYYWmLzye54fg3FY4JxV14vfhBlzf6r+oU/2JX1NPV1Q/xGm
         85GaIJ8+bNACj8E7DnTug/gMnq+2Lfzg+3JeCbaLST8fD3xsm3dVYmSxwF0VpoR6KENP
         ESNTd+t0k4Jac8vaokk6mGtKm63h79Y+Ss0/tRmPRcfTb6w9MqV55kcDpY1xPd6F3uzp
         x5vjm5Dd5zXN4+40x837HxBpnKaPTsKDW9fVWpX47JJB6P+sgeuytG6vHW4+4caqL0Rf
         altUKMg3ADL59nkg8q5bue+A39PQmrt8biPU25t1zcni35I6xZbSzlLlTTyAdGVNoTSk
         gqMQ==
X-Gm-Message-State: AA+aEWYVx32yo2AyC/wKUZ/snpAmlgDcHOcYYW9IISU5plQ/QrXGTkah
        DaKB/MBzWwX/bWZydAl2qyc9uOxi
X-Google-Smtp-Source: AFSGD/WeHGRJvtHWjUtZJzF4RU8zKjYl7bMxFYkRRyr0jvZ+LyMRdqvr3gQZvBw8wJEewUEjARJWbw==
X-Received: by 2002:a17:906:3f87:: with SMTP id b7-v6mr10067922ejj.158.1543757038831;
        Sun, 02 Dec 2018 05:23:58 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id k31sm3204858ede.5.2018.12.02.05.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 05:23:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: easy way to demonstrate length of colliding SHA-1 prefixes?
References: <alpine.LFD.2.21.1812020647440.32023@localhost.localdomain>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.1812020647440.32023@localhost.localdomain>
Date:   Sun, 02 Dec 2018 14:23:56 +0100
Message-ID: <87y398uknn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 02 2018, Robert P. J. Day wrote:

>   as part of an upcoming git class i'm delivering, i thought it would
> be amusing to demonstrate the maximum length of colliding SHA-1
> prefixes in a repository (in my case, i use the linux kernel git repo
> for most of my examples).
>
>   is there a way to display the objects in the object database that
> clash in the longest object name SHA-1 prefix; i mean, short of
> manually listing all object names, running that through cut and sort
> and uniq and ... you get the idea.
>
>   is there a cute way to do that? thanks.

You'll always need to list them all. It's inherently an operation where
for each SHA-1 you need to search for other ones with that prefix up to
a given length.

Perhaps you've missed that you can use --abbrev=N for this, and just
grep for things that are loger than that N, e.g. for linux.git:

    git log --oneline --abbrev=10 --pretty=format:%h |
    grep -E -v '^.{10}$' |
    perl -pe 's/^(.{10}).*/$1/'

This will list the 4 objects that need more than 10 characters to be
shown unambiguously. If you then "git cat-file -t" them you'll get the
disambiguation help.
