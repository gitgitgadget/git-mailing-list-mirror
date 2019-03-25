Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E57320248
	for <e@80x24.org>; Mon, 25 Mar 2019 05:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfCYFRA (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 01:17:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32928 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCYFRA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 01:17:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id v14so5131829lfi.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 22:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/k9n7dy9DR+tnYPLOkEnaXTwamj4zZmOOo/WiByo78=;
        b=n9E+qHnFp/DFKYdz7PNZvkgQeW6qwEjsS6iFU7OkYkcvcb030pgxW1XAxPDmdDIt5H
         R9y0/Ndl8Vy4hGmk1O4HFVMX/aIAmmSn5Q0UswfwychMN76UX+Eor0C2BGgbG2S7qSe7
         6M7hIi6QmRRkhNJupSG+BNGZuso3xe1V7w7tMG5gNnUGSt4AVQvp5qBH9LUDwyi9/z4u
         8JXo9zKf6F6hpb/Cmmca4YpBsruL4T/ijyQQEP+1t/xG63MWF2CQ9n+M9dE089evuQJi
         YkQT5q9uC8lvc01XImyLEzed9LPHjMzcQKLLOl2qeBDSBJyJGpg8vXXkpht19t3jWYbp
         FmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/k9n7dy9DR+tnYPLOkEnaXTwamj4zZmOOo/WiByo78=;
        b=YIf6R+AcClwXyBjSvc7QOkturiV5/z22GVsmrvnxD+6BJ5RaVeqKUWF61NnPq6rNAr
         dmY6pkxqns+8jmKOp4tlgTFgKgGDocY+P/wlv/xXc9Kezj4cxGnnGKHdUMLT/eLvgLfX
         IZ2OSG9dgvxGIrNvkeAQJ/YtBNE/nNnasKSEmhnWo1WwFww8AsPa3l2Gm6Au+idxknaD
         etzh6aiSgAS7O27n1PflX6i+iIe/qMcTdHS8t+qtcr/sYwspfA8J9SNcnJNHAwgPID1s
         f5kiJi9+FQRLw7xSmCMYXEi9EMmiv6MsJCwL3ddxltTVQWjvlz7wW0/5bdM2/NI69znR
         DITg==
X-Gm-Message-State: APjAAAXNeg0Iouwde0T4kPNPnjN0rgpXCKEjkV1t6TNoJxmRFvrayhRs
        qU66gVGCgeS7QzHexwn4b8+GLVb2a8qE9AQkta2WuDm9
X-Google-Smtp-Source: APXvYqxiuNIcEB+qN9gUSAtUq2zRGdetyHyNcgZdkc6kqE5drqj3+VUbWGaNoo9N0Ldoe9bGRL7tI7sW58n8Lfg8kV4=
X-Received: by 2002:ac2:5629:: with SMTP id b9mr10832672lff.100.1553491017064;
 Sun, 24 Mar 2019 22:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190323041332.9743-1-alexhenrie24@gmail.com> <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
 <CAMMLpeQbz5qHyK8e4gZ0zKQ5na+zQCd49GZifKZ_iO-gXrs1Gg@mail.gmail.com>
 <20190325011717.GA5357@rigel> <CAMMLpeQGz85ogLgKX6DBMyz0wpRvW9fXCpK87m+JoT9i7hw1Kw@mail.gmail.com>
In-Reply-To: <CAMMLpeQGz85ogLgKX6DBMyz0wpRvW9fXCpK87m+JoT9i7hw1Kw@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 24 Mar 2019 23:16:45 -0600
Message-ID: <CAMMLpeStw=qg50nbAkuKRTUTvkAhjw8kvZxxrAmTcfuK4L8cmA@mail.gmail.com>
Subject: Re: [PATCH] In `git log --graph`, default to --pretty=oneline --abbrev-commit
To:     =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 11:10 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> I like the idea of a completely separate `git graph` command. This
> command would simply be a builtin alias for `git log --abbrev-commit
> --pretty=oneline`, like how `git reflog` is a builtin alias for `git
> log -g --abbrev-commit --pretty=oneline`. Junio, would you be on board
> with that?

Sorry, I left off the --graph parameter. You can set up what I'm
proposing as a personal alias with the following command:

git config --global alias.graph 'log --graph --abbrev-commit --pretty=oneline'

-Alex
