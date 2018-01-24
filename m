Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD631F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932920AbeAXWhy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:37:54 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41609 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932902AbeAXWhx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:37:53 -0500
Received: by mail-pg0-f65.google.com with SMTP id 136so3730367pgd.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 14:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vibYHHYuFWjPlVj54cQA08btUDpzCd64O32z92sh8tc=;
        b=U9xsjSSx4WyMU7Ag3I5Z/FPEl0Rv6lhJ2DcC4C47IQ92mGSE0D8dmJdW4MlMh3l3lG
         1IMnOlSj25mwczOFv2LsWb0Xp6VnQiFSUteOkNPZMOK8hnKEyjRgcynZbbprHn4qYHq0
         TxO90gIx+2tTKSuqJmoj41tO3lLkpGwMkT2xJbGx6TS084yY3yJT9c+11qHWYl990AMn
         VqDwhcBmR8pPKJ4+RMjvqymEditNBoEevPs6W3VFl/I8aFkCBNnNOY7jHd717v54Ws/q
         dQx2otZVVE5eJQt/XE4Z1wMd+pbvHDhm6V2cYYsy+g9GjbeTRbPv82zz2Qf6oRzYV9vD
         65/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vibYHHYuFWjPlVj54cQA08btUDpzCd64O32z92sh8tc=;
        b=qTVahnuyijuP2f5GZV5E7eZjbPm3Qyy30uI4MGQ0IS3ZJAXUEYvxvoGHMWTF8kVgFx
         hW20oiuVvC2zw0EJvtGRAyNzNR0EF3bzZzXfzxPr6odfnZOrGg4ZxdN9sBf+uURDZZ2l
         hPdI6Rud6hTSd/T62LCMmakcpM04bdpNPDP2iibbT5aqbv9jxNjYTAhXR0U8ZFMsgveQ
         Yha4HCgUGtJymF95aKBzBTipa5aBizKB1MFp/M9RXS6VBqTkdSjsPDjvKEOwoQQnANnt
         dg6VSI8UaNaE4xoBPkqloG7Id0PsY3fDIL5T3BmtWlFa7zvshbcEUMbbN+iXbEF5PFVD
         vcBg==
X-Gm-Message-State: AKwxyteixA8klK31PB9XIFNvH75ud7NVHzo31y9n3l2BPDefaOjO9/A8
        oo3MPaZ8ztvZkDAeD+OpHgY=
X-Google-Smtp-Source: AH8x2279qE4WGBwavNqhDjcOjFiPyzsXGHPLZqKVtnEug/VtgUHsfA00DTT8CJFV2d1/epRglb+oEg==
X-Received: by 10.99.153.1 with SMTP id d1mr1786440pge.190.1516833472767;
        Wed, 24 Jan 2018 14:37:52 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f924:a479:e3c:a7cc])
        by smtp.gmail.com with ESMTPSA id 77sm11734206pfz.167.2018.01.24.14.37.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 14:37:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2018, #03; Tue, 23)
References: <xmqqefmgfbcx.fsf@gitster.mtv.corp.google.com>
        <d154319e-bb9e-b300-7c37-27b1dcd2a2ce@jeffhostetler.com>
Date:   Wed, 24 Jan 2018 14:37:50 -0800
In-Reply-To: <d154319e-bb9e-b300-7c37-27b1dcd2a2ce@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 24 Jan 2018 10:26:57 -0500")
Message-ID: <xmqq1siec281.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 1/23/2018 5:39 PM, Junio C Hamano wrote:
>> [Stalled]
>>
>> * jh/status-no-ahead-behind (2018-01-04) 4 commits
>>   - status: support --no-ahead-behind in long format
>>   - status: update short status to respect --no-ahead-behind
>>   - status: add --[no-]ahead-behind to status and commit for V2 format.
>>   - stat_tracking_info: return +1 when branches not equal
>>
>>   Expecting a reroll to finalize the topic.
>
> I sent a V5 (1/9/2018) of this series that removed the config setting.
> It looks like your branch on GH only has the V4 version.

Yes, I was hoping that the long discussion on "can we do better" to
settle before picking up that one, trying to avoid wasting time on
v5 in case v6 came sooner than I had time to grok v5 ;-)

Thanks for pinging.  Will replace.
