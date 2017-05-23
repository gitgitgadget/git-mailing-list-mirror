Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90C72023D
	for <e@80x24.org>; Tue, 23 May 2017 03:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757598AbdEWDdl (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 23:33:41 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36168 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdEWDdk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 23:33:40 -0400
Received: by mail-pf0-f181.google.com with SMTP id m17so100667040pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 20:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WNKh5Ln2SPSyB6hXDRRDaXCncwKQcCBGLXaH0FKyu1Y=;
        b=S9qyuHxvXbaY2NIxxLc0WWuuMMT5FOO53uvFiLv1dXST257JCGrpC+DPm6uwyWXALH
         mjD/cUu5FnYD2fU/XMj1Qfz74k8nPKoDEK9yrUp+iz5LoBM+nrihCuCNzdDxU+EE2FlY
         mQddEjUEl6OhcsDnzPffCCMKaajfiu1HvM37PPVlDWrw+khd1soYQOHhZVhb2WLas0gP
         uy+M3EsmjKKLpo2qPSDjJ8CvrcuW8tTleEXwKBfsNLlCLSXxLcTDs3Bh/ZVkefVVhMbg
         xtK4or6iMWTGDXvwPXT5G7X3kwPwExDFyrjF1Fhw4sAC4fHZVf+ro31OG8U9ByRUSDIJ
         THsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WNKh5Ln2SPSyB6hXDRRDaXCncwKQcCBGLXaH0FKyu1Y=;
        b=ob/UhMwG7qC9wPYdKBYTeCWiEGbpGzW2A5o64kScO1jyAr3lcdGLJ3tnaO2iWt04AO
         RjvsRNdBbs1pb8fTS5pIE9oPmF5atX8ZGJ+dNaYFjXENqY+IKAuf5ZvjmttHKPonaIdT
         /HLkfgN+IKu2xChWdW/b3Q35AJ+81i001K/NPLh6l1Ezm7rEIs+E+sv5gZSZKBQO8/Xs
         Z0RcjRlxfez/nR6MHoAQYvPaIKFIf+/DOwE6wnFVwCByWPFm4Tk07PcN/YzKjRAz3ua2
         sdxvbcvSQqdCRvjaiK/sq3ITDL894Ww09qZWujnr73JemVKPxaCjI8ORSIkpe31ZRpUs
         p0DQ==
X-Gm-Message-State: AODbwcCFCYlJCaMDyf8PSq8WA65mkPK+PEBShF1rBhBgzV+S1VSRae96
        ZVCEhEnF1olKNA==
X-Received: by 10.84.218.71 with SMTP id f7mr33002312plm.135.1495510420206;
        Mon, 22 May 2017 20:33:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id y2sm12394559pfa.65.2017.05.22.20.33.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 20:33:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2017, #06; Mon, 22)
References: <xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
        <20170522174208.GB17710@aiede.svl.corp.google.com>
Date:   Tue, 23 May 2017 12:33:38 +0900
In-Reply-To: <20170522174208.GB17710@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 22 May 2017 10:42:08 -0700")
Message-ID: <xmqqlgpomelp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> * bw/forking-and-threading (2017-05-15) 14 commits
>>  - usage.c: drop set_error_handle()
>>  - run-command: restrict PATH search to executable files
>>  - run-command: expose is_executable function
>>  - run-command: block signals between fork and execve
>>  - run-command: add note about forking and threading
>>  - run-command: handle dup2 and close errors in child
>>  - run-command: eliminate calls to error handling functions in child
>>  - run-command: don't die in child when duping /dev/null
>>  - run-command: prepare child environment before forking
>>  - string-list: add string_list_remove function
>>  - run-command: use the async-signal-safe execv instead of execvp
>>  - run-command: prepare command before forking
>>  - t0061: run_command executes scripts without a #! line
>>  - t5550: use write_script to generate post-update hook
>>
>>  The "run-command" API implementation has been made more robust
>>  against dead-locking in a threaded environment.
>>
>>  Will merge to 'next'.
>
> What's holding this up?  The deadlock it fixed was a real,
> non-theoretical issue.

Does "Being down-sick over the weekend" count?
