Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5152F1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 17:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeI2XlG (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 19:41:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41458 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbeI2XlG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 19:41:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id j15-v6so9461094wrt.8
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=szg3uJcXFKtiPAHZaS5jAvzuReZKNT7vqtlbBxhu0Gs=;
        b=fxX642TWE4Zh8mg1qDFamcjChC7M9vU/qlXDK/xfYlPXUj38fns5NmYtMp+Rsn9Gzo
         s7v4A71dV2NaHq1OzQDnEN3ya5+sj5rp+dZkwb5FWJ/V1UVDkkITdfuDVYR0NwG9M1Nk
         Cnv+EZJUxCDqd3MfIax93AFKQjP7qV87TmK69TrD/W/Dg3PBqmdL4IvMG7CpcilwH9gZ
         xmWJ5f89xFIt/Q2uiEeIM6R5nHG8SnGrcmangRz2PsClVGljQjlo0fKzTg7iI71QyLoZ
         R4Aznuxnp5xRdVF164kAZ3X7gku7sSSCXOJbXkSp6vqx8ittf+PA6Pdxo2R8lLsVLqTr
         tHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=szg3uJcXFKtiPAHZaS5jAvzuReZKNT7vqtlbBxhu0Gs=;
        b=n1FhBYuKF2jrq4jQHH9nsptPVEpNJ2Jqw42FmOmiNiVTFdWTkZTROFQfO2Y2qs+A+M
         SZbgHOmLihPlRWf2ukj7iDjNJ8JruyxCRIVc8zpFgkEKzpF6wzsnS0fVFCXbZ+1RoBg3
         lazGZLYXCyT3geX2Rr3yqslEjnDWd4A5Y4sUN7J1g/LrN29/MXIQ+u4jdZjh60P/mCug
         h4+slm7a1C6cOZPSJ69s2H4kuLDah2ODhJAF8ym2Xwxc8EkE0bnZNlUrJAXDnFAzjGue
         ZAHZI3v364ccPxrQj/XFeHOK8DnNU2w21GH+lbejkrE55tKoN5ZFIKH/nVpSoDBJ4RAm
         Q56A==
X-Gm-Message-State: ABuFfogdvnetZeotK2Vnkth80Vr5CEhKmuXPOaOElrSq/mPJSUpd4GhE
        yJSTB5XkT8/3vJ2IV5Yvo8k=
X-Google-Smtp-Source: ACcGV63AJk0DPEZ5i5A5MpeLZEsYCwCZUBQmhTXe0uPISuVblosRNzvabdEcg5I4Kv8uwoMjujUi9w==
X-Received: by 2002:adf:a29d:: with SMTP id s29-v6mr2436791wra.100.1538241113012;
        Sat, 29 Sep 2018 10:11:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i131-v6sm4687408wmg.26.2018.09.29.10.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 10:11:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Christoph Berg <myon@debian.org>
Subject: Re: [PATCH] grep: provide a noop --recursive option
References: <20180929140132.GA31238@msg.df7cb.de>
        <20180929145527.23444-1-avarab@gmail.com>
Date:   Sat, 29 Sep 2018 10:11:51 -0700
In-Reply-To: <20180929145527.23444-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 29 Sep 2018 14:55:27 +0000")
Message-ID: <xmqq8t3k9qjs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> This --recursive (-r) option does nothing, and is purely here to
> appease people who have "grep -r ..." burned into their muscle memory.
>
> Requested-by: Christoph Berg <myon@debian.org>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

I personally am not all that sympathetic to the "'git grep' and
'grep' sound similar, so even though it won't do anything useful
just add a synonym to noop" line of reasoning.  That will lead to
sloppy noop, and will invite unbound amount of busywork to deal with
future complaints like "oh, but 'grep GNU COPYING' does not give
useless filename in front like the same command line with 'git'
prefixed; please fix 'git grep'" (which we'd have to say "no",
wasting our time).

I however do not mind if we added "--recursive" with matching
"--no-recursive", and

 - made "--recursive" the default (obviously)

 - made "--no-recursive" a synonym to setting the recursion limit
   to "never recurse"

 - and made "--recursive" a synonym to setting the recursion limit
   to "infinity".

That would be more work than this patch.  But if I see "--recursive"
advertised as a feature, and the command by default goes recursive,
I do expect to be able to tell it not to recurse.

I also expect folks who are used to "git grep --re<TAB>" to summon
the only option of the command that begins with that prefix to start
complaining that they now have to type "--recurs<TAB>" instead.  I
am not solving that with the above suggestion to improve the
suggested "noop".
