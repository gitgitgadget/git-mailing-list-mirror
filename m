Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9090B20248
	for <e@80x24.org>; Sun, 14 Apr 2019 10:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfDNKYS (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 06:24:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36485 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNKYS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 06:24:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so16361864wml.1
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HNfJPMbLi0sy+lIrcdhLbKiEFYkHSZpD2soUQc7N9bo=;
        b=KJoGLFweT+zszJdDeaQnDJLamBuKLXKXc0X1Oh5O10Hzm8HzQzKXPTHOWV1kzM7Djk
         QMVvoEOmkYSNQnrvsdPw3miiNC5ur7ZFftYqG/jHDXtsqFxHnwDgjnNSUHBU1ZfFjZKV
         JAl0H7l7k++GzRTIMF0yp/VVMzEegEXz7y8zAHEpQ9WmMs7GgULiZeec5DTufrYc67yK
         b63fE0EiUYWw9+DTJXJB0iZhkHI1K8WuhjfYi+ElNiMPhGPdAHaN54R/ZHwaUEFShKl2
         p3f+8VhgLUSfW9GFUl68g4XrI9NCrGXpuhYxZBJ6tV/FO8k2Hjzd0etBvw9GxzG02p6f
         nwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HNfJPMbLi0sy+lIrcdhLbKiEFYkHSZpD2soUQc7N9bo=;
        b=GFhfjkKlFhM1gYUkbzoargJN4E5a8NR56h1NUpR4xRjDMoS2+wtIeYjFVIedeBnI5J
         3VpjYAM/FIKdOlf4imCAq0/JEEwp1QcVlt6cvtXtq1ELBt9tfjy+oXrNT2xVw0WZHRhr
         Q5UjM9NQae0xwky57Zsukl9vDc4zf85TGO+f0PdcuPVj3I2tdGWaVh1f2/nWSAASAaTA
         0liFmmZyIMfkaH/sggzxxWUsJ4lIWtojc/JPI6dTe295lkpro6avcJ3lRMwCJ0rwtEPE
         tEzkwdJh9RI2OOPOu33sf+VrhOQLbGzSO271n+Oa0hGqiLnxJUzq1QO6EF1xRJk/Zk3Y
         HeuA==
X-Gm-Message-State: APjAAAXm5l+z/WHgsbXxLB4iXHpz48Dstvkh16L4qKIe4xl0OtlskeGa
        IpyhOD37tC6Xv4xuWGY0mss=
X-Google-Smtp-Source: APXvYqy3kF5uAY9vS24f+N4dMeIUkxoL3E1PqWSv3qeMpm8HwzgD0z0v7zeAZ6UCsx6vbOa3wpjprA==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr16989586wmt.33.1555237456013;
        Sun, 14 Apr 2019 03:24:16 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x205sm18007533wmg.9.2019.04.14.03.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 03:24:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Platings <michael@platin.gs>
Cc:     Barret Rhoden <brho@google.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v6 4/6] blame: add config options to handle output for ignored lines
References: <20190410162409.117264-1-brho@google.com>
        <20190410162409.117264-5-brho@google.com>
        <xmqqo959w8pq.fsf@gitster-ct.c.googlers.com>
        <CAJDYR9S8XFH=JnQX8WcfgOZ7cr+X6kk45k9g8t3u5aP5wwdu0Q@mail.gmail.com>
Date:   Sun, 14 Apr 2019 19:24:14 +0900
In-Reply-To: <CAJDYR9S8XFH=JnQX8WcfgOZ7cr+X6kk45k9g8t3u5aP5wwdu0Q@mail.gmail.com>
        (Michael Platings's message of "Sun, 14 Apr 2019 11:09:55 +0100")
Message-ID: <xmqqbm18x4tt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Platings <michael@platin.gs> writes:

> If you only enable blame.markIgnoredLines then the hash for
> "unblamable" lines appears as e.g. "*3252488f5" - this doesn't seem
> right to me because the commit *wasn't* ignored,

I think you misunderstood me.  I was merely suggesting to use the
approach to mark the line in a way other than using the NULLed out
object name that has been reserved for something totally different,
and hinting with "the same *idea*".

And that idea is not even original to this series; the "^" marker
that is used to say "the line is attributed to this commit, but that
may only be because you blamed with commit range A..B and we reached
the bottom of the range---if you dug further, you might find the
line originates from another commit" is the origin of the same idea,
and this topic borrows it and uses a different mark, i.e. '*', for
the "we are not certain---take this with grain of salt" mark.

If you ended up hitting the commit the user wanted to ignore,
perhaps you can find another character that is different from '^' or
'*' and use that, following the same idea.

That is what I meant.  So you shouldn't be worried about using the
same '*' making the result ambiguous.

By the way, a configuration only feature is something we usually do
not accept.  A feature must be guarded with --command-line-option
and then optionally can have a corresponding configuration once the
option proves to be useful enough that it becomes useful to be able
to say "in this repository (or to this user), the feature is on by
default".
