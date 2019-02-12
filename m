Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CBF1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfBLAc4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:32:56 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51339 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfBLAc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:32:56 -0500
Received: by mail-wm1-f50.google.com with SMTP id b11so1115350wmj.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 16:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hie+J3ndXuC1JOJYE5etFZBJdpnxrtdZWU/EdSQe0/8=;
        b=MqVRY/AbNKdFTiCcwDi6svn7PszDNm9Erqa3AxH1Or6T9tr8n8dvqnbn5mOyfn2yhM
         vzy++udG/ozg7CZIeFVU/8ltBFFYW9zPbM5Zoo6EjLDmBYXKW9KoQM7XfPKDiA0mpWmc
         /XvT95tQPCBSq9mG2wk13ez4EXymAj6DDnvMgSzXcO4XcDSl+dzJyW5P6U9e80RImU8g
         8j7zJJOBhJ4v1RHG99WM/3UkXzg6TkKHkZHTHOd5HO4vPUJHy00ppS4jdK3rrbi9BCj3
         gJOFjiHNFQjm/Pk1WDtjs04prbLog4atQmM8kGRKDLqBy0xDHLrKOgxVnix2hlUZuj9e
         glCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hie+J3ndXuC1JOJYE5etFZBJdpnxrtdZWU/EdSQe0/8=;
        b=JsBmemc4FHEk2YmJEm//uAGUiWn9jaOJFZDbpT+L0D8Dabt9X9UHcD/l5a345skh7W
         o83Q2pyMtfo26sgJ39m7vj1aNk4tZ6N0Q8uNbkSD7DhXZW2C0HszSIZED8AAmNyGu2wq
         20Kz9oVLI+u4BZYuWzyJkG0matdPvFuMMwOVbfTfzkxWzNp/weQ3f+5x+T0/+b+VYjaG
         PTfWjmA8Wvrr/mEg4wttPhrmEnVu/lx4vzov+dEvaGCvgK++VqL4rqJdRIQevcfkPRoZ
         6E7rL5J9ZHvxmTVicY0gZmYIGiUmwsKC6tmbXRhVAoUvlaTbLzu2YGawIAlhfDkXrJzN
         YrOw==
X-Gm-Message-State: AHQUAuZWVItRu+MOdRKZPYl0uto3yz2WSU2LGMO7ak3i9XEx1oSE+g0p
        5PiXSfPjNBAeKB8TlhZXFM4=
X-Google-Smtp-Source: AHgI3IZ80yGWwJnR1aKvhV+WcmP3p2xpHgT99UZWmDS4/o59yQ+4P3etXF5i9bUUm7pflqt0S9ZJlg==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr673807wmh.18.1549931573875;
        Mon, 11 Feb 2019 16:32:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u184sm1586511wmg.45.2019.02.11.16.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 16:32:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0 on NonStop in one case
References: <000801d4c174$05b76860$11263920$@nexbridge.com>
        <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
        <xmqqftsughks.fsf@gitster-ct.c.googlers.com>
        <20190212002705.GD13301@sigill.intra.peff.net>
Date:   Mon, 11 Feb 2019 16:32:52 -0800
In-Reply-To: <20190212002705.GD13301@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 11 Feb 2019 19:27:05 -0500")
Message-ID: <xmqqpnrxg823.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm. We care to _some_ degree, since that's the condition we set up for
> making sure that update-ref cannot take the lock. But it would probably
> be fine to just confirm that we failed to take the lock. And there,
> checking for just "Unable to create $Q.*packed-refs.lock" would be
> sufficient.

Yeah, that was what I was getting at.  On top, we could also see
"test -e" after noticing the failure but that probably does not help
us prove anything.
