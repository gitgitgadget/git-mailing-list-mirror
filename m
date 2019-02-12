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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAB91F453
	for <e@80x24.org>; Tue, 12 Feb 2019 13:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfBLNPA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 08:15:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33094 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfBLNO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 08:14:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id h22so1346599wmb.0
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 05:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3iYWJIfdnaByTVh8zpe9w9lgv5ozy+41iqLVdyMfEds=;
        b=gqU4zd26sxYV5jWXCa+t+i3t1HZ323b9CtNVpjTztaDm5IMg5xJNG32f5mbuSAK+8K
         zYWLJgKwV5CwUekB7ATSXywIVJsHUsISt2yRhkmyZxQnzpwAJJJp+hniVo6QjbgkYpB4
         8Oay6JFKSGzZbJ1c5joU6rJQRz2kollHkJoc9127xXifsV6OFmRgonhiMH2fQ/EYvd7+
         1Vwl+uI9f33NF672yfkaB67NZtekIvsiK4U9yyhtEEGcgDbgqEDhPpcybbOcQaX/k7OK
         6/0TC+TzeOXjoeaN1Tk4ZZ1QF7a/d9qMwp0148Z3Xi+3qi7q/qU9pIGuDQPpXCYt9zY6
         MF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3iYWJIfdnaByTVh8zpe9w9lgv5ozy+41iqLVdyMfEds=;
        b=CRt0BESt9yuOTGgybT1wTRltlTho4ZkAS+yN8JQeSxR6x4HUmMcnYiO/93CdlsgOM2
         4/Mj4jf+KAwAWpdPHZKKOydfLC85AW68+2X81sTQ141MP1PXj8mi2kYRlg321bO5DO9c
         TKD8UplwS1lLYQs69EXD0s/Pv5/lqerPNAl/hzJj4SuNCwjHWN3Jf9JpQHEBD5yX5X2a
         K3oxMGP5n63B92yUr6bsPAopXuGzFgIa+gXUsbi/5mwSZtqpaBZ6oV9nKR568MWHNTCc
         qyATl8fJ55q+yyqRf3kVB8f0VWgLJ6SVNNIEvRdG0ad2bpkvQQyC/E3FmoWGNz72ZfjT
         JPLA==
X-Gm-Message-State: AHQUAuZduzpG7cWPJqFU51kQO7q6AUaHjR4NsIgyG75ZFeIj3RBZhEM7
        PSqMc3VyftJm0VKQSVot6/A=
X-Google-Smtp-Source: AHgI3IbS0H1E0J8iGINMVibSXSDzxlbrZ/QdSlOksxafh8uIjUuWuOtVWB7tCt1OybeKYEnjqnwHXQ==
X-Received: by 2002:a1c:d18a:: with SMTP id i132mr2867372wmg.27.1549977297703;
        Tue, 12 Feb 2019 05:14:57 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id 65sm43369836wrb.62.2019.02.12.05.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 05:14:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com> <87sgwtjjbk.fsf@evledraar.gmail.com> <20190212124323.GA11677@ash> <CACsJy8D-FVGXHbqKf8BAVWEFchbF5LAN6x8UM5g7v_HLO29CLQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8D-FVGXHbqKf8BAVWEFchbF5LAN6x8UM5g7v_HLO29CLQ@mail.gmail.com>
Date:   Tue, 12 Feb 2019 14:14:56 +0100
Message-ID: <87pnrxjghb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, Duy Nguyen wrote:

> On Tue, Feb 12, 2019 at 7:43 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> The test failures on NetBSD and Solaris/Sparc, not sure if we can do
>> anything without test logs or access to these systems.
>
> Actually if you could tweak your ci script a bit to run tests with -v,
> that would help.

I vaguely remember doing that and running into some issue where it
truncated the output, so e.g. I wouldn't see compile warnings on AIX
because of the firehose of subsequent test output.

But yeah, having this in some smart way would be great. I'd be most keen
to just work towards offloading this to some smarter test runner as
noted to Johannes upthread.

I.e. a good test_for(SHA1, params) function would run the tests with
"prove", and e.g. spot that tests so-and-so failed, and then run those
specific ones with -v -x.

That's how I was going to fix the log overflow problem, but I'd much
rather not continue hacking on this gitlab-gccfarm-specific thing, and
instead work towards something more general.
