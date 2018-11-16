Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5692B1F97E
	for <e@80x24.org>; Fri, 16 Nov 2018 08:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeKPSjc (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:39:32 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53736 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeKPSjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 13:39:32 -0500
Received: by mail-wm1-f53.google.com with SMTP id f10-v6so21132765wme.3
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 00:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LhUv8+S25mtOk4PXVNTqoy4kx3dwcEr4/zouohcSYlw=;
        b=JXWJXcRZk72yYHyD1ntS274qr8sKYJk1CizaomgDzpJZDpNf9LwsDeAycH994E7LsG
         dqcl3yjioXQb0rvPN5tazpyaGicZysWbcv4IQ8UWTkX+hQbl9gp9LTgOAs2wZvktpC89
         b4Djk5hjPkNgY+2h1Wp/UNeNlepNUc1UnPTxgmFRHgz5R6digH0Y8HywgVLuFzT0EqIK
         cKdIsw1MNJ/ETOzwgZDrCu9NfO9UKNifiAncMt9jWLaQajeq4wOySdP7WpTbhoQKkrIT
         wfKU+a01DfPPAF1Q0+E77fPMFfvCOF86GhHXWV7fAQ+z9V7TbkBWe6AxGYPSghF8vKrn
         or+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LhUv8+S25mtOk4PXVNTqoy4kx3dwcEr4/zouohcSYlw=;
        b=O/dFWdjviXO1ObZWlPfIh6kAMahWh8egMcck1InKRCczJRz/a6DFfzQOc9GaD4YR5W
         htM3ilObT7tXJDtYZs8hIlQclAlWFoGuYEgep4HazL+PGdV1BbvHWYZ9XeXh7O0nwgcb
         B/Bt+sicOXEtjIaORq58H0lhtfSbHtqnAQPZl7MKfwepv5018/kFMtGb8OumYuoKYU+t
         xGv5Eht1oOF0Nym30PvRL18qWgnRIaSlsZNzXE8bWbUL137O7bAB4SZ96OpyRLn1iUHb
         qn4JL0yp1uWp7nSpBTARY9IJqGbW0sNYjXX6EsCgFe6WUnwlunwsNkN26/z/+JIZSW4L
         4fgA==
X-Gm-Message-State: AGRZ1gKndIJn4mFBGQSkvAYKyRmkiNLG0OXFa86s+b5v55uJvpa0Bxc9
        EH5CzYrNqkxIPVZF9Yxc1kw=
X-Google-Smtp-Source: AJdET5fZRqtb+k9iBM8/DbGMAyILnJxt3zp+Mlsul4Y3bOoTTCH2pQ9SbCdGFlipEisaxBfF+bcNzg==
X-Received: by 2002:a1c:5d41:: with SMTP id r62-v6mr7582744wmb.93.1542356890934;
        Fri, 16 Nov 2018 00:28:10 -0800 (PST)
Received: from [192.168.1.3] ([31.223.156.230])
        by smtp.gmail.com with ESMTPSA id 74-v6sm27772662wmn.42.2018.11.16.00.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:28:10 -0800 (PST)
Subject: Re: [PATCH v2 1/2] [Outreachy] t3903-stash: test without configured
 user.name and user.email
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
References: <20181114221218.3112-1-slawica92@hotmail.com>
 <20181114222524.2624-1-slawica92@hotmail.com>
 <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <2f3612b8-5f26-adae-9a7f-05d16040938e@gmail.com>
Date:   Fri, 16 Nov 2018 09:28:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 16-Nov-18 6:55 AM, Junio C Hamano wrote:
> Slavica Djukic <slavicadj.ip2018@gmail.com> writes:
>
>> +test_expect_failure 'stash works when user.name and user.email are not set' '
>> +	git reset &&
>> +	git var GIT_COMMITTER_IDENT >expected &&
> All the other existing test pieces in this file calls the expected
> result "expect"; is there a reason why this patch needs to be
> different (e.g. 'expect' file left by the earlier step needs to be
> kept unmodified for later use, or something like that)?  If not,
> please avoid making a difference in irrelevant details, as that
> would waste time of readers by forcing them to guess if there is
> such a reason that readers cannot immediately see.

There is no specific reason for file to be "expected", I'll update that.

>
> Anyway, we grab the committer ident we use by default during the
> test with this command.  OK.
>
>> +	>1 &&
>> +	git add 1 &&
>> +	git stash &&
> And we make sure we can create stash.
>
>> +	git var GIT_COMMITTER_IDENT >actual &&
>> +	test_cmp expected actual &&
> I am not sure what you are testing with this step.  There is nothing
> that changed environment variables or configuration since we ran
> "git var" above.  Why does this test suspect that somebody in the
> future may break the expectation that after running 'git add' and/or
> 'git stash', our committer identity may have been changed, and how
> would such a breakage happen?
In previous re-roll, you suggested that test should be improved so that 
when
reasonable identity is present, git stash executes under that identity, 
and not
under the fallback one. Here I'm just making sure that after calling git 
stash,
we still have same reasonable identity present.
>
>> +	>2 &&
>> +	git add 2 &&
>> +	test_config user.useconfigonly true &&
>> +	test_config stash.usebuiltin true &&
> Now we start using use-config-only, so unsetting environment
> variables will cause trouble when Git insists on having an
> explicitly configured identities.  Makes sense.
>
>> +	(
>> +		sane_unset GIT_AUTHOR_NAME &&
>> +		sane_unset GIT_AUTHOR_EMAIL &&
>> +		sane_unset GIT_COMMITTER_NAME &&
>> +		sane_unset GIT_COMMITTER_EMAIL &&
>> +		test_unconfig user.email &&
>> +		test_unconfig user.name &&
> And then we try the same test, but without environment or config.
> Since we are unsetting the environment, in order to be nice for
> future test writers, we do this in a subshell, so that we do not
> have to restore the original values of environment variables.
>
> Don't we need to be nice the same way for configuration variables,
> though?  We _know_ that nobody sets user.{email,name} config up to
> this point in the test sequence, so that is why we do not do a "save
> before test and then restore to the original" dance on them.  Even
> though we are relying on the fact that these two variables are left
> unset in the configuration file, we unconfig them here anyway, and I
> do think it is a good idea for documentation purposes (i.e. we are
> not documenting what we assume the config before running this test
> would be; we are documenting what state we want these two variables
> are in when running this "git stash"---that is, they are both unset).
>
> So these later part of this test piece makes sense.  I still do not
> know what you wanted to check in the earlier part of the test,
> though.
>
>> +		git stash
>> +	)
>> +'
>> +
>>   test_done
>
Thank you,
Slavica
