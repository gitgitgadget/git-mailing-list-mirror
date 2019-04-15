Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C19420248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfDONpV (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:45:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37754 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDONpV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:45:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so20570591wmf.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wF3DFg5nU/pMREFUKVeWo3kzkLJLxJydFFzKbdZMNrM=;
        b=PSq3lJ8EaeRdYq4FAzpTm785gHBD4BgdOWyzLmJBVGLRyMBQPFfz76mPwkh6UyI7cv
         MMtxRbye1jZZ4SFTaaVkP7yr4fKcjZBnSS/dS+y6r7jaw8lDpQ6AFoqD0lO+7zSu94nx
         2k1o7D28Pjtd383AEzYXj4Rn1lz1iMC8ZDYj9uEO4W5aj3tjI5V+Z1CLRzkMV4R4M0S7
         3WJLJa7muVifdcWCvsVYZwWc5DICzqr2fRYTiA+FYvwY4vpiH5TN6cyGCAwM+L1cMzQp
         wjYqP3hi3ltusdlMIh/09toARfUHGu4u/rRua2BolMXJGuDkyH7WFf2fHoeDtBPooEyv
         p94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wF3DFg5nU/pMREFUKVeWo3kzkLJLxJydFFzKbdZMNrM=;
        b=fjmCDfIC6NDd/zHEns8BUhe9YD2Qdkw+jZt29mZpbaOpKSNhLfc4u599bVe0i3CcMX
         wgYcPZSKYxT6Su03fqZyA4RjBRS2Asxxe4Sp32fBr9Jny4Nk77I5+rqtZot4d2rQ4ojM
         iy0DMuk/719NGvGEj0/Uph74givdhDmB9/5Jh8yTDhg3UTabEjExGfFGKg3zdKwU0qtB
         8ab+X81wZBw85qgay89oH7SOXCFvRI+I7yBiJgJjsM0+vRjndrgqFRcDXy1RXvXEW2G6
         YXFyueCwLLhLUEMIgS+H2ML/ybIVUeAa3Esx2z6z9TgwebDomEEv1HK+hGJwfrIg5oCY
         CD5Q==
X-Gm-Message-State: APjAAAW5Ro+g02SdIFmozVnlX2fzjPZ45A6Lmj/4VArcvFZRH5b6upGh
        Qz1S8olUryJV0IBHd5XEub8=
X-Google-Smtp-Source: APXvYqyLl2LkePccsNBbgRLF1uda039Ak7RIGoofHQkjVM06LiqTHJ6AGJqac19RAEpYjQeOaxnS0A==
X-Received: by 2002:a1c:244:: with SMTP id 65mr22904672wmc.42.1555335919401;
        Mon, 15 Apr 2019 06:45:19 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 13sm19523590wmf.23.2019.04.15.06.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 06:45:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 8/8] tests: disallow the use of abbreviated options (by default)
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
        <a27d316855a833aa1726fc20c905dc40e41adf2f.1555061837.git.gitgitgadget@gmail.com>
        <xmqqv9zhwbxt.fsf@gitster-ct.c.googlers.com>
        <xmqqy34cugdj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1904151509020.44@tvgsbejvaqbjf.bet>
Date:   Mon, 15 Apr 2019 22:45:17 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1904151509020.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 15 Apr 2019 15:09:52 +0200 (CEST)")
Message-ID: <xmqqef63qt5e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 15 Apr 2019, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>
>> > Do you mean more like
>> > ...
>> > I think I can agree with either of the two positions...
>>
>> I am guessing from the earlier iteration that you wanted to say
>> "unless it is given explicitly, we turn it on".
>>
>> As this last-minute style update that was botched, and a typofix in
>> the proposed log message in 8/8, are the only differences, let me
>> locally fix 8/8 up and replace it.
>
> Sure. I still would like the `isset` thing, as it makes things more
> consistent, but I'll not fight for it.

${var:+isset} is fine.  Instead of

+# Disallow the use of abbreviated options in the test suite by default
+if test -z "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS}"
+then
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
+	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
+fi
+

if you used

	if test -z "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS:+isset}"
	then
		...

I won't object.  After all, I know I introduced :+isset pattern to
our shell script codebase as there are cases where it makes the
result easier to follow.

But the thing is that your patch had the polarity inverted.  Where
you must say "if this thing is not set, assign this value", you said
"if this thing is set, assign this value", which was totally bogus.
As long as that is corrected, that's fine.

Having said that.

When you check if the variable is set, use of the ":+isset" pattern
makes the result often easier to follow by explicitly letting us
compare with an explicit "isset" token, e.g.

	case ",${VAR1:+isset},${VAR2:+isset}," in
	*,isset,*)	: at least one is set ;;
	*)		: neither is set ;;
	esac

This *does* make the code simpler and easier.  But when checking for
"is it not set?", you can compare with an explicit literal "" and
that comparison is plenty clear enough.  You won't get as much
benefit as the "is it set?" test would out of the pattern.  I would
not say that it is pointless to use the ":+isset" pattern when
checking "is it not set?", but it is very close.

