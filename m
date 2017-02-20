Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE674201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbdBTM1h (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:27:37 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33259 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbdBTM1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 07:27:36 -0500
Received: by mail-lf0-f47.google.com with SMTP id l12so11597205lfe.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 04:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=N4jDfW5sBTMHiFGaCVw9oOPsKw3FgQ6NE8bdOYHRxz0=;
        b=jJl2MAuQlXUYZG+kwWSKYzNonyZaPFaXLTSCbtzVmnD9S/e3TtLV/d+Mj8XIQwca7z
         ycT3d671ik53ZYo/CiyABMFxziPqOYExNYJnFZnYiqRHUMvA8iCMwEPKmZfDX7WUTMjt
         /6FQVdhwmLIr8i7EDujuCRUfTLi1n25wFNZO8gyJJIjNxS1mT2Pu0QGkNbGX12uGPRxA
         wGGTX++wYI1Zi4Cu+3KQSrJMwuYGFxE//6+CzAKhSbRFVaCRHad5b9KIl3ejg67S5YkC
         8cOoRoNPB8cpbEaAwSvvW8KyV+uiGagP8PuSg/jB6VAfBQve0otlmsIw4gTjhcdJLbSt
         WRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=N4jDfW5sBTMHiFGaCVw9oOPsKw3FgQ6NE8bdOYHRxz0=;
        b=PljI1Q5gQz6s5TlnOUDletEsg2GvJw5juel7gv2B5YnL24JeNUorzo8vtcy5q8pCAW
         xI0kPvh/WPyq/3IKdFxyf2uJpQpJpkueKI3rSydxh4I6dwoIreOuOliFK/qpZTmE4K16
         0s3oY8S6LG9yZfJRF4RbbClPr+pVPgHa0h5CudSV7kuIKfZFWOFIkAPDQmIKHrDeyoat
         eI3hDVrSmQTKMoQzmpH62f0KDUeZzzwwNZAFCYCNsntsjJz9btEj37TP2uqfJLhWhkWb
         QUDLko2Gq4x4hSqqTCj7R6EBOUXnPU4iZOzOxRzPcEAALR/gknVs5E8Jjdb6Clq1dyyR
         LpYA==
X-Gm-Message-State: AMke39keGAg6o64YncPT0CUVopluYCvFvIMjboOJ3X9W/bCcBT0VquI5SBfkxyetXBmfcA==
X-Received: by 10.46.87.67 with SMTP id r3mr5505750ljd.31.1487593655055;
        Mon, 20 Feb 2017 04:27:35 -0800 (PST)
Received: from [192.168.1.26] (adat244.neoplus.adsl.tpnet.pl. [83.11.255.244])
        by smtp.googlemail.com with ESMTPSA id p19sm5179269lfe.1.2017.02.20.04.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2017 04:27:34 -0800 (PST)
Subject: Re: Git bisect does not find commit introducing the bug
To:     Oleg Taranenko <olegtaranenko@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net>
 <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org>
 <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
 <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org>
 <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
 <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com>
 <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com>
Cc:     Alex Hoffman <spec@gal.ro>, Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <58d25138-de2e-6995-444f-79c3ac0bbad2@gmail.com>
Date:   Mon, 20 Feb 2017 13:27:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.02.2017 o 08:38, Oleg Taranenko pisze:

>>>> Then you must adjust your definition of "good": All commits that do not have
>>>> the feature, yet, are "good": since they do not have the feature in the
>>>> first place, they cannot have the breakage that you found in the feature.
>>>>
>>>> That is exactly the situation in your original example! But you constructed
>>>> the condition of goodness in such a simplistic way (depending on the
>>>> presence of a string), that it was impossible to distinguish between "does
>>>> not have the feature at all" and "has the feature, but it is broken".
>>>
>>> Johannes, thank you for correctly identifying the error in my logic.
>>> Indeed I was using the term 'bad' also for the commit without the
>>> feature. In order to find the commit introducing the bug in my example
>>> a new state is needed, which would make 'git bisect' a bit more
>>> complicated than the user 'most of the time' probably needs. Or do you
>>> think, it would make sense to ask the user for this state (if e.g 'git
>>> bisect' would be started with a new parameter)?
> 
>> If a commit doesn't have the feature, then it is by definition, not
>> containing a broken feature, and you can simply use the "good" state.
>> There is no need for a different state. If you can't test the commit
>> because it's broken in some other way, you can use "git bisect skip"
>> but that isn't what you want in this case.
> 
> Commits missing feature == 'good' commit is a very confusing one.

Nowadays you can change the names for 'old' and 'new' with
`git bisect terms`.  HTH.
 
> Looks like in real life it happens much often, then git developers can
> imagine. For multi-branch/multi-feature workflow it's pretty easy not
> to recognize whether it is missing or not developed yet, especially on
> retrospective view where cherry-picking/squashing/merging is being
> used. My experience shows most annoying bugs are generating after a
> heavy merge (evil merge) with conflicts resolutions, where developer
> is not involved in the knowing what happens on counterpart changes.
> Then feature can be disappeared after it was worked & tested in its
> own branches.

Good to know about this problem.

> @Alex, I'm pretty interesting in fixing this weird bisect behaviour as
> well, as far as I struggled on it last summer and continue struggling
> so far :) If you want we can join to your efforts on fixing.

Anyway, I don't think it is feasible to weaken the assumption that there
is only one transition from 'old' ('good') to 'new' ('bad'); this is
what allows O(log(N)) operations.  See bisection method of root finding,
that is finding zeros of a continuous function.

Best,
-- 
Jakub Narębski

