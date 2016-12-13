Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5EB1FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 08:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbcLMIdZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 03:33:25 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:32942 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752892AbcLMIdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 03:33:24 -0500
Received: by mail-io0-f171.google.com with SMTP id d9so212602705ioe.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 00:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ORg7f4QS3XZ/om9/sUSEFrDAouAEzLx/ynSu/YPdcS0=;
        b=d3Y+vORhAyuRbDa+9z5GgaDtHBFddsp0+1/MxYVdyOszhbuYfk0G0mPwtiaFPXSeG/
         BjVLPppTTHUiBidS+V1FxJMLyKjQ37EsVSNyOrPiMlbGz11YRjNAllf4bP8gJFao31yu
         00bfROlmCXgpM+1xDpHh8RsEjGtic014cFfiwuWbJVIKLLFU85BxYDHuqIJIZhqN2yfy
         HbGDk1jHb3vEjaRNuhQ5KYU/dg723R1hYLwEE7zQBNab77JljapGeZnuHvUQcrDMFj0B
         TfQ4sA6Z8J5gFp7ixL2gF0DhqETdlpTwQoLNv7YO+YYres7xT1OqvCWu4eNBi0hTIeff
         NuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ORg7f4QS3XZ/om9/sUSEFrDAouAEzLx/ynSu/YPdcS0=;
        b=ktmnSYJs6T78KAxSYDtPaNq36mXE3JsLSey6uKJ7Lr2IBVqyVIqxqIQUZj9YmpD5iu
         NiqhToyg9L5ga6IjK+OWwh91PnHqTotNNbf2NrXaJ99ZJBuJug0MsNF1Hnd9vXUBlN3j
         FruceJZL+BfynW018orGpI0LoGs4OolRuhpHt8GhKumt9y/QZGjFlBVA89Begv0O23p5
         /XCQM4q+tEXe5Ytr2qeIlYXfsh40g7EBe0QxQnAjhxioreZgLcHpP/O3qGpKkcTRMa7O
         tblHTFuj5xumN/Y2M252rOBNEIsUW7bmVQjZDpj0V2kQWJCl75ZeEb+anJOSpRfBhJfo
         On8g==
X-Gm-Message-State: AKaTC01GHpkixggyPbAU8mRFqWL2nu3Egve3Sjgqz/mNf3A86J//9//jD7lp6TN7UMUmZ+gXr/Qgm2kfL8R4jw==
X-Received: by 10.36.203.66 with SMTP id u63mr1478038itg.111.1481618003790;
 Tue, 13 Dec 2016 00:33:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.0.93 with HTTP; Tue, 13 Dec 2016 00:33:23 -0800 (PST)
In-Reply-To: <b814932a-b395-2b27-979f-cd170ba363ee@jump-ing.de>
References: <CAFOYHZAsU_gNb=_K=iMFKFdt60SJ4Wm=Ag5=XMXuQgxNxCqWLA@mail.gmail.com>
 <20161212083413.7334-1-judge.packham@gmail.com> <b814932a-b395-2b27-979f-cd170ba363ee@jump-ing.de>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Tue, 13 Dec 2016 21:33:23 +1300
Message-ID: <CAFOYHZCEOXxFCih9E00kf1A7Y_QKe2GCuCB6w8_DJVRevNN9CQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] merge: Add '--continue' option as a synonym for 'git commit'
To:     Markus Hitter <mah@jump-ing.de>
Cc:     GIT <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 10:02 PM, Markus Hitter <mah@jump-ing.de> wrote:
> Am 12.12.2016 um 09:34 schrieb Chris Packham:
>> Teach 'git merge' the --continue option which allows 'continuing' a
>> merge by completing it. The traditional way of completing a merge after
>> resolving conflicts is to use 'git commit'. Now with commands like 'git
>> rebase' and 'git cherry-pick' having a '--continue' option adding such
>> an option to 'git merge' presents a consistent UI.
>
> Like.
>
> While Junio is entirely right that this is redundant, the inner workings of Git are just voodoo for a (guessed) 95% of users out there, so a consistent UI is important.
>
>>  DESCRIPTION
>>  -----------
>> @@ -61,6 +62,9 @@ reconstruct the original (pre-merge) changes. Therefore:
>>  discouraged: while possible, it may leave you in a state that is hard to
>>  back out of in the case of a conflict.
>>
>> +The fourth syntax ("`git merge --continue`") can only be run after the
>> +merge has resulted in conflicts. 'git merge --continue' will take the
>> +currently staged changes and complete the merge.
>
> I think this should mention the equivalence to 'git commit'.
>

It is mentioned in the OPTIONS section where the --continue option is
documented. I could move it here but the OPTIONS section is where the
--abort synonym also has a reference to git reset --merge.

>
> Markus
>
> --
> - - - - - - - - - - - - - - - - - - -
> Dipl. Ing. (FH) Markus Hitter
> http://www.jump-ing.de/
