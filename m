Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA271F404
	for <e@80x24.org>; Mon, 19 Mar 2018 21:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965219AbeCSVcm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 17:32:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41611 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965201AbeCSVci (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 17:32:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id b7-v6so6980441plr.8
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kmzSZwzNwrd6EPdff8URUnO8ChEyZH+1jSZB7oRcheA=;
        b=lnZfv6ovjyQOKrXEI17ot2EkKrkuNC9Ti8LhE1odPtsQ6BOff8e201QTZ4Gmt3r0xU
         sQAIsrKci0hWm1L1a0+ojGCORzf4Rf+kjUUaw738+7bGYTwKV4RbSwkTFZjJEVOV21lg
         zK8SIyXsJidca3eIqRaNX/UCEO4Hh6FvtShRc156SQrwJH5qj06Ty4OXT8N2XUPzDh+T
         b7j7d1ySXly3VLUXgaDAhk5CgAhZsPeSzu5ArDXXRobgShNag+441FrgGBWP0Kj0m7NC
         Voz4cgKKMz9B3hyY9rHzDpq0WIp7+IKp7MvS8pfUyrX6Nat+rB0p8/5G9rs/ig+GRJd/
         pCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kmzSZwzNwrd6EPdff8URUnO8ChEyZH+1jSZB7oRcheA=;
        b=MpPeK6sCN55r3YKntjKJNjiuGDDSD9kySLIgJLuoZi9WFR9QE/jnD1APUf/rNkJQun
         H9cRpLQUirvykVoIcSwX3AqUj9iEqtVJ71qQSVdC0VJ2pO/3t8spiBZ9VQ58iOJmn+G2
         7FWFOFm7U6tJC2QNtwC4jwLX7LHuWyTQxsBabZqYsoIO0QbgXmABFKU/5DcuX0rwLqNe
         ZAPReNWQz7NlLqykUjXHxFlaF5tWwMN0xvHwG4PkHzvKM6+fNkocGr7CkNr9UQJqwKd5
         UOOhGd6GvJwism+FETYsmk/2dUdJy6y9sK9BJ7vKWsK9SvgiCn/rGwXoIoDPXtL7b/ER
         /hWA==
X-Gm-Message-State: AElRT7FU5gsObksLjomKavwXh6E4K98iIZ/rvEtQpwyqln8r6jZIaGQa
        JUaltHAgET5WLpP9LPBKW/g523+nDGoDzRwSF8Q=
X-Google-Smtp-Source: AG47ELteOKeTfb1BsbZviG2xsv9lyCEsrPc3qceSfqPmBHXajoq6QtivHfR9P39g1NyST1aPFv40MV3LGenMA+25EIY=
X-Received: by 2002:a17:902:8685:: with SMTP id g5-v6mr9874188plo.133.1521495158433;
 Mon, 19 Mar 2018 14:32:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Mon, 19 Mar 2018 14:32:37 -0700 (PDT)
In-Reply-To: <20180319025046.58052-3-dnj@google.com>
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-3-dnj@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 19 Mar 2018 22:32:37 +0100
Message-ID: <CAN0heSpu4Lv9P+zzKPgJe3nx+J20Yex9is8SCztKobLc5ZfWCA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
To:     Dan Jacques <dnj@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 March 2018 at 03:50, Dan Jacques <dnj@google.com> wrote:
> Add a new Makefile flag, RUNTIME_PREFIX_PERL, which, when enabled,
> configures Perl scripts to locate the Git installation's Perl support
> libraries by resolving against the script's path, rather than
> hard-coding that path at build-time.
>
> RUNTIME_PREFIX_PERL requires that system paths are expressed relative to

This commit message mentions RUNTIME_PREFIX_PERL twice, but there is no
use of RUNTIME_PREFIX_PERL in the actual diffs (patches 1-3/3). Should
it be s/_PERL//? Your cover letter hints as much under "Changes in v6
from v5". And "Add a new Makefile flag ..." would need some more
rewriting since this patch rather expands the scope of the existing
flag?

> a common installation directory, and uses that relationship to locate
> support files based on the known starting point of the script being
> executed, much like RUNTIME_PREFIX does for the Git binary.

With s/_PERL//, this part above reads a bit odd. Would this be
s/RUNTIME_PREFIX/it/?

Martin
