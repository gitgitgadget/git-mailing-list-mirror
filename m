Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F19C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8366613B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 14:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhEDOp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 10:45:57 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:18995 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhEDOp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 10:45:57 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ldwIH-000ANO-3N; Tue, 04 May 2021 15:45:01 +0100
Subject: Re: Advise request on adding a new SSH variant
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <043101d73aae$026409b0$072c1d10$@nexbridge.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <fa8f81db-d470-130e-115d-7aef5e97e5a7@iee.email>
Date:   Tue, 4 May 2021 15:45:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <043101d73aae$026409b0$072c1d10$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,
some drive-by comments..

On 26/04/2021 16:08, Randall S. Becker wrote:
> Hi Team,
>
> I am getting a bunch of requests from my team (and customers) to make SSH
> configuration easier on the NonStop platform. 
> We are currently using a
> wrapper script to drive the variant of SSH on the platform but that is not
> convenient for many people. 
> I would like to add an ssh.Variant called
> "nonstopssh", or something like that, which takes a few extra parameters.
> -Q (quiet), -Z (don't display the banner), -p port (obvious but typically
> required), -S (a system process name). 
https://git-scm.com/docs/git-config#Documentation/git-config.txt-sshvariant

Sounds sensible to me. Maybe also look at past issues that
Git-for-Windows had with folks having too much prior choice (plink,
putty, tortoiseplink). May need more clarity in the docs ;-)

> The code in connect.c looks pretty
> straight forward, but I'm wondering about the best way to pass in a process
> name (it would be something like "$ZSSHX" - usually an environment variable
> "SSH2_PROCESS_NAME"). 
Hopefully others can chime in.. Maybe see discussion at
<pull.913.git.1616511182942.gitgitgadget@gmail.com> about $ARG variable.
> The program name for SSH, I assume, could come from
> GIT_SSH_COMMAND (typically "/G/system/zssh/sshoss", or I could force it if
> not supplied). 
https://git-scm.com/docs/git-config#Documentation/git-config.txt-coresshCommand
> I'm also wondering about controls for the -Q and -Z
> parameters.
> Should I just use the environment for this and build up args or
> is there a more appropriate way of managing these values?

>
> Thanks in advance,
> Randall
>
> -- Brief whoami:
> NonStop developer since approximately 211288444200000000
> UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
>
>
I was also thinking that the lack of replies maybe links to the "Pain
points in Git's patch flow" thread <YHaIBvl6Mf7ztJB3@google.com> whereby
it's all about the proposed patch, rather than thoughts about a
potential patch.
(Sort of like the philosophy of science [method] that ignores opinion,
and demands evidence)

--
Philip
