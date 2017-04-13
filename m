Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4D220960
	for <e@80x24.org>; Thu, 13 Apr 2017 20:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756334AbdDMUuN (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 16:50:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34546 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756397AbdDMUuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 16:50:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id o123so13509258pga.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ak5AzIHDwhU/YXo61Tk5dvMLUEaZbCT5DQMxBopHq4g=;
        b=Ht/NXd+JZMitXMtBu3lROsEoyP6pdbg6bo8HWZJdcbBBNRGeauMbB89I8yXIqnY1hi
         WSHvPgxZPGC52DQMS0c94bI6rh9ddGSIsTYx/bFAIUClKlsccVNjQZdiGvUC0UJadPwk
         nvN83Nh/hdZN/i7wHn7jH0cja/IByCWoXin7uBphx32Ik0W1q586MkwrtXZ3dfr+Zk3L
         EcrSYgU4tCjakQ88rJgBelEPEhoeMQ+vu1fpMbnSfP2pt6uVKyzZFL1UH+X6SGKMolA8
         teqbtPPk5lnr//vumAlm6o+qcNAW5GG7g0wS1hbY9BUTiwpWgKkUN9qnuy0IOQHdaPAA
         kS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ak5AzIHDwhU/YXo61Tk5dvMLUEaZbCT5DQMxBopHq4g=;
        b=YEbCNs2egbbcAgKmVeM+f+Otj6bI0nDRVkSxAKpdjnfTW46sycCNgnB+9rtsoOV8TD
         rS8O0s41lcEJ6FODriy+5aXdFg7MvSNcscNKLM2O+3/DcC33OJ3GziZo+Y8hwUB3DtBG
         GX573Z94RMvZGdARlG4jZhOlymmzZYrvAT+yKNLx7qRU7Cw0sbU2buZH6XKEApnYPJ9r
         6g3LeY3A/9BMKFL9hp73/EWYtP59csvWdAqXcxwCPl2kiUzq1hwDLxuuaTKKbFVEf5Uo
         ddtXpsho3+rP4YYXYcbQ6ElH4wzHQCK+KS7w0upjRHc8142IN4tlZK2ul6VGR3QsEt7g
         3fXA==
X-Gm-Message-State: AN3rC/5o8D3xA52+TEAO9YnkMjVynz+rqYjCX0xIEqqT0kuEkKhTC8L9
        CXNt5TgVSZRVdg==
X-Received: by 10.99.164.26 with SMTP id c26mr4392740pgf.89.1492116610917;
        Thu, 13 Apr 2017 13:50:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:40ae:ac27:c1a2:6a87])
        by smtp.gmail.com with ESMTPSA id s14sm44249303pgs.0.2017.04.13.13.50.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 13:50:09 -0700 (PDT)
Date:   Thu, 13 Apr 2017 13:50:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH v2 0/6] forking and threading
Message-ID: <20170413205008.GB10084@aiede.mtv.corp.google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413183252.4713-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> From what I can see, there are now no calls in the child process (after fork
> and before exec/_exit) which are not Async-Signal-Safe.  This means that
> fork/exec in a threaded context should work without deadlock

I don't see why the former implies the latter.  Can you explain
further?

You already know my opinions about fork+threads by now.  I continue to
think this is heading in a direction of decreased maintainability that
I dread.

That's not to say that this is wasted work.  I would prefer an approach
like the following:

 1. First, make grep work without running fork() from threads.
    Jonathan Tan's approach would be one way to do this.  Another way
    would be to simply disable threads in --recurse-submodules mode.

    This would be the first thing to do because it would make tests
    reliable again, without having to wait for deeper changes.

 2. Then, teaching run_command to prepare the environment and do $PATH
    lookup before forking.  This might make it possible for run_command
    to use vfork or might not.

 3. Teaching run_command to delegate chdir to the child, using -C for
    git commands and 'cd' for shell commands, and using a shell where
    necessary where it didn't before.

 4. Switching run_command to use posix_spawn on platforms where it is
    available, which would make it possible to use in a threaded
    context on those platforms.

Thoughts?
Jonathan
