Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB2E20248
	for <e@80x24.org>; Mon,  8 Apr 2019 04:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfDHEi2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 00:38:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34707 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfDHEi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 00:38:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so14635903wrq.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 21:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FHr/a/PaedIhBK+6llTfeWcxq3UYZPnMFn/YfKtxHA0=;
        b=DDK2/q25+X0trVLsYbL7A1c6tWNvIR7LqVb3BVelu9gVRjjAvnhQab5tOakSIfPO4l
         HEEwny1nlq901yIq/qK6nOFjD7Qi2h7ShpDVIbAZUiYPp1PpRbVnpCVPRMaYBJMc2X9G
         w9Ynyu0XeEcnxEiTEHEvhk/jP2NyeP2ZNbJfDLIK5hh8FsG1Flq7TxjtHfoPK2zh3B5w
         6vqm5e5kRMpGl7AmTy2Gs1R+nbrTRzgTVfjHDIyvWp4r88m+DCkhbh3g6MlVtL3U3qIJ
         eOA/QTfUmUvoGcEfYZC0CkuXs7g0qWn7Slt2Yl9wckda3rCOl3TEmW19OCYdLjVuh9L1
         EKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FHr/a/PaedIhBK+6llTfeWcxq3UYZPnMFn/YfKtxHA0=;
        b=b+jz55yM02JKNInfIyFG6LgGhvh2VgeRkprbZJWaCKGdWF5yreaNIRnmcQawEtf+Fm
         GpEDicsMAxGTB9u4lQAKgFz5v68uxNid1+p867tnrdCXp8tf/WhbUH0lBtV3xZKaAaex
         xohg5Y0UIsYVtRFxUUsXyDAhg4brdm6O72Po7q5cpbrMxQu7ArkF4Q9UsH6JT+zre3u0
         2ObhZEsKb+UbFow4ZzZ+od/jUfznIc9txqcAjgsWT0JLNmw4w+XjjOsgU7+NJIRC8jYT
         9ovsHnH6m8233C1VwmIfTN+XExpXVnm9B4a/3q/gDxBt5WaackGT4BzMojA3xz/uk48+
         0csw==
X-Gm-Message-State: APjAAAWVpugqaMbsOeVHExINdEagRHl2q51l5+fjTswQyyktf6Q0+QN1
        lwPbMoI78i06jNv0mdZnisQ=
X-Google-Smtp-Source: APXvYqyPu/3+HWQCghBl0xMQ9Kg14kPh+23yV1a+/LhZMZmxbIiGG37RF7yy+ryjcjmXjHd68HK9iQ==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr5442553wrq.209.1554698306067;
        Sun, 07 Apr 2019 21:38:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v184sm20750201wma.6.2019.04.07.21.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 21:38:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/4] t3431: add rebase --fork-point tests
References: <20190328221745.GA3941@dev-l>
        <cover.1554151449.git.liu.denton@gmail.com>
        <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
        <20190405111513.GU32732@szeder.dev>
Date:   Mon, 08 Apr 2019 13:38:24 +0900
In-Reply-To: <20190405111513.GU32732@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 5 Apr 2019 13:15:13 +0200")
Message-ID: <xmqq4l79az7j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> +	test_expect_success "git rebase $@" "
>> +...
>> +		git rebase $@ &&
>> +...
>> +	"
>> +}
>> +
>> +test_rebase 'G F E D B A' ''
>
> It appears that this last empty argument triggers some bug in Bash
> v4.2 and older (and on macOS such an old Bash is the default /bin/sh),
> as it turns that empty argument into something else, which in turn
> fails the test with:
>
>   <...>
>   ++ git rebase $'\177'
>   fatal: invalid upstream '?'
>   error: last command exited with $?=128
>   not ok 2 - git rebase
>
> https://travis-ci.org/git/git/jobs/516070862#L2276

Yeah, every time I see $@ that appears in any form other than "$@"
(i.e. within a pair of double-quotes without anything else in it),
it makes me feel very uneasy.  Shouldn't the argument to the above
"rebase" be spelled $* instead?  I somehow do not think use of $@
there is buying us anything.

Of course, if we were really passing an arg with $IFS character in
it, we could probably eval 'git rebase "$@"' it (with appropriate
quoting to adjust for the surrounding quote pair).

> Omitting that empty argument avoids this issue, and the test still
> checks what it was supposed to.
>
>> +test_rebase 'G F D B A' '--onto D'
>> +test_rebase 'G F C E D B A' '--no-fork-point'
>> +test_rebase 'G F C D B A' '--no-fork-point --onto D'
>> +test_rebase 'G F E D B A' '--fork-point refs/heads/master'
>> +test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
>> +test_rebase 'G F C E D B A' 'refs/heads/master'
>> +test_rebase 'G F C D B A' '--onto D refs/heads/master'
>> +
>> +test_done
>> -- 
>> 2.21.0.695.gaf8658f249
>> 
