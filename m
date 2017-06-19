Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5761FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 20:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdFSUCb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 16:02:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35956 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdFSUCa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 16:02:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id e187so9113465pgc.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sZCDzhzbUw2PZBXiwNDlYCptFUmHo7MyOLIy8tIFeQw=;
        b=pG2aAuF0PAoxIHXHsI5m+DdnD3+jGfZ6N+zTb+bFKik/zYc3optNiPzpFdySJtFlNP
         5dm9y/lug6EQOPNmyddrMcuCC8T0ZE4/AP7qj/VEQ3QOjEn++dhLnL4OvNnEyh4Zwbq9
         6M5eI++j5lD0nhCNbsb9xV5aElPw04KzO88dct1uFQYbwYejms+T1It1WZzUtiQVYTWc
         +bad0Ve2UIm4pFd8i7jDUpU1F/gIf4FIBYRELtU2nrDMcz+yJn0SofYtnqFLbW6lwHPb
         elJswEsf4VJcEPTDeE9fCzDqpSUTn+abJpNFiwX04eVuvyd9Avtd/M64MorQQzTYibYx
         yaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sZCDzhzbUw2PZBXiwNDlYCptFUmHo7MyOLIy8tIFeQw=;
        b=aIPmBhHd83w+Oy+P2+kLkWFTnPoF9lt9yy7fqyYO1r4LjXtyskKDDgGNXsugt1OsPK
         7qcjQporv5ZO8axinVFZsh/4x3uMY6hwnaScHgjVVe2mX/UkuKZwMwzGR/QX2TKXw3ZK
         FvO7PrgSdJVj6OO9jX7/7jruUMp2BJIzMTKlRUHhPY6W5wjzvit8Mb173N8fmQ0KnnXL
         lDYC9zO3jbcih/8w9ASt9nDbGHxaJJRKckhDJubEBdYTtJmMKsTuXz8Q6nO6io7NVvUL
         0gPVRrHgmNSEAkFOlw9MUsRx+34QbYOyYSJUkkBUqEsyLB/OAQoTRG28UmOgX0qA55y9
         I0LQ==
X-Gm-Message-State: AKS2vOwdkDaplTzASVq1onjipF7vIOu2cjZV+orU6Ii9rn5BDggPlhVk
        ssUxPFQl4XgF6A==
X-Received: by 10.84.232.141 with SMTP id i13mr31098069plk.172.1497902549334;
        Mon, 19 Jun 2017 13:02:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id o8sm24020911pfj.65.2017.06.19.13.02.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 13:02:26 -0700 (PDT)
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
        <8be59224-5bb7-50e6-4381-29c250fb10ec@kdbg.org>
Date:   Mon, 19 Jun 2017 13:02:26 -0700
In-Reply-To: <8be59224-5bb7-50e6-4381-29c250fb10ec@kdbg.org> (Johannes Sixt's
        message of "Mon, 19 Jun 2017 21:45:39 +0200")
Message-ID: <xmqqr2yfsq3x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.06.2017 um 20:43 schrieb Johannes Sixt:
>> Am 16.06.2017 um 15:49 schrieb Johannes Schindelin:
>>> On Thu, 15 Jun 2017, Junio C Hamano wrote:
>>>> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
>>>> index 325ec75353..801bce25da 100755
>>>> --- a/t/t3420-rebase-autostash.sh
>>>> +++ b/t/t3420-rebase-autostash.sh
>>>> @@ -45,7 +45,7 @@ create_expected_success_am() {
>>>>   }
>>>>   create_expected_success_interactive() {
>>>> -    cr=$'\r' &&
>>>> +    cr=$(echo . | tr '.' '\015') &&
>>>>       cat >expected <<-EOF
>>>>       $(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>>>>       HEAD is now at $(git rev-parse --short feature-branch) third
>>>> commit
>>>
>>> This is still incorrect, as the \r\n (which $(echo . | tr \.\ '\015')
>>> would emit) is interpreted correctly as a line break on Windows, meaning
>>> that cr is now *empty*. Not what we want.
>>>
>>> What I did is to replace the `cat` by `q_to_cr` (we have that lovely
>>> function, might just as well use it), replace `${cr}` by `Q` and skip the
>>> cr variable altogether.
>>
>> You beat me to it. I came up with the identical q_to_cr changes, but
>> haven't dug the remaining failure regarding the swapped output
>> lines. You seem to have nailed it. Will test your proposed changes
>> tomorrow.
>
> As expected, the patches fix the observed test failures for me, too,
> if that's still relevant.

Thanks for double-checking.
