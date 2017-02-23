Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F732022D
	for <e@80x24.org>; Thu, 23 Feb 2017 17:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdBWRkO (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 12:40:14 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33703 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdBWRkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 12:40:13 -0500
Received: by mail-oi0-f52.google.com with SMTP id 2so21204782oif.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 09:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TK+gCH34Ww5WIFs14oYCtMy9yIF4waykz7TRi9bBxOg=;
        b=GRU7iJ2tShUxV3KrW14vcmbELektKp1dGVJqSUQen+adkkA1ZsD5ixeHNI87Pb+H0v
         jzLmxaRTAdA3eYpO6VnPYYv9ZcAk/1e+8pfNfsxJKFuVLMC5ZMGy1ZCRwH+zSyTGfFzE
         CcHRqi7qc4LCNcnSm4gxOrA2QH3+yZi2hPLakqQX1hN8JipEaFJlIHQfIwcTSfAtnU6s
         2Cq+auKQDOxsF9eOfTMDt/bTWfvYEkGSYS5C7YaDNwOMtb+s5kDb8fsMrro9ZH4sAtHd
         7gwraV69Deatknt/zRsIcrTYiC6njceGhzmpy2oUDtqJ+HWY+9FIPfEOrcfiLLZLHh5W
         HOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TK+gCH34Ww5WIFs14oYCtMy9yIF4waykz7TRi9bBxOg=;
        b=CNRpOLudKpkyeK6e4wWdvd6F678ObJdOBbgNIJdYwu/vgeUoal26O+tKlUZyxCaJE3
         3WP+tpN5crwUlqpE2mskU/zua1PVA2yrvyQqwa3iOHARx7Ias++IGuy5IInyC+6RNCje
         ++FvaB98t7CIVFM1Ir/GOKDxA8+nAHnDWvxYcFeniJNP94lPKv5c5POOkSe7y+/ALPwX
         ChyWxMULRuOj+LCx60M//C3eyzA1qHs8dqjkqTbaLd9J1pYGSB3K7CKmTr/c8d7VQ4OJ
         EbDCkYnWyLddoqnMzxEvgkKAEDsziuvv5XDYKZFZ6PU/JUZl3XapeqvUT4a185KmC9UO
         3Nfg==
X-Gm-Message-State: AMke39mRsYL+LtMYxp/WCcms6MbYaMQDJ+MDwVqJ0B5EouWL16LtTb2qPvupjERQymTBvlKgmLCF7ruC9PYOOw==
X-Received: by 10.202.232.210 with SMTP id f201mr4065121oih.60.1487870988633;
 Thu, 23 Feb 2017 09:29:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 09:29:48 -0800 (PST)
In-Reply-To: <CA+55aFxJGDpJXqpcoPnwvzcn_fB-zaggj=w7P2At-TOt4buOqw@mail.gmail.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CA+55aFxJGDpJXqpcoPnwvzcn_fB-zaggj=w7P2At-TOt4buOqw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 09:29:48 -0800
X-Google-Sender-Auth: 10pO5QH2IKHYKPrsgOftaOOWTi8
Message-ID: <CA+55aFxjY7mv7YPLZwit7bEhC3VqpEDk1YSRFwSGOEKVw13x4w@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 9:19 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I don't think you'd necessarily want to change the size of the hash.
> You can use a different hash and just use the same 160 bits from it.

Side note: I do believe that in practice you should just change the
size of the hash too, I'm just saying that the size of the hash and
the choice of the hash algorithm are independent issues.

So you *could* just use  something like SHA3-256, but then pick the
first 160 bits.

Realistically, changing the few hardcoded sizes internally in git is
likely the least problem in switching hashes.

So what you'd probably do is switch to a 256-bit hash, use that
internally and in the native git database, and then by default only
*show* the hash as a 40-character hex string (kind of like how we
already abbreviate things in many situations).

That way tools around git don't even see the change unless passed in
some special "--full-hash" argument (or "--abbrev=64" or whatever -
the default being that we abbreviate to 40).

               Linus
