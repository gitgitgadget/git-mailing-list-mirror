Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC2621841
	for <e@80x24.org>; Wed,  2 May 2018 10:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeEBKqb (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 06:46:31 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37749 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEBKqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 06:46:30 -0400
Received: by mail-wm0-f44.google.com with SMTP id l1so23547840wmb.2
        for <git@vger.kernel.org>; Wed, 02 May 2018 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=He6baAkWAwPwG6dkMRA4B65TzrGW2TvI4eEOO6yurKo=;
        b=d8LAPmkwCEwrvdChrnYb2LFGomlcyY5WiMVwEjJQIlEEddW22vYFnFH9BllyxHTa8R
         Fu9gbLkKUk6HFJA5L+nT4hCrrg0yYX9XLeUiXsjMknVdODH4rDNfbm1obBhldJaeKzgA
         sUbTfXXZkeLlgQd5dJywK+Lb4IMZT20yldLt/ziqNdvevHsjtc0yuzdItyIe3X80NaUl
         tVNvgMG4+EnwJ0PShrqct7wbjk+XnI7VPDU7833kj1IySlrMqX3msVZ9J7vIihmn3uFD
         jEh6y7x1YTpRl7e0S3FLUqi0gCCLKdECy7Zt/A8RaNt3L45u8V17GKl4Z5FRWcxJTNTQ
         6eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=He6baAkWAwPwG6dkMRA4B65TzrGW2TvI4eEOO6yurKo=;
        b=Z42p0cAyU8j7SpKO9bDar3pEYoacRIuMMcQbA6iv/Y2YlUmzb+/BewFsWxYORCqSnM
         96B0/T3IYPg7gTE+uV6oVSItUFWaPFxeeFuQcIoyMB9j2fafDoe0hRpXy8hfA0FXcDzs
         71u+W329E0Gq2/7QW6iKC2RWiGf5tBOtwp7d0XF7+azwVvo5kDdmr1Q7i+halpezQJAi
         CRWbgQoECE/UNFaud/QTHtag3S8Xk1BF04PxhE4IjPCZ6VoxGuoCpIvTVqQfff0Ku54u
         7EQ2t9J6eDXXk6UrM2krUkGzkbBjDjLMrHoz4iDohKJsY2CebBEOOEBvho6Q6LUaRBcL
         exbA==
X-Gm-Message-State: ALQs6tAf74AtxPF5Fo0JxI66WVG3pw+e33GqMEpeP0/RBhkv3Wu0icO9
        9N3LfacAj8GSoS9yoXqHkE0=
X-Google-Smtp-Source: AB8JxZqXR6UIAN5Nxe5lonl86J8zK5lvYzZeNaiOFIchg0TgnN8kfyGyRD3baSG3WRmssCLwch2cwQ==
X-Received: by 10.28.145.196 with SMTP id t187mr11237986wmd.19.1525257988689;
        Wed, 02 May 2018 03:46:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b66sm12622959wma.48.2018.05.02.03.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 03:46:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #04; Mon, 30)
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjmkn7eyooKheOEQnS=6HMZSTbhejoxQdKB7W+n=7D5KuQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1805011439580.79@tvgsbejvaqbjf.bet>
        <xmqqr2muwvvq.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1805020850400.73@tvgsbejvaqbjf.bet>
Date:   Wed, 02 May 2018 19:46:27 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1805020850400.73@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 2 May 2018 08:53:16 +0200 (DST)")
Message-ID: <xmqqlgd2uygs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As I wrote elsewhere, for a low-impact and ralatively old issue like
>> this, it is OK for a fix to use supporting code that only exists in
>> more recent codebase and become unmergeable to anything older than
>> the concurrent 'maint' track as of the time when the fix is written.
>> Even though it is sometimes nicer if the fix were written to be
>> mergeable to codebase near the point where the issue originates, it
>> is often not worth doing so if it requires bending backwards to
>> refrain from using a newer and more convenient facility.
>
> So do you want me to clean up the backporting branches? I mean, we could...

For a relatively obscure and low-impact bug that is old like this
one, I'd actually prefer to be able to say "heh, if that hurts,
either refrain from doing so, or update to the recent maintenance
track that has a fix for it", to use the fix as an incentive to move
the world forward ;-).  After all, people have lived with the bug
for a long time.

