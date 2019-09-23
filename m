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
	by dcvr.yhbt.net (Postfix) with ESMTP id 739381F463
	for <e@80x24.org>; Mon, 23 Sep 2019 09:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392435AbfIWJqy (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 05:46:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39874 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390596AbfIWJqy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 05:46:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so13153523wrj.6
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T+9HBDolrJ85H9LZuQbxhgDdagKHDkjstG1mkN5Xf44=;
        b=JIKxNnBwyYfLRr95Vj7CEGZEdKf71VrPIKk/AmE9u0CSlSfz9Bs1NtE9GJ1YjHGbkE
         jAEhIDTgneFnWCM/7stKe6/Qqnl0v34U8Fha2SsaWC9QWdfrIiGLCfAyjG3F3KmMjRMd
         pf1X5G09ghjbyitHCKpyFXERTc6lbKTepGLXN+2uISiA5zjVALvG3VvwizpN15r4BF0f
         PK49yovXeVobDEhMuskzXPY57Bqt+IfJhl6s+xpArjqj7lqeqUfJdborXAC2AJ6LercW
         0t3NcQJfYBSzArRLPg6jQ2o+BFPJZv8PlZqDkA9/4P+hL8QCpV6yo0rPlRCzk9BvLw8y
         vzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T+9HBDolrJ85H9LZuQbxhgDdagKHDkjstG1mkN5Xf44=;
        b=oSoo6xCKuBs0ceioCQ+2YOF093yU5Uhm133cpX+6WQXznsbHL+XEZSteRQeOgNDRXL
         BLDcuT9Keptcxk0T1uBFwMVkcqRD6gXIDT7vcI6eIsxS9PMXPWo7VhcG6BnlQrsi5B8W
         eOivZR7rkFcOHuSW27aHT97I8k7zN1ekGVAm0rPzc75zExGuzLdg2gNRmn+prsm7+ZUO
         21VZOWauF2+VE0qvJKXwPsRfsGSg1dJ4BCh09FSYL9wu49/kAMUu64zjKyHrrlqV6wMX
         18dntcFNNlTr2fY6oizmzyP9jz7RLti3Z50e1d7Gd6VLpz/F8mSvv6GnkRHsQYM/qCtL
         LUkw==
X-Gm-Message-State: APjAAAVegJZ3uJJs5FQHFbOaC43GBGGRHrI4Bg01j3EkVUOR0NzLkG7p
        55P08hW8HHf8RD1Td7MxR+6/4zHO
X-Google-Smtp-Source: APXvYqw66lB/PxcW1yWkUDvAKo0WiXF1PzCed+07/WOqnkw3mCBS/6PmHxOUztv2bJgzZ8atKk9+XQ==
X-Received: by 2002:a5d:6812:: with SMTP id w18mr19847748wru.250.1569232012115;
        Mon, 23 Sep 2019 02:46:52 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id q19sm16147379wra.89.2019.09.23.02.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:46:51 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/1] git-config --add allows values from stdin
To:     Taylor Blau <me@ttaylorr.com>,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>
Cc:     git@vger.kernel.org
References: <20190917133135.190145-1-git@zjvandeweg.nl>
 <20190922031128.GA76333@syl.lan>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8c079514-bc18-cf03-1f82-4c2d2e878453@gmail.com>
Date:   Mon, 23 Sep 2019 10:46:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190922031128.GA76333@syl.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor and ZJ

On 22/09/2019 04:11, Taylor Blau wrote:
> Hi ZJ,
> 
> On Tue, Sep 17, 2019 at 03:31:34PM +0200, Zeger-Jan van de Weg wrote:
>> When adding or updating configuration values using git-config, the
>> values could all be observed by different processes as these are passed
>> as arguments. In some environments all commands executed are also all
>> logged. When the value contains secrets, this is a side effect that
>> would be great to avoid.

How much extra security does this actually add? - do the processes that 
can observe the command line arguments also have read access to the git 
config file?

  At GitLab we use Rugged/libgit2 to circumvent
>> this property[1].
>>
>> The following patch allows a value to be set through stdin when the user
>> passes a `--stdin` flag.
> 
> Interesting. I had thought some time ago about making an interactive
> line-oriented 'mode' for using 'git-config(1)', which would allow
> callers to add/delete/fetch multiple variables using only a single
> process.
> 
> This would satisfy a more general use-case than yours: particularly my
> idea was grown out of wanting to specify or read many configuration
> entries at once when using a tool built around Git, such as Git LFS.
> 
> I had not considered tying '--stdin' to the '--add' (implicit or not)
> mode of 'git-config(1)'. It is an interesting idea to be sure.
> 
> On the one hand, it lends itself to other modes, such as '--get'
> combined with '--stdin', or '--unset' in the same fashion. One could
> imagine that each of these would take either a key/value-pair (in the
> case of '--add') or a set of key(s) (in the remaining cases). The most
> desirable aspect is that this would allow for a clear path to this
> series being picked up.

It would be great to be able to --get multiple values and I can see 
people wanting to be able to --unset them as well.

> On the other hand, tying '--stdin' to a particular mode of using 'git
> conifg' seems overly restrictive to me. If I am building a tool that
> wants to fetch some values in the configuration, and then add/unset
> others based on the results using only a single process, I don't think
> that a mode-based '--stdin' flag gets the job done.

That's true but I don't know how common it is compared to a script 
wanting to read a bunch of config variables at startup (i.e. does it 
warrant the extra complexity)

Best Wishes

Phillip

> One happy medium that comes to mind is a new '--interactive' mode, which
> implies '--stdin' and would allow the above use-case, e.g.:
> 
>    $ git config --interactive <<\EOF
>    get core.myval
>    set core.foo bar
>    unset core.baz
>    EOF
> 
> (An off-topic note is that it would be interesting to allow more
> fanciful options than 'get', e.g., 'get' with a '--type' specifier, or
> some such).
> 
> I'm not sure if anyone actually wants to use 'git-config(1)' in this
> way, but I figured that I would at least share some things that I was
> thinking about when initially considering this proposal.
> 
>> [1]: https://gitlab.com/gitlab-org/gitaly/blob/8ab5bd595984678838f3f09a96798b149e68a939/ruby/lib/gitlab/git/http_auth.rb#L14-15
>>
>> Zeger-Jan van de Weg (1):
>>    Git config allows value setting from stdin
>>
>>   Documentation/git-config.txt |  5 ++++-
>>   builtin/config.c             | 23 +++++++++++++++++++++--
>>   t/t1300-config.sh            | 11 +++++++++++
>>   3 files changed, 36 insertions(+), 3 deletions(-)
>>
>> --
>> 2.23.0
>>
> 
> Thanks,
> Taylor
> 
