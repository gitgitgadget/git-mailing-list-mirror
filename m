Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50D21F453
	for <e@80x24.org>; Fri, 26 Apr 2019 05:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDZFll (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 01:41:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36713 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZFll (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 01:41:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so2538326wml.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sPP+K+qGjZFBPQG+8FfWH7XetAffec3XGs413XlWPKw=;
        b=H5mXlEO/t7bRiSxoT4Ym9Wg/T2SOWT17c4QZZPO8Tk7v+vlF98VdYwhYGzfP40tcsH
         4exTBZThNg1n8OGCYHNhcz8+W9RNCDrqGFVRTjwGxHGV+je8pCF8z1BrOWLuIEhZSHVm
         gG4VEAuJugLeotvAnVVfdL5ldcEiOJWhc8cA9EWtJ9i/j//Q86hqkiEfuKoPda50RduJ
         JZYAc2NgvdbtTwX1daSamrQel3bUEphCPw97rx4SyfLe1phlh3GL0EkpCIjIaeOs9Tkz
         hly6B+00+adK4PIpgs3LDQ3hU4qYW78+o2aTarnuAevzfW3daVkFV7L2IkhTPh2BcKBi
         +9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sPP+K+qGjZFBPQG+8FfWH7XetAffec3XGs413XlWPKw=;
        b=uCB9eBiK0BrlLGi5L5H3MI/JHwobPx+iXs6I+WAEbxXNmjlrTODTH2Lbtaax85cSrB
         HkJ6HWWA1RI6qaYwRskVLASxIdOTDDZZgoJ8kCjO3LldR2cI4AR+7q//6KPDlMetEniU
         Kql7Ja3jA0PpSe2a968acaaEn7Ewcsq5u1UH/40E8ss63duL+ni8zXJY9iVlMlGuvzTa
         SDi1V27GVWkdua3mZT8i2YbC4ABjkFwnNN0catBZtWIzvw6D2SNxK0gkbgmBQk08JvTr
         2VEia6CspVTiwnv1D9wXTH6OwNQHKJKFtKzmmM2Fi+fwLhPfBs/wN38//QUwScox5HUp
         ymeg==
X-Gm-Message-State: APjAAAVCG8qkuU/Egg2dVWZIuyc4H1CXzfJ2XNXdN8/9uoW8M8aTZU8N
        x6KnyaNbv7f6Eb3P/O4mAAR29J8SjUw=
X-Google-Smtp-Source: APXvYqxHDaazUyLlO8khu+x5/VAPw53QIOgPWmexz6gqbBnNVgxKPJJLvF5qBxjC+e6hhuyCcGdY4A==
X-Received: by 2002:a1c:14:: with SMTP id 20mr6563172wma.66.1556257299624;
        Thu, 25 Apr 2019 22:41:39 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id n6sm29480395wmn.48.2019.04.25.22.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 22:41:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
        <20190426050531.GA7854@Taylors-MBP.hsd1.wa.comcast.net>
Date:   Fri, 26 Apr 2019 14:41:38 +0900
In-Reply-To: <20190426050531.GA7854@Taylors-MBP.hsd1.wa.comcast.net> (Taylor
        Blau's message of "Thu, 25 Apr 2019 22:05:31 -0700")
Message-ID: <xmqqd0l9uxv1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Apr 25, 2019 at 07:15:06PM +0900, Junio C Hamano wrote:
>> * tb/unexpected (2019-04-10) 7 commits
>>   (merged to 'next' on 2019-04-25 at c49927fca0)
>>  + rev-list: detect broken root trees
>>  + rev-list: let traversal die when --missing is not in use
>>  + get_commit_tree(): return NULL for broken tree
>>  + list-objects.c: handle unexpected non-tree entries
>>  + list-objects.c: handle unexpected non-blob entries
>>  + t: introduce tests for unexpected object types
>>  + t: move 'hex2oct' into test-lib-functions.sh
>>
>>  Code tightening against a "wrong" object appearing where an object
>>  of a different type is expected, instead of blindly assuming that
>>  the connection between objects are correctly made.
>>
>>  Will merge to 'master'.
>
> Thanks for picking this up. Before you merge to master, I want to make
> sure that the whole series was taken in.
>
> I can see the first four of these landed on 'next' (in
> 5c07647d98...b49e74eac4), but I'm having some difficulty finding the
> later three.
>
> Did you pick these up as well?

Sorry, but I do not follow.

$ git log --oneline master..c49927fca0^2
97dd512af7 rev-list: detect broken root trees
ee4dfee227 rev-list: let traversal die when --missing is not in use
834876630b get_commit_tree(): return NULL for broken tree
b49e74eac4 list-objects.c: handle unexpected non-tree entries
23c204455b list-objects.c: handle unexpected non-blob entries
0616617c7e t: introduce tests for unexpected object types
5c07647d98 t: move 'hex2oct' into test-lib-functions.sh

Do you mean you do not have b49e74eac4..c49927fca0?  I do not think
the topic was merged in multiple steps (iow, at c49927fca0^ the
whole 7 commits were not in 'next', and after c49927fca0, all 7 are
in).  So I am not sure what you are asking.  IOW, if you have b49e74
in your copy of 'next', it is impossible not to have the others.

The merge itself can be seen at one of the authoritative repositories

https://git.kernel.org/pub/scm/git/git.git/commit/?h=next&id=c49927fca0de4c213ae9b21dcb7eafb80e453d27

Unfortunately, I do not know how to ask GitHub web UI to give us a
simple "log --oneline" equivalent of list like gitweb did (sadly
cgit is not much better wrt this), but I think clicking on the
parent link starting from here

https://github.com/git/git/commit/c49927fca0de4c213ae9b21dcb7eafb80e453d27

and remembering (or writing down X-<) the commit names would
eventually give us the equivalent.

In any case, thanks for working on this topic.
