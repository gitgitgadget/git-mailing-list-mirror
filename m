Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750E51FAED
	for <e@80x24.org>; Fri,  9 Jun 2017 10:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdFIKMM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 06:12:12 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35974 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdFIKMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 06:12:10 -0400
Received: by mail-pf0-f178.google.com with SMTP id x63so27020128pff.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3cnIIoF+ldu2+bbBIvHhe5ItvR2WY8VeqVcQJrRyMOs=;
        b=UriSWNmVHoQ55qQqrA6UbhJborRdPgcjk7UG5cEEBfSGHnUmdVT3e7vYyqK/rbhVG2
         6xMH7oUK68PjilFRukUTvsaZwW0hXX4K9foTEqyLggyKW22GrCGxWjdS5Iljk0q4oSVY
         IumbnSqqrNbuTpluusDN9y1WQeUltZn0CAJEEhdM69lxEKKAj+Ndpk7g0D2hjZk5nLsD
         xfpTZbew8Q8ukcgLlaGxARSxWp7dMJmTHapes73ARlu3xYtknUotxQKqETDkal5BClO7
         8DN4VhBL/LlRyT+5pCqWBjEWhw+SCUR8ZfVzQJyKDWkkegknelIczqIwv6PyblERvuHM
         mjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3cnIIoF+ldu2+bbBIvHhe5ItvR2WY8VeqVcQJrRyMOs=;
        b=igKBEGHNUVdCGCA0wTWVFyrfYCh3wwxNtCcdjpRCxb1acbd39/2tjvKC5+62Jhw1VY
         o0gyMNhdIuhMRuNJi/oWq7d1GGKoGirBJ6R/raTNCNSq1CXWAmqrFS2HfDCG7GgwuBYu
         9nAK+tAmQyiPuXRGCa/NNPHWLkJWmSJZieide/slo/MJzE2vew7YnDF75BSa1vW40ype
         GzydTeyJTkpQFwQnhMQFK8bWK/C5g90EdqphyXcfFeX8eHLn+p5ESRyTK1de4BkxX9td
         Qk87qaI2Yvy26pOMHJJth2p2gsPETtvGXOR7rIfD9K9Z04M7Msbv20DhBAfKdQwWCnuE
         SWcQ==
X-Gm-Message-State: AODbwcCDCf/52UiBmD8bWurO5PC9GEDmKPWvU+/A4ZRNkdRn/rVdOmJ9
        JIzcxaQN3Rogaoul967sCbd+E7PJqw==
X-Received: by 10.99.112.86 with SMTP id a22mr28539031pgn.158.1497003130126;
 Fri, 09 Jun 2017 03:12:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.143.132 with HTTP; Fri, 9 Jun 2017 03:12:09 -0700 (PDT)
In-Reply-To: <20170609085346.19974-3-avarab@gmail.com>
References: <20170608234100.188529-8-bmwill@google.com> <20170609085346.19974-1-avarab@gmail.com>
 <20170609085346.19974-3-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 9 Jun 2017 12:12:09 +0200
Message-ID: <CAN0heSo_S+_dut8RgDzVxffPZOzSTLwahsKrn7KG8aLvnrPbAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] *.[ch] refactoring: make use of the freez() wrapper
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 June 2017 at 10:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> Replace occurrences of `free(p); p =3D NULL` with `freez(p)`. This
> introduces no functional changes, but cuts the number of lines spent
> on this cleanup in half.

It's even better than that. ;)

>  48 files changed, 97 insertions(+), 197 deletions(-)

The difference is in builtin/am.c where some empty lines are removed
in am_next(), so no need to be alarmed.

The macro would be dangerous with things like "freez(ptr++)" but I
couldn't find any such side-effects. In hindsight, I guess your commit
message says as much since using "ptr++" for "p" would already be a
bug.

I have no idea whether this conflicts with other topics, or any
opinion on the best strategy for doing the conversion (all-at-once or
"while we're here").
