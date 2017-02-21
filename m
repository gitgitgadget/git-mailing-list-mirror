Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAAA5201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbdBUXhl (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:37:41 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33838 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbdBUXhj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 18:37:39 -0500
Received: by mail-pg0-f65.google.com with SMTP id s67so9955196pgb.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 15:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PACs7xBOqE+Dnltt9XnyAgihl7dGryBNjgBh1ni8zYQ=;
        b=UtHr3giwTmdStWiiMFgBn9F3z8jmhOM9D5ZFmuH+ULoYC3TQP3X2dlyTb0KZzlx39g
         jh/SYmeVFiTh/zdpmYu88W21MAwvDPEyvJVKdj1zjrktPi4lFttv6ff0Iv9aME8Qc2Xf
         sEsN/KMqvkFUPxCNZjTGhX453ys618pqwMHAyVLiZ2/vG1aLmMdPsViQcMDy6OaDd+3+
         61xDKDxpSSNh3FSu9LIGQlEbbLLFFP2EhODDuAXz7qwv3KUrBxEELJH6Q9G4lLBkswDn
         iRNNykH5xsFB49bX+v6XWbuU0iJXcyBp45ph6cZ6VURWnBJoxbJDTD7pq1LSa2AvZ/ce
         OWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PACs7xBOqE+Dnltt9XnyAgihl7dGryBNjgBh1ni8zYQ=;
        b=COEs5gw8mhUxwrnOg2H9Vm/5e7izdbX0vc4+7JnW2OvMtrg80b2/nlzqCqOFyUB8ks
         iUtGDd9xKqH2uefAFYUlHX1WBE9aABwpDMxLrQkmnTJzrevFtiRE1SO5EpiccBgss41J
         /yOi+I7nF2vusRT67hLZAqtSuRBgnsh7VsG26SrcfyoUEc2mjy+XGANXg9XkX6xEEEWJ
         5jUanA8GI1ivRNGpj5NWB1po0eLIoYZuT/ePLZVG+pELOaJM5uIdB5RQh02ns+sYAIJc
         gqruM42fXkwDYqzXEWZ0qjooCq8/3hOdWDG0HUrBuT65ejHc83dnwhmngZsDghT1C7WP
         i+Jg==
X-Gm-Message-State: AMke39nDv+Y4idk9uMNuMQUXmFQW+C+qUjlrvPBmU4lgJzAJa/QeJTzZjEqmbEWCeI5vtw==
X-Received: by 10.98.32.7 with SMTP id g7mr36036953pfg.119.1487720258655;
        Tue, 21 Feb 2017 15:37:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id x15sm43131158pgo.56.2017.02.21.15.37.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 15:37:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Toolforger <toolforger@durchholz.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: url.<base>.insteadOf vs. submodules
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
        <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
        <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
        <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
        <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
        <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
        <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
        <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net>
        <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
Date:   Tue, 21 Feb 2017 15:37:37 -0800
In-Reply-To: <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 21 Feb 2017 15:16:27 -0800")
Message-ID: <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Feb 21, 2017 at 3:00 PM, Jeff King <peff@peff.net> wrote:
> ...
>> I guess one answer is that this is the wrong approach entirely, and the
>> right one is something like: submodules should understand that they are
>> part of a superproject, and respect some whitelisted set of config from
>> the superproject .git/config file.
>
> This would break one of the core assumptions that submodules
> are "independent" repos.
>
> The way of action is a one way street:
> * The superproject is aware of the submodule and when you invoke a
> command on the superproject, you may mess around with the submodule,
> e.g. update/remove it; absorb its git directory.
> * The submodule is "just" a repository with weird .git link file and a
>   respective core.worktree setup. Currently it doesn't know if it is
>   guided by a superproject.

While that is a good discipline to follow, I think you need to
differenciate the project that is bound as a submodule to a
superproject, and a specific instance of a submodule repository,
i.e. a clone of such a project.

It is true that the Linux kernel project should *NEVER* know your
appliance project only because you happen to use it as a component
of your appliance that happens to use the kernel as one of its
submodules.  But that does not mean your copy of the kernel that
sits in your recursive checkout of your appliance project should
not know anything about your superproject.

This is true even without any submodules.  The Git project itself
does not even care you are Stefan, but you still can and do add
[user] name = "Stefan Beller" to .git/config of your clone of the
Git project.  A clone of the project may want to know more than the
data project itself keeps track of to describe the context in which
the particular clone is being used.  And .git/config is a good place
to keep such pieces of information.

So I would think it is entirely reasonable if "git submodule init
sub" that is run in the superproject to initialize "sub" writes
something in "sub/.git" to tell that "sub" is used in the context of
that particular toplevel superproject and customize its behavour
accordingly.  Perhaps it may want to add the url.*.insteadOf that is
useful for updating the submodule repository when it does "submodule
init", for example.
