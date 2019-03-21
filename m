Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBB3202BB
	for <e@80x24.org>; Thu, 21 Mar 2019 00:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCUArB (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 20:47:01 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53016 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCUArB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 20:47:01 -0400
Received: by mail-wm1-f46.google.com with SMTP id a184so1037365wma.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uKCN8H4A3LJvuHzREPb83qKtwVXRt4AQsGDcdfcFcIE=;
        b=LgK49wNhOV0UkLRj9+bXSX1tYERsrVhc19vI77INOeFGzLhYiwn9A9lj8Vqlll4ofw
         ORdvBvuIXtSPXdAEj7cqHwozkxXykUmW0mJLgfIFwzzBm/8JjlG6fUwwFNiwetPjPUkY
         Z5lI2qY4Do4iz61U+fQydsSOY17SFFuI5N8etQk/vnu73RGNI4UaVxbkb7m/wsilARDS
         M09VEyB7463MTit3MJXu3WLkNG/tCE3RmppT6671uPXoHXgqeEq3wSkhyxw5zp4pOTu3
         jMiAGbxwBHexF7ZLhbnXJ3TRDUwYurk+XgFEKCZiBHRq+gBeEhGhswSBKDK+bN63qq2b
         +7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uKCN8H4A3LJvuHzREPb83qKtwVXRt4AQsGDcdfcFcIE=;
        b=jChrfMFLiRAi1g1UYDRwr7TBypv31etcEcoLWLbIr5fX5wRgL7d8DDnPvvEICdY5LW
         XWeJ7Z7WlGsyJhHylenkw65u1SqroxClfNbvE+y8Akbmj0vhONzhOCqw72fpc2Gitd95
         1Et15Nt0hFI28z9dSrAVyujahMpX1QnGGj/ZPRZd7B/uLOXF2SI3ms8gfV7RlPW0sXqU
         YS/KJBcQhMewtUeix7Erkt/Sz89C4DSHRkJ32CUowPAEssppdwzZS4wshuPqLm2TvwBm
         ZojcQFNLvhhvVND6jdR60bsV/RGBxOaETYH/WtWsjA450hgCvmSZNQZrN4wvbeiIlVCL
         9shQ==
X-Gm-Message-State: APjAAAVJNTLKbxWjfyUCdaxQvUPJymMO+m8jbFQmzDEdYaq5lTsEJTde
        oQ8gB8nKX9OHRtf3X7es6SA=
X-Google-Smtp-Source: APXvYqzSyxAuBxdSeylS/uwfLvq7Lp0I3QFZ1E6sswxI2q0uQPvUm1XLEg3ULrLI/PHn05RGzbggAQ==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr627296wmd.16.1553129219153;
        Wed, 20 Mar 2019 17:46:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a10sm5947304wrs.19.2019.03.20.17.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 17:46:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
        <871s31dv6o.fsf@evledraar.gmail.com>
Date:   Thu, 21 Mar 2019 09:46:58 +0900
In-Reply-To: <871s31dv6o.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 20 Mar 2019 23:42:39 +0100")
Message-ID: <xmqqef71uk8t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Mar 20 2019, Junio C Hamano wrote:
>
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>
> I have re-rolls & re-submissions of some of my stuff as a WIP, but one
> thing that's fallen between the cracks & should be ready for queuing is
> my commit-graph segfault bugfix series:
>
> https://public-inbox.org/git/20190314214740.23360-1-avarab@gmail.com/

Thanks.  I quickly looked at the difference between the updated one
and the old one; will take a deeper look later.
