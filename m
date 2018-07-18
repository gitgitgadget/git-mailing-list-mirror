Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3091F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbeGRR4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:56:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33413 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbeGRR4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:56:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so15595564wma.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yNI28uKH5Q3veKSrqRPOpzbCeiFUzswZnv+BmTo0fpU=;
        b=Z0nJDBqw4KFyj5SrN05UJY0/onITnNqxSzaaijqDEf2wtlbu9vUNuszYxOdG4qSWpW
         xXB5WwyE9xmS1uD3FZb1yMGXoGzO6oPjO7nNXjaWXAqX10po21xUGZzEoDr7k/HRB1j5
         w+9+9O0flJIo9N5+aIRwhvnNnOYVtCiqtqA+2zw1NSiisuHh7+QWeCU9U1gl++Uvx75W
         XMKjfxk46/3KZzUY0J5sbuK7OMIhjNvuR46/ILlAL2H8z15V2KkTpcKAniPGrJgdAmHG
         7LzMc2LcDMxzMPfwf8tD65AEz1ur2IIFUl+kvl9+qlqSnbweHjk/uqBSrAUqJL+Bgch/
         A9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yNI28uKH5Q3veKSrqRPOpzbCeiFUzswZnv+BmTo0fpU=;
        b=oWPsIP1S2tTwL6BlYBL9HawdH7fXBqXp3+9CsBYnbTi0oyB5qqX7wDwzdSKpm6NOSN
         ZitXpcQiYvTx2rFGrZTp9AEGLyBevPrsTTKtcFJ9WHMYUTmjypKkpJV8tbDY5i7tXvBt
         f3rSN1eoxJzWbln5anhGdKcOotxjG70R8PvXnNaZHOGLiUWyTybo6lJLWuMGo2FU9xrk
         d0j6fHO3t5pZcVTEbvLqlrNNgG78t7npZF642LZkHVANOA6++guPBsrtShRCBQ0/Y2Rn
         OW3kHxSIFOh00KuNFo6NzC8+LUrnEJ1BkcLiep/xQoq/z9hQHMJXwXphJCN9iB+zzInv
         xi4w==
X-Gm-Message-State: AOUpUlEczD1KZapcfxEktXUUax9ocXAImHLiaEg2UpGb69Wby8xg7vyU
        scXYb9X5qSaJJfbYato/4iLtq3Jn
X-Google-Smtp-Source: AAOMgpfaYWNeuEBRuKXrP+MHoQqgqlreqZX48d/HSJh75UHjrzEIK1r6tgI66yjgxdTc01HJf0ZGhQ==
X-Received: by 2002:a1c:5c7:: with SMTP id 190-v6mr2211467wmf.24.1531934275824;
        Wed, 18 Jul 2018 10:17:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z5-v6sm6919397wrv.2.2018.07.18.10.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:17:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Akinori MUSHA <knu@iDaemons.org>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script properly
References: <86a7qwpt9g.knu@iDaemons.org>
        <xmqqwou0xtar.fsf@gitster-ct.c.googlers.com>
        <eb66f8fb-1535-37a8-526d-ed31f06c045c@talktalk.net>
Date:   Wed, 18 Jul 2018 10:17:54 -0700
In-Reply-To: <eb66f8fb-1535-37a8-526d-ed31f06c045c@talktalk.net> (Phillip
        Wood's message of "Wed, 18 Jul 2018 10:45:26 +0100")
Message-ID: <xmqq7elslayl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> (I think we had code to do so in "git am"
>> that was rewritten in C first).
>
> The code in builtin/am.c doesn't try to write valid posix shell (if
> one assumes it is the only consumer of the author script then it
> doesn't need to) which results in simpler code, but external scripts
> cannot safely eval it anymore.

Are you sure about that?  If so we probably should see if we can fix
the writer, and better yet, if we can share code with the writer
discussed here, as presumably we are fixing it in this thread.

But I do not see how builtin/am.c::write_author_script() would
produce something that would not eval correctly.  sq_quote_buf() was
introduced specifically to write correct string for shell's
consumption.
