Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302A01F576
	for <e@80x24.org>; Fri, 26 Jan 2018 07:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeAZHvF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 02:51:05 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:45462 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeAZHvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 02:51:04 -0500
Received: by mail-pg0-f49.google.com with SMTP id m136so6767323pga.12
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 23:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:references:in-reply-to:date
         :mime-version;
        bh=r47zVCZrNJD2fFbOVdaoMDYRoiDj1Ss6TEmY1veagJo=;
        b=k6sWXIGmAEisbvoacVIlIqXAnBmcIfjah9Bkrqx+Ub8zei8lSL8PONHVx9vPdEeMdQ
         QbMef7H96Y7FMjVUdzg/dDkHnMkxhZc+j2WdT3QrW3I32GYGIoMbZH237OOH7JIDdX/A
         Zb49GAjHZGFkoNBz8idTtgxgNuLdZeIWRpZLozRtynb3AtU7UWVD8hxGhDsZepnRn5yp
         +IqfBBN18nNJ624nGCa+fO8up8Y7iL2KV1mMG3oDyJJEbIkrH4e/IHgUGZVUyBk1fOaP
         QdaWPgXDg1J/M6sSTPEw5fcIqDlAMQKRItcbqxtTuvV/UrlkZsn9Ft4aRoEEcnrUn3AA
         CUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:references
         :in-reply-to:date:mime-version;
        bh=r47zVCZrNJD2fFbOVdaoMDYRoiDj1Ss6TEmY1veagJo=;
        b=W+6uQ2b1Sh8Dpqa+kIBxJeDwfhZWFxSVQpyr0kM4t15cgFkT0vDo19XkVESlvHsb++
         45nqw1seYHYxBQAeC8EtrauN5QFtz5f94565cPI5EYAsTE1iEewwUcpxJdmILtyJkKJp
         raAMthKKi709uvLzzrYyR1WL7JeHswyw1TBsvbPyx7l5jimI3W0bLI1sCFVV6iyR9VH0
         gRoHAgE17gaVamdoXdutb7MK531/STM3yeKhIaDLbA8x9NZeHHL4u1UXp0izQfZpj/zb
         i5ZAkmpptzDiUFJ5Aytpu05JnJBDDgxZXzxXXmx+fCUVMETjF8gMYI6+7VDXeEOckIIg
         EESA==
X-Gm-Message-State: AKwxytfGEkAY2KybgvpluP4YmruUSDPjVB6H9fWRW2O0xPvWfiUHGS6j
        yo9nPhUEcAZHRpMM8TzMq5/hwXi3
X-Google-Smtp-Source: AH8x227kK7vcjKqJlEyGGY77+XBCf5+SeNw44iJAeq2bgm7IBYv5dL98SdgxOdRFGa+eK/+5Cy5KaQ==
X-Received: by 2002:a17:902:5814:: with SMTP id m20-v6mr4378897pli.434.1516953064118;
        Thu, 25 Jan 2018 23:51:04 -0800 (PST)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id c29sm19737896pfd.172.2018.01.25.23.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 23:51:02 -0800 (PST)
Message-ID: <1516953056.8886.3.camel@gmail.com>
Subject: Re: Bug, git rebase -i does not abort correctly
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CACsJy8Dzh5E8JUDkwFmYTwS6KgqGc_1rJBVsDCoC9EpcSShN2Q@mail.gmail.com>
In-Reply-To: <CACsJy8Dzh5E8JUDkwFmYTwS6KgqGc_1rJBVsDCoC9EpcSShN2Q@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-IxJgYBL7VRXucOy8poS8"
Date:   Fri, 26 Jan 2018 13:20:56 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-IxJgYBL7VRXucOy8poS8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

On Thursday 25 January 2018 05:43 PM, Duy Nguyen wrote:
> rebase scripts are too much for me, so I'll play the user reporting
> bugs this time :)
> 
> Instead of doing
> 
>     $ git rebase -i --onto origin/master @~3
> 
> I sometimes accidentally type
> 
>     $ git rebase -i origin/master @~3
> 
> ("rebase -i" is actually an alias, which is why I never forget to
type -i)
> 
> Usually the todo list in $EDITOR shows noop, I realize my mistake and
> try to abort it by clearing the todo list before saving and closing
> $EDITOR. The problem is, HEAD is moved away anyway (to origin/master
I
> think) 

