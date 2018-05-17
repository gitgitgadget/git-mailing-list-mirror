Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617B61F406
	for <e@80x24.org>; Thu, 17 May 2018 03:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeEQDSc (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 23:18:32 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:53598 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeEQDSb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 23:18:31 -0400
Received: by mail-wm0-f49.google.com with SMTP id a67-v6so5743812wmf.3
        for <git@vger.kernel.org>; Wed, 16 May 2018 20:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OqkjlVv5lwPSTZMQDvVWl9+ulzeE8y1O5MGKC5p/+gI=;
        b=G/RH+D/MVlilf9oKX5oRuzwk6xPYzfy8Erl1qe3KG7yK/CJ1hKsg9ZLoAkDd2lDs7E
         7L1n81/B1UVv4mgt9nlAiv8wjcUZ3d1TJhemxB2Chc9a5crS+m6SwXMttjEAB7swg5nP
         orcF18+WTdeOz9czPHp3W+NBekEKE6hRZea30NIFZofHz1Hp7lLNaBn1Grh0px02ob3e
         SYTQUGf3Kv7SppOTAvn1Ac8gFjSKKzb8OVhGPlufXE3rUHs9OO3mXpr5R3PXz5JiMr5T
         JeEJbJwJOfnLZ1RQni6jtscoPm5Te2LbOsgKGnBT2VJAQkwpWSXEcXlitEzuFgPHLTZm
         WLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OqkjlVv5lwPSTZMQDvVWl9+ulzeE8y1O5MGKC5p/+gI=;
        b=f0XaSR5oOeH7oxwMKri/zD2ua2t+RCmlHM5DLh3ypEKKi7LsBZw+JhTMuqPWzhbHv3
         UzIsCf/3RYFdRYa4GArHQrzLQ/CRZzbxas9dkGZ4TH9TrwNwfVyfj02Ig6wpeLa8yfa3
         h2SWChAQTYQsZIHLGld3yBBv3Uhbvil7KSa0qPY84PiyR9uVFdwuJMxaO1LFxFkb+lHT
         igSXIezlcTSSRS3SNmFp/dc/0QwSSYHWEYkHzXQ20zFvAAZGyztcND4zj/AARfPqF7qh
         5JwgNpKU5TukGZL7qz1a5Eoz7rZ1q5fu5vTyGG96nozLkGAKTlrMsPA7lvlk5NuZbwmt
         3iZQ==
X-Gm-Message-State: ALKqPwfxXtvGmI/Yk3q4bmJdpn59BqjgYpPY8IR2Wx5tpkOTkbToTLMY
        eAX/Of+9EMHq18NtNsib7N/mcNZfuwUU7qS7FDK1EELn
X-Google-Smtp-Source: AB8JxZrbXhM6MmaFWOOqIa4oEQvOPzoTyAluJjIytvWL9JF/uuToe7eL1U0sxqy5cSw65dHevOpHSAOFDOCcFZOIIu0=
X-Received: by 2002:a50:8f21:: with SMTP id 30-v6mr4556242edy.265.1526527110358;
 Wed, 16 May 2018 20:18:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Wed, 16 May 2018 20:18:09 -0700 (PDT)
In-Reply-To: <285692D0-1DE8-4CAF-9BCE-F1A04D5C66B5@anmol.io>
References: <285692D0-1DE8-4CAF-9BCE-F1A04D5C66B5@anmol.io>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 16 May 2018 20:18:09 -0700
Message-ID: <CA+P7+xqQZzTrm274rbbP_O85Y+YGZ4PQ8PMFJnJtKR4wR0AObQ@mail.gmail.com>
Subject: Re: Add option to git to ignore binary files unless force added
To:     Anmol Sethi <me@anmol.io>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 5:45 PM, Anmol Sethi <me@anmol.io> wrote:
> I think it=E2=80=99d be great to have an option to have git ignore binary=
 files. My repositories are always source only, committing a binary is alwa=
ys a mistake. At the moment, I have to configure the .gitignore to ignore e=
very binary file and that gets tedious. Having git ignore all binary files =
would be great.
>
> This could be achieved via an option in .gitconfig or maybe a special lin=
e in .gitignore.
>
> I just want to never accidentally commit a binary again.
>
> --
> Best,
> Anmol
>

I believe you can do a couple things. There should be a hook which you
can modify to validate that there are no binary files on
pre-commit[1], or pre-push[2] to verify that you never push commits
with binaries in them.

You could also implement the update hook on the server if you control
it, to allow it to block pushes which contain binary files.

Thanks,
Jake

[1]https://git-scm.com/docs/githooks#_pre_commit
[2]https://git-scm.com/docs/githooks#_pre_push
[3]https://git-scm.com/docs/githooks#update
