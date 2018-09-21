Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CE21F453
	for <e@80x24.org>; Fri, 21 Sep 2018 04:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389026AbeIUJwb (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 05:52:31 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39948 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeIUJwb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 05:52:31 -0400
Received: by mail-wm1-f47.google.com with SMTP id 207-v6so1602490wme.5
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 21:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xyuoh10rZyVX7JEC+cJ/5cX6htKEIS3QhnbDT0oWCOk=;
        b=U3ycLOaYxe9TSKwJA/aaKdXXo4VW9HWWtwc/NQh9YoF7JNF0dFb7VJDP0c9BC+oe6H
         4X8X3d1AVhna+nOkXd7RBCkFKMKfA4+RGnBrTYt6Ucg4fZuv/F8PIvrlNBitBOeIsjmQ
         Xfs8vBtP/KPN4YGbGu3bdZfzVWnhuSdQdwD0I05qRjqSXA1e5vlVdpY1mnCJPB4yOcIl
         IoVhjPGSWrfWQxkvBGuUjgN6ki+iybH47ftScbsgUdEEG+2iEM65zOwscyt+ljoDW9/L
         JBrRPRGEmwlgnLRJNhIibRN383kMdDu/5niephOw1HgYUOFDPp+FC0LLz5opcKH2/dNG
         o6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xyuoh10rZyVX7JEC+cJ/5cX6htKEIS3QhnbDT0oWCOk=;
        b=QKCepSk6M03M3LAipI8lO+J4yDkROO34JqzbxdhxRtYlGB4/d43miajUwI/FT9ZFqI
         J5uXj3pCp+7IJ4axNTtwDyNB8WoLKBSsRVAYXg1R9kXOe5mFzeZwKQy6I0Dxi/G9r1Ty
         jngh1wATj8pgarBVn9Jlct5Kq0jO9NeEVKauR++MnUlHuRswK6GgvZ3d6uZRG/c417he
         m6aSbSCE4diTqiEIRVn7B2OYr+rFAaQej4JC8q15UsjXIx5IKlK1GrByRwc6Iq3zlgaG
         8KFhJ1yHJ/oYIiX9KhQ9Wb8njTLgKmHStXvwD/Y5Lbqx7VfhqP4q5hwI3kG5QfUKdhfV
         ziAg==
X-Gm-Message-State: ABuFfohZ81wM5bGixeZpZhojiCEUOnGstOTWrLaHVdvyQb7BYR4lq23p
        7JggJ/7W93UQ6A1b+zMp7rI=
X-Google-Smtp-Source: ANB0VdbPebaEhj/EJ8UON59jzcEfPJMXPCNhLi8Mkz0z6n7mwV9PSZ6KHPpBuX/U4qw3IK1isoS0mQ==
X-Received: by 2002:a1c:1203:: with SMTP id 3-v6mr5382840wms.46.1537502734454;
        Thu, 20 Sep 2018 21:05:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r13-v6sm3432929wmf.35.2018.09.20.21.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 21:05:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     alexander.d.mills@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: bug with git merge-base
References: <CA+KyZp4G6WCXjp_9x+NBWZysfg+Fu_PtF4qrhipT8UuLNnsCHA@mail.gmail.com>
        <CAPig+cS+8+uGQTfxmq1XGMt5FBM1oq72d3N=3BkjhrA9ui+EWw@mail.gmail.com>
Date:   Thu, 20 Sep 2018 21:05:33 -0700
In-Reply-To: <CAPig+cS+8+uGQTfxmq1XGMt5FBM1oq72d3N=3BkjhrA9ui+EWw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 20 Sep 2018 22:31:06 -0400")
Message-ID: <xmqqsh23xzoy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 19, 2018 at 6:25 PM Alexander Mills
> <alexander.d.mills@gmail.com> wrote:
>> The following command sequence exits with 1, and no stderr
>>
>> base='remotes/origin/dev';
>> fork_point="$(git merge-base --fork-point "$base")";
>>
>> I cannot figure out why it's exiting with 1, but there is no stdout/stderr
>
> Unable to reproduce the problem. Perhaps you can provide more context.

Well, reading builtin/merge-base.c::handle_fork_point(), I think the
intended behaviour is:

 - die() when input is not well formed (e.g. bad commit object,
   ambigous ref name, etc.); there is an error worth reporting in
   this case.

 - show one that used to sit at the tip of the ref, if exists, and
   signal success with exit status 0; there of course is no error in
   this case.

 - if there is no such fork point found, signal failure with exit
   status 1; nothing is written to the standard output as there is
   no fork point to be shown, and nothing is written to the standard
   error.

I do not think the code considers the last case as an error, i.e. it
is just as natural not to have any fork point, as there is one.

It might be OK to teach the command to say "no fork point found" to
the standard error under "--verbose" mode in the last case, but
since the command does not take --verbose or --quiet, I have a
feeling that everything is working as designed.
