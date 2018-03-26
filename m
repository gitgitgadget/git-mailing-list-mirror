Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D681F404
	for <e@80x24.org>; Mon, 26 Mar 2018 06:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeCZGBI (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 02:01:08 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38548 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeCZGBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 02:01:07 -0400
Received: by mail-wm0-f48.google.com with SMTP id l16so13101523wmh.3
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 23:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ppYzI3gmKo8q37qf8XIgNHstkHu3t4ZvyI0JKXrKsZI=;
        b=FlcsDrNxhq4NhRW6Kwz5PIoLArsrkZ6ceVa7Sw9sJRVIb2N/AfSymmkr2z1J/DNNqI
         sU74K0GYY7OaAiY2Qp+SCcEomaiOXia8hQ0Gg/3N10XheM+OzVJyKAoSpiH9yEOB/GjQ
         LcYXSPVc+DTYH64prbShbsb2wDDaIViveII1lue1fIE9AklT+2D3nt6426/9XWeuEy1P
         T1e2dIvRS7+ZVB28qmHd9RyG+qttKffW9MWA1wYGBWNIqnkQEFEyhyPqNg3JDla08hoo
         /j0qxf5OQhZTq9JiN6ZwsPE5BwJXVTP3rrOfQ98VbHg2Ix6Y3nvUyBw4zWG0JT7dPMPK
         yPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ppYzI3gmKo8q37qf8XIgNHstkHu3t4ZvyI0JKXrKsZI=;
        b=Ov3D06RCc84a84Ksdpq8tnjrLF+cr+NbVrxShpBWPQb+eW7czoXTcOYOgkVXmwQnmw
         mtcAX7xj97gzRiI/tfESPXSnr/KYJQSZDk5iUK0eq7PKRnRY8mHgXvqDbfqx8fIeNbp1
         5t8NkjB+WZN32VcLUzQ5gY3+CHlgW6M2af11Np4Px9Dk19ERJSxq2SzqQAsx4bxA2wxF
         1SUy9ujFCpS5V2cstAyCNC5Zi7xXvSdpw57mQR8Z1sZ+hKsW5wbbiDDXd3j7SYKaZQHJ
         8cz1boslqp321z//+T6Ekhvu4do3Urwn9b04Uzdx+x7w+lSNJMVOTyMMn7UnGr0U0dwJ
         uu/A==
X-Gm-Message-State: AElRT7GusrDMGvW5neQkJe9Q9GK4k0CU2Atc0iqvHACdCz00LhuNxsvM
        5SipxNbZdIcEOq0xgER5Juo=
X-Google-Smtp-Source: AG47ELulsKFS7SUlEDoIJrl+qse8N7lrYqUZ4D2zKSWGoLxgKuCK6hCO19zfA3ZsPzf3dB2Hn8Q9TA==
X-Received: by 10.28.132.133 with SMTP id g127mr15295542wmd.50.1522044066298;
        Sun, 25 Mar 2018 23:01:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k1sm18223396wrf.66.2018.03.25.23.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 23:01:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/3] RUNTIME_PREFIX relocatable Git
References: <20180325205120.17730-1-dnj@google.com>
Date:   Sun, 25 Mar 2018 23:01:04 -0700
In-Reply-To: <20180325205120.17730-1-dnj@google.com> (Dan Jacques's message of
        "Sun, 25 Mar 2018 16:51:17 -0400")
Message-ID: <xmqq4ll3e5pb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

> This patch set expands support for the RUNTIME_PREFIX configuration flag,
> currently only used on Windows builds, to include Linux, Darwin, and
> FreeBSD. When Git is built with RUNTIME_PREFIX enabled, it resolves its
> ancillary paths relative to the runtime location of its executable
> rather than hard-coding them at compile-time, allowing a Git
> installation to be deployed to a path other than the one in which it
> was built/installed.
>
> Note that RUNTIME_PREFIX is not currently used outside of Windows.
> This patch set should not have an impact on default Git builds.
>
> This is a minor update based on comments from the v6 series. If all's
> well, I'm hoping this set is good to go.

When testing the non-relocatable (i.e. traditional) Git, we use
GIT_EXEC_PATH and bin-wrappers/ trick to ensure that we test the
version we just have built, not a random version that happen to be
on the $PATH, without requiring the built product first to be
installed before being tested.  From the diffstat for this patchset,
I am guessing that you are using the same mechanism even when
testing the relocatable one.

I wonder if the relocatable Git would allow a simpler arrangement to
test without installing.

I am asking merely out of curiosity, not suggesting to make a trial
install somewhere in the build area and run the built Git normally
without GIT_EXEC_PATH trick.

Thanks.  
