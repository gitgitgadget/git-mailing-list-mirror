Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D3C20288
	for <e@80x24.org>; Fri, 21 Jul 2017 16:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbdGUQLb (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 12:11:31 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35713 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdGUQLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 12:11:30 -0400
Received: by mail-wr0-f169.google.com with SMTP id k71so30741882wrc.2
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tf6h+iVqJ77sG873MZ9KCvy0zEXmmrVKQMeQr4fLCuQ=;
        b=RHwe4eeNqIzcEQPcW9j8aCTnNMRnsOJbFByu/dm4v9XpzUcWbLO/RyFHiSwsAXgdXV
         zzsqYRC26C9x66TAJ0zIKLAwGnIPykN51Ueu6mqCLZoIYqhiMNwJU8raU4FaA8oAlK+T
         0BN7LFgUbTnZrsmkkYQDvemIJHtJt/CSA+tS9/7qJdNe4XiQ9gJ9W03Xn6WYd6GfGykU
         djfD5d52wKIjpo3+F8b94z3fK4fUdkyRttLjYxDSznKBBkYmL8b+c83kiJIA/rPNsQex
         I5fQYHYEX4FNzY3IhLK5UuH0n95cpG5y2qwdmfqah5mxx2IQTl4PrtnpHE8Xfvv93hEe
         IVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tf6h+iVqJ77sG873MZ9KCvy0zEXmmrVKQMeQr4fLCuQ=;
        b=ZPcwZUu5RuNGyf1iB5zmv9NCXgGGyTpaKOwNftpyQKvJ+g5aKE/eyXZ+qCKwrTp9sg
         m/FAE+ULq2U83xzuh5e1LtTDuXwUXl2uUQCmNhW6tsCxFLtcW8SDKkb2PyR98J0OWIWo
         8J42UOtldF+oC1PxgpzJmkAzTwZ4gQRtW+0fBphYUCKxSnWbXZaTW7XrSZc9UVJJTVyL
         lrZ/RgSKKl1aeSsYVciM3SNhnlTxii4VDTAsLsfc+yDec3ZdoiudT+W9opGuRyrMLG+a
         lO4KtE1p119wRuBzL2sLx+GYLeUv8UlTtrt+tYIsK+j5piBG8YU+FaRJuOabJZfsOiLg
         ryCQ==
X-Gm-Message-State: AIVw110zQ7WalHx4Cyt5Q68HwI7yyb+xzJhGSlMLySVkqozoZ2vhHvZU
        YcrOUkmidFg38xBzhxU=
X-Received: by 10.223.180.88 with SMTP id v24mr10088108wrd.29.1500653489134;
        Fri, 21 Jul 2017 09:11:29 -0700 (PDT)
Received: from rempc0k844e.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s4sm2239946wmb.27.2017.07.21.09.11.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jul 2017 09:11:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Reducing redundant build at Travis?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4lu7m94h.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 21 Jul 2017 18:11:26 +0200
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <333FEA3F-BB43-4183-ADD1-14E73E668EA3@gmail.com>
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com> <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com> <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com> <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net> <xmqqbmonrrvr.fsf@gitster.mtv.corp.google.com> <20170714153224.6qnupcsa3pkig76k@sigill.intra.peff.net> <4BB4EDA1-58A5-45AD-8BEC-1CB06CDC23DD@gmail.com> <xmqq4lu7m94h.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 20 Jul 2017, at 17:16, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 14 Jul 2017, at 17:32, Jeff King <peff@peff.net> wrote:
>>>=20
>>> I don't know if Travis's cache storage is up to that challenge. We =
could
>>> probably build such a lock on top of third-party storage, but things =
are
>>> rapidly getting more complex.
>>=20
>> I think we shouldn't go there because of the complexity. I reached =
out
>> to TravisCI and asked about the "hash build twice" problem [1]. =
Unfortunately,
>> I got no response, yet. The issue could also be considered a feature =
as you
>> could perform different actions in your TravisCI configuration based =
on
>> the branch name.
>=20
> Oh, no doubt that it is a feature, and a very useful one at that.
> With that, we can change actions depending on the branch name in
> such a way that normally we do our build and test, but when we are
> on a branch (not testing a tag) and its tip is tagged, we become
> no-op to avoid the cost of testing.  That is the feature we exactly
> want.
>=20
> The question I had, and wanted a help from you, was if there was a
> way we can write that "are we on a branch (not testing a tag) and is
> its tip tagged?" test only once in .travis.yml, even though we have
> quite a many items in the matrix.  With the current way .travis.yml
> is laid out, without such a facility, we'd need the logic sprinkled
> to at the beginning of all "before_install:" or something like that,
> which is not quite optimal.

To answer your question: I don't see an easy solution to the problem.

However, maybe it is solvable with a creative usage of "build-stages"?
https://blog.travis-ci.com/2017-05-11-introducing-build-stages

Sorry,
Lars

