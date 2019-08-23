Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900A91F461
	for <e@80x24.org>; Fri, 23 Aug 2019 18:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405673AbfHWSqd (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 14:46:33 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:55895 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405582AbfHWSqd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 14:46:33 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i1EZy-0002zq-BA; Fri, 23 Aug 2019 19:46:30 +0100
Subject: Re: [PATCH v3 13/13] format-patch: learn --infer-cover-subject option
To:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
 <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
 <xmqq8srms4ak.fsf@gitster-ct.c.googlers.com>
 <20190823181545.GA14048@archbookpro.localdomain>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <d8a02cfd-2250-44ce-b559-dbec742b7cdf@iee.email>
Date:   Fri, 23 Aug 2019 19:46:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823181545.GA14048@archbookpro.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/08/2019 19:15, Denton Liu wrote:
>> Having said that, I suspect that in the longer term, people would
>> want to see this new behaviour with a bit of tweak become the new
>> default.
>>
>> The "tweak" I suspect is needed is to behave sensibly when "the
>> first line" ends up to be too long a subject.  Whether we make this
>> the new default or keep this optional, the issue exists either way.
> The reason why I chose to make this an "opt-in" option was because there
> currently doesn't exist a standard on how to write branch descriptions
> like there does for commit messages (i.e. subject then body, subject
> less than x characters). However, against best practices, some
> developers like to have really long subjects. As a result, there's no
> "real" way of telling whether the first paragraph is a long subject or a
> short paragraph.
>
> As a result, we should allow the cover subject to be read from the
> branch description only if the developer explicitly chooses this (either
> with `--infer-cover-subject` the config option). This way, we won't have
> to deal with the ambiguity of deciding whether or not the first
> paragraph is truly a subject and stepping on users' toes if we end up
> deciding wrong.
>
> Thoughts?
Perhaps the `--infer-cover-subject` the config option needs to be 
multi-valued to include:
      "subject" (always expect short first lines) or
      "message" (always the long paragraph description, still use 
***Subject Here***),
      with the "true" being used when expecting both as previously 
described.

-- 
Philip

As an aside, for format-patch to learn a --branch-version option that 
creates a branch with the '-vN' suffix to the current branch when the 
-vN option is used would be a useful addition (as long as the formatted 
refs are first parent to the current branch). #todo list #leftoverbits

