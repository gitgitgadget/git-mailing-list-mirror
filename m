Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396F61F78F
	for <e@80x24.org>; Mon,  1 May 2017 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756091AbdEANvo (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 09:51:44 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:32924 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755441AbdEANvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 09:51:42 -0400
Received: by mail-io0-f172.google.com with SMTP id k87so119030366ioi.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5lD/fiY0yxSU5PE4ng8VFQ9yU0mIBlG/PpRy3i6Os+Y=;
        b=GLeHYGGVkLsJvlywTJyw7E9e2r44Sg7ny8ntqhPIPi51w0ZqSTz+Aw84Hfc/U8zJMO
         ZGexnMu6Qiv/YydH1O4C7qe2kUhkx86pAnylstAwFvHR1vmY7Z0nwNv9cMzK4NVV5MUS
         vMB3WXeK82+SFRL75mrZw/tIaz5Xw0Wju25N5551QpQh+8ZDgtyPRA8QEqkn3IEJ2pBs
         RYQyH88EanGJwrKa3gWRk6+NFYc5xKOH/pZQwK1f2bIp75/+7RMQhXv96pnlGZn4e1uH
         Vzd9HcgPZcQlm0I7IDdZy+jUJHDq/gLjYml4CFVAjNIrnGGqPmdCxbDugUUqnyjmOxNd
         Z6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5lD/fiY0yxSU5PE4ng8VFQ9yU0mIBlG/PpRy3i6Os+Y=;
        b=twnYmZzq7LjfXKiieqjo6UKhO1rFYqocbRcO7CoEW+jcYoZaNIL5OKcIYWjUq9gu3b
         esJVi+lHGDvXutMYheUvsrHl8SNEs6bluWnXm37VKc3mOl2fqiqOo5xK8ZXbqudJnkSw
         cWO2bDG0EYdGkPk21HySKcqTN1dy/5htKUHh09r09MREqlXxKWyIlcapN9OEI0Iq9V5J
         M3nC+0z3GMKV5+PlzxvSHzBn/4CKvmLUm+Uywh3Mo5/XDCd0YRp7mSJf0IMZvETpmaDW
         xfNJR9IWZ57phg31ZhNqY2NEzqWrl27p9gPUn5n8RKdQRtz70flcmzoMl+uM8AlA2JdG
         2upg==
X-Gm-Message-State: AN3rC/6s9B/OxQxrFKkeYWDOZGmycNvDGSvIh1tw3JUvLvm8HmQGRkiI
        yVqq5I5qhfK+Enh1ylVzfNurhvoDmbFj
X-Received: by 10.107.130.16 with SMTP id e16mr26760927iod.17.1493646701996;
 Mon, 01 May 2017 06:51:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Mon, 1 May 2017 06:51:01 -0700 (PDT)
In-Reply-To: <CABfTTAdQPGei6CZoHGJGUtKHdJ4eT822pzc=DATynfeaZ94gxA@mail.gmail.com>
References: <CABfTTAchc61aB02sCD=Oa9gRMGr94h7mC53B9q6Qy2k2hDqzAQ@mail.gmail.com>
 <xmqq60hljqud.fsf@gitster.mtv.corp.google.com> <CABfTTAdQPGei6CZoHGJGUtKHdJ4eT822pzc=DATynfeaZ94gxA@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 1 May 2017 08:51:01 -0500
Message-ID: <CAJZjrdXfcaUrJXbAoPtRtvigouZ2eNyNsZ=2WtSY20_D+Ow6qw@mail.gmail.com>
Subject: Re: Bug Report: .gitignore behavior is not matching in git clean and
 git status
To:     Chris Johnson <chrisjohnson0@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2017 at 8:56 PM, Chris Johnson <chrisjohnson0@gmail.com> wr=
ote:
> Good assessment/understanding of the issue. git clean -n  does not
> report anything as being targeted for removal, and git clean -f
> matches that behavior. I agree with it probably being related
> specifically to the -d flag.
>
> As another experiment I modified .gitignore to ignore /A/B/C instead
> of /A/B/ and the same result occurs (-n reports nothing, -dn reports
> removing A/)
>
> Lastly, I changed .gitignore to just be /A/, and in doing so, clean
> -dn stops reporting that it will remove A/. I=E2=80=99m not exactly sure =
if
> this last one is surprising or not.

It doesn't seem so to me, since a trailing slash in .gitignore is an
explicit directive to ignore the entire directory, so when pruning the
tree of files/dirs to ignore, it drops everything in A/ before even
getting to A/B/C. The issue is that ignoring A/B/C shouldn't leave A/
to be cleaned.

> Also, and sorry for the noise, but I did a reply-all here, but will a
> reply automatically include the rest of the list? Or was reply-all the
> right move?
>
> On Sun, Apr 30, 2017 at 9:41 PM, Junio C Hamano <gitster@pobox.com> wrote=
:
>> Chris Johnson <chrisjohnson0@gmail.com> writes:
>>
>>> I am a mailing list noob so I=E2=80=99m sorry if this is the wrong form=
at or
>>> the wrong please.
>>>
>>> Here=E2=80=99s the setup for the bug (I will call it a bug but I half e=
xpect
>>> somebody to tell me I=E2=80=99m an idiot):
>>>
>>> git init
>>> echo "/A/B/" > .gitignore
>>
>> You tell Git that anything in A/B/ are uninteresting.
>>
>>> git add .gitignore && git commit -m 'Add ignore'
>>> mkdir -p A/B
>>> touch A/B/C
>>
>> And create an uninteresting cruft.
>>
>>> git status
>>
>> And Git does not bug you about it.
>>
>>> git clean -dn
>>
>> This incorrectly reports "Would remove A/" and if you gave 'f'
>> instead of 'n', it does remove A/, A/B, and A/B/C.
>>
>> Despite that "git clean --help" says 'only files unknown to Git are
>> removed' (with an undefined term 'unknown to Git').  What it wants
>> the term mean can be guessed by seeing 'if the -x option is
>> specified, ignored files are also removed'---so 'unknown to Git'
>> does not include what you told .gitignore that they are
>> uninteresting.  IOW, Git knows they are not interesting.
>>
>> It looks like a bug in "git clean -d" to me.

I may be wrong (I'm not very familiar with the codebase), but I don't
think it's a bug in specifically git clean -d.

Throwing gdb at it, when builtin/clean.c:cmd_clean() calls
dir.c:fill_directory(), A/ gets appended to dir->entries, regardless
of whether or not git clean is called with or without -d. The
difference is that if git clean is called without -d, the loop that
strips out directories strips out the A/ entry.

When dir.c:fill_directory() is invoked through git status, A/ does
not, however, get appended to dir->entries. As best as I can tell,
this seems to be because git status sets the
DIR_HIDE_EMPTY_DIRECTORIES flag, whereas git clean does not (which
makes sense), but the fact that DIR_HIDE_EMPTY_DIRECTORIES is
responsible for not adding A/ to dir->entries seems to be the issue.
