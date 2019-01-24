Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6621F453
	for <e@80x24.org>; Thu, 24 Jan 2019 18:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfAXS0V (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 13:26:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38765 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAXS0V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 13:26:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so4148896wml.3
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 10:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0aJuIiX/nOWlLbXdr3+lwqFLunTl1I7Gm5M6gafXqY0=;
        b=YKGzTVhXyM0CYnupuT4EOrwyBCMGhUmuFAueUabdvhtEBE89E6NMrYibM3hXJ1uV9W
         SbXs7gjOvxXqhFUx3ancZcuS3CiDhqGCCKPi9dM561foHgwmenfrAhFW/eZIZsWNUY0y
         SpZh5XM8X2eKZdwUKkC6qRAbAaeQqXR1leHx8ldfDty+jc+xIB7nIMVwXi5otI5Kv2Xc
         6qhPlLglduhpHn4Q+rEkJT960DIOCgBda7B4jT4NyQ7xvBwy71i+UqOg6dU/6oOxw9ZY
         Ry4Oxhb2KNqXK+4sRzAX9QZJIyZHypZIfdrxm8WwvILFnAT7KCUPNN7nQPqRmhyDYQC/
         BQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0aJuIiX/nOWlLbXdr3+lwqFLunTl1I7Gm5M6gafXqY0=;
        b=n0Cdk6ojq5ufe7lFFJbC/mc6Cm0s7YXYjxArKzbhZkvx2jL2yLnxtQpkfu2mSl7qBK
         7nBOMSuAHribSKLOQjKJcpGRedHMz/Cwp8vnohQ8M0Rzb62jeyQn90pKigIDndtuXKnG
         eCPHgd4ERUiJ0keAJn7lztcLP88pyaDI/5MQUteJqFC2ST8+d3LyPv9g14OF5ML5oy49
         2gk8Saxh7Zq+AN6i97X9LIFbOQ7/iuNKzS1UV+gUjQMASpYE5HgQ1Ia2wXIXWcn6rQDJ
         0bvC8fvp+xe2jQlul4or2RDnleJVBCqEuxa/85V6Jzv91GN9KbCCV+m2n/EOuXbqFnbz
         AYxQ==
X-Gm-Message-State: AJcUukc5kdMlkhtbqolK/Y6+gO0ugV8xPxoy1jmcMU3ce9OzLk/v+Nsc
        0WzQOyySn5FIsYhSZkwmIYJbfBMb
X-Google-Smtp-Source: ALg8bN7ELZdU4HjRqX1blMAXJUgN7Ia+wlS7+qDivGNuZnJGpyAwUhy7FiIs2tdDqoXy+ksw0lNyAA==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr3811227wma.109.1548354379084;
        Thu, 24 Jan 2019 10:26:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t4sm98606989wrm.6.2019.01.24.10.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 10:26:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Rafael =?utf-8?Q?Asc?= =?utf-8?Q?ens=C3=A3o?= 
        <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
References: <20190122232301.95971-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190122232301.95971-2-nbelakovski@gmail.com>
        <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
        <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
Date:   Thu, 24 Jan 2019 10:26:18 -0800
In-Reply-To: <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
        (Nickolai Belakovski's message of "Wed, 23 Jan 2019 15:34:22 -0800")
Message-ID: <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nickolai Belakovski <nbelakovski@gmail.com> writes:

> Yes, the parser used the atom argument in an earlier version of this
> patch, but we since moved the map out of the atom since it only needs
> to exist once globally. Even though we have a caching mechanism for
> atoms it still seemed like a logical move to explicitly keep one
> instance of the map globally.

I think that is a mistaken move from an earlier version to this
one.  The worktree-related stuff only becomes necessary and belongs
to the %(worktreepath) atom, so unless there is a compelling reason
not to, we should hang it there, instead of introducing a global.
When you have --format='%(worktreepath) %(worktreepath)', you'd have
only one shared instance of it in used_atom[] to ensure that we have
a singleton instance.

The object_info support in the file, which is relatively new, may be
what you borrowed the wrong idea of preferring globals from; I think
it should be taken as an anti-pattern.

