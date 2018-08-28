Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09B61F404
	for <e@80x24.org>; Tue, 28 Aug 2018 13:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeH1RiB (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 13:38:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36377 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbeH1RiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 13:38:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so1424084edq.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OXHgRmUAuEEatU9wlDAP4B00C39VBUFPmD26RHsaOVY=;
        b=agXXKVIj7OwKivgowbWhvh8H41POp21jFFoaXXX6KA+OFyP3BjRBxoQ5KFnS5i3oxk
         eBpzx4erCFkIOJRVsjv43eaO4MSiaMcG6eoGXTn2McgstHFDMXyAfn8FEcldChiW3g4M
         50Hzeb6Z6PbiVys2oNsMdykqdXR0SkJGI+m8ekBe0LQQecbELS5xXSEMlnqOlmdEwYRL
         tsgH/Pcrw03lNduWXQhKumjuvYm/GqNDyRjjLxhTIBepNozGIT6lqrPi8m+aQ6WHdpKZ
         9rp9dTzUcmg6eBPg1mW/hqaTooGpUzRCzIpoLtTzEvk8D1d2Uqs3XW7jLsajyTpf+c2x
         oWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OXHgRmUAuEEatU9wlDAP4B00C39VBUFPmD26RHsaOVY=;
        b=Mcm/oEj+oU0UZqf5hMmpULTETSwn+pnGJWWuGpuKzOuxHRC4Eo3bhY8kH6WIVQ95SJ
         5+UJ6v/R3BglkJrmunwG88pTpCeD/7UbimfCoWQ6j27P2LcPRpnGSp4WqnMFLd19Cib0
         0Jo9l5cB7ogKiyV9iRdoNyT2P0T+2Gba2I9sP5gJEYNp9IA1276Cjw94cHIa3g5y45AB
         Q2uZ/dshrgHQFvfY3ra4Ws9KkHbHaKkNoHnuvUGUEhevddZk8F3PYZxdHh2Kn72MXpsr
         GkL8hz+MMHCmf4vIANJf0X6Ldio1o9z5EWJa7mJ5s68veIojV0h1uSCCW+zfqEbMrAsV
         xLog==
X-Gm-Message-State: APzg51CqxIAmxKa8S5Qq9GLDuc4AYSBRgSrGHtApZr49b5HhclAWLfay
        FcaSE+gTgvjKBQj/9fW0pAQ=
X-Google-Smtp-Source: ANB0VdZRLxRjy/QTa4/QihKEMOP54DhZDO4yPfP6gMRUhqnCfXN0YImXDdN809BO0CS4+7A6bPyJuQ==
X-Received: by 2002:aa7:c384:: with SMTP id k4-v6mr2604765edq.270.1535463974778;
        Tue, 28 Aug 2018 06:46:14 -0700 (PDT)
Received: from nikolays-mbp.flixbus.com (h-213.61.119.99.host.de.colt.net. [213.61.119.99])
        by smtp.gmail.com with ESMTPSA id g39-v6sm788432edg.63.2018.08.28.06.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 06:46:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: A rebase regression in Git 2.18.0
From:   Nikolay Kasyanov <corrmage@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.1808281532220.16620@tvgsbejvaqbjf.bet>
Date:   Tue, 28 Aug 2018 15:46:12 +0200
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDE5DF36-1E32-4FC0-A206-81FAA1A962E4@gmail.com>
References: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com>
 <87in3ueiks.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1808281532220.16620@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Yes, it does fix this behavior. Could you please point me to the thread?

Best,
Nikolay
> On 28. Aug 2018, at 15:33, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> Hi,
>=20
> On Tue, 28 Aug 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
>> On Tue, Aug 28 2018, Nikolay Kasyanov wrote:
>>=20
>>> I=E2=80=99ve found something that may be a regression in git rebase =
implementation in 2.18.0.
>>> First I spotted it on macOS but I can also confirm it happening on =
Linux.
>>> Git 2.19.0.rc0.48.gb9dfa238d is affected too.
>>>=20
>>> In order to trigger it, a repo layout similar to the following is =
required:
>>>=20
>>> files/
>>> 	file1
>>> 	file2
>>> 	file3
>>> 	file4
>>> 	file5
>>> project
>>>=20
>>> Let=E2=80=99s call this state baseline. Then, in a branch, let=E2=80=99=
s edit project file and move file3 to nested/files subdirectory, =
here=E2=80=99s the final layout:
>>>=20
>>> files/
>>> 	file1
>>> 	file2
>>> 	file4
>>> 	file5
>>> nested/
>>> 	files/
>>> 		file3
>>> project
>>>=20
>>> Let=E2=80=99s get back to master and also edit project file to cause =
a conflict. After that trying to rebase the branch upon master will =
cause the following git status output:
>>>=20
>>> rebase in progress; onto baf8d2a
>>> You are currently rebasing branch 'branch' on 'baf8d2a'.
>>>  (fix conflicts and then run "git rebase --continue")
>>>  (use "git rebase --skip" to skip this patch)
>>>  (use "git rebase --abort" to check out the original branch)
>>>=20
>>> Changes to be committed:
>>>  (use "git reset HEAD <file>..." to unstage)
>>>=20
>>> 	renamed:    files/file1 -> nested/files/file1
>>> 	renamed:    files/file2 -> nested/files/file2
>>> 	renamed:    files/file3 -> nested/files/file3
>>> 	renamed:    files/file4 -> nested/files/file4
>>> 	renamed:    files/file5 -> nested/files/file5
>>>=20
>>> Unmerged paths:
>>>  (use "git reset HEAD <file>..." to unstage)
>>>  (use "git add <file>..." to mark resolution)
>>>=20
>>> 	both modified:   project
>>>=20
>>> All renames except file3 are invalid and shouldn=E2=80=99t be here.
>>> Here=E2=80=99s how the output looks like produced by an older Git =
version (git version 2.15.1):
>>>=20
>>> rebase in progress; onto baf8d2a
>>> You are currently rebasing branch 'branch' on 'baf8d2a'.
>>>  (fix conflicts and then run "git rebase --continue")
>>>  (use "git rebase --skip" to skip this patch)
>>>  (use "git rebase --abort" to check out the original branch)
>>>=20
>>> Changes to be committed:
>>>  (use "git reset HEAD <file>..." to unstage)
>>>=20
>>> 	renamed:    files/file3 -> nested/files/file3
>>>=20
>>> Unmerged paths:
>>>  (use "git reset HEAD <file>..." to unstage)
>>>  (use "git add <file>..." to mark resolution)
>>>=20
>>> 	both modified:   project
>>>=20
>>> Here=E2=80=99s a ready-to-use repository: =
https://github.com/nikolaykasyanov/git-rebase-bug.
>>=20
>> Thanks for the test case. This bisects down to 9c0743fe1e
>> ("merge-recursive: apply necessary modifications for directory =
renames",
>> 2018-04-19) first released as part of 2.18.0.
>>=20
>> I have not dug to see if the behavior change is desired or not, that
>> commit changed the results of a bunch of test cases, maybe it was
>> intended. Elijah?
>=20
> I think this was already mentioned before, in a different mail thread:
> have you tried whether `git rebase -m` fixes that behavior?
>=20
> Ciao,
> Johannes

