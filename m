Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BBAE1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 17:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfJNRlG (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 13:41:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35140 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfJNRlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 13:41:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so16645814qkf.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6hdghGud7ZGYSpBoGRU8RUL2Sr597TkIVnjPgsMY8JQ=;
        b=JbHl+4W5XpRWZV5Jv+2q8WZ2LKtJWzty02zTi9Zar/z/hB4EwtzheeyPu18z42yHDP
         mIs0KEtUrRdHZP3z0h5DPO+rch6vuVLGJt+hujvVZxjdoliONcLm3BiM2ofg/0tfuxjo
         BjFDQ6p8dBTY1e755kR6RZFff9xvaEKx9ULglvv6J9wO9S23TvwI6iFYkQb5V4oOX3Ha
         zj0NM7IKXmzZqK4fNv6Om1MmhdNGROyQJyODF11obwr1WJWOZwDf87JbE7dnzmn0a0Pi
         BlSJA80S/+Y89x4qLjdAhrfixMpL6gVD3phlAGMvXlIMBfbS7UfXf6qv8/SuxX8jLcKR
         j5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6hdghGud7ZGYSpBoGRU8RUL2Sr597TkIVnjPgsMY8JQ=;
        b=A9qeEeAjwxzkYMeqfBi5aWG+s5sMQokG1qjT6zQKQNSA0k/RpXFl7cbO4OXGlrNout
         46fJLceDFG68QhsYv2EroeV4jus2+oJ8uK3zSI6nJkEeyXzw79HE7dxQRpBw7RkzyRZc
         gK+8v/vGHlzHjIq1FnCTNgSe8puxs4xNS5MzjLvtQZEzzHOKa3BiXd4NpOHAIPWfdaHx
         j2smmLdNRj0rgQGyFYQMUP6DsFJPOmCPPZPpovFgUWLG5PRVnHT1BwHB6XRLmUJC+xIB
         RL+vVo2U3w7gDfIIHJyo3xWbT1PkSwRsuA5kJOa7zMywr/uc5x6y5u9uuIJV3wxxtAPE
         /vKw==
X-Gm-Message-State: APjAAAUb7JUttNGxtE8FHidplvMPE9xDmtGr56Wb+j34IaaOHG8/dmcv
        9DOkQoJ+eZLY2duTk/PnRv0=
X-Google-Smtp-Source: APXvYqz3qZK7Z63WopWdGQiHCX0GVNBXEU9AwaXFeslyJLZC0yY41cNN44YCyQyfV4GK4uq10hvjHA==
X-Received: by 2002:a05:620a:136a:: with SMTP id d10mr28426411qkl.201.1571074865202;
        Mon, 14 Oct 2019 10:41:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4807:bd77:fc97:8ac8? ([2001:4898:a800:1010:f93c:bd77:fc97:8ac8])
        by smtp.gmail.com with ESMTPSA id j5sm8053185qkd.56.2019.10.14.10.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 10:41:04 -0700 (PDT)
Subject: Re: [PATCH 07/11] graph: commit and post-merge lines for left-skewed
 merges
To:     James Coglan <jcoglan@gmail.com>, Jeff King <peff@peff.net>
Cc:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <6c173663aac37f1d314db8637cf4a243066b8078.1570724021.git.gitgitgadget@gmail.com>
 <9fe7f2d9-2108-5cf6-dcd7-06d91e74e98b@gmail.com>
 <204c7479-c78d-54ff-5ece-397b4c31804c@gmail.com>
 <20191013065609.GA30601@sigill.intra.peff.net>
 <5661fb1e-d850-f193-6d00-23de9f48e742@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bea5d779-434a-5995-fff2-d8e6401e59a5@gmail.com>
Date:   Mon, 14 Oct 2019 13:41:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <5661fb1e-d850-f193-6d00-23de9f48e742@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2019 11:38 AM, James Coglan wrote:
> On 13/10/2019 07:56, Jeff King wrote:
>> On Fri, Oct 11, 2019 at 06:04:21PM +0100, James Coglan wrote:
>>
>>>> I should have noticed in your earlier commits, but why don't you keep
>>>> the output inside the test suite? You can start with "cat >expect <<-EOF"
>>>> to have it ignore leading whitespace. Sorry if there's something else about
>>>> this that is causing issues.
>>>
>>> I was following a pattern used in t/t4202-log.sh. I believe it was
>>> easier to debug these tests with the setup and expectations split into
>>> separate blocks, but I wouldn't be opposed to merging them.
>>
>> Some of the older tests used that style, but we've been slowly
>> modernizing (I know, it's hard to pick up the style by example in such
>> cases!). The usual style these days is making sure everything goes in a
>> test_expect_* block, with "<<-" to indent here-documents.
>>
>> Another minor style nit that you picked up from t4202:
>>
>>>>> +cat > expect <<\EOF
>>
>> We'd omit the space after ">" here.
> 
> Thanks, I've now made the style changes you've suggested on my branch. How should I go about sharing the current state of my patch series after I've incorporated all the changes suggested here? Should I post them as replies on this thread, or start a new pull request via GitGitGadget?

Since you sent v1 via GitGitGadget, all you need to do is
add another "/submit" comment on the same PR and it will
send a v2 to this thread.

It will auto-generate the range-diff from v1 and append it
to your cover letter.

-Stolee
