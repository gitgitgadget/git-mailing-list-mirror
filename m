Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A6B20248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfCFX4n (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:56:43 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39065 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFX4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:56:42 -0500
Received: by mail-wm1-f45.google.com with SMTP id z84so7549295wmg.4
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=33wSSqXo6zYmyLGA+kZnNEyd3lJlA/ThKcb692TVRzM=;
        b=Ub873g3Ja8Q0Jd3r+mXv0p63GQf+vMeumB276Ag9iG/KyS0BgcgA8s7kLJTMasLnGx
         f6daGKheoUElbIPajKGlEIbwBLQI1iXMKcrPQhIu/bvi1WIwu7P6rzcTXZVGwIRtlke5
         CCi6l4c7QWZy86LxG31l940Nq46sDjNMJgJmuSjBvCWzlwmiT0urnoCJmJL15OcqWCcO
         VE5ljRBXkf2GQzWytCSUYLYHW5Go2u+f0gHYWmGqYp4vRESgUtpaIC9cPrSzyB5hY9ki
         B3mBv7w6dBb0XBh3stzzw7ke4iJ1I3GgxJASUnyQ3ihRFbQuUWs0Rm4zX1aWvV0qZZmm
         Q8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=33wSSqXo6zYmyLGA+kZnNEyd3lJlA/ThKcb692TVRzM=;
        b=gH+0Xw/HSo7tXMKYGA/EgQgcrXl/YS1CMC1wjkgk4WwLB/WllQmK8fktdQriZo77wn
         ISs+R9JivDxWVd97MX5QryrdnTXxUGA6/1nBHAPLfprHF+ZgnkQkdRdQPiZqSifEdIt4
         y8SSwNe25b2XHzLJzmIRYKFdIjAIdeK2fPjUjWlMNTfTvV5L0HvIntxKtD32kZW+W5SI
         f2jE5YzIXd4E7YHoy37xTxGJv5Tq+J7A+gssOLgXgsp4An7k+Z4mSO/YGlWVnYK8xLEy
         P9+baOjmlsZ838j8sjJoGXpFWh2Iie1ijGU4LGGirkRq6t9aEw7XF2zZdooE5OE2Gks8
         E1LA==
X-Gm-Message-State: APjAAAV1eCwbdacgSteQj8IK7KCBB2mQtdN4fLkGjI7AQ/nV3FYhMyPX
        LncVq8/akWzJrO8X2/thH3JCXCF4TkE=
X-Google-Smtp-Source: APXvYqx9C37jbR9SXCns+neY9DU6E+NI8as+i7fSpEJNoEG0JrG2evlArFrg7/Tcy3vmtmNn93usTg==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr3762535wmh.112.1551916600642;
        Wed, 06 Mar 2019 15:56:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v6sm5648297wme.24.2019.03.06.15.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 15:56:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: ps/stash-in-c, was Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903061441200.41@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Mar 2019 08:56:39 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1903061441200.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 6 Mar 2019 14:41:46 +0100 (STD)")
Message-ID: <xmqq4l8fpnew.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 6 Mar 2019, Junio C Hamano wrote:
>
>> * ps/stash-in-c (2019-03-01) 28 commits
>> ...
>> 
>>  "git stash" rewritten in C.
>> 
>>  Will merge to 'next'.
>
> Yes, yes, yes!
>
> Thank you so much!

Not "me", but all those who worked on whipping the topic into shape
;-)
