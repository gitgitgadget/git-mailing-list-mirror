Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17211211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 05:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeK3Qpk (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 11:45:40 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:35687 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeK3Qpk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 11:45:40 -0500
Received: by mail-io1-f54.google.com with SMTP id u19so3596811ioc.2
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 21:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7h1Zst7F03FU0nrGI4T4Wocxy5M5o+B8claWUi3Qh1Y=;
        b=rP+SjOoDHBScj+iPqHPVusWDI2bbYAe0QNxJYW6MZ6AT2FeU8GGqfCXTNcy70T1ipG
         QXUh+J7wKd8qBwd18l6k9kfVWLP+NRwJ+qLgYj7DXvWNRmOiovIElDyJYrr4tZ/2KFcY
         TF5+vsP19l8ZXsSY9nzYy4rPIveksg6G8jq6d8mMeHA/pa4+EqKaYdKJyJObRNiFOgrO
         uQq47bG/cIIYa3Rr7iBHnngAmUgls5Gp/UjbKlbFDXbb2OvFFz4cwDePQQMNHBVV7g/S
         oCH35cO/i4eWBe7iTOg6mNeydgR27nC/5h8YwDevCG8CHE7pb79InX/pBScRyilVqHhY
         kIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7h1Zst7F03FU0nrGI4T4Wocxy5M5o+B8claWUi3Qh1Y=;
        b=bAc+tcq57+e9BBaHzadAGr6GQqcgIX4J8J87SmFGykoLNMH0YlImh1lK0V+n2ZdwLP
         EvwnLeAorAhdBNWy9Xh2i4nqN0hiHincLutF7JNvl7PnWJpQ2i1KD2uDMj73MLFnwC6b
         +d+eH58bWAmR4hCm1KeI1XmfA+VPJWzcHDEJg1Q6h4n+T1bv9DRc9i01r5BmQhUg/2/c
         Vyr7rzNbFBE0BK/Luhq2gyBPyiHIrJ9xWzL/LqL7V/+gDEM1np7r3tM2Yp347Ei99y40
         tKtB5X8pBu3EmwggEvMIpvZrcc49GBg1OaBqTVxn1w92SJCIRdZn5AGAWJ4PWnYYCZec
         5RHQ==
X-Gm-Message-State: AA+aEWZ8HxufaPi4+cTX7aTGqsvg1tsc2fyVuK3X5dZcXa2Cf8+Z+7Yj
        NfNsbgym7VOnro4u9mNMl0eaAWfUPkKZVJeT8kQ=
X-Google-Smtp-Source: AFSGD/UHfdbvPhxaDDZmgI2eUjlFPezzeOPPVMgMo4YGI0bTxIteVeWN5t2P0MqmOUBS+Xdr+qEkz7SjlQhLFfpyPZA=
X-Received: by 2002:a5d:944d:: with SMTP id x13mr35225ior.282.1543556252688;
 Thu, 29 Nov 2018 21:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <87pnunxz5i.fsf@evledraar.gmail.com>
In-Reply-To: <87pnunxz5i.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 30 Nov 2018 06:37:06 +0100
Message-ID: <CACsJy8DCKQctO+rf=xP5gVVUy9XBq35Z1xSbfwB30nDJMMJsrA@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>,
        Elijah Newren <newren@gmail.com>, dan@fabulich.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 30, 2018 at 12:05 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Assuming greenfield development (which we definitely don't have), I
> don't like the "restore-files" name, but the alternative that makes
> sense is "checkout". Then this "--from" argument could become "git
> checkout-tree <treeish> -- <pathspec>", and we'd have:
>
>     git switch <branchish>
>     git checkout <pathspec>
>     git checkout-tree <treeish> -- <pathspec>
>
> Or maybe that sucks, anyway what I was going to suggest is *if* others
> think that made sense as a "if we designed git today" endgame whether we
> could have an opt-in setting where you set e.g. core.uiVersion=3D3 (in
> anticipation of Git 3.0) and you'd get that behavior. There could be
> some other setting where core.uiVersion would use the old behavior (or
> with another setting, only warn) if we weren't connected to a terminal.

core.uiVersion is a big no no to me. I don't want to go to someone's
terminal, type something and have a total surprise because they set
different ui version. If you want a total UI redesign, go with a new
prefix, like "ng" (for new git) or something instead of "git".
--=20
Duy
