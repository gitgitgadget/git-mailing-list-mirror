Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7221F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 18:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJJBSI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 21:18:08 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33154 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJJBSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 21:18:08 -0400
Received: by mail-ed1-f45.google.com with SMTP id h13-v6so2557025edq.0
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8qYAZUqQ0c9KiKRUWA+oeH8wWVi++VOs9FRoIgKe7ok=;
        b=NdV5DQ6RRXFiSQF3JqrZ5n8cYftXATofl1k+NMYx1arC/9mu4GfdaHMgpypU+fJ8xd
         SGNP5aFiXM5W1fVFt+EswQ7bZz25uVce6wWPbxNW1ZYrBy47Rfk0fIJngQP738OQVsb3
         TjSgQP8hmMyiR0eHdVQiZt/kMZePE3QLjt9Dv3+Jn/ot5V+Ps6V5InSVO+UsL6Dr6+Ux
         TxI/+AN8KSR/pninwqyiDPlmB/x/naOW/GmoMmhci2wf7JgvG96yDIuoSiK4+/CA+CRK
         gSSCUH29+yyk28oxKgfr05ecpf9Z2gBMcfxZDWRGXIk5OX64J4FcKtOVfXrbgXEFbvc5
         Kxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8qYAZUqQ0c9KiKRUWA+oeH8wWVi++VOs9FRoIgKe7ok=;
        b=TlYABSXPoO37e6WnDfQ59Lqk/zFtEVlvtpoRrXfxzN+ljaobf/aGIlSSFseIdOBW3b
         eOIcHBqUZo7rGibNP9mvKQIp1xfKfRAZeJAk8l+uQ86TkUahPcc1bI37CPmZrR+r+zkK
         +LHBArJxlF9Q1g+uNlTtfj/GcJT6eiiw1/CErVpWNR4h/ZP8BT6Qoc66IvLDJ7rHLYVm
         FsRFKLCNUxOI6ACEA8LGMWcXc0j+H/pwmFeV1lMakP3uuB2uRlMmihQ/Ca1rEB/xKazV
         1nM6QKGteBHJ4FSDXS4/Xj6CggiDj/B9R7Pq4syjRCt1Nc3f4P8fzjslq+seASzZheoG
         wydg==
X-Gm-Message-State: ABuFfoi7EW2vtNdam93XIVWlhRpphduOhAf4lviz6h5PlZ3IJwg+1Wil
        yebWPygZg30f8C2thS2xG0wiYihbL2hsjPZ15Bakyg==
X-Google-Smtp-Source: ACcGV60JljhJWm5DnSlK8ezDOrkPAy96Nj0eA2Nzx00uPQmLtBnDXDl5FYmjJTZFAUqFhqxKBmyZBPtGcb9DnBbSScw=
X-Received: by 2002:aa7:d709:: with SMTP id t9-v6mr2174232edq.231.1539107997337;
 Tue, 09 Oct 2018 10:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHMHMxUDN4xKD9GfmOEx1bW1jDeWUgYgg_xdAtvLrFgMV2oCLQ@mail.gmail.com>
 <CAHMHMxWutm=jWC2nLJCEEE4CZ-ERc79vvwrbo8VnfC0VGwei0Q@mail.gmail.com>
In-Reply-To: <CAHMHMxWutm=jWC2nLJCEEE4CZ-ERc79vvwrbo8VnfC0VGwei0Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Oct 2018 10:59:46 -0700
Message-ID: <CAGZ79kZCSen-jNE=XCzVds-gxFsnkK_nPoJw8sE00bXtTPf5+w@mail.gmail.com>
Subject: Re: git difftool does not give the --cached option
To:     stdedos@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 9, 2018 at 7:33 AM =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =
=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 <stdedos@gmail.com> wrote:
>
> I have install the latest git version from the PPA:
> $ git --version
> git version 2.19.1
> $ lsb_release -rd
> Description: Ubuntu 16.04.5 LTS
> Release: 16.04
>
> However, trying to autocomplete git difftool --cached gives:
> $ env -i bash --rcfile /etc/profile
> $ . /usr/share/bash-completion/completions/git
> $ git difftool --
> --dir-diff          --extcmd=3D           --gui               --no-...
>          --no-prompt         --symlinks          --tool-help
> --tool=3D             --trust-exit-code
>
> Please direct me on what would require more attention.
> /usr/share/bash-completion/completions/git is the same as the
> git@master/contrib/completion/git-completion.bash and e.g. here:
> https://github.com/git/git/commit/6cc4bc15f92e85b41d9da9075905f20c6a9008f=
e#diff-f37c4f4a898819f0ca4b5ff69e81d4d9
>
> It seems that --cached exists.

and it seems that there are more options that are not completed,
not just --cached. I don't know offhand where to look further, though.

>
> (Side question: What is the "--no-..." option shown? I cannot seem to
> find it anywhere in the documentation :/)

Answering the side question, see
b221b5ab9b (completion: collapse extra --no-.. options, 2018-06-06)
https://github.com/git/git/commit/b221b5ab9b92f3def37184db6e052ec87d7635b4
