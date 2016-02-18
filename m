From: Stefan Beller <sbeller@google.com>
Subject: Re: failed submodule update re-run results in no checked out files?
Date: Wed, 17 Feb 2016 16:15:12 -0800
Message-ID: <CAGZ79kaM5JREvfCmNMn8FQm1mutmDB3e8DYmtxMEzmUO5mqccw@mail.gmail.com>
References: <CA+P7+xoF1Rz_43-v3NzGk1Hxp=yhF3toh1nFNQFMRVWr5q8STg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 01:15:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWCFb-0000Gf-JA
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 01:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965474AbcBRAPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 19:15:14 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:36650 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965331AbcBRAPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 19:15:12 -0500
Received: by mail-io0-f169.google.com with SMTP id l127so55685569iof.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 16:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/LiSAJwE75xHGzd8qd1gImaCMVsl98paaCL7h0CdIvg=;
        b=IS1DhPZjAerh8J1evzLhFU4JI+Iz53EWblpr0Sj4Dp9mSYSiONORWk8LDKs8t3K+Ej
         svJ9ptYAW5eAJdY8WPk+DyqRZ7LDZ2d62qj7R4M4b8DOHgsPVsTA3rWkgDmq/tCFfsvi
         lpqALyIAyFkpfxg6Rja0PWb1wE9n7X8jzgLDcoOLowpxCcchG0Sovu9edN+MCxGu4qqm
         mw0RNuTqzUBZZ3HI+cE0wnzjE9qmzlAgV8ysooHHk4WfzMQhY5J9HZHD2F/4HBPBzJEt
         n5H8v3H+5noaetYpa9QwISzTWvlzh43aCoyCqCq4BvUfxZqHY4H17PBPG9qtQpTzChpI
         U06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/LiSAJwE75xHGzd8qd1gImaCMVsl98paaCL7h0CdIvg=;
        b=WO+jnzt83fji1uuIRmfjveSZoHq9E1hhpFcPml7bJRux/9/qdhUIQut3lHouUrBpyI
         trOu19KcQkroYDFa7Nc0A+zhlje3UW2yx7IhvmoDzzRajfhMHfhNUIKOmpIEOvPQbixK
         BfiN2BD5OydMnz9gral/wavebUmycICxnMFark42vAlkDwSR3QqCRCps0pLUu4FJBwex
         HpBWIrIMX3Obg+eG+JJyNeZIaN/5huhm9w/IugDJI4L+P6vnwyffQ1Ky6CbqIXTZLZBY
         UfcjzqI0AbHh4QkLsYmjJ/n3d1DJmzPR47uLsarr3kURNyhI3lkPzu+bNajLp28DIVSk
         SanA==
X-Gm-Message-State: AG10YOSZGAjtH+A5NEKX92Alke+JASRWITMTkvfNt7T/4BYZcswCY8zu9E1NFCpad6adRhe70iYstPtkDO87yvr/
X-Received: by 10.107.137.100 with SMTP id l97mr7230876iod.110.1455754512138;
 Wed, 17 Feb 2016 16:15:12 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Wed, 17 Feb 2016 16:15:12 -0800 (PST)
In-Reply-To: <CA+P7+xoF1Rz_43-v3NzGk1Hxp=yhF3toh1nFNQFMRVWr5q8STg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286567>

On Wed, Feb 17, 2016 at 3:54 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Hi,
>
> I am having an issue currently when using Git with a remote server
> which has a limited number of ssh connections.
>
> The ssh server sometimes closes connections due to too many concurrent
> connections. I will get the following output from git in this case
> when performing a submodule update of a submodule which is not yet
> currently cloned/checked out.
>
> stdout: Cloning into 'src/SHARED'...

Which version of Git are you using?
(does it include origin/sb/submodule-parallel-update, which rewrites
lots of the relevant code? Also it introduces parallelism, which may not be
anticipated by the server admin)

>
> stderr: Total 10288 (delta 7577), reused 10190 (delta 7577)

Seeing both stdout and stderr, I assume you're on master or even behind that,
which doesn't include the rewrite.

> Received disconnect from 10.96.8.71: 7: Too many concurrent connections
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> Unable to fetch in submodule path 'src/SHARED'
>
> The submodule is not cloned successfully, and this occurs somewhere in
> the middle of the process.

I wonder if the client should retry each submodule at least once, in case of
transient errors such as this ssh config having too many connections.

>
> If I run the command a 2nd time,
>
> git submodule update --remote src/SHARED,
>
> I get a successful run, but the files are not actually checked out.

The submodules are cloned via clone --no-checkout.
This is because you may have a custom update strategy configured,
(or a preset such as "none" which would clone but do nothing further)

> I
> believe this is because the clone that failed did succeed in getting
> the repository into a state where all the files are "removed" so a
> further submodule update will do nothing since it's "already" checked
> out at the correct commit.

you can pass --force into "git submodule update" which passes that
flag along to the checkout.

>
> Am I right in my understanding? Is this a bug? I believe I can fix
> this using --force.
>
> Note that i don't yet currently have a reliable reproduction of this
> for various reasons, not least of which is that simulating network
> error is difficult.

I have a similar problem which I am debugging currently with the
new code. (~1000 submodules which may fail randomly; This is
why I wonder about either automated retries or ignoring the errors)

>
> Any thoughts on this? Should I just have my script that runs my
> continuous integration builds add a check to ensure files are checked
> out? Is "--force" enough to get the submodule to be re-checked out
> even if it's already checked out at the location?

I believe so.

Stefan

>
> Thanks,
> Jake
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
