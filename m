Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B9C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 08:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiCVIrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiCVIre (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 04:47:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E35591
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 01:46:07 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso7671195otd.6
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k825DxMzhvg7SpTxBiz6+jN6ievv7NP8LxLe/MDHD0M=;
        b=JQYGXTUH6lRzUc1joga5AgoGqy9KJ7+vE6FcgggyVpCobZOh4XSJ5/dNUvzqDVpqFK
         nY0mXlsNgtLWRZ8ua0r2MWNKakIXvaXRn5M4uwt4y7mSPeB7l3WaagTVxcZoIDbwa5wp
         BGThLL24TDRiFje/k66uSWzhSQlvIaDmKzvUpF9V4f1vegg3/eKIdWwLRch2ul0hqeXv
         GHRkhUqGpujUMb0sygJvy4nX5ETC+3LvwvYY/tCehUWcBVMwpDX6wy7DH4UhRRAIQhZ7
         RCZBrwZTJBXpUnqhz9JfGfUaEsSH2CwgXqwJ+R9w1ir4k4WCdqo59gpm66EO7P9/Axne
         S+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k825DxMzhvg7SpTxBiz6+jN6ievv7NP8LxLe/MDHD0M=;
        b=wLA94XlC/p0HbxhuXtsppSBAq4o5pjTLNE4i+9D0/cuxcYyQ9cY7S8i/A92aITP+Kb
         D4ta/XfZhnK4zZvVkeyfwxlNAM0Mj6u7HHDDsI400nUqvDUH3EcdM4cLqT+n0e+kQHZ1
         2nwUfl7Y6A/OrE4pJDqDVcJjDqYmurJDBR2hSSS3Kc6udMqL19k7AKPAAjvp+PG7+fvF
         1N/AUwlBwK+F9n7iwrhV58iWIqR1Fkw/3QLwlak6IkfH9uwXcah9aBNLU2KhRljad8Im
         AXmRFxeOdOw6PKNIdqk/PxVF4j4HxdyMzSc/H4njNzS+SusOhpxHBYI624L36lvR+L5g
         qLjw==
X-Gm-Message-State: AOAM530i7VFMDIN8frX3DH0b1XJtgBpxnKXR5C8UcRvkkJIAZHka6TLv
        wq2Z1aKQRfCUUhpVtFGKmtJVXQKqpGqgz5RzRFA/MM/yXRo=
X-Google-Smtp-Source: ABdhPJwmOoSyP6ZOzTVcaU0BEFHR3xNKRkaimRRRpdARrjI0VArKLP7jqoy5CcEFdYVBHiqG1DzBqbAZ8Xet9GyOyKg=
X-Received: by 2002:a05:6830:1d8f:b0:5af:14a6:4b03 with SMTP id
 y15-20020a0568301d8f00b005af14a64b03mr9634339oti.145.1647938766837; Tue, 22
 Mar 2022 01:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220321225523.724509-1-gitter.spiros@gmail.com> <5dea325c-c80c-c203-c42e-b55e58b717de@gmail.com>
In-Reply-To: <5dea325c-c80c-c203-c42e-b55e58b717de@gmail.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Tue, 22 Mar 2022 09:45:58 +0100
Message-ID: <CA+EOSBmzndi=f108Ho8e801K_cDPFdWuddkiLwFfNNK_2Rg4_Q@mail.gmail.com>
Subject: Re: [PATCH 00/41] use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno mar 22 mar 2022 alle ore 07:49 Bagas Sanjaya
<bagasdotme@gmail.com> ha scritto:
>
> On 22/03/22 05.54, Elia Pinto wrote:
> > Elia Pinto (41):
> >    archive.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    branch.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    am.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    blame.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    commit.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    credential-cache--daemon.c: use the stdlib EXIT_SUCCESS or
> >      EXIT_FAILURE exit status
> >    help.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    init-db.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    mailsplit.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    merge-index.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    merge.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    pull.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    rebase.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    remote-ext.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    rev-parse.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    rm.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    shortlog.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    show-branch.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    stash.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    tag.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    unpack-objects.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
> >      status
> >    update-index.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
> >      status
> >    obstack.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    git-credential-osxkeychain.c: use the stdlib EXIT_SUCCESS or
> >      EXIT_FAILURE exit status
> >    git-credential-wincred.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE
> >      exit status
> >    daemon.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    git.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    help.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    http-backend.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
> >      status
> >    parse-options.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
> >      status
> >    path.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    remote-curl.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    run-command.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    setup.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    shell.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    test-json-writer.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
> >      status
> >    test-reach.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    test-submodule-config.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE
> >      exit status
> >    test-submodule-nested-repo-config.c: use the stdlib EXIT_SUCCESS or
> >      EXIT_FAILURE exit status
> >    upload-pack.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >    exit.cocci: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
> >
>
> I think we should only have 2 patches in this series: the first is to replace
> with EXIT_SUCCESS, and second is to replace with EXIT_FAILURE.
Salutations. You can help me ? I'm having trouble continuing the
course and haven't had any answers yet. Or if you can help me figure
out who to contact. Thank you for your cooperation.

Thank you. But there are many sources that include both of them, the
choice would then be arbitrary. However, I follow the various reviews.
> --
> An old man doll... just what I always wanted! - Clara
