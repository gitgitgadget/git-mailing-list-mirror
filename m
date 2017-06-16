Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7528D1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 21:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdFPVFH (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 17:05:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33608 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbdFPVFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 17:05:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so2188724pgb.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5WR0UBHCPwCZzSSiDX0VYLy8e7rhE1/gZ426Q/y606Y=;
        b=hcDT9+dF5UHGsfXX05FEv51CojJDSgEHsr3KPuJqdWd+WupnAE57RePolylmfyrQgu
         jR9zXrsPzO15NCv+YkZikarhF20J7+bNrg1Z3BFol0fODa8ghG2Tlw+lkpYnzPZp1A7V
         YKgW96OLXCDw89BR3kp4fQBBW6C/jtniB9VTVPQvVkdMJyW6cAWGmJgPRiDfrtajuqDn
         p/P/WOIkqNz6O1cTbnPjzLd8evsFTun9tTJdZBsBsIyC85fSM3YFfbJ69HyxpB0i6A9y
         viVRHosqoDFrxufRcq+v9ECpu55+EgDAMe7jhQG8Qzg6Sm8BvxIDzFtDorw3pT+OSc0y
         UslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5WR0UBHCPwCZzSSiDX0VYLy8e7rhE1/gZ426Q/y606Y=;
        b=kwQLlaEqcwanQM06ZTMky5n5xH4ZurLuQmL2+No3DgUb8RijYzPE7ZkTKHSRxJaKyk
         PZfcUfPfOzGOkahHSuVF1pkVMOkgkX82hSlZGtBAopVrLew5OCTVvoHBzA3DWbSDFFOW
         dfF/m6/yX0nG4xdzAGd/Z3V/DcBPtLDVIw7OLVon/ZD3R4heDh90fRxm3S4aQpKrIJbl
         7iFfX74EhUq/9MBeGQ6q8qakqaV+YN08ftH1rVDgJpho7x7Wb7cbLyTfDvPL7W8LFeQ6
         G412qWalgL7mJKEQCkdcoP9ebGVx1vfF8lP1RXYLia06QIKsNlNEGKOv29CoUThwrZnl
         n28A==
X-Gm-Message-State: AKS2vOxcsH6n6MbE5Hi/ZFptzMWLZFC3hvkC4bDmcwxIJaGQIgPkDLZ3
        6CTDxHqP46JwGg==
X-Received: by 10.101.76.136 with SMTP id m8mr13229363pgt.159.1497647104264;
        Fri, 16 Jun 2017 14:05:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id 66sm6332487pfm.82.2017.06.16.14.05.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 14:05:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i fixes
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170614102427.5220-1-phillip.wood@talktalk.net>
        <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com>
        <xmqqk24cygvm.fsf@gitster.mtv.corp.google.com>
        <xmqqfuf0ygmu.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706161527140.4200@virtualbox>
        <3c975634-8651-af74-66bf-ee793bc073fc@kdbg.org>
Date:   Fri, 16 Jun 2017 14:05:02 -0700
In-Reply-To: <3c975634-8651-af74-66bf-ee793bc073fc@kdbg.org> (Johannes Sixt's
        message of "Fri, 16 Jun 2017 20:43:26 +0200")
Message-ID: <xmqqvanvwsn5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.06.2017 um 15:49 schrieb Johannes Schindelin:
>> On Thu, 15 Jun 2017, Junio C Hamano wrote:
>>> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
>>> index 325ec75353..801bce25da 100755
>>> --- a/t/t3420-rebase-autostash.sh
>>> +++ b/t/t3420-rebase-autostash.sh
>>> @@ -45,7 +45,7 @@ create_expected_success_am() {
>>>   }
>>>     create_expected_success_interactive() {
>>> -	cr=$'\r' &&
>>> +	cr=$(echo . | tr '.' '\015') &&
>>>   	cat >expected <<-EOF
>>>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>>>   	HEAD is now at $(git rev-parse --short feature-branch) third commit
>>
>> This is still incorrect, as the \r\n (which $(echo . | tr \.\ '\015')
>> would emit) is interpreted correctly as a line break on Windows, meaning
>> that cr is now *empty*. Not what we want.
>>
>> What I did is to replace the `cat` by `q_to_cr` (we have that lovely
>> function, might just as well use it), replace `${cr}` by `Q` and skip the
>> cr variable altogether.
>
> You beat me to it. I came up with the identical q_to_cr changes, but
> haven't dug the remaining failure regarding the swapped output
> lines. You seem to have nailed it. Will test your proposed changes
> tomorrow.

Ouch.  Thanks, both of you.
