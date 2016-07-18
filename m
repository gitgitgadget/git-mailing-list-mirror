Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B889E2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbcGRQNB (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 12:13:01 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:36952 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbcGRQNA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 12:13:00 -0400
Received: by mail-it0-f53.google.com with SMTP id f6so78381007ith.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 09:12:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NAQWRHfowa+oDRX9MtCAc9E9HNJu16jeG5gX9oJVWpU=;
        b=jn025E/mgDAHZSKuMAvhky23NEiwqUWTJPwOVAMErTnOjUT0FKhg9Rh8X8ySYlETRN
         aA8EL6pF6BragGNzMBzqD7qnLgRiOhXSpIl5hJ9jGYfKUycZhVncjxVPJFovBziAJb9p
         sGIDP4bJBUbKJYS6l4mnmpfUAiHF3V0AlgI3oqqe+KmlSjzP+Bq7O2PlL2wA8cUWPXfx
         lCYrGqPR1jxbMR3N08vbrKtIMX/482LvWhOh96Ub1yuBf4ph0ZVaxch5Vmht5M4+x0Fb
         wvR4AclEWXVJhKJPK7xA+ChhquVCShwXnKW1RGQtLxNTwkL7eluPH3fKJ1qThtUNHP7t
         y4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NAQWRHfowa+oDRX9MtCAc9E9HNJu16jeG5gX9oJVWpU=;
        b=PBTNT+yzuxiQVC8ixey59MAEPtL6emUYXUIxSePmWoWEXifzsqgbUPjw1a0FIa4ehT
         fqe+I6DWgKvB6v7pwZ/meYYgHs9ddoh/JjqbWdi4x7z2QYbEniZ0eSglw1EgCRDy1T+H
         OPLvC3YgenV9hEpnzBt3QeNlHlJEK97hReA1hhLIgv3Ebqoo+D85pr18RCjOtnEuJsdJ
         s7dSM2PeyCqUplWIPtXoAZkHK+tzZlrqxdj3qRAdvXXXxUITI8PI0lJbALe4XmDgxkin
         LmnofzSEMse3LztKIcavy485TP1dvnBLwbxvnDwbDCanAF66d798cC9QG5OKX9xSJYJf
         fqJA==
X-Gm-Message-State: ALyK8tIDI/rTJxUpE0je2aTB1y9Bp2waS0mtB8W5yOUXcvpdYSW3q9kw6r5TDQ1mc/S8qHvW/+QtJvShoQfr+A==
X-Received: by 10.36.50.206 with SMTP id j197mr46779921ita.70.1468858378565;
 Mon, 18 Jul 2016 09:12:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.4 with HTTP; Mon, 18 Jul 2016 09:12:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607181750470.3472@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox>
From:	Herczeg Zsolt <zsolt94@gmail.com>
Date:	Mon, 18 Jul 2016 18:12:57 +0200
Message-ID: <CAPp-Vra8c7eFegysKrM-hZKNmD6B21XqVkE8HB0QcG_m8hu+Ow@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johannes,

>> My point is not to throw out old hashes and break signatures. My point
>> is to convert the data storage, and use mapping to resolve problems
>> with those old hashes and signatures.
>
> If you convert the data storage, then the SHA-1s listed in the commit
> objects will have to be rewritten, and then the GPG signature will not
> match anymore.
>
> Call e.g. `git cat-file commit 44cc742a8ca17b9c279be4cc195a93a6ef7a320e`
> to see the anatomy of a gpg-signed commit object.
>

Yes and no. That's the reason you need the two-way lookup table. If
you need to verify a commit which was signed as SHA-1, you must use
the lookup table in reverse. This way you can reconstruct the original
commit structure, which than can be verified. Of course it's work to
do so but you only need to develop the new signature verification
algorithm. You save much more on the other side where you don't have
to rework all the other algorithms to multi-hash.

Another interesting point is that multi-hash storage, actively hurts
signature security! (Duy just mentoined that while I'm writing.) A
signed commit (or tag) is just as secure as the least secure hash it
refers (directly or indirectly). Let's imagine that you make a new a
commit, and there is on old file in the tree somewhere. That's a weak
point: cause it has SHA-1 hash, someone can replace it (and thus
change your commits content.

I would clearly mark any signature wether it's SHA-1 or SHA2 (or
anything else) based, and strictly allow that hash in all the trees
and objects while verifying that commit. If it's not the same
hash-type as the storage-key, than use the lookup table for conversion
before check. (This has some interesting side-effects, but it's all
about good implementation).
