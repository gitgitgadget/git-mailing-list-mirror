Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EEA81F51C
	for <e@80x24.org>; Fri, 18 May 2018 12:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeERMZ3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 08:25:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44944 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERMZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 08:25:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id q22-v6so3687656pff.11
        for <git@vger.kernel.org>; Fri, 18 May 2018 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=El43YL8yQGwr0FZkcDz8OMUk7qFLkInJeHCUNpBsogE=;
        b=QU5wNBpDKXPyoOZJkRscApblrzOmNWB2VCWQ50u4WzkO+eILufbfebiVVZNlxBS7Fl
         Ja/01CvJ8BXZJIXnTp/D077D2rFkCM0eHNU4j+gFyr6W5B3Zl/Syc0HWu47lhl8np/lJ
         u59gOzaVdAEbVaih3vV515Cp1gP/JpFd9nHZ3o8rI7E0rX8ZfAUudQeYNygwh8e+9/g8
         ry99bfTDYo0jNIw+o+0iKRlnOdwG0Up6Is95yJBp3TpF5ohflOOjc7UGDlxNd4ZeVORb
         lrUK3kPy4DYfgZWf+vKmm0+WJ1rR6F/0we8h/TQdMDmedGv1dRQDqvM9Sl3pkiNnVJAu
         NnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=El43YL8yQGwr0FZkcDz8OMUk7qFLkInJeHCUNpBsogE=;
        b=nFm5iQA17MtOwyg7F9dXhy0Bn3FEOlIhHyEbdVir9b6+RwyjI6f1ldrWnlYfhOKsp9
         yURpLdw/dRnDBpvKeRpVRfiSZRVxB7htf94HWcui3O/1nrwkUSDE0zMXlDSLPvRj4F1q
         R03osuXM1b0IOxhBhzYkR22HreuFVyuGPeo99dbJgLB0ILGVFdAr4h2pqjMTvo1QGPM6
         eHQI00d1KzTgbPQpibhZ2uSn78e1+0e22rms6O6mTd1JGdx7Ks3RPowRwbMF+ZwfUMim
         KSNl50ceUWR3EBP65CaJu82zqzBlVnPNoVGERsqWJ6QMbQqFX6eCBqALnpTwlyNiHu1K
         bZqg==
X-Gm-Message-State: ALKqPwfllzM315hfHu3tBVgqENWjyp3zpVqzgjwQpswhIUbGUak61SLP
        TUxbT4cL4DMo7k4PXiIe6y7CyTL9fnyz274izWyzDnIY
X-Google-Smtp-Source: AB8JxZprh3DPN1GbjmX+POJwuuHlA1NB2NPbCMhh2Bx+biLLZ9yoJVvnEEoa3x+wJDBEIaGeqskK86WXKLJsrHXlDWU=
X-Received: by 2002:a63:7e08:: with SMTP id z8-v6mr7346849pgc.383.1526646327494;
 Fri, 18 May 2018 05:25:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 18 May 2018 05:25:26 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805180648020.10270@localhost.localdomain>
References: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain>
 <CAN0heSrJMFij9xt6RstLD16+2CxJ_HALer4iRL74AZQvH0VWRQ@mail.gmail.com> <alpine.LFD.2.21.1805180648020.10270@localhost.localdomain>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 18 May 2018 14:25:26 +0200
Message-ID: <CAN0heSpVKd=-Dpdk09LVtTd0vC2dLUwg0=hbxhKskM3RencsYA@mail.gmail.com>
Subject: Re: error(?) in "man git-stash" regarding "--keep-index"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 May 2018 at 12:51, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Fri, 18 May 2018, Martin =C3=85gren wrote:
>
>> On 18 May 2018 at 11:37, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>> >
>> >   toward the bottom of "man git-stash", one reads part of an example:
>> >
>> >   # ... hack hack hack ...
>> >   $ git add --patch foo            # add just first part to the index
>> >   $ git stash push --keep-index    # save all other changes to the sta=
sh
>> >                                               ^^^^^ ???
>> >
>> > i thought that, even if "--keep-index" left staged changes in the
>> > index, it still included those staged changes in the stash. that's
>> > not the impression one gets from the above.

If I try to follow the example, it does exactly what it purports to do
and I understand why I would want to use this exact technique with
`--keep-index` in the situation outlined: "you want to make two or more
commits out of the changes in the work tree, and you want to test each
change before committing"

So I claim that the example is correct in the sense that it describes
what happens when one uses git in the real world. Another question is
whether the example and the real-world behavior match the impression
you have from elsewhere, e.g., from earlier in the man-page.

That's why I asked this:

>> So would the error be in the part of the man-page quoted below?
>>
>>   If the --keep-index option is used, all changes already added to
>>   the index are left intact.
>
>   no, that part is correct, it clearly(?) states that staged changes
> are left where they are, in the index. i submit that the misleading
> part is in the example i quoted, which suggests that only the "other"
> changes are saved to the stash -- that is, the changes other than what
> is already in the index.

Could you try the example? I think it is important that we find whether
the source of confusion is the example or the earlier explanation
quoted just here.

>> That is, this doesn't say *where* things are left intact (in the
>> index? in the working tree?).
>
>   in that case, that's something that could obviously be clarified.

Would you suggest adding something like "both in the index and in the
working tree" to what I quoted above?

>> The man-page does start with
>>
>>   git-stash - Stash the changes in a dirty working directory away
>>
>> which to me suggests that "leaving something intact" refers to
>> precisely this -- the working directory.
>>
>> Or is it the name of the option that trips you up? That is, you read
>> the name as `--keep-the-index-as-is-but-stash-as-usual`, as opposed
>> to `--keep-what-is-already-in-the-index-around`?
>>
>> While I'm sure that some clarification could be provided, I'm tempted to
>> argue that is exactly what the example provides that you quoted from.
>
>   i guess we can agree to disagree, since i think the snippet of the
> example i provided gives a misleading explanation.

We can disagree on many things, but I would very much like us to agree
on whether the example correctly describes what the command does, or
not.

Then, if the error or source of confusion is not there, then let's
identify it and see if we can find out how to address it.

I suggest that the source of confusion is here:

  If the --keep-index option is used, all changes already added to
  the index are left intact.

Martin
