Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BDE1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 01:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeJ2JrR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 05:47:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52402 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeJ2JrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 05:47:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so6534472wmw.2
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 18:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QRFakYEzkDUuaJUct/eDYPaAGSmis2acajS9xib/tAc=;
        b=W2sYf4/MNilMwwZ0OeVi8hI9BjEcYd+VncxAp+tYZiEnhjt0iu1UMtIhkhXjaK2lH3
         gf/04I+3KCGkpx1+/+2e88eVCAlxUX9nVJ+JKBtpdsyasvPzq7KO4pK84dddNCRnfxwn
         x2wlyfMqpDQXRzA7b1Qknyjhiwrsmg8u36YMu2Q/GQlNBp7gzSSEswIaR8860QGh+Ji3
         reOrcmcX9NOslUwpWA7wNGHZo84w6TAbaMyszs0KxYhHYFXo3hy3BXdXr8Jgqdlc01uN
         lF045vc//hvhawl2Xk2WFiDrRWmMHpuCmEATmpNCGXvxkcUuJHNh/aUO1lyLi0BZK0Zs
         mW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QRFakYEzkDUuaJUct/eDYPaAGSmis2acajS9xib/tAc=;
        b=TP/uEM9QwfISVxtCmQ5TDkouN63Ki5VoES55W1PXlkDoNmbxM4HpP8/Lwcv9M19SjZ
         Zl8zijrxbEQu5U8BUgZ5yrZiGPvZrWd/fpwR4zvqbzsjpzksnWORvIsiTFNt1/3rRj3+
         augVFrkpU8rAmvL1xFmy8q83Z9zb/D2wA7nz6TJ9nKlLtD41bFtdugrWeE/cYD4PqjL2
         r4tSLwybI483gphUexRqWh00hLmkBb/8l36xDGIMx1EVHjnogzYtn6Fq3wjF6IUT6h9C
         7IvU/RI+3GQWbVzVDeOtEs4tke4p6gy+jBAuAnD52uWPSoJxLBIA8zo+45NKCVXZ+92X
         +7vw==
X-Gm-Message-State: AGRZ1gIBfdz8GECSP8quKXRz6xfGRzH/33vmPSm0ePI0YcdHGl3O/FpR
        ti1tH0IbLeCy9tB9AJcz3n8=
X-Google-Smtp-Source: AJdET5cIf9jrLoYw8we1A4dBbjhSZ3p0Y2Jk5I0TdB+yoxbnAJFi8prT5iHHtfJq7T7b5EOK5KV4Jg==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr12682910wmf.47.1540774855886;
        Sun, 28 Oct 2018 18:00:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a1-v6sm15181800wrt.79.2018.10.28.18.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 18:00:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] push: add an advice on unqualified <dst> push
References: <20181010104145.25610-1-avarab@gmail.com>
        <20181010104145.25610-3-avarab@gmail.com>
        <20181010205505.GB12949@sigill.intra.peff.net>
        <87r2gxebsi.fsf@evledraar.gmail.com>
        <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
        <87r2gclnjc.fsf@evledraar.gmail.com>
Date:   Mon, 29 Oct 2018 10:00:54 +0900
In-Reply-To: <87r2gclnjc.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 26 Oct 2018 17:45:27 +0200")
Message-ID: <xmqq5zxla7nd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I was going to submit an update to this, as an additional improvement
> can anyone think of a reason not to always infer that we'd like a new
> branch if the LHS of the refspec starts with refs/remotes/* ?

Depends on what purpose the remote you are pushing into serves.  My
instinct tells me that it may be more likely to be emulating the
case where the remote, which is hosted on a box on which for some
reason it is cumbersome for you to get an interactive shell prompt,
did the same fetch as your local repository and stored the same
value in its remote-tracking branch than creating a local branch.  I
do not say it is entirely unlikely that the push wants to create a
local branch there, though.  It can be a way to "reprint" what
somebody else published as their local branch, which you copied to
your remote-tracking branches, to the destination of your push.  I
just felt that it is less likely.

To put it another way, I would think both of these two have at most
the same probability that the push wants to go to a local branch:

	git push refs/remotes/foo:foo
	git push <any random sha1 expression>:foo

and I would further say that the former is less likely than the
latter that it wants to create a local branch, because it is more
plausible that it wants to create a similar remote-tracking branch
there.
