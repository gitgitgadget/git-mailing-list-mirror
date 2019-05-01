Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFE51F453
	for <e@80x24.org>; Wed,  1 May 2019 14:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfEAO6d (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 10:58:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47071 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfEAO6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 10:58:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so5134180wrr.13
        for <git@vger.kernel.org>; Wed, 01 May 2019 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XwTsMqUTtBjYS/+bS1+v4LGBmEzs8w/a1He0lJnaUvk=;
        b=R5ebly3tmBQG7Zl4jLNn0BBmk65y6SNSk6LNCgfSb+0nkKQCmhZSNzTshn/WPt4wnu
         Owjiw5QlsPKUkubPD5z3VQO9BPo83X5FSeORtqKoJFRy8ifNMUXXTgIFrWCHa4xKiSUk
         ma5tX9EDqA5/6umutXVfI7gL/vImpPPE6TkVsqQxc3TcuKL2+RFTlluc9fG0XIWbJMJL
         tKpKOFrU/SRxSgRKi9FQ0j4LfTnGfFrlSgwBlTc5HbTbDGx2nby8DdV9n6zUfL6zN2ns
         /1XVM4Ei66t5g7eWnZGwu1p/EblyUK54AmW3l4CeJfE7Mq84ynLuV5wGLx1D4xnoEIi5
         9dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XwTsMqUTtBjYS/+bS1+v4LGBmEzs8w/a1He0lJnaUvk=;
        b=XvfA5rwfYC35EvWoSXNhVRuwEc575uzQRB9QJRGEKLIpOFOJyP+J0uu6JjZWmyn97T
         NWi7x4MXVWPYunR6dhXjPkx8Q/u+MRrcd5bJN5K/KNQf/0TWTeGzEMvOeOHRlH+Z1jfI
         UL8kCVfT7Ymcuz9lz+YxWemJ/PlbKX1GqkCQ4ldoP+EHs62XMcjdxYe8KJeM970jI/Tr
         NutniCRWprrgitngI+pIF76SwYumLNV0WbVyreTVUBbk4Nj0JuTpzVeqVH1YR62oH+ts
         Pflfab1LQgF61pVm/k2Zd+N2d6KfABJ4iKBG6vx9gwkLRk215+lt6x7lTJL05Fqiid0A
         zwig==
X-Gm-Message-State: APjAAAXrmkzqT7tlb2hRz+b9KgYw+wRQW2A5f0I0V0hfhdX75OlxJvga
        dWKpTBQ7PIA7ePTTeygXYSc=
X-Google-Smtp-Source: APXvYqwDEdnJjDTL6r0dINsQv2JeRo3xUoYERgwdk+DQvXtq5oe+7sfPNetnRNQqVohHhvjTHcj5ow==
X-Received: by 2002:adf:a28b:: with SMTP id s11mr8685369wra.16.1556722711337;
        Wed, 01 May 2019 07:58:31 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id l21sm4056702wmh.35.2019.05.01.07.58.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 07:58:30 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] read-tree: improve untracked file support
To:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20190501101403.20294-1-phillip.wood123@gmail.com>
 <CACsJy8CNUEBXmBcQnRHqdeFJtTvBuZ9thP7QPAw-ZOD+2ty3VA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d4c36a24-b40c-a6ca-7a05-572ab93a0101@gmail.com>
Date:   Wed, 1 May 2019 15:58:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CNUEBXmBcQnRHqdeFJtTvBuZ9thP7QPAw-ZOD+2ty3VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/05/2019 11:31, Duy Nguyen wrote:
> On Wed, May 1, 2019 at 5:14 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> These two patches teach read-tree how to avoid overwriting untracked
>> files when doing '--reset -u' and also how to respect all of git's
>> standard excludes files. I'd like to see the porcelain commands stop
>> overwriting untracked files, this is a first step on the way. I'm not
>> sure if we want to add options to the porcelain commands to protect
>> untracked files or just change their behavior and add an option to
>> override that. I'm leaning towards the latter but I'd be interested to
>> hear what others think.
> 
> For new commands like git-restore, it's definitely a good thing to not
> overwrite untracked files.

I agree, unfortunately this series does not help with git-restore, only 
git-switch. For restore on an index without conflicts I think it could 
just use the pathspec in struct unpack_trees_options and set opts.rest = 
UNPACK_RESET_PROTECT_UNTRACKED but that does not help if we want to 
handle conflicted paths differently to non-conflicted paths.

> For existing commands I guess we have to go
> over them one by one. For "git reset --hard", it should really just
> overwrite whatever needed to get back to the known good state. "git
> checkout -f" , not so sure (seems weird that we need force-level-two
> option to override the protection provided by -f, if we change default
> behavior)

I think it's fine for "checkout -f" to overwrite untracked files (and if 
"switch --discard-changes" does not then there is no pressing need to 
add such a mode to checkout), --force is a good name for an option that 
nukes everything that gets in it's way. For "reset --hard" I'm not so 
sure, if I have changes to an untracked file I don't wont them 
overwritten by default. There is no porcelain equivalent to "read-tree 
--reset --protect-untracked -u" and I was hoping "reset --hard" may 
become that porcelain equivalent with a new --force or 
--overwrite-untracked option.

For the various "foo --abort" some (most?) are using "reset --merge" 
which I think declines to overwrite untracked files but rebase uses 
"reset --hard" which I'd like to change to protect untracked files in 
the same way that rebase does for the initial checkout and when picking 
commits. I haven't thought about stash.

Best Wishes

Phillip

