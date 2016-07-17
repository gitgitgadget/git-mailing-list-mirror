Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06ED82018F
	for <e@80x24.org>; Sun, 17 Jul 2016 15:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbcGQPTe (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 11:19:34 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38136 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbcGQPTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 11:19:32 -0400
Received: by mail-it0-f54.google.com with SMTP id j124so13220603ith.1
        for <git@vger.kernel.org>; Sun, 17 Jul 2016 08:19:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=HF7zHqzRsnaLN0uVXcoUoKuHGqPsaEeKmGxtg3RBS70=;
        b=KjZzC/lk76ovuaQi/2ch46u8glkE43JWf6chFw86jaQVbS8oOfB43+i6wsDR9K4Y0E
         iqMTWy9IRkcBt+ZR+kFqC5rEebox4FcSpytsF3DMI1MurRe4pm64tCrBNmDIf/JxLldG
         2X4EDOoY2nWiXUTNTAnBct8CpQ+TAfQm/3xA+IlH3ezddq98KnSSLjZdp6/smX3c87HC
         RbGjCT1LypmK2uosjM+lAEDOp9F2bsJuRw4Sgv1zUnZ4mT9LiSLUOJczuRaWXy/BUJwj
         /9JlrkCwgtbECniPWYQf6Od3jqKhDb0DEmQvOy3CaoAP6hf4SYKw6ca4Lg1Lo9fm633C
         CQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=HF7zHqzRsnaLN0uVXcoUoKuHGqPsaEeKmGxtg3RBS70=;
        b=Tzqf18+taGhad3nK07fPq+5Sd2n0votuglmyjZEA45JN10K8f9vmY0djljZVSeBkpo
         3rSgQZJu1GEhIpYKYXmhG3w3dl7rE0lCR7W9jvK4iHQmRPkIdfPgGBz/H8ixognc7YS+
         KS2PyARSyxeh+avw2xApBoYRVp6xXHn1B0X7R2Ju/gGQiiQciq/+jKP2XxRwhBVL9KQm
         cyHiim2f2gzIK67UzPKbQjILnaQRQfjphoKJAGkLQzIgn13gnuoCKhEqWtPQ1fghM/wv
         D9pS4q0cHbvDG3pOJ4t+lLZ4cK2Ig9yCm/NHCf2jbYc7ujaiDSwYi+KkL/QO2LFazv/P
         PwGQ==
X-Gm-Message-State: ALyK8tKVTjslfpvUNPwYfmL2waghd1PGmOIDBlQ7P9KfYE8sO8y/UWAUqTgF/FX2hu/vpsUfToHQE2FraHEtbA==
X-Received: by 10.36.33.197 with SMTP id e188mr27000260ita.42.1468768771775;
 Sun, 17 Jul 2016 08:19:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 17 Jul 2016 08:19:02 -0700 (PDT)
In-Reply-To: <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 17 Jul 2016 17:19:02 +0200
Message-ID: <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 17, 2016 at 4:21 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Jul 17, 2016 at 10:01:38AM +0200, Johannes Schindelin wrote:
>> Out of curiosity: have you considered something like padding the SHA-1s
>> with, say 0xa1, to the size of the new hash and using that padding to
>> distinguish between old vs new hash?
>
> I'm going to end up having to do something similar because of the issue
> of submodules.  Submodules may still be SHA-1, while the main repo may
> be a newer hash.  I was going to zero-pad, however.  I was also, at
> least at first, going to force a separate .git dir for those, to avoid
> having to try to store two separate types of objects in the same repo.

If it's just the external hash representation, can we go with a prefix
<algo><colon> to identify the hash algorithm? For example
sha256:1234... is SHA-256 while 1235... by default is SHA-1 (but we
could switch the default to SHA-256 via config file later SHA-1 is
dead and nobody wants to type sha256: every time). It catches
incorrect hash algorithm references.
-- 
Duy
