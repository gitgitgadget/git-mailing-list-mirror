Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36921F5A1
	for <e@80x24.org>; Tue, 12 Nov 2019 23:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLXGl (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:06:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38607 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLXGl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:06:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so3361pgh.5
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJodqdxpkw5l2aSpq2AuW1sJevKDn4GpCSuWrgGGl5E=;
        b=l8kdZu+3qWWdriiUqShC4AO1Wd1+vtYpnfI+0kjCaca/41+L1xuGuceof8M5VgVZo9
         TyQSpCQS6U/q3FVX0vPE2l2s2IKOzcOI5mMJ9z14SJf7w1mBEJScwL6YIyBstV8n7RTz
         vptLh+ozn+f8qXi5ee+uBx6atoQBu9f9o3qphB85pQCm2AGAgWt8RG6lfZgn7VxeVW9G
         FEMmkwFw0HLNQ4hfTa1HPknubU5lTR4JBcmR9ksvobKsjlu7jfSOhGMp6Solz6rhC3KU
         JXbWg47y6638FCbt7T8DVA3JYqE+sH0QOu1lipucsVbHlQxJGvmZz+fRPjO5Hcu6PIP5
         oEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJodqdxpkw5l2aSpq2AuW1sJevKDn4GpCSuWrgGGl5E=;
        b=fNFsmD6c292nvkNlY6MLRSm/SRdsxICddZ5EfqIAwlpmWmcZWIMc8wIaRFKpN3doIA
         9Q/+EjAYYvEU5GCcvWnBjNc8KJk4iWJn9FPWnT7Zl90GkPrjVHZqhF4XHPsCODZjYQV4
         WcmfOAr+3QKhKjtwCjz0PUBq5G7g9wtbO5+oUSFKnePZGUh9EZvIVGbHeDl02X8+LzKh
         jy+YlZNwWqqcnCoId7DmR8Znr4WCxPmXzthLjnW4JPGei22YhX0cPT96lttydS4c9LQ8
         6ed3x1QKAlrP463RzGJoMtJ1mmptnlH+h4bRgYaxpvIqQrVW4XfG9NZyk9LmzvRcrE6j
         tvEA==
X-Gm-Message-State: APjAAAXijC7WaojGeYNOmXaEL4JCJpzab7nLeTifjq2gLQ2dAYSArqWa
        arT3b7jLmxUZ4ig+ljmY6PKJIp6P
X-Google-Smtp-Source: APXvYqyRNlmYxAikd9RGFlOcaPH1FiKuAGBzLmceJpss3G1gJBfJX6NugSJqCiNRSSnxQCbYMObEuA==
X-Received: by 2002:a62:7a85:: with SMTP id v127mr488459pfc.141.1573600000179;
        Tue, 12 Nov 2019 15:06:40 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id d8sm32674pfo.47.2019.11.12.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:06:39 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:06:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 10/14] t5520: test single-line files by git with
 test_cmp
Message-ID: <20191112230637.GA61654@generichostname>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
 <2f9052fd94ebb6fe93ea6fe2e7cd3c717635c822.1573517561.git.liu.denton@gmail.com>
 <xmqqh839fzbm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh839fzbm.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Nov 12, 2019 at 02:17:33PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > In case an invocation of a Git command fails within the subshell, the
> > failure will be masked. Replace the subshell with a file-redirection and
> > a call to test_cmp.
> 
> I.e.
> 
>     test "$(git cmd args)" = "expected-string"
> 
> =>
> 
>     git cmd args >actual && echo "expected-string" >expect &&
>     test_cmp expect actual
> 
> which makes sense.  It may break if expected-string begins with a
> dash or something silly like that, but a quick eyeballing over the
> patch tells me that we are safe there.
> 
> Technically, "$(git cmd args)" used as a command line option of
> another command is called "command substitution", not "subshell".
> The proposed log message may need to be updated.

Okay, I'll send out a new reroll with some log message cleanup.

> 
> > This change was done with the following GNU sed expressions:
> >
> > 	s/\(\s*\)test \([^ ]*\) = "$(\(git [^)]*\))"/\1echo \2 >expect \&\&\n\1\3 >actual \&\&\n\1test_cmp expect actual/
> > 	s/\(\s*\)test "$(\(git [^)]*\))" = \([^ ]*\)/\1echo \3 >expect \&\&\n\1\2 >actual \&\&\n\1test_cmp expect actual/
> >
> > A future patch will clean up situations where we have multiple duplicate
> > statements within a test case. This is done to keep this patch purely
> > mechanical.
> 
> OK.  One thing that worries me is if the existing tests are not
> expecting (no pun intended) to see 'expect' or 'actual' (e.g. if
> they somehow rely on output of "ls-files -u", we are now adding two
> untracked files in the working tree).

Do you mean `ls-files -o`? I think `-u` means "unmerged" while `-o`
means "others" (or "untracked"). This test doesn't have any instances of
`-o` being used.

> Another is if the git command
> is expected to produce nothing, possibly after failing, and the test
> is expecting to see an empty string---in such a case, the hiding of
> the exit status would have been intentional ;-)  We'd want to be sure
> that we aren't breaking the tests like that by reading through the
> result of applying this patch.
> 
> Since this is just a single file, I trust you have already done such
> sanity checking ;-)

Thanks for double-checking on me. I have, indeed, manually verified the
changes.

> 
> The mechanical conversion procedure itself looks OK.
> 
> Thanks.
