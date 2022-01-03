Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF84CC433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 14:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiACOvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 09:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiACOvW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 09:51:22 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3D6C061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 06:51:21 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e128so40650713iof.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 06:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sumologic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tKQDUQ1eied1/o47p3K3GLOgtGPPrzGYEos61qt7VY=;
        b=dTHLDVpAoU6rZ/Z+bOCMvN2Ippqcyj/EJ5ZkQhc8TQz8T2ubg04T+Nv9kkaowXWojU
         99vDiEkZwxXW5EAF4FuzlI6TRfgALJ7vki/2+bdNylIp3A4w7AWx+rPUFGb0zLT9vXqY
         ZBbJQ+ze18A6stg8y/uIQ5Ei3x3J6xNFugczU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tKQDUQ1eied1/o47p3K3GLOgtGPPrzGYEos61qt7VY=;
        b=a+U1SBtRpLIHAq8OA/X4YDzo4d6eS4fEVm4TwFxlH4O2kj6zoKbee53UxRQH764bw/
         QKFx2jZi2AR8j74GGhK7+jj5KvLkMCGarvdtVj0xUIcgClmmiwzldDWD7UYQaFTj07q3
         m1CQWalMWLTKf60lVpPJdvb7fl+LhYVat1cF9gEOX8DXKSh1krXsNWUpPyCTsy83Uq9s
         GGFILYrznDRpkCtT0Ljyh4UJzua8z09ZmqZB12p6OaplVOGQJWxgqg2QNVYwF94jgHSu
         9ojs0Z4j709wkZcDkzt0zwv1l3ze96EwJC6DIaqp2fnJNHq8sj8WYfvc6ql7ers85O/x
         JMTg==
X-Gm-Message-State: AOAM531+nmpmTjQLlM4G0lvNQ4AkvJon2CEo8CUU3a/P4sZcxMJg/Hkk
        jKdOHarYpSyupSrHm4AeleZ6vvN154/o9BRTep5F/onDy7D2Ig==
X-Google-Smtp-Source: ABdhPJxZ0LChWWgWKrwi8ip/jaQJ2w4oE9MM5yHHXkxlg3GnuZxu7Bp0dOhqxpyw9ERcny3JIBHb0BvyqCwsZjcL+6U=
X-Received: by 2002:a05:6602:2e03:: with SMTP id o3mr20883942iow.14.1641221481244;
 Mon, 03 Jan 2022 06:51:21 -0800 (PST)
MIME-Version: 1.0
References: <CA++hZeHEVN6JZMdtXMjG2bDqerJjrFjhjYOry_rnWDgjTbQ8aA@mail.gmail.com>
 <20211215155221.tzg55fxerpowj623@carbon> <CA++hZeFiFAuCD=C-2xJJt3yd5guyJrssjtpAmAqYXkMQuRtfpw@mail.gmail.com>
In-Reply-To: <CA++hZeFiFAuCD=C-2xJJt3yd5guyJrssjtpAmAqYXkMQuRtfpw@mail.gmail.com>
From:   Ana Jovanovska <ajovanovska@sumologic.com>
Date:   Mon, 3 Jan 2022 15:51:10 +0100
Message-ID: <CA++hZeELoG1yMdu4pGpRx+2bBF63yNgOwV-UoB5=CH3pAg9jNA@mail.gmail.com>
Subject: Re: Git SCM API remote
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     git@vger.kernel.org, Enrico Benzoni <ebenzoni@sumologic.com>,
        Michele Zambelli <mzambelli@sumologic.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

The libgit2, more specifically pygit2 helped me in creating
repositories, branches and getting a list of branches locally.
But with the integration (in Python), would like to connect to git
remote server and to be able to do some of the git commands
(https://www.pygit2.org/index.html) as mentioned.
I looked into Remotes - RemoteCallbacks - credentials(url,
username_from_url, allowed_types)
(https://www.pygit2.org/remotes.html#pygit2.RemoteCallbacks.credentials).

Can we have support on this matter - how can we do it? Also if you are
available for a call, so to better understand, it will be great. Thank
you in advance.

Kind regards,
Ana


On Mon, Jan 3, 2022 at 3:45 PM Ana Jovanovska <ajovanovska@sumologic.com> wrote:
>
> Hello,
>
> The libgit2, more specifically pygit2 helped me in creating repositories, branches and getting a list of branches locally.
> But with the integration (in Python), would like to connect to git remote server and to be able to do some of the git commands (https://www.pygit2.org/index.html) as mentioned.
> I looked into Remotes - RemoteCallbacks - credentials(url, username_from_url, allowed_types) (https://www.pygit2.org/remotes.html#pygit2.RemoteCallbacks.credentials).
>
> Can we have support on this matter - how can we do it? Also if you are available for a call, so to better understand, it will be great. Thank you in advance.
>
> Kind regards,
> Ana
>
>
> On Wed, Dec 15, 2021 at 4:52 PM Konstantin Khomoutov <kostix@bswap.ru> wrote:
>>
>> On Wed, Dec 15, 2021 at 01:57:42PM +0100, Ana Jovanovska wrote:
>>
>> > I am developing the integration with Git SCM and I will need your help
>> > on this matter.
>> > This is API remote doc https://www.git-scm.com/docs/api-remote .
>> No, it is not.
>>
>> Unfortunately, looks like your knowledge about Git itself is a bit lacking
>> currently as you appear to not be aware of Git's terminology.
>> I would say, reading a book on Git ([1] is good), and a couple of manuals on
>> it, possibly starting with [2].
>>
>> > Can I have more information on how to use it, do I need some additional
>> > library?
>>
>> Git itself does not ship anything you could call a library, but it is
>> comprised from a large number of individual commands (which are what you would
>> call "command-line commands") which are broadly divided into two categories -
>> for end users and for use by other commands; these groups are called
>> "porcelain" and "plumbing". Call out to plumbing-layer commands is the typical
>> way to automate Git.
>>
>> If you need to somehow manipulate Git repositores - you did not say anything
>> about what that "integration" has to be about, - without having Git installed,
>> you may resort to 3rd-party libraries such as [3]. ISTR it also has wrapping
>> libraries in several programming languages.
>>
>> Also note that there exist libraries for various programming languages which
>> wrap calls to plumbing-layer Git commands, so they sort of implement something
>> in between a "pure library" which does not call out to Git and calling Git
>> directly.
>>
>> 1. https://www.git-scm.com/book/en/v2
>> 2. https://www.git-scm.com/docs/git
>> 3. https://libgit2.org/
>>
>
>
> --
>
> Ana Jovanovska
>
> Software Engineer, Engineering
>
> M (389) 75 300-828
>
>
>
>
>
>
>


-- 

Ana Jovanovska

Software Engineer, Engineering

M (389) 75 300-828
