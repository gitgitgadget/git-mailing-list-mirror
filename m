Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257211F404
	for <e@80x24.org>; Wed, 14 Feb 2018 17:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033288AbeBNRM7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 12:12:59 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35017 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032907AbeBNRM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 12:12:58 -0500
Received: by mail-wm0-f44.google.com with SMTP id r78so23316646wme.0
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1Tr5gDtDoRgwY4n6zJuYpbzrCyJsO9bt4bunrM8TNP0=;
        b=OOFRqPpqjdxkXC2UuSX/DWEIQM75fRGpCXqLDw9jrEjXjk2hmlwl2mDYGkj2PHVMTZ
         2sJ5TR1V2ElWY/7VeLNvLxFCmV8iMDSAdZ6AX7AaX1zuCsdL131gOGVjwl2VTY5ikRty
         +0dCff7NvEOy7E+N2My/MzmiajS1GEQKvjoAYPsp3Hsahgwtvr2eQ2dkjLIVuSVAdlGv
         R2Bao2zAtSxU0NLRx4aFMD3Vllw0+xvYUCmmDbcDuws2AWot/WZ9/+5jDySMtBsU6Ydd
         ZGsg8PP6H5NRc375iXk0dv8Fg/njXjzZiAXrhmww2V2qRSXx1kVKvcGZsOuSG7ZHvG3y
         x25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1Tr5gDtDoRgwY4n6zJuYpbzrCyJsO9bt4bunrM8TNP0=;
        b=PPl+YhrktMqZ6DxAbTxxMxO+Wj/Jki3UGk9ncID5G/8LENZbkEaRHRB0MafjcygrdF
         QRuDdbm+4GLjH6tkDmBik/mlKU1nPoeulTgTcRYnSwQPSUGqP+DQxc/P9Mi661zD7Zbg
         OEJNQU75Lf6NpzC0JNsnKGIZ//6TLBEPZjwOqPSJ4vrmBe1uXCb9pi3cbk5iAHkIBgdX
         JIGGD7K8oFF6oyBME+4k8y1IECEwNxPWJwOWZZ43oHLHQIRmLkq28ZxPF6N+3QxoDjLe
         VvOxxmQL+n2IiGOFq7sPw5KHhJV/vhAjqfvnJvLTXQqTgBgBDouym05YZada7zFSa0zP
         tUnA==
X-Gm-Message-State: APf1xPD/WeOg38o4VS+0VobTSjS3cIzPW7N2CAaJ/+vr0qXov0Dfib5E
        /4Ee1e8vw8hBEwJTq10L9NU=
X-Google-Smtp-Source: AH8x22764vNcRBlEEtpIKLPbxI18wnyW3nYcG4mUlKUBzowwygZDHetoUNRuSyc5on/08+on9LbxtA==
X-Received: by 10.28.206.6 with SMTP id e6mr2537957wmg.160.1518628376492;
        Wed, 14 Feb 2018 09:12:56 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2sm13748733wmf.0.2018.02.14.09.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 09:12:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2018, #02; Tue, 13)
References: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
        <CACsJy8ASyntVwHfES_Rk4Fj6ftQC+moFd1gwgB3rzYhpdYOX9A@mail.gmail.com>
Date:   Wed, 14 Feb 2018 09:12:53 -0800
In-Reply-To: <CACsJy8ASyntVwHfES_Rk4Fj6ftQC+moFd1gwgB3rzYhpdYOX9A@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 14 Feb 2018 16:36:50 +0700")
Message-ID: <xmqq4lmjpka2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>  Will see another reroll.
>>  cf. <CACsJy8BoPxbt=hqAd9fS7MLiF33FVtAk0=Fr_q7UgYy1YvEg0w@mail.gmail.com>
>
> Well, the next reroll would just drop 42/42, which may be easier for
> you to do it yourself. I don't think I can work out what all
> git-completion.bash needs to rewrite 42/42 in a couple days.

OK, I agree that I should have read the message I pointed at that
way.  Thanks.


