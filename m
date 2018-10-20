Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E851F453
	for <e@80x24.org>; Sat, 20 Oct 2018 23:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeJUHl6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 03:41:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51915 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJUHl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 03:41:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so6760952wmf.1
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=z55d/Gx33ij6cTH4tbIJphOfMq/00PCG6x8oDdxaYqQ=;
        b=FPmmU/ghapFBQ5VR4KkVGQCf6INBuCwRpvkQ/NmzI5c9dAGftOzrRR/D1fdsoKzfLN
         Z77kUm6YuOC1+pH+KPKA6AfVuFyBit4gdee1mdrmU9YSjal9i5y3h4CwnAoPsULhcwil
         /FZGrYi8ukQYvcAal1+iVbz6zt9NOYLRff1DLmR3f5yiqXc7BH+nzMQNCGbQCEhU17QR
         o9+fcTXTXto7NfFXorqfSuNEmduPGEXr3aoqY3mXHdNg1gKUe5iTUMIJi274l8M4tWxV
         7+up85GtyOu1RCbu5b51I0CQ8V4tYHqEQmSZuaTwJ1YdZeNXK27/EykVIOxS/QlyXNod
         4Sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=z55d/Gx33ij6cTH4tbIJphOfMq/00PCG6x8oDdxaYqQ=;
        b=gp/tE1DBDK+tFbnBucwBa7wRnpTPWwPF1tMMoWn4wjpxQefeRDbeWayps3DAxugl1g
         44JFrJka7Mjsdes01NdxxsftFAa8vjWGKvD2NN0Cy9rsoppnJ9FvVm10CMGwBKWXWAQx
         s994zoxWqTp1/auNMZO2+nWF9/+7LkdjV/h0mZVuA+tMu56qAnE7E0WYUoPUkOxZYxKJ
         nGgiha6hhlG/DxVz+EnIXnXffPbiMQkIgTk0/hAsIZh4cFFoLuj6QMCNpJWWNcUXmnXi
         NIMVImYg15vSay/0z0OsG05qmHs83AzvjhUEqt+SmGREs0/+19TKAn1AneEgAj52Eleo
         PAaw==
X-Gm-Message-State: ABuFfoioObu83StFYXim/lQoGLX/EjON9LHO/BlUj+b/XwdfRvJBThI0
        CSR69LblyVuotvmgl0pJ1Nc=
X-Google-Smtp-Source: ACcGV61zQiWgGCszek58QlhVgnX1l1HrPpVX//6TDkyC26WYDhhLl4+o266CAzp7CFcl35D6roeHhg==
X-Received: by 2002:a1c:dac7:: with SMTP id r190-v6mr10469543wmg.137.1540078186536;
        Sat, 20 Oct 2018 16:29:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b5-v6sm25972068wrr.94.2018.10.20.16.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 16:29:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/59] Split config.txt
References: <20181020123848.2785-1-pclouds@gmail.com>
        <87d0s4ctds.fsf@evledraar.gmail.com>
Date:   Sun, 21 Oct 2018 08:29:44 +0900
In-Reply-To: <87d0s4ctds.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 20 Oct 2018 21:25:51 +0200")
Message-ID: <xmqqr2gkyz6f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I had a slight bias against this when you started this, since I'm one of
> these odd people who don't mind ~20k line files if the line count isn't
> contributing to inherent complexity, e.g. in the case of config.txt you
> could just use the search function all in one file.

After typing "less Documentation/config.txt" and realizing that I
have to open another file (which one?) to find how we described the
push.default config, I am already experiencing a lot stronger bias
against this.

But I know it will pass.  Once this ~60 patch series completes, my
irritation would peak, because at that point I would not be able to
even do "git grep push.config Documentation/config*", but I would no
longer be reaching for "less Documentation/config.txt" anymore at
that point.  Once Documentation/$group-config.txt (which I think is
a mistake) are renamed to Documentation/$something/$group.txt, then
I know I can do "less Doc<TAB>/$some<TAB>/$gro<TAB>" to get my ease
of use back.  There will still be an annoyance caused by having to
open another file when reading description of branch.<name>.merge in
branch-config.txt and seeing a reference to push.default, though.

And the end result makes it impossible to place a description of a
new variable in a wrong section.  It still is possible to mistakenly
insert a variable in a wrong place in the right section that
requires a fix like 8578037b ("config.txt: reorder blame stuff to
keep config keys sorted", 2018-08-04), but we do not fix all the
problems under the sky in one series ;-).

So after saying all of the above, I am moderately supportive of this
series.
