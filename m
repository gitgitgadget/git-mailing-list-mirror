Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6FC1F406
	for <e@80x24.org>; Fri, 11 May 2018 02:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeEKCsE (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 22:48:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50711 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKCsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 22:48:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id t11-v6so464580wmt.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GWV10X+5vrFyr9zSw6sfT/XBZ6yLKjAr6lgx79O6auc=;
        b=OQUCF5s6nnYemKxZrb/nRLT94Sfm6V+F7N1vyeGwXKJWViq0rrkmMBatE8h2r9eKsO
         zbgwVlTUUbbPKTrXtI8Nwfyw3DXyf/OKa6IcDx2frWZQvGSxgVOoD5TNOyKLlFHtMZch
         L3ZLWUxGw+XD1aMWv8Uk6hR1mqXwKMH2d9fUcNPei9qCEaUsunVYnn3SiSfz8V+QzyeF
         GD0qS+8Omu1GcqGQDw0goqgJRW18dcbtcCQWyrYp+xYQ2IUvmPgvvnNXtAs8jkVhLcIn
         E53NqEnGwbjXvd+18dUFhjFCTygsDsVcpTshw85ckaXLRKUDrIlZhAQIHcHV/ymFFTgs
         Ebcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GWV10X+5vrFyr9zSw6sfT/XBZ6yLKjAr6lgx79O6auc=;
        b=Yr09Av0RcJp0CS6EfRfVRT3Z9sNLCWHqH1QPQU6l4nobrvSHcIUgnIGTQZ+qwAXbAS
         9ghPWiLWNni+qIwMaPkPFfP/sWgcXGl+DmPMQeMx4WcqT/nkzQYOapdO1IYcUxzliG/y
         CTA3yKO7mRFSPHsyfv5KELpjE8PkwbS5xGqacOYqIKJYV2KdflqMgCTmuhYtdoaJ9hhz
         0BtFmwOUPok1H5VbJZkE3UD+K8SMg/0eh8t53lizY8J8aIDsC7oLXKvgHZqZoE//aHrj
         Fon11a68QbmBbaV3W6JbxplPsvm7nnqOGzisXcE9Z40jA7B3PAA4tI5QTq6LvaHENZGU
         XMEg==
X-Gm-Message-State: ALKqPwdurX6HLkTDkclBuuVfSKTIlolvHw3Cmm9GcTBkBvDz6UIFhNWO
        I9XFsBRKxfVok4A5QVkKYas=
X-Google-Smtp-Source: AB8JxZpXOponnK6W7O4mciHk6JgRXeRUI0n76dyWHS0E3bMs0+Rjs1ywm9x8JGqQ4wBLLJjlMvOUYw==
X-Received: by 2002:a1c:9310:: with SMTP id v16-v6mr720950wmd.60.1526006882506;
        Thu, 10 May 2018 19:48:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l37-v6sm3487321wrl.83.2018.05.10.19.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 19:48:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Oliver Joseph Ash <oliverjash@gmail.com>, git@vger.kernel.org,
        martin.agren@gmail.com, mqudsi@neosmart.net,
        phillip.wood@dunelm.org.uk
Subject: Re: Regression in patch add?
References: <be321106-2f10-e678-8237-449d2dd30fee@talktalk.net>
        <20180510141125.21677-1-oliverjash@gmail.com>
        <e8aedc6b-5b3e-cfb2-be9d-971bfd9adde8@talktalk.net>
Date:   Fri, 11 May 2018 11:47:59 +0900
In-Reply-To: <e8aedc6b-5b3e-cfb2-be9d-971bfd9adde8@talktalk.net> (Phillip
        Wood's message of "Thu, 10 May 2018 18:58:11 +0100")
Message-ID: <xmqqzi16hpr4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Yes, I think it probably makes sense to do that. Originally I didn't
> count empty lines as context lines in case the user accidentally added
> some empty lines at the end of the hunk but if 'git apply' does then I
> think 'git add -p' should as well

I am not sure if "adding to the tail" should be tolerated, but in
any case, newer GNU diff can show an empty unaffected line as an
empty line (unlike traditional unified context format in which such
a line is expressed as a line with a lone SP on it), which is
allowed as "implementation defined" by POSIX.1 [*1*]. Modern "git
apply" knows about this.

If "add -p" parses a patch, it should learn to do so, too.


[Reference]

*1* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html

>
>> Meanwhile, I can easily configure my editor not to do this for `*.diff` files.
>> 
>> Thanks for your help, Phillip and Martin!
>
> Thanks for posting an example so we could test it, it makes it much
> easier to track the problem down
>
> Best Wishes
>
> Phillip
>
>> Mahmoud, does this also explain your problem as per your original post?
>> 
