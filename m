Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4945120248
	for <e@80x24.org>; Fri, 12 Apr 2019 15:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLPVc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 11:21:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38159 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLPVc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 11:21:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so11489331wmc.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2BMYHROiirllr/SYTxw1GMlidpiPmxfbLceiMOpCNBo=;
        b=UDWCrqb3HL0O7oqd+ALuT7cyy3mx3sUdoOiNp5EbWD+4emlaj+35C6K4Q/CxhDlT3L
         4+ODPLEPxje+Aupc5bN94xMrczvv13wEowUI9OX/ShDg0D4dUA/8ZwsQOGPIUwepaChh
         18FsOPx9OK9wRgZNlpAZAVQuRPZQ8lxRdRRHAqhelZEGcT5TtKU1FeXS3qPh38jTsWkD
         d5kaE4CcW/fnoA3HiAGxQRuiMP4X2w4L8dVXMdtaKCK5FhhJwGDXm0L4Vdyucm+Y8Yjy
         OJdYYEetVrBI68jTzlMzK5clTjaG8YiQmRhxsqbmv6ixmjkm8NVJgiy6XnWFdALOxVY5
         yGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2BMYHROiirllr/SYTxw1GMlidpiPmxfbLceiMOpCNBo=;
        b=a66QAdhPF9V/jz637VbTWJ3UsT1aBBitxwypAn5+UHmjYwPzl9YBXyUGArfqJnaiRw
         8WGYTH2+5ZP9o52ibW98wP4hY5cLU5ZMIjgqdGZ8KD2rjrEdDbihPbXeFBob/Q39frbz
         jUXsBhHH+9Isr2JiY1g9U/qXI4DBIbwbyzZ/d7cBg3zrHhC3eXbrxmpj0Q+an6q13nIF
         F4C+7G/wMGLs75lNPryhShq5OxCP1QKV8fzenywhqI7Uc7sOECo06wgeFfutDm6pjFkp
         UhuLSHxkio0BX3AAQSwM/vCFI6ePvMilR5Flsd+3Ltv3e1PzyeJbeRCZRguKVMRIGSyv
         wA3Q==
X-Gm-Message-State: APjAAAW/saw4oGZSaNytq5jJWxEFSRf72XHjUIsuAtbTTtcQTAAqZWS3
        nu71H1JlBotLpjfFFKFCHOQ=
X-Google-Smtp-Source: APXvYqw93RMSTtvIg/OhDxOFWM3Wn5/B2p2/WaTvQUNqcAQl9DtPYhi+Iyg605SY2+DhgR3ChVo7Uw==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr11744955wmf.73.1555082490509;
        Fri, 12 Apr 2019 08:21:30 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y3sm9438533wmi.27.2019.04.12.08.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:21:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ron <ronazek@protonmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git merge should report an actual syntax error when a semicolon is used instead of space for specifying multiple branches
References: <fQ_n3UAoz-yQ8MMCgPLhVDqkMCqpXQ2Dk34IZgksKIQ1B3Sig_T70nPI5mI0z9z2A5ZLdk5ooUYnAJelV-7eMNrnCr4V73Rz87pP1arR8WA=@protonmail.com>
        <xmqqsgunya8j.fsf@gitster-ct.c.googlers.com>
        <NVqJoDneX4bKnXsESFmcKt_7jDQE8Wk9l_F9rkNcnplXgV8TVjfbaMIhKfZ2v9BwJrJ2QJYcq-E6UdshPdhKttO4bIUGdsbs0zZUPNwQvUY=@protonmail.com>
Date:   Sat, 13 Apr 2019 00:21:29 +0900
In-Reply-To: <NVqJoDneX4bKnXsESFmcKt_7jDQE8Wk9l_F9rkNcnplXgV8TVjfbaMIhKfZ2v9BwJrJ2QJYcq-E6UdshPdhKttO4bIUGdsbs0zZUPNwQvUY=@protonmail.com>
        (Ron's message of "Fri, 12 Apr 2019 13:37:06 +0000")
Message-ID: <xmqqd0lrxn9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ron <ronazek@protonmail.com> writes:

>> I do not know what "git fetch" uses semicolon for here. Care to
>> elaborate?
>
> Those were all typos, I meant colon, two dots. Sorry.

Do you mean to say that because you can say

	$ git fetch origin +master:refs/remotes/origin/master

you expected that you can say this?

	$ git merge +master:refs/remotes/origin/master

The "git merge" command takes one or more commit-ishes to be merged
to the current branch on its command line, and the above command
line is correct at the syntax level.

But because 'master:refs/remotes/origin/master' does not name a
commit-ish, it is the right thing to barf, saying that it is not
something the command can merge.

If you replace the colon with space, that would mean an entirely
different thing, i.e.

	$ git merge master refs/remotes/origin/master

would mean "I want two commit-ishes, the tip of my 'master' branch,
and the last observed commit at the tip of the 'master' branch at
the 'origin' repository, merged into the branch that is currently
checked out, making an octopus merge".  It also is syntactically
correct, but it may not be what you wanted to do.  Most likely, you
would have rather wanted to do one of these:

	$ git merge refs/remotes/origin/master
	$ git merge origin/master
	$ git merge origin

In any case, because the "what to fetch, followed by where to store
it, separated by a colon, with how to store it optionally signalled
by a leading plus sign" argument syntax used by "git fetch" must
convey a lot more (and different kind of) information than "which
commit to merge to the currently checked-out branch" argument syntax
used by "git merge", these two commands have to take quite different
kind of information and use quite different ways to express these
two kinds of information at the syntax level.  The 'master' on the
left-hand-side of the colon used by "git fetch" does not even name
the 'master' branch _you_ have, while "git merge" that is a totally
local operation only can name a commit-ish object that is locally
available (e.g. a request to merge the 'master' branch you have
would say "git merge master").
