Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F91E1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427303AbeCBRL6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:11:58 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:38345 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424699AbeCBRL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:11:56 -0500
Received: by mail-wr0-f175.google.com with SMTP id n7so10823327wrn.5
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 09:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uCglzfohveOVc3NX8u7AX4jU5MCwdyJEensmf0FiLDc=;
        b=ieGojpdvDcBQXZ5r4SjmpakDm7e/aDUjmcX33zJ7lq5qPyMsD4sl5ZmmQgZf0uOpU/
         8y/aKRNFelRMYm0BvehN9xqJJ/E/Pyyjydh7p/23QiHYCY/dfgdZOsyevrHJs6wIyQbF
         M0E8XrCGkxOUMxObJiO5dKUUCGiiWwEQ8c8Grgjev4zPyw86VIFyUVm9EufdFqF5K6a9
         CIqQyIWFsFgPZXaP9WfIfrs+FynLK2N/R36l0hYk2BCBqShNtySpJyCGb1L1rRqVWvhR
         p/pjh7qiLS+GIhD/FhSZNF3ZnlRQvIN1jtWp7HPcmLhtyF0LYJLqjwxlsziuxxy7xZw9
         /dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uCglzfohveOVc3NX8u7AX4jU5MCwdyJEensmf0FiLDc=;
        b=DfoNbk/SFDBDYHWH+RsvvNHzvkq+qopQHSAIkLjIINAfy/yP1EGvcsavcVz4Bg1/9e
         FerS5mIgsczwo11PWtJHBNQZvuZbRVXLDU9Z8P5sT8wYRe1wrNG1szneyayF5Dnki0qr
         9aIEc2k6yHalLtrydVWe+YJeWgX2BV+7NjH7D7PjhtrhBT9BGJwPyqw150G+q7+eoXGw
         hHnLdkluEqDkJMkSWgut3+xsBSBJJNryq68FQSnE8ygPrd9bmmVqHgJPgMe2+sywVwlA
         Md/0wys0CJ2akEK2Ax43MhvYhBQVP4LiGQr1/r/qb3Yfrq6puWLUd+cHoMpVcErAcseh
         Vuyg==
X-Gm-Message-State: APf1xPD2+dUb1Ax6xVogPhScjrIhReu4rbb1+9XoDTO9wuR+TE3Z3ROk
        XIhRIhLa1z2B3A078ue9pO4=
X-Google-Smtp-Source: AG47ELsJCu4mGenkY9z3qbRDTkSewb0EyQaj6bo3EF0WxRX58IhyjpDBetHG7rV8wM4yN05cSIHVwg==
X-Received: by 10.223.163.136 with SMTP id l8mr5978104wrb.270.1520010715258;
        Fri, 02 Mar 2018 09:11:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o11sm6345264wrg.91.2018.03.02.09.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 09:11:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #01; Thu, 1)
References: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjmRT-vdyxsXTk1FB4BMLc8z6968kapqyqx5djKof5hQFg@mail.gmail.com>
        <xmqqwoyucsom.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 02 Mar 2018 09:11:54 -0800
In-Reply-To: <xmqqwoyucsom.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 02 Mar 2018 09:07:21 -0800")
Message-ID: <xmqqsh9icsh1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> On Thu, Mar 1, 2018 at 11:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> * sg/travis-build-during-script-phase (2018-01-08) 1 commit
>>>  - travis-ci: build Git during the 'script' phase
>>>
>>>  Stalled for too long without any response; will discard.
>>
>> I still think this is a good change as-is and it does make checking the
>> results of Travis CI builds easier.  The issue Lars raised in [1] is in
>> my opinion a non-issue [2] in practice and Lars hasn't yet disagreed
>> with that.
>
> OK, so I simply misread the discussion and did not realize that it
> reached a conclusion?  If that's the case, good ;-).  Thanks.

OK, I think I now understand what happened.  I misread the "fold"
discussion and thought we were still exploring the possibility, to
avoid showing uninteresting zero-status case to the users.

If we do not care about that part, then it seems that the discussion
thread is complete.  Let's move on.
