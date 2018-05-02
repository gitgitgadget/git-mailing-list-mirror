Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2ED121847
	for <e@80x24.org>; Wed,  2 May 2018 04:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbeEBEch (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 00:32:37 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45472 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeEBEcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 00:32:36 -0400
Received: by mail-wr0-f172.google.com with SMTP id p5-v6so12456239wre.12
        for <git@vger.kernel.org>; Tue, 01 May 2018 21:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hBFBQDBdSEogAQoYfEJ9IPHBFUSDJcVoMffknocxIfM=;
        b=M+rNTdfpvVvgGiPSkQat88cmuNICD2LTCOI2vfRckKO4WxumRECuM/HxvThC+6lqhA
         iYTBcDGvfVJNSDKbIQ+RPQf09BLm28z1MsO14uYKmDmT7SZaAQ7M07go+8dlqH95E9qT
         JkONogUUP61JWiB1BdviLvwfab2AtgrgmKKNRoKNCNpu0uRlQ13zIoG88J3DiJunolWh
         fHgf4eGkB2bbohPQh15dDqUozPZmGn4axa30U8zU3ogWZN9qlGf0302PXkK+Dac/0qZL
         7ESC6qTDbTsmCrjJrsvIi4aUtNpH+1lloZV9FZiL4WBiqereSzsFDf4iz8igPl2locTb
         Xnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hBFBQDBdSEogAQoYfEJ9IPHBFUSDJcVoMffknocxIfM=;
        b=HHAccwN2ZlcYlJnN68I4oCaQsAxCAm7NtrkW/D1vnSFixS2hSdTPEdQb6CYueLyBFr
         hpvBnRYOuJdKHMHUpi1R04ZHX2x6gie/GqO3C3Lj/uDxEZxgbwZyDwoaAh9el8W2B8vX
         D46o/o16OQDKp3DRXIeyPl1ORAbkWjgRTUYPziEdkoH6e3HVWpjDtcw1+NiFmn3G8IJ5
         u79m53B0VTEUhQxG+7I63J4rTdV7X4ChcQOox54rY2mPU+DvMrnrLcga3wJ9RyJfoXIo
         q8wlRAu6fN4/DNGPrIp2h6W+MUbJUV/juRrvpmN9YrPG6e5Cw7hG1+pilULyIFUd/GCL
         9L9w==
X-Gm-Message-State: ALQs6tCcEbYibeA/9lAsHnCiNZEaEVg8UY2BdDn3E6tjqPSzEVopNnEN
        vmB6GsRx44d5dAOnl1mdEVZrSH4q
X-Google-Smtp-Source: AB8JxZr0vzVo0c1Xn66hQzo7y6OdVOFuTH0jAhLs9+A7PM968ZZ5/Vxp1RZfZdrkSVVL4ILcf1b0/Q==
X-Received: by 2002:adf:ac4f:: with SMTP id v73-v6mr12941245wrc.5.1525235554932;
        Tue, 01 May 2018 21:32:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p128sm18358168wmd.45.2018.05.01.21.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 21:32:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Casey Fitzpatrick <kcghost@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-submodule is missing --dissociate option
References: <CAEp-SHXo2fnyUSMDqJnfOkh_R21R2FjFUtQ14u9s6-tV039tHg@mail.gmail.com>
        <CAEp-SHXXwtgDb=bzTmT88aPQ267ANLCN6S3teC4hjHYDL9NQ3Q@mail.gmail.com>
        <CACBZZX4NMJE0kcgb0aB0z3X6yGhL8VJVx6V3tYfA3socbjTQfA@mail.gmail.com>
Date:   Wed, 02 May 2018 13:32:33 +0900
In-Reply-To: <CACBZZX4NMJE0kcgb0aB0z3X6yGhL8VJVx6V3tYfA3socbjTQfA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 30 Apr
 2018 15:16:19
        +0200")
Message-ID: <xmqqmuxiwuce.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Mon, Apr 30, 2018 at 1:30 PM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
>> It also seems to be missing "--progress", and I imagine others.
>> Perhaps submodule add/update should be reworked to automatically
>> accept all the options that clone would?
>
> --progress is not missing, but I see that it isn't documented. It was
> added in 72c5f88311 ("clone: pass --progress decision to recursive
> submodules", 2016-09-22). What you're suggesting makes sense, but as
> shown in that commit it's not easy for it to happen automatically,
> there's a lot of boilerplate involved.
>
> But since you're interested you can see how to add new options with
> that patch, it should be easy for anyone not experienced with the
> codebase, it's all just boilerplate + adding a test.

I think it is going in the right direction overall, but a few corner
cases may need special attention.  "add" may be adding a new module
that locally originates, in which case "clone" is not relevant.
Similarly, for "update"options for "clone" are not relevant unless
it is the very initial one.