For me it left HEAD at @~3. Reading the synopsis of `man git rebase` I
could guess that the corresponding abstract form would be,

    $ git rebase -i <upstream> <branch>


> even if rebase is supposed to abort the operation and leave
> HEAD untouched.
> 

This might seem to be a bug as the comment in "git-rebase-todo" says,

    However, if you remove everything, the rebase will be aborted.

But "man git rebase" clearly says,

    If <branch> is specified, git rebase will perform an automatic "git
    checkout <branch>" before doing anything else. Otherwise it remains
    on
    the current branch.

Junio has previously confirmed that "git rebase [-i] <upstream>
<branch>" is just a short hand for "git checkout <branch> && git rebase
[-i] <upstream>".[ref 1] So, it's not surprising that it left HEAD at
@~3 when you completely removed the contents of git-rebase-todo and
exited the editor.

Does that help solve your issue?


[ref 1]: 

https://public-inbox.org/git/%3Cxmqqpo8387hz.fsf@gitster.mtv.corp.google.com%3E

-- 
Kaartic

QUOTE

“It is impossible to live without failing at something, unless you live
so cautiously that you might as well not have lived at all – in which
case, you fail by default.”

      - J. K. Rowling


WIKIPEDIA: DID YOU KNOW?

Only 33% of internet users in India have heard of Wikipedia !!

* What do you think could be the reason behind this?

* What are ways in which the awareness about Wikipedia in India and
other countries be increased ?

Reference:

* Give your ideas for increasing the awareness of Wikipedia in India
and
in other countries and get a Grant from the Wikimedia Foundation to
bring your idea to life.

  https://meta.wikimedia.org/wiki/Grants:IdeaLab/Inspire

* Know more about the awareness problem of Wikipedia

  https://meta.wikimedia.org/wiki/New_Readers/Awareness

  https://meta.wikimedia.org/wiki/New_Readers/Next_steps/Raising_awareness
-- 
Kaartic
--=-IxJgYBL7VRXucOy8poS8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi,

I seem to able to reproduce your issue. More comments inline.

On Thursday 25 January 2018 05:43 PM, Duy Nguyen wrote:
> rebase scripts are too much for me, so I'll play the user reporting
> bugs this time :)
> 
> Instead of doing
> 
>     $ git rebase -i --onto origin/master @~3
> 
> I sometimes accidentally type
> 
>     $ git rebase -i origin/master @~3
> 
> ("rebase -i" is actually an alias, which is why I never forget to type -i)
> 
> Usually the todo list in $EDITOR shows noop, I realize my mistake and
> try to abort it by clearing the todo list before saving and closing
> $EDITOR. The problem is, HEAD is moved away anyway (to origin/master I
> think) 

For me it left HEAD at @~3. Reading the synopsis of `man git rebase` I
could guess that the corresponding abstract form would be,

    $ git rebase -i <upstream> <branch>


> even if rebase is supposed to abort the operation and leave
> HEAD untouched.
> 

This might seem to be a bug as the comment in "git-rebase-todo" says,

    However, if you remove everything, the rebase will be aborted.

But "man git rebase" clearly says,

    If <branch> is specified, git rebase will perform an automatic git
checkout <branch> before doing anything else. Otherwise it remains on
       the current branch.
Surprisingly when git-rebase-todo's content is only a "noop" just
closing the editor without removing the contents also seems to be lying
as it checks
-- 
Kaartic

QUOTE

“It is impossible to live without failing at something, unless you live
so cautiously that you might as well not have lived at all – in which
case, you fail by default.”

      - J. K. Rowling


WIKIPEDIA: DID YOU KNOW?

Only 33% of internet users in India have heard of Wikipedia !!

* What do you think could be the reason behind this?

* What are ways in which the awareness about Wikipedia in India and
other countries be increased ?

Reference:

* Give your ideas for increasing the awareness of Wikipedia in India and
in other countries and get a Grant from the Wikimedia Foundation to
bring your idea to life.

  https://meta.wikimedia.org/wiki/Grants:IdeaLab/Inspire

* Know more about the awareness problem of Wikipedia

  https://meta.wikimedia.org/wiki/New_Readers/Awareness

  https://meta.wikimedia.org/wiki/New_Readers/Next_steps/Raising_awareness

--=-IxJgYBL7VRXucOy8poS8--

