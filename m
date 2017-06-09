Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91401F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 13:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdFINOU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 09:14:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35215 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdFINOT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 09:14:19 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so8566781pfd.2
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tbB6COMZ+OeBI2P2o3CEvRovVOKDAXg7gh2AHi8R6Ps=;
        b=fYB7Zr/2DToObP+JchWeSgVqeS8lxHNaeGCDCZ45Jx6y42JcuFOEQraG8uG3x9pnah
         QdXq5dv7zPdLk/oDbNQcyVTr56F6vChSD7ha7o0yZD3maBGEthDhxjeO4R9JAtktpElx
         0i0TY2wI/kyhcNvFI5cQOAlkwoWza9iDe0ZWBriBdU1Dh6uy3N5qKQzPYeUlu+9MUIzF
         ykW9N9yCWWxdkUPCUEFdt8WBEQmZT3JJWObq7lQdnbP+ceBV3Ns8wdPe4yLqQJTjYXuQ
         9VRWBg03JugSFMoPQU2t2GmYqicD6jBWn3FNCpFz7Qu5RbXSfGnl9dSH7D9hp2lCgi2l
         Ts7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tbB6COMZ+OeBI2P2o3CEvRovVOKDAXg7gh2AHi8R6Ps=;
        b=kv+IEETGaJQF78u7MOY0ZkXh/n6VOxpat4WQ0F0/7yLOztAQhj7vEGB65u/Ln1ptZV
         fAEFVGyhYHodGe1lMtWxQ1ibGjwjkMQj+M283CV+8WmoJIVWYN1u8butcvFzyQWQatEX
         2oj6gou2bkgrURsS4A2W7bL61WpzYwudQoyfe/TBVHq/cc3JSLthgG5s1IiLGJxRPXuQ
         dh4SL2jb6aZxLCT4PBEJ1Hp9WZaTe3cr7b6vQQj6cef02Px7ajRmNGX3YLvBwBLda0nj
         ADmkGYCoB/NBPvKeOCn0xUtq7a4B/SGymJvIJMAmrowy9nF7VsvnIG8XCOe/B6dWyokI
         z5QQ==
X-Gm-Message-State: AODbwcA/1M7V3wlHtKgVVVHeGskg3QZh5oZBqt0thH6/UZRywga+UfuA
        zEAQ+uM801gkrA==
X-Received: by 10.99.44.68 with SMTP id s65mr33102674pgs.73.1497014058502;
        Fri, 09 Jun 2017 06:14:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id x5sm3259452pfi.103.2017.06.09.06.14.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 06:14:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] add [--] to usage of filter-branch
References: <20170603101755.13619-1-asheiduk@gmail.com>
        <20170603101755.13619-2-asheiduk@gmail.com>
        <ef30e8f5-8206-7b42-e229-6cd4b0492e76@gmail.com>
Date:   Fri, 09 Jun 2017 22:14:17 +0900
In-Reply-To: <ef30e8f5-8206-7b42-e229-6cd4b0492e76@gmail.com> (Andreas
        Heiduk's message of "Mon, 5 Jun 2017 10:51:09 +0200")
Message-ID: <xmqqk24l717a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> Am 03.06.2017 um 12:17 schrieb Andreas Heiduk:
>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>> ---
>>  Documentation/git-filter-branch.txt | 3 ++-
>>  git-filter-branch.sh                | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
>> index 45c849d8c..1efdda804 100644
>> --- a/Documentation/git-filter-branch.txt
>> +++ b/Documentation/git-filter-branch.txt
>> @@ -86,7 +86,8 @@ OPTIONS
>>  	This is not a real filter executed for each commit but a one
>>  	time setup just before the loop. Therefore no commit-specific
>>  	variables are defined yet.  Functions or variables defined here
>> -	can be used or modified in the following filter steps.
>> +	can be used or modified in the following filter steps except
>> +	the commit filter, for technical reasons.
>
> I'll move that into the previous commit.

Yeah, the description of "technical limitation" is different from
clarifying the disambiguating "--" in the documentation.

I am curious what the "technical reason" really is, though ;-)
