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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EEF6211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 13:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbeLBNZw (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 08:25:52 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33097 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeLBNZw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 08:25:52 -0500
Received: by mail-ed1-f50.google.com with SMTP id p6so212063eds.0
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 05:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=B+i/QbGU9vlYctI0MZrKwyOd056V8kdG3YC61jiFUPs=;
        b=Fa5N5w4OxuW3BY1aVvIrzLJDJWOHkwMle+h2wHlXEb6hJK6oJC7X9RZvKbfmM7Lb8R
         eZ3rY7RZ23Ct4/cukuKcuoGyStSGw5YDvxB3fMhK2r1A+lFyZKbDmAB+58hPRKyPAORJ
         bkuJU94M1jvvfg1uKb8XhLWMhtR1ggF8P5LfH8Td91aPaOmQo5Ee9Onj1mWQda6SrUXf
         A8nSqfwFdQJzMxBzVFMR8JmFS2oMp4X3S1EeEdkUhL8w08x5BpL6KXV/Q/ZdFVqq5QL6
         YH+nFi4dyP9v7FqGaHjtBAcdjeZ0ilHxd/WT00WFZGuDa2VUSYuTotlzuZi7s+y8qrlR
         BeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=B+i/QbGU9vlYctI0MZrKwyOd056V8kdG3YC61jiFUPs=;
        b=V9pyIsb5+bWZ4axqkqDYadEXX6prxJRGu4bEORbMODyUPwbrjtrgasucX5AOYafZ8o
         mb53g5bQJEfVqvoZERstQHtXtdCh3ao06FCK4zb/xcEPNvmmRIFyxVSjj4DDumUBhx0T
         wGYEMNUyj3EYbGj9ebhiI158wylxFyhzw/omjzGx/REY3F3VTfeYEMNrv7NEO1VFXQ9e
         V9BqkEmUaTm9lnaSyPxPrdRayBl/iwamcEOYxBQjdhdhp6+2cTrZ20rZhwUsG6y5b04e
         gwIvgUxEqU/nkB65YB3WnzyYil6Td9YfTaMcKwYY4bmns/vDzgNu6RbIzoNXVvtYzbmV
         LqUg==
X-Gm-Message-State: AA+aEWb4vvYhbJpMhDrNuMQ7lIRb0yhnU+IV6c48pdTZKNK463BJIJE0
        9h9J/7QIZt57dSGEVYw+myI4ERbc
X-Google-Smtp-Source: AFSGD/WT6gc7UZjAPyERfyH7IqWUIlDSdf9ahDyyh2KLJHl+uYnxTimBDGJ6opTkZU7TB/p/iTAQXQ==
X-Received: by 2002:a50:b54e:: with SMTP id z14mr11418234edd.239.1543757147257;
        Sun, 02 Dec 2018 05:25:47 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id y16sm2968835edb.41.2018.12.02.05.25.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 05:25:46 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Cameron Boehmer <cameron.boehmer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] git clean --local
References: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com>
Date:   Sun, 02 Dec 2018 14:25:45 +0100
Message-ID: <87woosukkm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 01 2018, Cameron Boehmer wrote:

> 1) add a new flag
> -l, --local
>     Do not consult git config --global core.excludesFile in
> determining what files git ignores. This is useful in conjunction with
> -x/-X to preserve user files while removing build artifacts.

Or perhaps a general flag to ignore configuration would be useful for
such cases, see
https://public-inbox.org/git/87zhtqvm66.fsf@evledraar.gmail.com/
