Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644C41F404
	for <e@80x24.org>; Mon, 27 Aug 2018 22:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeH1CSM (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 22:18:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34765 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeH1CSM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 22:18:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id m199-v6so373166wma.1
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mcvYMqdXvcUk/TgMkAsQBzRWDHF50xb/b8MgYKdv1Q4=;
        b=fBYTXieo90zE2VBcGzlDnieJKpuYE7scoeqXur1VTGxOJ+KKGWVhTj6SrDqqScdnbu
         9/Fuc8Rp4OgSJJyJhXFxNMswIz7PI4wO/aCNN5/Vk6yssa9WyJQB4sKJPtbLOWPeF1HF
         3xdBJS0f6f/hx6XHlHAHDuEf2XN/jqe4MasSzVIBihw/Sz9vYBzaCV+MLCVpk4NtWiWs
         Yl1CIVX04UvHLLZ2fnuofNgve1yT1X1cFk56koQ65f1Fx5RQd8FqyNAuBxScAwSZ4+wD
         Z0qml0l1RUcUu3tx3PELtEg5zCmkBkyT2/DdjrthLh66uoPASQ3tYwl35iepwY39gy+n
         PRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mcvYMqdXvcUk/TgMkAsQBzRWDHF50xb/b8MgYKdv1Q4=;
        b=lZ8kG5UJnzptWNloK2B5nJYy2uqLq/ov7gPgtwrtrWmCtt6zwbSiQE552LxQvbdjzx
         b8Ve5LE7s8uHkE89nLT491B+xSAB6cNVeaLgK1wNVyHlY1/spxdxLdGkcOf5OdZVfcsJ
         JSKwVOTFXZxtm8SZpIQLq3QX3VSkHWGV5NSk1333PdQM+zi91saj+UVx+A49Jj0jj7xp
         70P0aw2BzT+GF/jza+368lqoXd227CVWvGaGIY/22usGdDlIW3bheNcE3Cax48NVXR2C
         O52XmnnEVjZmTus3plOCeY7ovF5Gu3OQ/EqkuSTU7DoFKzoQN/8SHmbv7oOpoR2k7Gff
         BINA==
X-Gm-Message-State: APzg51BsmfsXx+jNif64tjQLwSc0mhY46KbKwO4+M3Me0Yedmn9pUSCK
        UxMrRNWkcxXCdHNCgrKiadg=
X-Google-Smtp-Source: ANB0VdbUup4cblgasXRI1wGmNgcvSGVBadJpI9LIjqAGncooLmEk45H4mKeTcSEj9D6Yk5hNxr/kcA==
X-Received: by 2002:a1c:f317:: with SMTP id q23-v6mr3411111wmq.132.1535408974532;
        Mon, 27 Aug 2018 15:29:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n17-v6sm251341wmc.13.2018.08.27.15.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 15:29:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Scott Johnson <jaywir3@gmail.com>, git@vger.kernel.org,
        Constantin =?utf-8?Q?Wei=C3=9Fer?= <i7c@posteo.de>
Subject: Re: Would a config var for --force-with-lease be useful?
References: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com>
        <xmqqin3vk3yv.fsf@gitster-ct.c.googlers.com>
        <87o9dnegxi.fsf@evledraar.gmail.com>
        <xmqqlg8rinbz.fsf@gitster-ct.c.googlers.com>
        <87k1obee0f.fsf@evledraar.gmail.com>
Date:   Mon, 27 Aug 2018 15:29:33 -0700
In-Reply-To: <87k1obee0f.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 27 Aug 2018 22:44:00 +0200")
Message-ID: <xmqqd0u3igtu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I.e. making plain --force-with-lease harder to use by hiding it behind a
> config option gives the user fewer options than with --force to recover.

I agree with that.  But I would consider it a good thing, if done
properly (i.e. suggest --force-with-lease that is not a lzzy form).

> So I think we should still recommend the longer and even safer variants
> of --force-with-lease, but being guaranteed to have the SHA-1 you just
> clobbered locally is *better*, and allows us to e.g. do this:
>
>     $ git push --force-with-lease
>     hint: You just clobbered <X> on <remote with <Y>. If you regret
>     hint: this you can (until the object gets pruned) do:
>     hint:     git push <remote> --force-with-lease=<refname>:<Y>

Until the object gets pruned, and until somebody else pushes there
to make the damage bigger, you can recover from a mistake with that
information.  It probably is a bug that the lazy force-with-lease
does not report what the remote tip you just overwrote was, and this
would help great deal.  It would be a good place to start.

One thing that I am still not clear how this line of thought truly
would help users is how to help them decide their answer to "If you
regret this".  An unthinking naïve user would say "of course I meant
it when I gave the option---why do you think I regret it?" without a
bit more hint, namely, "<Y> was taken from the remote tracking
branch, are you sure that is still what the newly prepared contents
you built to replace?  Did somebody clobber it while you are not
watching?"

These three lines however will be felt too loud by those who would
most benefit from them (i.e. those who do not know why they need
protection); I do not think advise.* to allow them to be squelched
would be appropriate.
