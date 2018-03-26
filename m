Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFA61F404
	for <e@80x24.org>; Mon, 26 Mar 2018 15:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeCZP4h (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 11:56:37 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:47084 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeCZP4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 11:56:36 -0400
Received: by mail-wr0-f170.google.com with SMTP id d1so7429726wrj.13
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wTY94PqKziSuWg4beAvyhjK8M6p/ISx0zuGc4yv4sMw=;
        b=aCBi+qJCg8EZ5UnT/Kb0gKAPlurOoo52fCyntNNVkUslfuozFOEoT2z9uPeIGBN0WM
         lyhk1qcNHx1Fy4JiLjIhowq37w3jvym2eURL8VT0+HG4gPSNwcH1oL9wFt3o5F8GqhBJ
         Whp1xupqOkDGm60Jnnr8IrDZBYB890Zc9iHXweKRhNJLgi3BUbk5BcWyWLLO8wMU68EA
         lJFayef8Lqoehm7zcK7OKEogt0ztxvCULRZb42HJDbHEEYXLEphO9TGGIKg/LxaRQAli
         CrjG8vAV0aoRJIvG2A67AxktO01akLjbisn7msB7hclhVuNM6uE43PBfhDCP7dfnhEeK
         T94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wTY94PqKziSuWg4beAvyhjK8M6p/ISx0zuGc4yv4sMw=;
        b=lFcjxRrFU4yAAJU3GYGsU0bkIdzyyA1NiBNy5oyGoqhSc8hgt3SDXaeMjG9T+H1VXJ
         DwxpDZqfzaxas+9ZNSkltMk6J8E/4pbP8yuaQoS9+gXNmkO6Q3o15a0Ft/+o79mFX4M2
         Xw++yXLzKJjvaYex7q+0imhmIci29NUG6AUSX/gSVimabllYaMCR9JTYaX3PjmgyKV5R
         QDRe5vp9gGzScRQJ5EACS+5Oeyj9Zj69C40mj8dVryLgxuq7Iez3MQmPo5fVca5KM41l
         XhaHVSKXK1Kf4sYA36ykXnO9mr+auh1BGyL3Oflix7z5Zq6LGQZdFPH27uQUtbAx/+Dp
         MW6Q==
X-Gm-Message-State: AElRT7FYnRwhYnjtGbTR3TJMgJ4KUq41IRynLI8Z4EkxmrvwZeacxaC0
        U9a2iTgj6/u6fO3B22KOfeo=
X-Google-Smtp-Source: AG47ELtaOJ6yptGSW+ZjaOcIUYgt/0W1l8grS8h2JRkPSC+PEK+6WnusQIuAo1bgvs9GLaiedB9GcQ==
X-Received: by 10.223.160.241 with SMTP id n46mr30567023wrn.280.1522079794641;
        Mon, 26 Mar 2018 08:56:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t196sm16089210wme.35.2018.03.26.08.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 08:56:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     jeffhost@microsoft.com, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
References: <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
        <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
        <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
        <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
        <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
Date:   Mon, 26 Mar 2018 08:56:31 -0700
In-Reply-To: <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
        (Wink Saville's message of "Fri, 23 Mar 2018 22:36:49 -0700")
Message-ID: <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> json-writer.c:123:38:  error:  format specifies type 'uintmax_t' (aka
> 'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned
> long long') [-Werror,-Wformat]
>
>         strbuf_addf(&jw->json, ":%"PRIuMAX, value);
>                                  ~~         ^~~~~
> json-writer.c:228:37:  error:  format specifies type 'uintmax_t' (aka
> 'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned
> long long') [-Werror,-Wformat] [0m
>
>         strbuf_addf(&jw->json, "%"PRIuMAX, value);
>                                  ~~         ^~~~~
> 2 errors generated.
> make: *** [json-writer.o] Error 1
> make: *** Waiting for unfinished jobs....

For whatever reason, our codebase seems to shy away from PRIu64,
even though there are liberal uses of PRIu32.  Showing the value
casted to uintmax_t with PRIuMAX seems to be our preferred way to
say "We cannot say how wide this type is on different platforms, and
are playing safe by using widest-possible int type" (e.g. showing a
pid_t value from daemon.c).

In this codepath, the actual values are specified to be uint64_t, so
the use of PRIu64 may be OK, but I have to wonder why the codepath
is not dealing with uintmax_t in the first place.  When even larger
than present archs are prevalent in N years and 64-bit starts to
feel a tad small (like we feel for 16-bit ints these days), it will
feel a bit silly to have a subsystem that is limited to such a
"fixed and a tad small these days" types and pretend it to be be a
generic seriealizer, I suspect.
