Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012A91F461
	for <e@80x24.org>; Mon,  1 Jul 2019 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfGARz5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 13:55:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41308 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfGARz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 13:55:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id q4so4904714pgj.8
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AajvnKWBaKwQVxpvgZRmYP4iWDdFLFtgyUD2SIK639k=;
        b=MLLfgzdF1wPxL1JdouQyhq8FidqhrICYX8pJpzWyYyR6X+Qu30kxftw73f48wjUIx9
         aRrw6FDrjCBIDnmI+HjBR3Sq8Og6xVnUvS11P1+/LdnjsehfyBppbhR1FqDTR/VUdH66
         IGTO23bXxme6TllIi+v5arv1+uMRwOFh31i7AGZa+Dhbv58ETtDHDRQC7jv0Bgy1XZUK
         67XJuA3V6HaXc2G/eWwgUNyJyv97WsDuvxI+WVx/dT7aMh3r2oDtfL6VExfekRby0vQF
         i/tQTugMe1YNxtCGewZ6r37XkP2s+oQxSkU+E5aWSbMpuVwUQaTRc6SofHTa4aOi3p2b
         CklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AajvnKWBaKwQVxpvgZRmYP4iWDdFLFtgyUD2SIK639k=;
        b=kUdR3TQtoiPjPOxDmuATe/ufbhtdQs/kiJyc4tEw9CGyMzpgWJChh4y/NBWqMUw7Ne
         g2e5byG9SfwDW1l4xFv5tiiiIIv7HgbgcL45N/7h3vcoGCAc/cBmTJjaFdL60NTWNKVI
         o9FLc8fv6l3zGqK4QvctsxQ4fA3ElURl8jcCWK/0/kuBz6VC3F5eaSDlexzWq7gai5XL
         rRWYwKwydxg7jQVwJqwDBNwrmXsYQXP96Oky7UWJuz40YcBNps0dajlfvpN+OCcTyUYo
         Hor/tAjtgBlM7kZOnj0yE2LLQwg3dLm521I662IrqMiI3eItvRRy4vSTkOavYjjLHwso
         KixQ==
X-Gm-Message-State: APjAAAWSjqIQgZhLgB1asG2V/40dDAfr+tDs7HAjl+Evoz4ZzTYoBJDq
        yol2om6Dl+1wtPhN0/12CssESQ==
X-Google-Smtp-Source: APXvYqzseTxkcvWC8i7VpklSd/MgbjI/jqXGnbIb3RU6+qkUg2WfjOqEV6LQZxra5maudwO/g1Y+UA==
X-Received: by 2002:a63:4c14:: with SMTP id z20mr25787535pga.360.1562003756438;
        Mon, 01 Jul 2019 10:55:56 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id m100sm185234pje.12.2019.07.01.10.55.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 10:55:55 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Platings <michael@platin.gs>
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
 <20190628062457.GA18662@sigill.intra.peff.net>
 <4d466fce-15df-3a73-f5f9-f29bc5b79a04@google.com>
 <xmqqmuhx7m6i.fsf@gitster-ct.c.googlers.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <ad5d38d0-167e-4e34-e994-2bc2a271b50b@google.com>
Date:   Mon, 1 Jul 2019 13:55:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqmuhx7m6i.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/1/19 12:29 PM, Junio C Hamano wrote:
> Barret Rhoden <brho@google.com> writes:
> 
>> On 6/28/19 2:24 AM, Jeff King wrote:
>>> On Wed, Jun 26, 2019 at 03:29:29PM -0700, Junio C Hamano wrote:
>>>
>>>> * br/blame-ignore (2019-06-20) 9 commits
>>>>    - blame: add a test to cover blame_coalesce()
>>>>    - blame: use the fingerprint heuristic to match ignored lines
>>>>    - blame: add a fingerprint heuristic to match ignored lines
>>>>    - blame: optionally track line fingerprints during fill_blame_origin()
>>>>    - blame: add config options for the output of ignored or unblamable lines
>>>>    - blame: add the ability to ignore commits and their changes
>>>>    - blame: use a helper function in blame_chunk()
>>>>    - Move oidset_parse_file() to oidset.c
>>>>    - fsck: rename and touch up init_skiplist()
>>>>
>>>>    "git blame" learned to "ignore" commits in the history, whose
>>>>    effects (as well as their presence) get ignored.
>>>>
>>>>    Will merge to 'next'.
>>>>    cf. <20190620163820.231316-1-brho@google.com> (v9)
>>>
>>> My -Wunused-parameter branch complained about merging with this. Since
>>> it's in 'next', we'd want something like this on top, I think (ideally
>>> after Barret confirms my hand-waving below).
>>
>> Looks good to me.
> 
> Thanks for a quick response.  I'll queue Peff's fixup on top of what
> is shown above.
> 
> The patches are already in 'next', so we'll go incremental to fix
> any issues discovered in the series from here on, instead of
> replacing the series wholesale.
> 
> Thanks.
> 

Sounds good, thanks.  Please disregard my v10 series then.

The other change in my v10 was squashing the following commit, which you 
might want to grab for next:

https://public-inbox.org/git/20190630181732.4128-1-michael@platin.gs/

Thanks,

Barret
