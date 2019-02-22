Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8168520248
	for <e@80x24.org>; Fri, 22 Feb 2019 15:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBVPbB (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 10:31:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVPbB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 10:31:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15so2322145wmi.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E8vYee1cK3SreKxdZk56uzdXxWwaNlhtE7XsJOfN6cg=;
        b=HljIwripWVtCbeHDHlCzZddSd2D5j0mE7CVA/7nasm2vmkekTXDyXYybiu3R/HhNe3
         Y0jJF2XI+ZNtF097fNDC3/vzSqAGRypLOFHrvhun8sVuL9pgBVnTZig5vy4kRu0R3t05
         aZ08Dxtv9FTeO3HET1DhmhyQ9OIkfrR4l3ojUhZrqHftT9K+f0fJVE1EXQQYGPwyvvhG
         1b7ECu3MQnLvsK1xJqfdk2NSq73bEEOAov0dOrbMyjiB7c5nnDfE3BgmCG99vnE5n8X6
         EMWzqOzlLpH3WowcsLpycXaBG7mBkEfFWedNGkOGwA8ufhUodwXzm+sVJXKg0YjPXeXN
         zxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E8vYee1cK3SreKxdZk56uzdXxWwaNlhtE7XsJOfN6cg=;
        b=qeGUFB44rObN71JHx883XLoHMuJjesuhwjaij6HDZ4XhaXl7sgLL1T+stmrNmOMsRr
         9T1tabL6mmBUCerh2sOgtYUqbwBnNfAxe9WNZx6CCPq2sj+QA/LTIZ+Z2kIdcY8x0Xa7
         qvKxBcqS+f2UymDGwFRQjKwEsiCdkiArMtWW9OzpnNc1/SYaScm701oCfb2IWStaw8gA
         gcOL+ODvWLuJhB9u3dMDakdZyr/ilmG7fAl8AH9KbpmVpDGQnXyGYoKEAGItd+gdhqn+
         fTDBXrNJVkzLJCcpuULc7xqk/J+tvAz0RQpP6ckRx1Ztl6S6cV+h4XpOLdIGr28D+Gz7
         400A==
X-Gm-Message-State: AHQUAuaORcZR2yTS/ievUuW83eKS5emMrCEEPCNrsbsxKfReUqjE6nYg
        nlFVP60n1A5n0j4HCwpeYn0=
X-Google-Smtp-Source: AHgI3IZe48ar+i60149lSoyQVZudspNpypMpIUJu9g5HdTR+rKsSG2ZIMPJVf7vMzMG2GkStwX3hwA==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr2825928wma.114.1550849459083;
        Fri, 22 Feb 2019 07:30:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a1sm2248831wrq.96.2019.02.22.07.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:30:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how does one interpret "git diff <commit> ^<commit>"
References: <alpine.LFD.2.21.1902220816010.6353@localhost.localdomain>
Date:   Fri, 22 Feb 2019 07:30:57 -0800
In-Reply-To: <alpine.LFD.2.21.1902220816010.6353@localhost.localdomain>
        (Robert P. J. Day's message of "Fri, 22 Feb 2019 08:22:12 -0500
        (EST)")
Message-ID: <xmqq1s3zsuvi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   was perusing the git FAQ and ran across this:
>
>   How do I obtain a list of files which have changed in a given commit?
>
>      $ git diff --name-only <commit>^!
>
>
> after playing with "git rev-parse", i figured out that the above was
> equivalent to (using kernel "v4.19" tag as an example):
>
> $ git diff v4.19 ^v4.19^

A "rev" argument on the command line can have two (and a half but
that one does not come into picture in this discussion) polarity.
Normal and negative.  Negative revs are written with "^" prefix (not
to be confused with "^" suffix which means "the first parent of),
and normal revs are written without "^" prefix.

There are some short-hands like <rev>^!, but they expand to
combination of the normal and negative rev arguments at the bottom.
The one you used, "rev^!", on the command line expands to "rev --not
rev^1 rev^2... --not" for all its parents.  Here "--not" means
"treat all revs that follow have opposite polarity than they are
written until you see the next "--not".  For a non-merge commit,
that's equivalent to "rev --not rev^", which in turn is "rev ^rev^.

Now these normal and negative revs are often used for specifying
ranges to revision walking operations (think: "git log" etc.)  When
used to specify revision range, the set of commits a range specifies
is anything reachable from any one or more of normal revs, excluding
the ones reachable from any one or more of negative revs.  So "git
log v4.18..v4.19", which is a short-hand for "git log ^v4.18 v4.19"
(because A..B is a short-hand that expands to "^A B"), i.e. list all
commits that are reachable from v4.19, but I am not interested in
the ones that are reachable from v4.18.

"git diff" is about comparing two endpoints, so these normal and
negative revs are used differently.  With one negative and one
normal rev, you can tell "compare negative with normal to produce
a patch that takes the tree of the negative one to the tree of the
normal one".

So with "git diff v4.19^!", aka "git diff ^v4.19^ v4.19" (as v4.19
is not a merge), you are asking

	git diff v4.19^..v4.19

which is equivalent to asking

	git diff v4.19^ v4.19

which is "give me difference to bring the tree of the first parent
of v4.19 to that of v4.19".

For interactive use to see "What happend at v4.19?", it is much
easier to type "git show v4.19" than "git diff v4.19^!", though.
