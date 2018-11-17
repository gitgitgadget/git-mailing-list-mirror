Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8271F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 18:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbeKRFFc (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 00:05:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53843 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKRFFc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 00:05:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id g131so1197806wmg.3
        for <git@vger.kernel.org>; Sat, 17 Nov 2018 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jCT/dwM09UkdZVODVZZUdrl4Qa9M54cJevphjFD9lRI=;
        b=NbkypNVGwU68VeIpJkMCLyrlBOjYMqqpTAsnfCk4ktCK9Ns+OgQKOIr6ouHkQ9OGuE
         wgv6ICBO4qIPNI8xnRU/gFrvc8zW9EDL3ejZLXOfaoZnu9wvMAWfopZGjqGL5fyG4uEz
         qW3lojrpsfWIGcUWApQo5f6mUi2jOgYIxtcuj1NdLv5Ab7Uct1si7r+hht7e4iu+4UmG
         EYEavC8bA5SoPr6B1u6W7ANewQa6GCSXIKYCfSXwOYv63X9O+agEjj/EVaagylDL5gKX
         qfdzi1pgrGPtzU16zr3D3D47LupBY41F0AMKVwXEa0oKpUsh4yOHv7A04nQ/W4KHFfFV
         0TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jCT/dwM09UkdZVODVZZUdrl4Qa9M54cJevphjFD9lRI=;
        b=gvVB/3b5ARHQxYotlv3bwl8FJrewpZwjSTX+qAeY2HGqDq9w0IMs8UUkHxANJoyXDS
         1Cjt4TgOQ5xm6SZibEeNTpk29Xqj/fzR9pa6m4p/aheFQFxv+PEvIbcGJdIxcM3WIeGX
         8S309gbcI+dUlJ195jq3Ra07GPM9WzTheWruzB4P5X+WVwRaR+w8gxYuUX6xmPJyWwjz
         ya3JZhDYGfB0gI1yw4DS0ca0uOQO4JVmeM7CYtB/ZqaMMPBaiGOKXx/QFD/tzrocN90N
         m93bjYtLHRa2AjmAJGFJJkjhQlMnqhT2JkhUcXcy+rGTy1Nj6MVjJnuzZIihPaSzIEKq
         /yuQ==
X-Gm-Message-State: AGRZ1gJ1sHgE7CvQ2tMYi8qBCKw0FT7WT8hc/RYJurXpCkXLPqdhGl7W
        8rmNThOBlY3pysHR3pYhFLc=
X-Google-Smtp-Source: AJdET5cMeOqhobiqtHclWhTJERDPe6Q699BixzHQPJz2hoo1K8E/CmDZQxpj2wXrUxpaH4qE4xUgog==
X-Received: by 2002:a1c:9611:: with SMTP id y17-v6mr2381055wmd.36.1542480477997;
        Sat, 17 Nov 2018 10:47:57 -0800 (PST)
Received: from [192.168.1.3] ([31.223.156.157])
        by smtp.gmail.com with ESMTPSA id a133sm87172wmf.17.2018.11.17.10.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:47:57 -0800 (PST)
Subject: Re: [PATCH v2 1/2] [Outreachy] t3903-stash: test without configured
 user.name and user.email
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
References: <20181114221218.3112-1-slawica92@hotmail.com>
 <20181114222524.2624-1-slawica92@hotmail.com>
 <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com>
 <2f3612b8-5f26-adae-9a7f-05d16040938e@gmail.com>
 <xmqqsh01ib51.fsf@gitster-ct.c.googlers.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <a75dcea8-797d-9c9b-3453-2de2a4d983dd@gmail.com>
Date:   Sat, 17 Nov 2018 19:47:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqsh01ib51.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 16-Nov-18 11:12 AM, Junio C Hamano wrote:
> Slavica Djukic <slavicadj.ip2018@gmail.com> writes:
>
>>>> +	git var GIT_COMMITTER_IDENT >actual &&
>>>> +	test_cmp expected actual &&
>>> I am not sure what you are testing with this step.  There is nothing
>>> that changed environment variables or configuration since we ran
>>> "git var" above.  Why does this test suspect that somebody in the
>>> future may break the expectation that after running 'git add' and/or
>>> 'git stash', our committer identity may have been changed, and how
>>> would such a breakage happen?
>> In previous re-roll, you suggested that test should be improved so
>> that when
>> reasonable identity is present, git stash executes under that
>> identity, and not
>> under the fallback one.
> Yes, but for that you'd need to be checking the resulting commit
> object that represents the stash entry.  It should be created under
> the substitute identity.
Would it be correct to check it like this:

         git reset &&
         >1 &&
         git add 1 &&
         echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >expect &&
         git stash &&
         git show -s --format="%an <%ae>" refs/stash >actual &&
         test_cmp expect actual

It is similar to your suggestion when there is no
ident present.
>> Here I'm just making sure that after calling
>> git stash,
>> we still have same reasonable identity present.
> I do not think such a test would detect it, even when "git stash"
> incorrectly used the fallback identity to create the stash entry.
>
>
Thank you,
Slavica
