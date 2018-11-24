Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C621F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 14:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeKYBZq (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 20:25:46 -0500
Received: from smtp.rcn.com ([69.168.97.78]:61391 "EHLO smtp.rcn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbeKYBZp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 20:25:45 -0500
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.2 cv=DKTN2GFb c=1 sm=1 tr=0 a=OXtaa+9CFT7WVSERtyqzJw==:117 a=OXtaa+9CFT7WVSERtyqzJw==:17 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=NTnny0joGdQA:10 a=JHtHm7312UAA:10 a=bmmO2AaSJ7QA:10 a=BTUBnpS-AAAA:8 a=XFuC0ZUt5dlUrl2DQDMA:9 a=QEXdDO2ut3YA:10 a=pblkFgjdBCuYZ9-HdJ6i:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: ZHNlb21uQHJjbi5jb20=
Authentication-Results: smtp02.rcn.cmh.synacor.com header.DKIM-Signature=@mandelberg.org; dkim=pass
Authentication-Results: smtp02.rcn.cmh.synacor.com smtp.mail=david@mandelberg.org; spf=softfail; sender-id=softfail
Authentication-Results: smtp02.rcn.cmh.synacor.com header.from=david@mandelberg.org; sender-id=softfail
Authentication-Results:  smtp02.rcn.cmh.synacor.com smtp.user=dseomn@rcn.com; auth=pass (LOGIN)
Received: from [209.6.43.168] ([209.6.43.168:33072] helo=uriel.mandelberg.org)
        by smtp.rcn.com (envelope-from <david@mandelberg.org>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPSA (cipher=DHE-RSA-AES256-GCM-SHA384) 
        id A7/83-27719-61269FB5; Sat, 24 Nov 2018 09:37:10 -0500
Received: from [192.168.1.152] (DD-WRT [192.168.1.1])
        by uriel.mandelberg.org (Postfix) with ESMTPSA id 1B9341C6048;
        Sat, 24 Nov 2018 09:37:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
        s=201809; t=1543070229;
        bh=qosO1EpzLG6dTC7FWAGCl1k6v0MBBDdKA+oTWiI4UTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Lg48abyiZC2RKeGtfoXhYTu8uTgALflTG6SJ54N+kyY/6RRyluqj+sEFWe1hrEuzN
         SYPsfPqe/pk1A/r0LcCNukCpbC5MJ9Q7GgMbkJy2RdS6TBr8UEg2wAifSkd+KLEXhZ
         NJNVU93dAZz5116xXS2io+PRDAuXqNEvxe6i3ejo1igtCIiFvjGaVrKADBvhk8byz+
         mv2DiPb6/R8nwNTUJ4FQEWQ8uPIOfqX26Im3b51bLqYo+hnbNcyN+kYcFsTshl+Raj
         FvWkHg+NjdhErIfkkUPWRF2zLl/X/2El0PRvktbzMGg9YY0YD6PHAV7iZdkegXvtRx
         mmz9Qpgmv3P+A==
Subject: Re: git overwriting local ignored files?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <a852c0e9-f278-8e2a-406c-bb6099b2440c@mandelberg.org>
 <xmqqftvr2jfo.fsf@gitster-ct.c.googlers.com>
From:   David Mandelberg <david@mandelberg.org>
Message-ID: <7ac49733-2e62-7d29-36aa-99df4124b54c@mandelberg.org>
Date:   Sat, 24 Nov 2018 09:37:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqftvr2jfo.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/23/18 11:22 PM, Junio C Hamano wrote:
> David Mandelberg <david@mandelberg.org> writes:
> 
>> It seems that git is overwriting my local files on merge if they're in
>> .gitignore. See command transcript below. I searched `git help config`
>> and Google, but I couldn't find any way to prevent it. Am I missing
>> something? (The reason I care about ignored files is that I'm using
>> git with a working directory of $HOME to manage my dotfiles, and most
>> files in my $HOME are not tracked by git but are still important.)
> 
> The .gitignore file is to list "ignored and expendable" class of
> files; there is no "ignored but precious class" in Git.

Ok. Would a patch be welcome? I have three ideas for how to implement 
it, and I'm not sure which is better.

1. Add a boolean config option called core.preserveIgnore (or similar). 
I'm guessing this is the least amount of work, but it's not very 
flexible. I'm also not sure how it should work with `git clean`.

2. Add some syntax to the .gitignore format so the same file can list 
both "ignored and expendable" and "ignored and precious". I could see 
using this to mark compiled files as ignored+expendable and per-repo 
editor/IDE config files as ignored+precious. Do you have any idea how 
big of a patch this would be? Or any idea for the new syntax? I think 
starting a line with "\x" where x is any character not currently escaped 
by a backslash would cause the least disruption to existing .gitignore 
files.

3. Like (2), but use a separate file instead of .gitignore (and the 
other git-ignore files).

Any thoughts?

-- 
https://david.mandelberg.org/
