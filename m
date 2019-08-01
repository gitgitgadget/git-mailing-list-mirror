Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1C31F731
	for <e@80x24.org>; Thu,  1 Aug 2019 17:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfHARfa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 13:35:30 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:34824 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfHARfa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 13:35:30 -0400
Received: by mail-wr1-f54.google.com with SMTP id y4so74476495wrm.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j09V48o0Q4xkT4A4oe8vB0xkP4usZmcZucUBvlkYshA=;
        b=aKiVjhQshQ+19VCaEU0ZPRSEHUqWH9QPNllxjlUWEXSxayXTQMjcQDAaJc6PQbXFYq
         R0sX75IsIaGrhqzIWoXD/HsVEiAzL8Vqo12K5B8ATfL0kDJGLxqy0/mCthuAmdbKv/S7
         vnYsNhhk03zz+Scdp5nqA+UO4//oJDXSzadth6owfHR0dUiVAMvczpyPtWNldr1cThe2
         e8Igpahy1kFLjoe1b4sBrsqBCVxUXy26zpzbCz1AgFogwe5+3LzYdzJpgENA4tnaa1lL
         EGpy9kBuFuVTQjMov8p3IzRGS5Vc9z2MuIcjebsvlc/Ahmr8QWd5qjr96wDPQ0LXtPAJ
         bGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j09V48o0Q4xkT4A4oe8vB0xkP4usZmcZucUBvlkYshA=;
        b=XxcfIIjTj1yFQ1yW8JH4BRm7CvPzsSlyJ3erdDnXrS6hLI95E3omzBNfrr65xBjE/2
         V/W8MAjfroPsZBsc9O2fWTl8QgssXZ4zDXKbuQTeZVvkRJBTBaJNyh2yQGZOYeR8W7QQ
         7TQSwBiYBD6XXxWUx3BN5+qmtAZTazBvMEQ/cHuBlJMYnxm0Bn5Yy4HrMDgMhI2f7SPe
         yf4b7BlmZ4ypGy8z4B2hsDDIrIqpulSgb1lIJcM6IzEhhsguc/cUmolvhGJmanwJKz2r
         YD10SIQkKAsuN1uFxaPI6HyVN69bGV6DjLZIGBLsNlK0EvW/X+bpZ9UGHrQNUjqPZ9XZ
         0JqQ==
X-Gm-Message-State: APjAAAVG1SH3vp1b5jtspVVDqx4/4nP9JvEK3kvjQF2e4NvjigWNwYNc
        xdl8vHx7FRq42TOxfVPrT/8ai7y1
X-Google-Smtp-Source: APXvYqwOd50UE9CKwgMPHlIppuL3NWE6mq/wYDqtpmrE/0NmvJ6HJqCcaZ836Cjy3YpjjlOeSCcTvA==
X-Received: by 2002:adf:f84a:: with SMTP id d10mr133953386wrq.319.1564680927618;
        Thu, 01 Aug 2019 10:35:27 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-23-226.as13285.net. [92.22.23.226])
        by smtp.gmail.com with ESMTPSA id v5sm89356774wre.50.2019.08.01.10.35.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 10:35:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
 <20190731171956.GA26746@sigill.intra.peff.net>
 <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <06daa8c1-d955-1e49-e5e6-85d53ffce6e6@gmail.com>
Date:   Thu, 1 Aug 2019 18:35:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08/2019 14:25, Alexandr Miloslavskiy wrote:
> On 31.07.2019 19:19, Jeff King wrote:
>> I don't have any real objection to adding stdin support for more
>> commands. Bu tin the specific case you're discussing, it seems like
>> using "git update-index" might already solve your problem. It's the
>> intended plumbing for scripted index updates, and it already supports
>> receiving paths from stdin.
> 
> I have now studied which git commands already use commandline splitting
> in our application. For some of them, I didn't find comparable plumbing;
> for others, I feel that a lot of new edge cases will arise, and it will
> need a lot of testing to make sure things work as expected.
> 
> Therefore, for us it would be best if high-level commands also accepted
> --stdin-paths. If I develop good enough patches for that, will you
> accept them?
> 
> We're interested in these high-level commands:
> 1) git add
> 2) git rm
> 3) git checkout
> 4) git reset
> 5) git stash
> 6) git commit
> 
> Here's the list of detailed commands and plumbings I found:
> 01) git add
>      'git update-index' doesn't seem to be able to skip ignored files.

No but it only takes paths not pathspecs, can you filter out the ignored 
paths first? From a UI point of view it would be better not to allow 
users to select ignored files if you don't want to be able to add them. 
If you want to use a pathspec then you can do 'git ls-files 
--exclude-standard -o -z <pathspec ...> | git update-index --add -z --stdin'
git check-ignore --stdin should help if you have a list of paths and you 
want to remove the ignored ones (it's not great as it tells you which 
ones are ignored rather than filtering the list for you)

> 02) git add --force
>      Probably 'git update-index --add --stdin'.
> 03) git checkout
>      Probably 'git checkout-index --stdin'
> 04) git checkout HEAD
>      Didn't find a plumbing to only affect named paths.

You can use a temporary index and do
GIT_INDEX_FILE=$tmp_index git read-tree HEAD && 
GIT_INDEX_FILE=$tmp_index git checkout-index --stdin &&
rm $tmp_index

> 05) git checkout --ours
>      Probably 'git checkout-index --stage=2 --force --stdin'
> 06) git checkout --theirs
>      Probably 'git checkout-index --stage=3 --force --stdin'
> 07) git rm [--force] [--cached]
>      Probably 'git update-index --force-remove'
>      Didn't find how to delete files from working tree.

You have to delete them yourself.

> 08) git reset -q HEAD
>      Didn't find a plumbing to only affect named paths.

It's a bit of a pain but you can use 'git update-index -q --unmerged 
--refresh && git diff-index --cached -z HEAD' to get a list of paths in 
the index that differ from HEAD. The list contains the old oid for each 
path (see the man page for the format) and you can feed those into 'git 
update-index --index-info' to update the index.

> 09) git add --update
>      Probably 'git update-index --again --add --stdin'
>      Not sure that --again is good replacement.

or something like 'git update-index -q --refresh && git diff-files 
--name-only -z | git update-index -z --stdin'

> 10) git stash push [--keep-index] [--include-untracked] [--message]
>      Didn't find plumbing for stashes.

stashes are just commits really so there are no plumbing commands 
specifically related to them.

> 11) git commit [--allow-empty] [--amend] [--signoff] [--no-verify]
>        --file=CommitMessage.txt -o
>      Didn't find a plumbing to only affect named staged paths.

You can use a temporary index, add the files you want to commit with 
update-index --stdin and then run 'git commit'

When I've been scripting I've sometimes wished that diff-index and 
diff-files had a --stdin option.

Best Wishes

Phillip
