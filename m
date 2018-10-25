Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6D31F453
	for <e@80x24.org>; Thu, 25 Oct 2018 08:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeJYQtG (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 12:49:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38271 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeJYQtG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 12:49:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id b14-v6so542468wmj.3
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1VCq16usPQ7H3LEaJq1FVXAWCWNofkWuQajkdbitr+0=;
        b=cyGrQirTNJp+o+AI9y87BF7HOvpzgL0MqW3Mvp36RZ/WXp105WhK9Js1neeoaqjePi
         PW4sFjfVZcjkRC+FwlrWq/IYdCrCJ6gFMf7n2/olHc9l8aff1AWfF5zRIQg1aYCWe2YF
         wyyMrbF1XHx7kJjraQEq7EIuwcnX8orHkAMzug4rPOEPEZqEUj9Mz9zaykyrMZItcfRO
         fWcMNYHb6m+s9Rm4t2yMRiWULO94vI+l9Jka3FuA2h2Qqw2WBde4g4S+E3IDKr01OMl3
         6mtPyodgnjYokBmDJ+zPh/u3cof0cbaBJPnfwe/aMV0jGfi7SzvDJzXjPi2Ss83Yu4JZ
         AQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1VCq16usPQ7H3LEaJq1FVXAWCWNofkWuQajkdbitr+0=;
        b=Rw6Bz/guEucyDWexXpfk9qAXOmQOvifdJBBpCDunshEPIyjW6WGqNhdtEmtG/T8jb8
         ZrHFmPJdGRuOzrioj64l1s93LZhiUkUK8IPRYD5J+sAjRqK1cge/pfDrUnlRZQMBL/mh
         nG0BorQl8zeURy/9oBqAI5GFSAX41i23cmqE032EfM2u16tcxfTrxSkOOhxaS1Vla5g9
         9MASpciZQPRCqsYRMfiQhzRd5ZHBBsLfroC6DGfvOvQfpIYRUjN4Ue/5wNrJ2EsYKSmx
         ovFIk4mevux01pQoEMKUUPTtLZbXQM0QFTPajXwhN/AATyP8FptubJzYfn6gG5QCsePN
         7qzg==
X-Gm-Message-State: AGRZ1gLsSOhKktPTSq6btSg1lp4Q0qjJ1dDsQ71d4Q0MF0bMrc9QF8R8
        YcAelVwswuR1IndkFZ4VEUc=
X-Google-Smtp-Source: AJdET5dT9rmlz5wjbiF7ewNi5JFttbo6MrpOtOdzvxqM6I4Fv7n+0ET6ROxLn3DijduEoYMmxiNrvw==
X-Received: by 2002:a1c:1804:: with SMTP id 4-v6mr737868wmy.29.1540455443782;
        Thu, 25 Oct 2018 01:17:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i11-v6sm4465034wrs.87.2018.10.25.01.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:17:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Oct 2018 17:17:22 +0900
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Mon, 15 Oct 2018 03:11:57 -0700 (PDT)")
Message-ID: <xmqqo9biigod.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> For a long time already, we have Git's source code continuously tested via
> Travis CI, see e.g. https://travis-ci.org/git/git/builds/421738884. It has
> served us well, and more and more developers actually pay attention and
> benefit from the testing this gives us.

What's the current status of this topic?  Has the "p4 daemon gets
left behind" one resolved to everybody's satisfaction?  I think that
one was the only large discussion on the series (aside from "do we
want to keep Travis?" subthread, which does not make this series
undesirable), modulo your "oy oy oy that is leftover debugging I
need to remove in a reroll".

The topic was marked as "On hold, monitoring discussion" and it
seems that discussion has quieted down, so the next step is to see
an updated series?

Thanks.


