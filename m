Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB04320248
	for <e@80x24.org>; Mon, 18 Mar 2019 06:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfCRGxz (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:53:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35915 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRGxz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:53:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so3028000wml.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xHrgPEAuyOg4yo84EQ6lQ+VZZ8txbtICSxldeurYPvo=;
        b=o9J2N/5nV8YDpwu4e7MLhM4yCbVwFLm0UTVxyxZgPLnyRcg9ZcsxwnVcryMNluUj0x
         wP+IoRAPragIB1nYJbwvd1Y8e+TryXaB53ixDHzc/xP6eaiPWLflmxjC/tsaCdnKwGk2
         mlrhQpyhgMcxyXXqlRdaqYX+3o27lQpRn+yxB7YxSpV7fdmvU6BUu41tdgNdlGKKszTC
         YqPVeDR0QtAQttpY53rwCTjSKuoV9zHNku4CSM+ZXg6j8sFnPmRPgwRHoPq78QPWKE8k
         JPW/a1NNX3OtaYRDHHWidBWcko8iPsasvYDXVauDVuZH6D8qR4e92ljwR8j6SeIfcqAj
         G1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xHrgPEAuyOg4yo84EQ6lQ+VZZ8txbtICSxldeurYPvo=;
        b=bZjEGEmS5ytlPrTlQPTOZklNnTTASzG1Ri6NMH7w7oI26VB7FHD1nsAStEMXW5cAxs
         zyys0VkFkyc8Dhd/IleZ9AmrTfdoYjF/DNGrEtZPqrvHx1PSkz/EWS4CuECXVXg9hIPk
         SSQnAAt0slbfB8rn28wYz/vOhwAHZUTebz0Q+MhpZpE8NvU84/P3GoYkKwYLLFNpI1ac
         6xXmjEPRqOJoV/bu47MkBF9AX+9Q3RS1NZcH5FLcLA/kD/ZI0YiVO+oAznAHKveO98xb
         pI8tjit+F1xFdhXpx816h9/kkQFnAAw79Coq+UnXay612teODISGl8DCYjb6DbfJriON
         rq4Q==
X-Gm-Message-State: APjAAAWAQ2WqqPb6b4CNctH44sMLof7ttr81CCAeUCkPRgeaHmdaX+AM
        kmoIBVOOTPtuqOkUakRjT5HOC7acTAk=
X-Google-Smtp-Source: APXvYqxelM5xEIAc0hLIPzp4QW1oHzMt/j5iTjDLKpEJnQV30twFXrMrIKLkp0SIohufvsllPkk6Tg==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr9638636wml.4.1552892033808;
        Sun, 17 Mar 2019 23:53:53 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a204sm7852221wmf.12.2019.03.17.23.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:53:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] doc-diff: support diffing from/to AsciiDoc(tor)
References: <cover.1552838239.git.martin.agren@gmail.com>
Date:   Mon, 18 Mar 2019 15:53:52 +0900
In-Reply-To: <cover.1552838239.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 17 Mar 2019 19:35:59 +0100")
Message-ID: <xmqqsgvk1xmn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> I've taught `doc-diff` a few new knobs to support usage like
>
>   $ ./doc-diff --from-asciidoc --to-asciidoctor HEAD HEAD

Nice.

> But I have made some progress on fixing up Asciidoctor *and* AsciiDoc
> issues using this, and once the output of the above command is empty --
> which might not be too far off -- it could be interesting to try and
> keep it that way using a bit of automation around these switches.

That would be exciting.

