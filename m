Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3BD91F404
	for <e@80x24.org>; Fri,  2 Mar 2018 16:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426881AbeCBQDS (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 11:03:18 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35323 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423736AbeCBQDO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 11:03:14 -0500
Received: by mail-wm0-f68.google.com with SMTP id x7so3957664wmc.0
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 08:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Y5YfloX5wt7GeXylcHoW4xevM3r9p810QsirCOQubY=;
        b=tEPABhmqiElmKT/ZdPTJNBjz8APkoVm/JK6Ba1LF1ARoE4hIxhTKxrUtwWA9bf6nAi
         evLHP8ewUIsPskgdRZUIDTQbyV5byJauyvWrhnxGRZ15POWR5+K+jc69WNJKPlPkd/8n
         BHX/F9nv9yD+FUvPpXVegKVhZMkP3e4gMgYdtlD+cTO51KY+VWvZ48Iom4BYZkzxtBv7
         xkD4X8h57UrsgATpJJBnAbDhhpUD5FJFi1NibcJ/USYKSFNOgMZCrJ7C9jbSI65C4SdF
         tYRWC8uw7ChENoMN8ZuFroJRWfQjGylv8dY5JRUKu0YOJHeqXe84pzdzC6m2DteQJPdG
         /r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Y5YfloX5wt7GeXylcHoW4xevM3r9p810QsirCOQubY=;
        b=Ug8w4SLo3bemyrO86UEajlrQtOPFMv6MhtPhzrMxcNoPzdGq3hgo62BicZGMaOOjc+
         DJFNHJPiAinHbqj1zzxDFLF3wQw4RlqgfLIkzQcqzrXLTc+A7INICd+oDEOLTyKZ7m6b
         5JuTgUmQYwq+tapscFMPnUeaz3093N5R+KQ+MKCU3iX3evFzBIAOjvPT6E8FSJ+ynMZU
         28H+iNa4iqNLinpE+ZoOtY6d4//dAkbjXk9cBElmK77tzp3iz1eZDx7JyppjAe/ZafXY
         inagUMVUEG4XEXA4SR6PJgxNM1MLSiQtB/WPpHyuMAnNa6/lrchBnkCLtBE93wDkSMlv
         AEAg==
X-Gm-Message-State: APf1xPA+zn/Vn7x+l6z1mmQW6HOlYv+xXwhq1uGprHo2aAZ9SZl+6/zt
        2PahSVwkasnFv2Jvkqfvs7N8VKoiVHvOCGgpI84=
X-Google-Smtp-Source: AG47ELvggP/3coP5f2nv52beH3kZw3cMxhz/HhHe/xECktlgRUqEnYqdL+a4Gcj9W92Cy0oOpukMkz+ngdegQggfs/I=
X-Received: by 10.80.153.221 with SMTP id n29mr8035653edb.303.1520006592499;
 Fri, 02 Mar 2018 08:03:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Fri, 2 Mar 2018 08:02:51 -0800 (PST)
In-Reply-To: <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 2 Mar 2018 08:02:51 -0800
Message-ID: <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 4:36 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 02/03/18 11:17, Phillip Wood wrote:
>>
>> On 02/03/18 01:16, Igor Djordjevic wrote:
>>>
>>> Hi Sergey,
>>>
>>> On 01/03/2018 06:39, Sergey Organov wrote:
>>>>
>>>>>> (3) ---X1---o---o---o---o---o---X2
>>>>>>        |\                       |\
>>>>>>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>>>>>>        |             \          |
>>>>>>        |              M         |
>>>>>>        |             /          |
>>>>>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
>>>>>>
>>>>>
>>>>> Meh, I hope I`m rushing it now, but for example, if we had decided to
>>>>> drop commit A2 during an interactive rebase (so losing A2' from
>>>>> diagram above), wouldn`t U2' still introduce those changes back, once
>>>>> U1' and U2' are merged, being incorrect/unwanted behavior...? :/
>>>>>
>>>>> [...]
>>>>
>>>> Yeah, I now see it myself. I'm sorry for being lazy and not inspecting
>>>> this more carefully in the first place.
>>>
>>> No problem, that`s why we`re discussing it, and I`m glad we`re
>>> aligned now, so we can move forward :)
>>>
>>>>> So while your original proposal currently seems like it could be
>>>>> working nicely for non-interactive rebase (and might be some simpler
>>>>> interactive ones), now hitting/acknowledging its first real use
>>>>> limit, my additional quick attempt[1] just tries to aid pretty
>>>>> interesting case of complicated interactive rebase, too, where we
>>>>> might be able to do better as well, still using you original proposal
>>>>> as a base idea :)
>>>>
>>>> Yes, thank you for pushing me back to reality! :-) The work and thoughts
>>>> you are putting into solving the puzzle are greatly appreciated!
>>>
>>> You`re welcome, and I am enjoying it :)
>>>
>>>> Thinking about it overnight, I now suspect that original proposal had a
>>>> mistake in the final merge step. I think that what you did is a way to
>>>> fix it, and I want to try to figure what exactly was wrong in the
>>>> original proposal and to find simpler way of doing it right.
>>>>
>>>> The likely solution is to use original UM as a merge-base for final
>>>> 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
>>>> though, as that's exactly UM from which both U1' and U2' have diverged
>>>> due to rebasing and other history editing.
>>>
>>> Yes, this might be it...! ;)
>>>
>>> To prove myself it works, I`ve assembled a pretty crazy `-s ours`
>>> merge interactive rebase scenario, and it seems this passes the test,
>>> ticking all the check boxes (I could think of) :P
>
> Hi Igor
>
>> It is interesting to think what it means to faithfully rebase a '-s
>> ours' merge.
> I should have explained that I mean is a faithful rebase one that
> adheres to the semantics of '-s ours' (i.e. ignores any changes in the
> side branch) or one that merges new changes from the side branch into
> the content of the original merge? In your example you add B4 to B. If
> M' preserves the semantics of '-s ours' then it will not contain the
> changes in B4. I think your result does (correct me if I'm wrong) so it
> is preserving the content of the original merge rather than the
> semantics of it.
>
> Best Wishes
>
> Phillip
>

I believe this was always the outline of this type of approach, as per
Sergey's original email.

We only have the content, and we don't know the semantics (nor, I
think, should we attempt to understand or figure out the semantics).

Regards,
Jake
