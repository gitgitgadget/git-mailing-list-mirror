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
	by dcvr.yhbt.net (Postfix) with ESMTP id B1E721F462
	for <e@80x24.org>; Thu, 20 Jun 2019 09:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfFTJ5s (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 05:57:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56212 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTJ5s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 05:57:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so2397110wmj.5
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 02:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=49jy8ayZeFMd7NT3DAcRLZ43qnTD46l9KI1k51mDbOE=;
        b=H66coBe9m8MfqNOUaLkJZ5zZJc18OUkLEIWCL3Vwowh7g2r5ZjXgKpR/CbIfts0qUj
         ynbsdyf2q7jjh6i8SFYSAxa1BP1UmTj0m0gFkjBygZeOy9j61bHsQwY4q4FtPOzERGo+
         1gmjpEsnxRiYSGDzBL+RvxsH9F+CncgScUZIDM8qoRjpvpITe1W8WHpX+//Z8mWBmKTl
         KmT432ACH9dKsvVj/JwSpaLPr6xfwaMKkVhh/74UFucCSQ/j/RnNhVk+qq8RIuL3GC+t
         WdTBHs8m7Jhoo+oW5QoNgGk+3/Zsu7UAN4C0fPJ8JLFsQa1lLqnltMqVoN8ELw8VyqG5
         p1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=49jy8ayZeFMd7NT3DAcRLZ43qnTD46l9KI1k51mDbOE=;
        b=bGwZbRXKWrwFirbwPMfHXDzDcqlNAOGvxjuIiyUwV6WA0sjGCh2e7NEjSgynytv8d2
         QUZcl8iTxJhiaB/7T4hnSih8hiqyNzVTkGkG2LoZWtcUy+wIfCJzFfZrcr4VsGTeV+N9
         YJ6CSujg+uxuil98/3OhqQMOtTtS6a8b7YzteMMA5+4gRrqkeyY5GNKbuJNeIPjYKWxG
         6zoZlk53YpW7V1JoobOROmz/wCDk224vZtjbHhF84s9oSNdxOXWiiqJQQCmIca41727B
         w93/e4YlBszXpw6EYZornt8gd79uwo2xVeQ0LUjz8DE474V1fHsVSwE6Usp4WOeAf45q
         Q7vA==
X-Gm-Message-State: APjAAAVS0QWeApXd0ufPhwZ4iuOFk3np0QMO+KeNW1TYW+rv4ksFdc1T
        9efKU3zR6bxmPMcyVAYN0rY=
X-Google-Smtp-Source: APXvYqyOeXXFiBqR+2cj6ef0+PT6LUf8X6s6ClkzSUUxT+WzbbKEZL6s33Tp89usHS8Ds6bnc757Uw==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr2188414wma.147.1561024666629;
        Thu, 20 Jun 2019 02:57:46 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id x17sm22513590wrq.64.2019.06.20.02.57.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:57:46 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 4/5] cherry-pick/revert: add --skip option
To:     Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        martin.agren@gmail.com, jrnieder@gmail.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
 <20190618170650.22721-5-rohit.ashiwal265@gmail.com>
 <xmqqr27oq5z1.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <76359a86-0eb1-dd87-c36f-7bd2df8b0ae5@gmail.com>
Date:   Thu, 20 Jun 2019 10:57:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqr27oq5z1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/06/2019 04:40, Junio C Hamano wrote:
> Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:
> 
>> +give_advice:
>> +	advise(_("have you committed already?\n"
>> +		 "try \"git %s --continue\""),
>> +		 action == REPLAY_REVERT ? "revert" : "cherry-pick");
>> +	return error(_("there is nothing to skip"));
>> +}
> 
> Two comments.
> 
> The places touched by patch 1/5 emitted the error followed by an
> advice message; this new one breaks the pattern by giving the "hint:"
> first and then error.  Be consistent by swapping these two (and
> return -1, as "error() that returns -1" will no longer be the last
> thing executed in this function.
> 
> This one, and the in_progress_advice emitted from the patch 1/5, are
> both bad in that they make calls to advise() without guarding it
> with an advice.* configuration variable.

I'm not sure we have one for cherry-pick/revert/rebase. At the moment 
they print advice advice for a failed pick unconditionally (the caller 
of `print_advice()` sets `show_hint` based on the result of the merge 
rather than user preference) it would be nice to fix that. Maybe that 
should be checking advice.resolveConflict though. I'm also not sure if 
that is really within the scope of this patch series.

Best Wishes

Phillip


> This does not allow the
> user to say say "I've learned this part of Git enough; do not tell
> me verbosely."
> 
> Pick a random global variable that is defined near the top of
> advice.c, and learn how they are set (to true by default, allowing
> configuration to flip it off) and how they are used in order to
> prevent a call to advise() getting made.  Then mimick that to guard
> these calls to advise().
> 
> Thanks.
> 
