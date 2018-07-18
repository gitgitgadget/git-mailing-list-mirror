Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4BB1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeGRSDw (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:03:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35158 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbeGRSDw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:03:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id y22-v6so3700715wma.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5kslTo/JheaiTI2VY0i0KWHYOrYJmGyBGr01E1I6Nh8=;
        b=tsnRc90qhgGC2OkQ/QIwhte+r+O2jF42kF6hmFLUSP2N4gP1VLi3gEQy/aINjTGc3M
         kv24t+ez0n4tP6v8mVD8Jqk2jXHepjmPK6jVoIsZUJ4FUMEY/VaCOsT4tuQTTGtnzvS9
         jJmSw4ViK/8APp4Wv+BU2ur5B0TQqOgjDgrNupyqH+vVeJsb3aqW1oMuBcK0lgbcRlrg
         XQt4cTLmJQ1kD8OX8C6EMGMbmVH+bASljv1AHWc6xni0kD4wrObonL4wv1DOsprSxwzy
         Y7YaytYF5uGYUJHZ+oJ/SFEC8IUVbbJlsq5Yi1woRwyr6NoVUkZLPfAA5zrW70X77o95
         5zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5kslTo/JheaiTI2VY0i0KWHYOrYJmGyBGr01E1I6Nh8=;
        b=I4UppndO5GBLNNgkoi4ziOf+eba/Sllh+bFQjP9HS02WCvnjLF9nBNgRk53vZ0go7X
         4cA0JscKFx5bCYISdFmdOnDPv8BCMbPkzRrlbY+ine5c73zFz9U4OZfgZ6Bk24n35E6S
         PMr9aeMRt0OCAsYgdYKZeSznZuRpE6R/yq8X4vddfoxQQlFOR8Kjq+n+y59Kg3PpNmDz
         J++SRGFo4uzn0ft3JU6Ay06+UnTZBTSCepO7S8JyBj3z1hKTbrdEslG9b1aRzwWlUaV3
         vF3A9iuTx4J4JFmmce8qnQWrcJCvtCGDFbb0HJPQzDOdE/b7kSLtyxp+WpEIzKlvFwyk
         NW4Q==
X-Gm-Message-State: AOUpUlGbQQDQ2T8H59yY7s6hCtFp4BvG62wF1C+NnzVyxt/oZhUmCyAw
        0ZRTBZEiiudGfDAJeVZtsVA=
X-Google-Smtp-Source: AAOMgpdWdSEAn82hyQWxybvpYOee9wI+FW5oERu6WJv+WRVpCoXKft4dbpWo/cw/UmgkqjZIvSdXwA==
X-Received: by 2002:a1c:8e8c:: with SMTP id q134-v6mr2371773wmd.3.1531934697744;
        Wed, 18 Jul 2018 10:24:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z7-v6sm2598938wrh.85.2018.07.18.10.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:24:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Akinori MUSHA <knu@iDaemons.org>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-scriptproperly
References: <86a7qwpt9g.knu@iDaemons.org>
        <xmqqwou0xtar.fsf@gitster-ct.c.googlers.com>
        <eb66f8fb-1535-37a8-526d-ed31f06c045c@talktalk.net>
        <eb295aea-dae5-5e1c-bacf-2c77d3ce0195@talktalk.net>
Date:   Wed, 18 Jul 2018 10:24:56 -0700
In-Reply-To: <eb295aea-dae5-5e1c-bacf-2c77d3ce0195@talktalk.net> (Phillip
        Wood's message of "Wed, 18 Jul 2018 14:46:17 +0100")
Message-ID: <xmqq36wglamv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> The only consumer of a faulty author script written by the sequencer
>> is read_env_script() in sequencer.c which doesn't worry about
>> checking that quotes are paired. 
>
> That's not quite true anymore, recently another consumer
> read_author_ident() was added which uses sq_dequote() instead of
> custom code. Looking more closely at write_author_script() the quoting
> of single quotes is buggy they are escaped as \\' instead of \'.

That's embarrassing re-invention (instead of reuse) with additional
bug X-<.  It seems that all of that blame to d87d48b2 ("sequencer:
learn about the special "fake root commit" handling", 2018-05-04).

We should fix both broken writer and readers that compensate for
breakage in the writer, I guess.  Sigh...

