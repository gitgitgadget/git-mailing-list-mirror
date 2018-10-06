Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655681F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 23:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbeJGGqd (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 02:46:33 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:34081 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJGGqd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 02:46:33 -0400
Received: by mail-wm1-f48.google.com with SMTP id z25-v6so6156187wmf.1
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pyg2QKisV6FpW/19PL62hsjBl85dQfUa3tugmHAHtUM=;
        b=gHB+M0k/uOWI95V5V7zIV2tmmp6EvMZBdDFHIDELrTEjSemqLYR2icwxcGlaBPH4Aq
         N/+ZXT473OUCOvVUO252mbbFSJgD5f9A7PX/wQV0ihjvy/xGHkhxIMRHzckojFWxscuX
         uCWx/LsDAjlUGKW7p9nJNWajmEbuLzoXp/q4Yekat9UD4LBpwHSsQK+fqAfqz5kEio0U
         BeKhRSXYfp6f5gKQ6e7DfIIQujVh++yxbDpf6UPc0PQCdY4LNu6WzmlGIOt9n1lQRaTS
         oGMj58U+FCdwZRKL00/GOGQTZP79vbqi2LLvPtZ/uDaRscfZyFEh9iTs8IxCFTWiG9TG
         UKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pyg2QKisV6FpW/19PL62hsjBl85dQfUa3tugmHAHtUM=;
        b=mq5Id8BFGRcuBWgSS9862WTojA2RxwhgPfKRAqqYXnQg+ASYFd/kHwtKTMbKN0vPxH
         smv8cUHw87RoSqMjvle/Vc7XwrPafTXnaKsS0khIsna4tCtwxCQgYlDsr4jKLA8HpRcc
         4Wu3qyLG1gUgbP7d1qkq1NctNDsS5ixEo1qunZF4VlcUbYXG6ihq34dbGRCmrLPXXWu6
         2f6mC5fAGfTm6uS+AI+UMGtn2S4afQBekQKTgqhkQ0wfYg3lNpZ4tpBG3V6EYrEgIhqQ
         tn2QJCOTvRWVlSxy4AxUeyUREV1L+2LKWdjo/prsReXxk+w8MJEybm90j32/pBs6x/sC
         FOEA==
X-Gm-Message-State: ABuFfogAQm2fDsNufbOogGZ9P+XskmGdPbBGed5JAMZE789O0K1aFmnl
        CiXgecHoS6HNDwQ+9IlMwUJyddegjqk=
X-Google-Smtp-Source: ACcGV61plem4C36xNGSpXR0bTt+7UaEjPr80CJO0ckNqSENdMMFuZvoIMHce4h/f3FhRKEDrl261KA==
X-Received: by 2002:a1c:9b91:: with SMTP id d139-v6mr11261856wme.62.1538869282179;
        Sat, 06 Oct 2018 16:41:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l70-v6sm13977276wma.0.2018.10.06.16.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 16:41:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ananya Krishna Maram <ananyakittu1997@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] git/userdiff.c fix regex pattern error
References: <20181004113015.GA30901@manohar-ssh>
        <nycvar.QRO.7.76.6.1810041624290.73@tvgsbejvaqbjf.bet>
        <CA+=o6KFN-p901GiJzj5BquU2RKCVTOKarGpjjuqsASN_uqGZSQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1810041718480.73@tvgsbejvaqbjf.bet>
        <CA+=o6KHxwYdYsvFDzBaG1q2jvgtN5f4LruD5k=dqei8workWfQ@mail.gmail.com>
Date:   Sun, 07 Oct 2018 08:41:20 +0900
In-Reply-To: <CA+=o6KHxwYdYsvFDzBaG1q2jvgtN5f4LruD5k=dqei8workWfQ@mail.gmail.com>
        (Ananya Krishna Maram's message of "Thu, 4 Oct 2018 16:09:57 +0530")
Message-ID: <xmqq7eiuwsm7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ananya Krishna Maram <ananyakittu1997@gmail.com> writes:

>> But it does not need to be escaped, when you specify the regular
>> expression the way we do. And the way we specified it is really the
>> standard when specifying regular expressions in C code, i.e. *without* the
>> suggested backslash.
>
> Aha!. this makes total sense. I was thinking from a general regular expression
> point of view. But I should be thinking from C point of view and how C
> might interpret this newly submitted string.

If you were thinking from a general regex point of view, you would
never have treated '/' as anything special, though.

Historically, some languages (like sed and perl) had an regexp match
operator, which is denoted by enclosing a regexp inside a pair of
slashes.  In these languages, if you use /<regexp>/ operator, and if
you want to match slash with the pattern, you somehow need a way to
write an regexp that has slash in it.  E.g. if you want a pattern
that would match 'a' followed by '/' followed by 'b', your regexp
would look like "a/b", but the regexp match operation you would
write in these languages would be like /a\/b/, so that '/<regexp>/'
parser can tell that the second slash is not a slash that signals
the end of the match operator.

And then there is an unnamed misdesigned language that has a
regmatch() function, which takes a string that contains a regular
expression, but somehow requires that string to begin and end with a
slash for no justifiable reason ;-).  If you were thinking about
regexp from that brain-dead languages' point of view, yes, you
should unlearn it and what Dscho gave you would make sense.

C's regexp(3) library does not share such a misdesign and just takes
a regular expression as a string.  You would still need to follow
the quoting rules of C string literals (e.g. write a literal
double-quote or backslash after an escaping backslash), but of
course slash is not special there.

