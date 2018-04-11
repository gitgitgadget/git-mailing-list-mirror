Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C50E1F42D
	for <e@80x24.org>; Wed, 11 Apr 2018 23:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeDKXTC (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 19:19:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35268 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeDKXTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 19:19:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id r82so6627895wme.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LfhFCOjzHJwwujB1SOr/6KvcJX80ROZMYS39VvUMPmc=;
        b=VrIUsfxdP4ZCOEXaNbtpVj87F4WAlRoTQru/xtyetJRHqcKpi86YSGubH0pUCAO13u
         oPZf4z54n64QgbLDYzsckEJ7WRevGJT8o5CwVVUP/RmoaB8xfNVTv62wb9fj99D4IyGk
         qZYhj82pQEqF3+mQShOBEhonFxal3SBA6ewIgh+GA54W8l75pGzk2mN+ZnEG+fkhlE43
         3IyHJ0rLHe+/m15K/YKJxDnN1O7f6yYq9iwPt5b3mSABl1lSbTh6Mom1l+69midR2J2E
         K2FQXqvWk/DHE4AwpwbCqwEpt5MMUUM5/03iLseQv1En68fqMrELai0aR028hpzAp8rZ
         4rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LfhFCOjzHJwwujB1SOr/6KvcJX80ROZMYS39VvUMPmc=;
        b=KdErzF1vxsABf+Y47EoKJt8HoBjOX7I5L4UaE/+HsHBn5M8Qh4rnWQJnFn5EptS4CT
         qkqRaOq+O0W5rErURCyXk/jEe74RZA/fwag3IPFzhGhWUZjqA46syjDXk66tm7rAm6M3
         /pW1SRo4YRgWd8DL1GVrz0A5aF+k4JCtWNJPeEIe3krUxxN1zuWYS2TLmVKzK2piWABX
         EhvVi2nzorI0eyXviha6CO4poGGe7PgxbmfL8eornOzMSBMyv+R16GFCLTRWvHCGoiS/
         v+ybc4jCrRIr4rEM5sSuHds96+HILXQb/3WmQQNYi9jhyaunCdwPgvdOZi+7vt+WI4Zm
         PFzA==
X-Gm-Message-State: ALQs6tBKD0szW2PFKULa0H1XQc8T00huLYfLaicQoVriNOlRniFFSHPJ
        3rUBjCik4g+lEUH5suquFB8=
X-Google-Smtp-Source: AIpwx48GOBoUTIp1h+qNUds/xvGGkafIQP/F+KB4/sV3XFvP3NkoRU79rXjgg9ZzPA9mojTljtbCig==
X-Received: by 10.28.135.195 with SMTP id j186mr4061074wmd.143.1523488739673;
        Wed, 11 Apr 2018 16:18:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h197sm3193357wmd.3.2018.04.11.16.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 16:18:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] git-svn: allow empty email-address using authors-prog and authors-file
References: <20180320220743.GA17234@whir>
        <20180324102046.8840-1-asheiduk@gmail.com>
        <20180405075113.3y6a5nadijswt7pm@untitled>
        <e2234113-52cf-1443-5abb-70a595037f30@gmail.com>
        <20180405194421.GA25243@80x24.org>
Date:   Thu, 12 Apr 2018 08:18:58 +0900
In-Reply-To: <20180405194421.GA25243@80x24.org> (Eric Wong's message of "Thu,
        5 Apr 2018 19:44:21 +0000")
Message-ID: <xmqqa7u949i5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Andreas Heiduk <asheiduk@gmail.com> wrote:
>> Am 05.04.2018 um 09:51 schrieb Eric Wong:
>> > Can you confirm it's OK for you?  Thanks.
>> 
>> Looks good, works for me.
>> 
>> Do you squash this patch with with my commit or do you need a reroll?
>
> Nope, no need to reroll.  Pushed to my repo for Junio.  Thanks all.
>
> The following changes since commit 468165c1d8a442994a825f3684528361727cd8c0:
>
>   Git 2.17 (2018-04-02 10:13:35 -0700)
>
> are available in the Git repository at:
>
>   git://bogomips.org/git-svn.git svn/authors-prog-2
>
> for you to fetch changes up to cb427e9eb0243fe7a1a22ea3bd0a46b7410c0bf3:
>
>   git-svn: allow empty email-address using authors-prog and authors-file (2018-04-05 19:22:06 +0000)

Sorry; this message fell under my radar and I had to privately get
reminded of it.  Pulled.

Thanks, both.
