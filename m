Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58DAC1FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 12:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbdBKM26 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 07:28:58 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36399 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbdBKM25 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 07:28:57 -0500
Received: by mail-lf0-f41.google.com with SMTP id z134so33935957lff.3
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 04:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gjfEGRId1Hx2TatErw3qmBWgZ65AIcv6dh1U8ZAWRd0=;
        b=TExKErJ+Ad0sJHSWZUeV17nS562dW2qwa1SKrx9lx5/UT/PF8fXZ1ZOB552BKEuKZc
         eqLQiyu4YjwsyURiPncbJ01LOtsOv37mnep5VdyI1q3k9sQxzmjtw4prN+tz5eI2YmU1
         Wrv6p7H1aD2b8Q/LsF5VFVN62RjsUvntv7Sg4gA8DdM7LXlsoqyLdhpUs9firu24KgAg
         EjE63HJZx7bSWcbyS9AEdqw43d7OrlHMCs2rbOSckmHTMZGJ6E09flg+ukqX6B2ITkzH
         tNLUjZTgBAycKxxSIW6x3ycQrvyBNINL2cs7lztINS+Uw2qKGQIFYXwi7V2yIlBMY/04
         Ppcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gjfEGRId1Hx2TatErw3qmBWgZ65AIcv6dh1U8ZAWRd0=;
        b=PK/pBguyYmo/dVcStdiR6MU924NKI1dGh27lQORiWCaBMpw5Q4OqyyBZ6i+3B51snU
         PycUQ1mo+GllBdsSXoa6MqGkhix7yDXQtvKVngzhGSRBwyoCzs8HZXMLuj/k9uU7dR5R
         HhxzQB1wYTK5c/1Ki+fRKmj3YBBP0JmbSJve8B1HL+J9794c3COlic7AidusQFyQ9zyQ
         y3uJ7jdmf+7Ph/2iW17iLQukWfNLhm+8IykOTg207IxJXvuQZv25u9wbJBF5tv5Sh5KC
         ILL9WPcxLAA/2KJETp1e0MaaZv4KEHwVmLtlqUQkYWmTVqRtgVj6V9EzHARuuNSHf61x
         +GMg==
X-Gm-Message-State: AMke39n0CxUx6uu2G7kDNjakiYq6vw4woCv6ft7Ze8Z4Q9azH7qepqWwT1KWfh6HfzGn7OqHZdf1WvbH824GOg==
X-Received: by 10.46.9.76 with SMTP id 73mr556341ljj.128.1486816135809; Sat,
 11 Feb 2017 04:28:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Sat, 11 Feb 2017 04:28:55 -0800 (PST)
In-Reply-To: <CAL7ZE5yXaJQFci+9aF4+cxeycnf71FMyLTV14t_TGDR3cnnfVA@mail.gmail.com>
References: <CAL7ZE5xYVM6=C+SJLJ2HMFZ2gvuduw8p0UnS0RnBaXibj0mgDw@mail.gmail.com>
 <CAP8UFD18Sbqo-_ZVyYTJtwNaRc8bFSd0KEYQ1oRH7-G+xnJTJg@mail.gmail.com> <CAL7ZE5yXaJQFci+9aF4+cxeycnf71FMyLTV14t_TGDR3cnnfVA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 11 Feb 2017 13:28:55 +0100
Message-ID: <CAP8UFD3uEAuK5SQD8V8f4GC3-jC+ix2sPwiFBw_kW3JhBG6L=g@mail.gmail.com>
Subject: Re: Non-zero exit code without error
To:     Serdar Sahin <serdar@peakgames.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 11:26 AM, Serdar Sahin <serdar@peakgames.net> wrote:
> Hi Christian,
>
>
> We are using a private repo (Github Enterprise).

Maybe you could try 'git fast-export --anonymize ...' on it.

> Let me give you the
> details you requested.
>
>
> On Git Server: git version 2.6.5.1574.g5e6a493
>
> On my client: git version 2.10.1 (Apple Git-78)
>
>
> I=E2=80=99ve tried to reproduce it with public repos, but couldn=E2=80=99=
t do so.

You might try using the latest released version (2.11.1).

For example you could install the last version on the client and then
clone from the server with --bare and use this bare repo as if it was
the server.

You could also try `git fsck` to see if there are problems on your repo.

Are there submodules or something a bit special?

In the end it's difficult for us to help if we cannot reproduce, so
your best bet might be to debug yourself using gdb for example.

> If I
> could get an error/log output, that would be sufficient.
>
>
> I am also including the full output below. (also git gc)
>
>
> MacOSX:test serdar$ git clone --mirror --depth 50 --no-single-branch
> git@git.privateserver.com:Casual/code_repository.git

You could also try with different options above...

> Cloning into bare repository 'code_repository.git'...
>
> remote: Counting objects: 3362, done.
>
> remote: Compressing objects: 100% (1214/1214), done.
>
> remote: Total 3362 (delta 2335), reused 2968 (delta 2094), pack-reused 0
>
> Receiving objects: 100% (3362/3362), 56.77 MiB | 1.83 MiB/s, done.
>
> Resolving deltas: 100% (2335/2335), done.
>
> MacOSX:test serdar$ cd code_repository.git/
>
> MacOSX:code_repository.git serdar$ GIT_CURL_VERBOSE=3D1 GIT_TRACE=3D1  gi=
t
> fetch --depth 50 origin cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee

... and above.

Also it looks like you use ssh so something like GIT_SSH_COMMAND=3D"ssh
-vv" might help more than GIT_CURL_VERBOSE=3D1

> 13:23:15.648337 git.c:350               trace: built-in: git 'fetch'
> '--depth' '50' 'origin' 'cc086c96cdffe5c1ac78e6139a7a4b79e7c821ee'
>
> 13:23:15.651127 run-command.c:336       trace: run_command: 'ssh'
> 'git@git.privateserver.com' 'git-upload-pack
> '\''Casual/code_repository.git'\'''
>
> 13:23:17.750015 run-command.c:336       trace: run_command: 'gc' '--auto'
>
> 13:23:17.750829 exec_cmd.c:189          trace: exec: 'git' 'gc' '--auto'
>
> 13:23:17.753983 git.c:350               trace: built-in: git 'gc' '--auto=
'
>
> MacOSX:code_repository.git serdar$ echo $?
>
> 1
>
> MacOSX:code_repository.git serdar$ GIT_CURL_VERBOSE=3D1 GIT_TRACE=3D1 git=
 gc --auto
>
> 13:23:45.899038 git.c:350               trace: built-in: git 'gc' '--auto=
'
>
> MacOSX:code_repository.git serdar$ echo $?
>
> 0
