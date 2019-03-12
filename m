Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE41A20248
	for <e@80x24.org>; Tue, 12 Mar 2019 07:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfCLHWL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 03:22:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56043 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfCLHWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 03:22:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so1412891wmf.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7k/YoXxODv9bruEhDZk3xh1f8FNtxIMSF0ZDqRsMP8o=;
        b=Tp2WVU7RdawwvPgLJkfIIj/vZkZA5VSBbRlw0a7S9Kqkf7vXqp8k6kysFX9OVEzJzs
         IUH/a02LMQ7A+FJNFAR/t/xtSfyqHDo2Y3iM1AD0k6bc1JTtxJGLCN4x6Alhayp5LZl9
         pAtz8qFRQfD2keyuUjWKCM6tjkHjmY1AYXGa6eRgvFoCnDrQj+dzkilCsG9jkIq5NE8I
         jrFQJcfRThASFXU/e6xuMMEKraKfkq3fF+GLMs6wIl9X7WBqcq8dcATARWVZ0CfkxBDn
         0yMCtiIdVpgrpHRhMwqUS8QELyoPcwG8AoNjsIJNJXxMuXKevRBwDv/zSw8GrMcrWUEB
         mBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7k/YoXxODv9bruEhDZk3xh1f8FNtxIMSF0ZDqRsMP8o=;
        b=I0JkhX2PMQu1neHmmBVnUCv1/P80DfCHQHC5FOvlju8sY2Z8mAk+V2eYen8MUk/Skv
         vo7+C5xwCfCVKf7/pvXT1NFBTLw8lNnbatcE4+bKKUpwt0lCEhEq86O8Ykk2KaGlkqFx
         hRpNeLFLq0VUlavvVTks67SVWMXpTnANj4fk7Kl3Vm1p4wwEFbpakt12iPmcqk5fy892
         sqkLfi6+Y0JYp7XOGqVfXsaW9Gaipzkv2I3iCd5eIMMqJ4EX/AwwXSNT7TltA6+dTvza
         OFOvEaLJt9ZPtNQlMNZbVE/8YaZZ0HwlIV0XDMV+uWWmraGaK4/K/t/+dn4i81veiPqE
         C3aA==
X-Gm-Message-State: APjAAAUZgvOChPD11VhNmF2PNcPiD0HJ33ee1OPtBbxXoPUFtB6YsEXs
        NsjVuD/EpyH2+Hzt5rDhaK4=
X-Google-Smtp-Source: APXvYqxGUDmoLW5+gYjEWkwTvqOHp6tFoj7aqy6A2c7ly/gOyZuwqFNdFRbt9ZncjHP+hGB/d0Du2Q==
X-Received: by 2002:a1c:3c02:: with SMTP id j2mr1332785wma.72.1552375329240;
        Tue, 12 Mar 2019 00:22:09 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c202sm1054668wme.38.2019.03.12.00.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 00:22:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        vincent.guittot@linaro.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecating git diff ..; dealing with other ranges
References: <20190311093751.GA31092@archbookpro.localdomain>
Date:   Tue, 12 Mar 2019 16:22:08 +0900
In-Reply-To: <20190311093751.GA31092@archbookpro.localdomain> (Denton Liu's
        message of "Mon, 11 Mar 2019 02:37:51 -0700")
Message-ID: <xmqqef7ch80v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> =>		content="$(git diff HEAD^! | tail -n 1)"
> ...
> It gets caught in my attempt to only deprecate ..'s. Technically, it's
> undocumented behaviour and it only happens to work because git-diff
> accept ranges but it doesn't operate in an intuitive way.

It reuses the same notation as that is used for ranges, but makes
the notation mean something entirely different from ranges, because
"diff" is about two endpoints.

And "git diff ^A B" (or "git diff B ^A") works like "git diff A B".
So does "git diff A^!", for a single-parent commit A, work like "git
diff A^ A".
