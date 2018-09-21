Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341611F453
	for <e@80x24.org>; Fri, 21 Sep 2018 04:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbeIUKqT (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 06:46:19 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40774 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIUKqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 06:46:19 -0400
Received: by mail-wm1-f51.google.com with SMTP id 207-v6so1681868wme.5
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 21:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d4M2X7h4wLOVrJRPyAI2I5UfpYL2kzj7so9u1GPUKUU=;
        b=ORPyReKDZvhl4pCVj495rWDGjoTfexLWSs9Yn6xPmQHeLucnyGd3Prlu6J0mSJP042
         jtM4aH7Vt6mwFgYrQ/BXMWg5kYn9Z44WPnC5nPLenBIl/H3nQ+l4JgKx4DDlRLUAXE8P
         klI/FqWGT295F9vPTDn/r1jkmLnmN/QSI+NDy2T1KD1M38BPwLQPY2hnXsGDZTL8drFS
         nCE36rzn1lcTloXgJ48fxu1jnrX/uU6Lmp8t1EEW2ZV3jHAtJ+Rw7ZImeC3HvjgSkH/3
         K6B37LfumTlS/f1bd4fbIYqV70aMbclRx7vlBTCaZxau8lFH/5H9uoUriEcQpHDWx+Rk
         I2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d4M2X7h4wLOVrJRPyAI2I5UfpYL2kzj7so9u1GPUKUU=;
        b=EpevRsb8SC5Al6Z0mhFsCGkiuTDOobjbatjHanY4N+ly5nk7PwUl1rtMoZ8YlIOPsw
         kwxJB3JqItDZ+93Ey3O9pNP5RzhWooY1BPO/yF2U8wL3g9SvyTjdSZQM/0czOeQj/3Vz
         Y7AADqQ38QAgaolo9ysVRz4sZLLvby+XTBCNcTYBjPRzlEFcomQYvxMnuY8EqVGDlgAn
         ZdPlEc5nuPOvKwLhKNBw6AjCTSrgwmx0B9uHGGBcITNF/ChZ9JqJA+SJlVMifVd4AOg4
         uhJJVQTmFmR2zYk53mTWi0itbmW+ntSCNLdDBHBu4YxPCQKgljsW+c4ME6TuNGo2xBmy
         3RxQ==
X-Gm-Message-State: APzg51Bc+WDPzZSUcHKarrrIoNO73o70H17zJQDG11YmsJrnjYG/hZeq
        Me6OUqzxOaVaI69+p1cZxbc=
X-Google-Smtp-Source: ANB0VdbFYabn9rmOsH3g+eSCX5DcT1Bcju3DYiRucruA6A5NzqDBLCSdaPLeLtG29rejSkSo4wgMbg==
X-Received: by 2002:a1c:9290:: with SMTP id u138-v6mr5214699wmd.52.1537505952579;
        Thu, 20 Sep 2018 21:59:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j11-v6sm20164270wrr.37.2018.09.20.21.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 21:59:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     alexander.d.mills@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: bug with git merge-base
References: <CA+KyZp4G6WCXjp_9x+NBWZysfg+Fu_PtF4qrhipT8UuLNnsCHA@mail.gmail.com>
        <CAPig+cS+8+uGQTfxmq1XGMt5FBM1oq72d3N=3BkjhrA9ui+EWw@mail.gmail.com>
        <xmqqsh23xzoy.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 20 Sep 2018 21:59:10 -0700
In-Reply-To: <xmqqsh23xzoy.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 20 Sep 2018 21:05:33 -0700")
Message-ID: <xmqqo9crxx7l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Well, reading builtin/merge-base.c::handle_fork_point(), I think the
> intended behaviour is:
>
>  - die() when input is not well formed (e.g. bad commit object,
>    ambigous ref name, etc.); there is an error worth reporting in
>    this case.
>
>  - show one that used to sit at the tip of the ref, if exists, and
>    signal success with exit status 0; there of course is no error in
>    this case.
>
>  - if there is no such fork point found, signal failure with exit
>    status 1; nothing is written to the standard output as there is
>    no fork point to be shown, and nothing is written to the standard
>    error.
>
> I do not think the code considers the last case as an error, i.e. it
> is just as natural not to have any fork point, as there is one.
>
> It might be OK to teach the command to say "no fork point found" to
> the standard error under "--verbose" mode in the last case, but
> since the command does not take --verbose or --quiet, I have a
> feeling that everything is working as designed.

I forgot to say that the behaviour above used by the "fork point"
mode seems to match the behaviour of the more established normal
"merge base" mode.  builtin/merge-base.c::show_merge_base() also
follows the same "die if the input is faulty, give output and
succeed if a merge base is found, otherwise be silent and signal
failure with exit code" pattern.
