Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84063209FA
	for <e@80x24.org>; Wed, 12 Apr 2017 13:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754353AbdDLNbX (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 09:31:23 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33810 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbdDLNal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 09:30:41 -0400
Received: by mail-io0-f178.google.com with SMTP id a103so41518043ioj.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FBg/OuqaGNHbpjt6OBHPHUkZRyjzxDWC1jgBkI1etGU=;
        b=Ui7CJM7NZ91KB5l8qCnw9PTNds2MG/H25qfccOg9th53wcEqTwwFD5xWwRHxj95BZW
         VvvXHum4KXU4vgbJ1qemibeqI9/n1/NiW/Cryu8fho51rU0Z5znWKDX4ZCWMH3UL1iku
         7sKRJKVLPoyj5DlGU/SndJczccxTcVHamguIVvEBPn7UxZB1qC9tsYuRp9KAcWiYO8xJ
         jYAHnDJkC6N5b6wNR+gO7GD3tVhJ2oi+JDiqmP/DB6Z3dwYWO63XhMjuKFMuxfJyPh7c
         AYoW6NqXS/scXsm3iEWAm/iRr/lx5OCIMm7qwWWFzjEzd3PKwhY9RBR00lTCJ268T5hM
         SdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FBg/OuqaGNHbpjt6OBHPHUkZRyjzxDWC1jgBkI1etGU=;
        b=fxu56SXQdU88wsq1WZGWf5fjHX3sWoYviGudcnMPJfKy1QdcZrUP7XF/YKyAqr4n/L
         7j0WB3pwMH963V93jBVi8PIQ8pioQphSkMZ/2YOfXRUu5nBZqwpJnie1lDFZ8gYLcguv
         gMWR070RhjatLQ0xvTr/nlN4m7NtxoN3ihpZ37GecvTNpM7/P3XgH3cVIRShDQjQt3De
         ruSd/63olAMjmGL2vZ1KtOhxgy1KC0l85Jnc54qReQzmITtWgDw56yGimGFgXh1WoKof
         FTvDR56Ufy7Flrtpk3I9KaJ2SsW4j9gLdAAIV/8DoND0T2FsINWTgwOqFFkP/m+7c97R
         DsXw==
X-Gm-Message-State: AFeK/H25hKlERSL5wmMbWwiFoYK5hzI9d7fDcJcfW6gcVHcaoeimonl3tAMOh0avcG7j1YLpkWC1tBN+3tf0NQ==
X-Received: by 10.107.150.201 with SMTP id y192mr68287004iod.33.1492003832939;
 Wed, 12 Apr 2017 06:30:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 12 Apr 2017 06:30:12 -0700 (PDT)
In-Reply-To: <61ef36d9-7f25-80d6-5216-554684bd54dd@grubix.eu>
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
 <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu> <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com>
 <CACBZZX7xqoZ3LboOjwvQvX3JRJFhjFC54+mfLOddLXzconrobw@mail.gmail.com>
 <5704E476-BD11-47D1-A15E-C1E29A1398AD@grubix.eu> <CACBZZX4W1kk2cnncWz1EVjA-WtFryYzNoiiDHR9+9VC4AKJhKg@mail.gmail.com>
 <61ef36d9-7f25-80d6-5216-554684bd54dd@grubix.eu>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 12 Apr 2017 15:30:12 +0200
Message-ID: <CACBZZX4Fkvbqz-ynKwsoj8c4dYZxjjW-OkQbM=SNePL1HAPxkw@mail.gmail.com>
Subject: Re: `git status` output is very misleading after a merge on a
 "detached HEAD"
To:     Michael J Gruber <git@grubix.eu>
Cc:     =?UTF-8?Q?Enis_Bayramo=C4=9Flu?= <enis@picussecurity.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 3:11 PM, Michael J Gruber <git@grubix.eu> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 12.04.2017 14:=
18:
>> On Wed, Apr 12, 2017 at 7:43 AM, Michael J Gruber <git@grubix.eu> wrote:
>>> Am 11. April 2017 22:40:14 MESZ schrieb "=C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason" <avarab@gmail.com>:
>>>> On Tue, Apr 11, 2017 at 5:13 PM, Enis Bayramo=C4=9Flu
>>>>> HEAD detached from origin/master 1 commit ago,
>>>>
>>>> In lieu of that, which would need some of the rev-list machinery to be
>>>> invoked on every git-status, I wonder if just saying "HEAD detached &
>>>> diverged from origin/master" wouldn't be clearer:
>>>>
>>>> diff --git a/wt-status.c b/wt-status.c
>>>> index 308cf3779e..79c8cfd1cf 100644
>>>> --- a/wt-status.c
>>>> +++ b/wt-status.c
>>>> @@ -1542,7 +1542,7 @@ static void wt_longstatus_print(struct wt_status
>>>> *s)
>>>>                                if (state.detached_at)
>>>>                                      on_what =3D _("HEAD detached at "=
);
>>>>                                else
>>>> -                                       on_what =3D _("HEAD detached f=
rom
>>>> ");
>>>> +                                       on_what =3D _("HEAD detached &
>>>> diverged from ");
>>>>                        } else {
>>>>                                branch_name =3D "";
>>>>                           on_what =3D _("Not currently on any branch."=
);
>>>>
>>>>
>>>>
>>>
>>> No way. That would reduce the information that we give.
>>
>> How does it reduce the information we give? Maybe I've missed
>> something about what "from" means here, as opposed to "at", but it
>> seems to me to mean the same thing as "diverged" by definition, i.e.
>> we detached from the branch but we diverged from it.
>
> No, "at" means we're still at that commit - detached but not diverged.
> "from" means we only started from that commit, but are not at it any more=
.
>
>> Saying "diverged"
>> just makes it clearer, how does it reduce the information we give?
>
> I misread your patch on my mobile phone, sorry. I thought you meant to
> replace both "at" and "from" by "diverged from" because you considered
> them synonymous.
>
> But your patch touches just the" from" case and emphasizes the "diverge"
> aspect, which is fine, of course.

Ah, that explains the confusion. Yeah saying "diverged" for the "at"
case wouldn't make any sense, there's been no divergence.

>>> Note that the difference between from and at is also: are there commits=
 that we could lose when we switch away, that is: that git checkout would w=
arn us about?
>>
>> Right, but I don't see how that's in any way conflicting or mutually
>> exclusive with saying before hand that we've diverged from the branch.
>>
>>> Maybe improve the doc instead?
>>
>> Aside from whether my patch makes any sense, the solution to a UX
>> issue really can't be "oh this just needs to be documented". For every
>> user who's confused by some interface we provide a *tiny* minority of
>> them go and exhaustively read the docs for an explanation, will just
>> remain confused.
>>
>> I think saying from v.s. at is way too subtle, I for one have been
>> missing it for years until this thread, that's bad UX, git's also used
>> by a lot of non-native English speakers who may not at all get the
>> subtle difference between at and from in this context, or if they do
>> think the UI is using that subtlety to tell them something.
>
> Well, we have to find the right balance between clarity and brevity - an
> interface that is too chatty is a nightmare. That's why I suggested both
> doc changes and additional information.
>
> What do you think about the ahead/behind info as suggested? That should
> be more informative both qualitatively (something diverged) and
> quantitatively (by how much).

I think it's better UX, but worry about placing something like
revision walking into "git status", that can take a long time. E.g. on
linux.git doing:

    git checkout origin/master
    git reset --hard v2.6.13

Will yield:

    $ time echo "[ahead $(git rev-list origin/master..HEAD|wc -l),
behind $(git rev-list HEAD..origin/master|wc -l)]"
    [ahead 1, behind 657045]
    real    0m7.859s

That's admittedly a very pathological case, and could be solved in
practice by changing the copy so that after e.g. 100 commits we start
saying "over 100 commits ahead..." or something like that.
