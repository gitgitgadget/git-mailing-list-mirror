Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68C3200B9
	for <e@80x24.org>; Fri,  4 May 2018 19:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeEDTzy (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 15:55:54 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35787 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeEDTzw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 15:55:52 -0400
Received: by mail-yb0-f175.google.com with SMTP id b19-v6so3263243ybg.2
        for <git@vger.kernel.org>; Fri, 04 May 2018 12:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SSeDgNLnDoVcbouDdwuH2GXK1HFxPo5PkGrigCLfrks=;
        b=A8YTcyRnJkKedk9aDG28ABjHuWLsns2uRQh+oPFqI2VaHj7d1HjQzBSGTBvT9YI4wE
         dGrRoqyG+Fd81/GlUlL9ve3yB1tNuJa93dw71cN1rtvygQEtUfbkaZ3zkHNkF9+bIl+s
         YEcscfMLw5IhxRXRU1CwYwoqN0L7gBkFqO/Mjxnwdo6uE4/X4587tn3zVMKTuXdOssXF
         wOcztdYJkG52d5Uk9YpCLj05ob4YYlCFz1l0abQdhxf1uqUWBdl9Nf/byn/ipSJrR9D0
         TWCTCYtRgzX/LKTkXnHVXQuTvIdnX+5rydgKo5bKQzcvjNZwAIz+Oe4P0LgkAtfjfw+q
         GObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SSeDgNLnDoVcbouDdwuH2GXK1HFxPo5PkGrigCLfrks=;
        b=ntmP0P9NcOChetkgKYrfPel4ieHKM/cz7emDgd6ySaytWec+vAXwCx/GiY3OqguHSW
         j9q9+QECHWp77pWOJk58IlOzdG2Zp1TJhGP/DeVe8Ae/2H5OHp4QjuGJDk3oM4q+aHeh
         ijKIM0BP0p7aFIzqs+uFlN0xluT6lOG6KnT822e21OlGs3bXmBEeBGnoGC1Q439fZ3cd
         yiRYgtRRjtNONepn9SsXkNJckojeXei5XvYl5/H4tHhjvuLFqVeZFbvCo2nKnW6tZyKa
         mtqDBkBc9oYpzf+CSHinLrHc9IFOcIvzlYcZ+BQwdTcjWJBeKmoIXBs8rrOpCy5UmVmj
         sYmA==
X-Gm-Message-State: ALQs6tAeHfqMUVfHSHhpDbYjTgFaPTXb662YaC7RCM7eI4UUZdY3fqcq
        zUT46iTxIxv9ZYDL9sodUx4P8UHmzJadQ7fh32Uog2bKB8E=
X-Google-Smtp-Source: AB8JxZpNlvHnKieQP+XcA9nMnCwO7XLSRQkYo0yfjSETOrsHNiY/QFalZfSB6PrbDD0XqrJYasSWOddQqX43aITDpMU=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr15775891yba.352.1525463751567;
 Fri, 04 May 2018 12:55:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Fri, 4 May 2018 12:55:51 -0700 (PDT)
In-Reply-To: <cover.1525388472.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <cover.1525388472.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 4 May 2018 12:55:51 -0700
Message-ID: <CAGZ79ka2SmfA_ZUA2MjuqSwb=gUphbRxp=NQgj5AcqvMiePZFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Let the sequencer handle `git rebase -i --root`
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Wink Saville <wink@saville.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Branch-diff vs v1:
>  1: 42db734a980 ! 1: 73398da7119 sequencer: learn about the special "fake root commit" handling
>      @@ -54,40 +54,50 @@
>         return NULL;
>        }
>
>      ++/* Read author-script and return an ident line (author <email> timestamp) */
>       +static const char *read_author_ident(struct strbuf *buf)


I like the new way of read_author_ident. Thanks for writing it!


>       +
>        static const char staged_changes_advice[] =
>      @@ -159,7 +169,17 @@
>       +/* Does this command create a (non-merge) commit? */
>       +static int is_pick_or_similar(enum todo_command command)
>       +{
>      -+ return command <= TODO_SQUASH;
>      ++ switch (command) {
>      ++ case TODO_PICK:
>      ++ case TODO_REVERT:
>      ++ case TODO_EDIT:
>      ++ case TODO_REWORD:
>      ++ case TODO_FIXUP:
>      ++ case TODO_SQUASH:
>      ++         return 1;
>      ++ default:
>      ++         return 0;
>      ++ }

The switch case is not as bad as I thought following the discussion on of v1.

This series is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!

<off topic>
During a lunch discussion I wondered if the branch diff format could lead to
another form of machine readable communication, i.e. if we want to add the
ability to read the branch diff format and apply the changes. Note how applying
this diff-diff would not create new commits, but rather amend existing commits.
