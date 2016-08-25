Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B7D1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 16:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758159AbcHYQCA (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 12:02:00 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36305 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756608AbcHYQB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 12:01:59 -0400
Received: by mail-pa0-f50.google.com with SMTP id di2so18076970pad.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alexnauda-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sGS5Pa7irksKFrRCACt7vuGe02MvURQVrD4NimE3Yf0=;
        b=wd1UJC6gRoar3QKXYEkC3Kw/io526mDYQZNZosE0gwqT4tCVmBdaBNVD8k76FuUNAz
         CoS9wSvsfTk+0MMIdGt7WNg8aJ+Se6monJEwo/TRHDb9SqZJt4qqZ39hERLt93Nff8sq
         cGzQiyqG84srDKUIPHS3MjlhuHTSKV0IZwPtCYvfoIItMBjy4xwXdpE19EtyAViOt3/M
         hsDX0iFvM3ehkNmiIehVMEKsBmbYvS2uB6+TiStODEkm1oqprsEY/KIXpY9OhZwhP/nV
         5+RmQMi/ENXmFKUgPBIQrlUpYasP3bF56eA4DwOaeh0XK2FX3vWbb5IDY0MJEJgf85fC
         G1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sGS5Pa7irksKFrRCACt7vuGe02MvURQVrD4NimE3Yf0=;
        b=ibTLNcGhmI7fFn/3QBNL8foJtWlpTFxJHgAPcLBW5bIWxYOSj+9cdJnoF1sZjLSvbN
         tz9l5ZXPrY4MefmJH2BoZ2g9HeoCiNu/M0sE7Lp7AX3jOMtii+/vWPRNGQGGKdTJd17q
         DfAv2WknHnm5HzblDQO6cLEVX7BZHgaTgEhZd5y4kHSEBQFKbyh0is2BGgdc9dpKVaGp
         04hgriFYIkmwwAF4vfFnWnZ0ySWHxf13fI8GDRN23YD+4Qste2Q1dIzVUHoJx5C/9hkL
         AYgV8LzuxKyrT2jVH8pVeSr69a1qnlViXQssygEAGSRd7ZljwdLSw7HaqHIbvhrNNSF4
         ZyjQ==
X-Gm-Message-State: AE9vXwNUadt182Xj5xzVEHsAI78wdeww9YkLmu5TMRNo+OcupLX39Te2Az3SrnyCfi+1CvKcX477AWXzm/3cbg==
X-Received: by 10.66.221.229 with SMTP id qh5mr17483310pac.66.1472140918177;
 Thu, 25 Aug 2016 09:01:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.67.4.229 with HTTP; Thu, 25 Aug 2016 09:01:57 -0700 (PDT)
X-Originating-IP: [54.208.66.34]
In-Reply-To: <67cde0aa-89fc-b574-d5f5-7e754d77b5bb@alum.mit.edu>
References: <CAMQLHmAraXPL=8SmMG4X_424FAzx4q2Byk8pva5wEOg7vNSqLw@mail.gmail.com>
 <20160824213900.gcnwxu46zvgpjr5a@sigill.intra.peff.net> <67cde0aa-89fc-b574-d5f5-7e754d77b5bb@alum.mit.edu>
From:   Alex Nauda <alex@alexnauda.com>
Date:   Thu, 25 Aug 2016 12:01:57 -0400
Message-ID: <CAMQLHmA=b0HMO9s0nt3VTdOYe51oE3UrrrCDH3Z_Tq0Nuhe-kQ@mail.gmail.com>
Subject: Re: on Amazon EFS (NFS): "Reference directory conflict: refs/heads/"
 with status code 128
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 2:28 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/24/2016 11:39 PM, Jeff King wrote:
>> On Wed, Aug 24, 2016 at 04:52:33PM -0400, Alex Nauda wrote:
>>
>>> Elastic File System (EFS) is Amazon's scalable filesystem product that
>>> is exposed to the OS as an NFS mount. We're using EFS to host the
>>> filesystem used by a Jenkins CI server. Sometimes when Jenkins tries
>>> to git fetch, we get this error:
>>> $ git -c core.askpass=true fetch --tags --progress
>>> git@github.com:mediasilo/dodo.git
>>> +refs/pull/*:refs/remotes/origin/pr/*
>>> fatal: Reference directory conflict: refs/heads/
>>> $ echo $? 128
>>>
>>> Has anyone seen anything like this before? Any tips on how to troubleshoot it?
>>
>> No, I haven't seen it before. That's an internal assertion in the refs
>> code that shouldn't ever happen. It looks like it happens when the loose
>> refs end up with duplicate directory entries. While a bug in git is an
>> obvious culprit, I wonder if it's possible that your filesystem might
>> expose the same name twice in one set of readdir() results.
>>
>> +cc Michael, who added this assertion long ago (and since this is the
>> first report in all these years, it does make me suspect that the
>> filesystem is a critical part of reproducing).
>
> Thanks for the CC.
>
> I've never heard of this problem before.
>
> What Git version are you using?
Git client 2.7.4 against GitHub (Git 2.6.5)

>
> I tried to provoke the problem by hand-corrupting the packed-refs file,
> but wasn't successful.
>
> So Peff's suggestion that the problem originates in your filesystem
> seems to be to be the most likely cause. A quick Google search found,
> for example,
>
>     https://bugzilla.redhat.com/show_bug.cgi?id=739222
>
> http://superuser.com/questions/640419/how-can-i-have-two-files-with-the-same-name-in-a-directory-when-mounted-with-nfs
>
> though these reports seem connected with having lots of files in the
> directory, which seems unlikely for `$GIT_DIR/refs/`. But I didn't do a
> more careful search, and it is easily possible that there are other bugs
> in NFS (or EFS) that could be affecting you.
>
> If this were repeatable, you could run Git under strace to test Peff's
> hypothesis. But I suppose it only happens rarely, right?
Actually it seems to be reproducible. Here's the last portion of an strace:

[...]
stat(".git/refs/remotes/origin/pr/7/head", {st_mode=S_IFREG|0644,
st_size=41, ...}) = 0
lstat(".git/refs/remotes/origin/pr/7/head", {st_mode=S_IFREG|0644,
st_size=41, ...}) = 0
open(".git/refs/remotes/origin/pr/7/head", O_RDONLY) = 4
read(4, "5d82811a248900efd8e201c6d9232de5"..., 256) = 41
read(4, "", 215)                        = 0
close(4)                                = 0
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open(".git/refs/remotes/origin/pr/16/",
O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
getdents(3, /* 3 entries */, 32768)     = 72
stat(".git/refs/remotes/origin/pr/16/head", {st_mode=S_IFREG|0644,
st_size=41, ...}) = 0
lstat(".git/refs/remotes/origin/pr/16/head", {st_mode=S_IFREG|0644,
st_size=41, ...}) = 0
open(".git/refs/remotes/origin/pr/16/head", O_RDONLY) = 4
read(4, "2886c4f3ba8c3b5c2306029f6e39498d"..., 256) = 41
read(4, "", 215)                        = 0
close(4)                                = 0
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open(".git/refs/tags/", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
getdents(3, /* 2 entries */, 32768)     = 48
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open(".git/refs/bisect/", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) =
-1 ENOENT (No such file or directory)
open(".git/packed-refs", O_RDONLY)      = -1 ENOENT (No such file or directory)
fstat(2, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 3), ...}) = 0
write(2, "fatal: Reference directory confl"..., 58fatal: Reference
directory conflict: refs/remotes/origin/
) = 58
exit_group(128)                         = ?
+++ exited with 128 +++

>
> Is it possible that multiple clients have the same NFS filesystem
> mounted while Git is running? That would seem like an especially bad
> idea and I could imagine it leading to problems like this.
>
> It's surprising that you are seeing this problem in directory `refs`,
> because (1) that directory is unlikely to have very many entries, and
> (2) as far as I remember, Git will never delete the directories
> `refs/heads` and `refs/tags`.
Seems like sometimes it happens on other directories:
refs/remotes/origin/ or refs/remotes/origin/pr/1
Then as I was stracing it again, suddenly it succeeded. Some kind of
race condition?

>
> Michael
>
