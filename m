Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B301F78F
	for <e@80x24.org>; Mon,  1 May 2017 15:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755179AbdEAPnT (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 11:43:19 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36356 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdEAPnE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 11:43:04 -0400
Received: by mail-io0-f175.google.com with SMTP id p80so122284416iop.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1cRRpY/hRITIldLAhfv1vv2gViCFc+brZkJAshIqMa4=;
        b=Vccd1eYjwfD9L0OXhEHiciqZWZ9jtM4vtT7Q3bD/pQP8LGkOI/aIH4ZExoO5P7Vtw5
         6inD2RmmuKqjgggzi9ha2nVhS5zmaZsPQQUsaq2inyf+mUN/Brd7zknCLFVIQbnslAD4
         edcchnojHTZ5YTig7OsGXF9u4Sd78wPSLVq/gRrocFvwaWVlxVsIKyEM8z4hgr1mluwl
         ZLoqU1hvKjwMj0r+6TnWfV+IDDz024+koecjkpx6Sk5/XASkKPsKidXkMXeQILjPoJ8A
         0nV157ZllwbmNXnd13DUQc6oyr4G0P5JqT9HftHCJtY9HE+8fqLsD1D1HFT87Axsulbm
         lVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1cRRpY/hRITIldLAhfv1vv2gViCFc+brZkJAshIqMa4=;
        b=ZlCbZbZlY7OpbTeAA2dh0/KD+kHakOEm6//gYRVX+9QxYser71brWb+hYY52Mi7jyG
         57hdAX0EFbTud2bUMOAfg88jbqlUS9bd4VoTb1o1guku5lwNxHKouH9Cfsdvy1JdSHVB
         U2iFI8FR31EIFBUEGPjTaAVoKSfww1oVz4FMluHAAqCEuo2/FM2kMGw5vwzHmDH7Cumz
         5vvztn2j1ZkVn4fb1skqPUQqCWDaDRBZOA47VFQiYHOXDkl5LQmasqSq+C3M9iWDaosd
         DEju7cCe/si/tJt3EjnNzW2LyP+jlz7hZNMl/taQtz3GZdvOCtUewmPMsW7KGn/CfNxs
         avLQ==
X-Gm-Message-State: AN3rC/7YGwhm3QiFGGg9aqZi4xUierRnSjVbHQNCqlnCNxI9hR4BNVZY
        Q8XzQXfz72/+4ayGkpJfdwrvHOpzAA==
X-Received: by 10.107.11.89 with SMTP id v86mr27553662ioi.85.1493652888648;
 Mon, 01 May 2017 08:34:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Mon, 1 May 2017 08:34:08 -0700 (PDT)
In-Reply-To: <CAJZjrdXfcaUrJXbAoPtRtvigouZ2eNyNsZ=2WtSY20_D+Ow6qw@mail.gmail.com>
References: <CABfTTAchc61aB02sCD=Oa9gRMGr94h7mC53B9q6Qy2k2hDqzAQ@mail.gmail.com>
 <xmqq60hljqud.fsf@gitster.mtv.corp.google.com> <CABfTTAdQPGei6CZoHGJGUtKHdJ4eT822pzc=DATynfeaZ94gxA@mail.gmail.com>
 <CAJZjrdXfcaUrJXbAoPtRtvigouZ2eNyNsZ=2WtSY20_D+Ow6qw@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 1 May 2017 10:34:08 -0500
Message-ID: <CAJZjrdXVopdvDoDwnsmqvrLESKQq=-a2waDgu5HYYoP2WvSrPA@mail.gmail.com>
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

After some more digging (and familiarizing myself with the
behind-the-scenes logic) the issue is that dir.c has this implicit
assumption that a directory which contains only untracked and ignored
files should itself be considered untracked. While that works fine for
use cases where we're asking if a directory should be added to the git
database, that decidedly does not make sense when we're asking if a
directory can be removed from the working tree.

I'm not sure where to proceed from here. I see two ways forward: one,
builtin/clean.c can collect ignored files when it calls
dir.c:fill_directory(), and then clean -d can prune out directories
that contain ignored files; two, path_treatment can learn about
untracked directories which contain excluded (ignored) files.

On Mon, May 1, 2017 at 8:51 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> On Sun, Apr 30, 2017 at 8:56 PM, Chris Johnson <chrisjohnson0@gmail.com> =
wrote:
>> Good assessment/understanding of the issue. git clean -n  does not
>> report anything as being targeted for removal, and git clean -f
>> matches that behavior. I agree with it probably being related
>> specifically to the -d flag.
>>
>> As another experiment I modified .gitignore to ignore /A/B/C instead
>> of /A/B/ and the same result occurs (-n reports nothing, -dn reports
>> removing A/)
>>
>> Lastly, I changed .gitignore to just be /A/, and in doing so, clean
>> -dn stops reporting that it will remove A/. I=E2=80=99m not exactly sure=
 if
>> this last one is surprising or not.
>
> It doesn't seem so to me, since a trailing slash in .gitignore is an
> explicit directive to ignore the entire directory, so when pruning the
> tree of files/dirs to ignore, it drops everything in A/ before even
> getting to A/B/C. The issue is that ignoring A/B/C shouldn't leave A/
> to be cleaned.
>
>> Also, and sorry for the noise, but I did a reply-all here, but will a
>> reply automatically include the rest of the list? Or was reply-all the
>> right move?
>>
>> On Sun, Apr 30, 2017 at 9:41 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> Chris Johnson <chrisjohnson0@gmail.com> writes:
>>>
>>>> I am a mailing list noob so I=E2=80=99m sorry if this is the wrong for=
mat or
>>>> the wrong please.
>>>>
>>>> Here=E2=80=99s the setup for the bug (I will call it a bug but I half =
expect
>>>> somebody to tell me I=E2=80=99m an idiot):
>>>>
>>>> git init
>>>> echo "/A/B/" > .gitignore
>>>
>>> You tell Git that anything in A/B/ are uninteresting.
>>>
>>>> git add .gitignore && git commit -m 'Add ignore'
>>>> mkdir -p A/B
>>>> touch A/B/C
>>>
>>> And create an uninteresting cruft.
>>>
>>>> git status
>>>
>>> And Git does not bug you about it.
>>>
>>>> git clean -dn
>>>
>>> This incorrectly reports "Would remove A/" and if you gave 'f'
>>> instead of 'n', it does remove A/, A/B, and A/B/C.
>>>
>>> Despite that "git clean --help" says 'only files unknown to Git are
>>> removed' (with an undefined term 'unknown to Git').  What it wants
>>> the term mean can be guessed by seeing 'if the -x option is
>>> specified, ignored files are also removed'---so 'unknown to Git'
>>> does not include what you told .gitignore that they are
>>> uninteresting.  IOW, Git knows they are not interesting.
>>>
>>> It looks like a bug in "git clean -d" to me.
>
> I may be wrong (I'm not very familiar with the codebase), but I don't
> think it's a bug in specifically git clean -d.
>
> Throwing gdb at it, when builtin/clean.c:cmd_clean() calls
> dir.c:fill_directory(), A/ gets appended to dir->entries, regardless
> of whether or not git clean is called with or without -d. The
> difference is that if git clean is called without -d, the loop that
> strips out directories strips out the A/ entry.
>
> When dir.c:fill_directory() is invoked through git status, A/ does
> not, however, get appended to dir->entries. As best as I can tell,
> this seems to be because git status sets the
> DIR_HIDE_EMPTY_DIRECTORIES flag, whereas git clean does not (which
> makes sense), but the fact that DIR_HIDE_EMPTY_DIRECTORIES is
> responsible for not adding A/ to dir->entries seems to be the issue.
