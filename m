Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568DF1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 12:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeK0Xxy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 18:53:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46378 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeK0Xxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 18:53:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so18844662edt.13
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 04:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xV8EopXDU+TXRon5YZx1KpzqtKiM4XtTSlq8rekthUY=;
        b=p6hKZEsYUZYjMkGb+SqZ6MVK9MzKzmOwHXjxjgnwD3ypTUypVySK7dpOidEgBMP/B2
         P/8Su0WQ93KtN68KaV4IPtdkorXdwFQZ9uxrwJLx01+GLjoz0HSleZa9Kvs0zwmdDdQt
         Ujb0U24hWHAEOc4Ao2JUw+tS/3KRvEibAjGDA+kzj5kzDABdF/k/LbHSdoSntHIhcybV
         aq9s/YZKwo14AoD/nWUni8Fia4YtMln9jUXtlRLZUfH62mDcP+5J4C69HFKsQY+BpHjp
         mRNStTJffwgQ+gNb/jGZuhWbwKQotj+92m+WVlOS4hahqSlNuU9JVexbVRhrVGaXX095
         JGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xV8EopXDU+TXRon5YZx1KpzqtKiM4XtTSlq8rekthUY=;
        b=K0o2+MlZehKF2fPTF7oTMeEhufqBVK/VfuD1JqJqJ6ys1tSMhodyhQ/8pF6CeGkcWr
         smEHVbgEaA0t5LD+C+4/70ApdGl0LUE7JAY1NVuhVU3xjvAEVWCquOyTFaRiBVmF1Kl2
         fQgqnu35zcU4dvNOoLOL6HPetD/h2lR2zZq2Io6/ctefeBNGiGr9xPgOrqBPqrJtYJ3O
         gAyTdZ+BhEpXAq4lxX1IMOm8NSoMHMbrzG474oaWTKVtyeQd3NvwIL+C/yh76mL557fg
         FM6VhAXGZflUX1sQVLzfCdgmCEuYJjalOOTTBT3F85k+IAigPFsOpTUFiaj8yh3Utvtd
         Kcuw==
X-Gm-Message-State: AGRZ1gKq0siuJyabpwxp9rji6WS1qxmlDv8rL4wLVlDr8uK/jewnm6Tx
        dwYhmrYriml3OcYkNjCkdtgEJT1tOVUZmOq7onA=
X-Google-Smtp-Source: AJdET5cS+ch/+04noYQF6jvR2JCGlEZ0OcrxPV9A6zSySOrcavc44xDJGdCbsyHfzHKXXDwXe3sACXQFh6vFCc6QuD4=
X-Received: by 2002:a17:906:7143:: with SMTP id z3-v6mr23817032ejj.241.1543323362363;
 Tue, 27 Nov 2018 04:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com> <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv> <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
 <87sgznzwcp.fsf@evledraar.gmail.com> <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
 <87pnurzvr6.fsf@evledraar.gmail.com> <CACsJy8Ck7CZ7JWaN6ark=wrAngywJJh76y-FvJ87gE2ckVS8pg@mail.gmail.com>
 <f6aad4a2-8cb4-acc2-af9b-9c9c82059b89@hibox.tv>
In-Reply-To: <f6aad4a2-8cb4-acc2-af9b-9c9c82059b89@hibox.tv>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 27 Nov 2018 04:55:50 -0800
Message-ID: <CA+P7+xri1=peNpEiZCE802HwCXhojyp2BDvOR+6BBSoRtsZyzA@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     per.lundberg@hibox.tv
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        jjensen@workspacewhiz.com, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, drizzd@gmx.net,
        hellmuth@ira.uka.de, kevin@sb.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 1:45 AM Per Lundberg <per.lundberg@hibox.tv> wrote:
>
> On 11/26/18 5:55 PM, Duy Nguyen wrote:
> > On Mon, Nov 26, 2018 at 4:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >> Some of the solutions overlap with this thing you want, but I think it=
's
> >> worth keeping the distinction between the two in mind.
> >
> > On the other hand all use cases should be considered. It's going to be
> > a mess to have "trashable" attribute that applies to some commands
> > while "precious" to some others (and even worse when they overlap,
> > imagine having to define both in .gitattributes)
>
> Agree - I think it would be a very bad idea to have a "mix" of both
> trashable and precious. IMO, we should try to find which one of these
> concepts suits most general use cases best and causes less churn for
> existing scripts/users' existing "semantic expectations", and pick that o=
ne.
> --
> Per Lundberg

Personally, I would rather err on the side which requires the least
interaction from users to avoid silently clobbering an ignored file.

Either Duy's solution with a sort of "untracked" reflog, or the
garbage/trashable notion.

I don't like the idea of precious because it means people have to know
and remember to opt in, and it's quite possible they will not do so
until after they've lost real data.

I'd only have trashable apply in the case where it was implicit. i.e.
git clean -fdx would still delete them, as this is an explicit
operation that (hopefully?) users know will delete data.

Thanks,
Jake
