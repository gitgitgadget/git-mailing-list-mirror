Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDF41F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeAXWhg (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:37:36 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35229 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXWhg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:37:36 -0500
Received: by mail-vk0-f49.google.com with SMTP id n132so3625962vke.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 14:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s94wuur/hjwHr5zdEfKnSdDomSpenR1i9cc0ha1imyk=;
        b=oM2jc/q6fhV2Y43ZMWKz8Uu2hMzQGII8KqmguRMMqAyFts53HOn+u+h8UR/thyFUVO
         wA57dKLhBDgpzC52Ke15J9FGo0Q/+SuI8xBCbbHKBwMPGK+Y3TkoNle892bVe2uGXA3c
         qKKrpFkaWOgO1xNrSJUHExehJ+vX4vQOEr68P0LHJezdP5xFvJ2Qdr066FM6FfkJA5iX
         51x7FB+yHwBV2Ewcv+6J/GxwlwbvHmCJuhGDuRLaBgp8NJmZrxI7fVJm902Ml5KD3poJ
         TxKpmofDIJSVLbCOwc5oFWmM99cnUGv6Yb96lT/YIml0Km61MAqP2u3/sj9a6uQFz6/W
         duTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s94wuur/hjwHr5zdEfKnSdDomSpenR1i9cc0ha1imyk=;
        b=PgcPAQqNpeuUEj8GodKWg7r3LV2ikNwDy1s3D+j31Z3TM6G1TIdi8zK8Ul8fplx3tu
         sZXxn9av2b6DDYbkIhLQPUbZLrs517J5vz3JDkJQsWvlPGAtabBBbhSt62a8zsSnUIS2
         CbrB2+Gwz4Mxwo+HXvwJYGMS3byXGzEMtAjwT3veS96ablHP/5ne9MNjoCuqE0JjIKnm
         9Lt0VaQA+QfEy59+aot+/Ob1cWv158IoOfe0Hh79NNFm7qvNC8YaCPKnutJAHwA3kFFW
         VzMtfTGVuPZjt3qtRLL1b7vQzqBa8HRm5ycOMzenCXarijHWzdiG5xkYYGZHXMSaxWKm
         OUuQ==
X-Gm-Message-State: AKwxytdwOKKg0o8iMn8IVDzyWz/VVFVDCuNc31mPBnNL+qQfTi/ZF04/
        8zwmY2/ZV5oooj+I4HFh6XA0hZZ5Xp8GUGfMi80=
X-Google-Smtp-Source: AH8x2252MgyK3VXQZ/n2bBYzY6n1FRq57hjjm1+0NjYNJXN8++jfeKzkIttA3qNfqLLV7QapJ9dLxC9dh1rlN1mPc5g=
X-Received: by 10.31.33.86 with SMTP id h83mr5576692vkh.183.1516833454972;
 Wed, 24 Jan 2018 14:37:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.8.83 with HTTP; Wed, 24 Jan 2018 14:37:34 -0800 (PST)
In-Reply-To: <87bmhiykvw.fsf@evledraar.gmail.com>
References: <87bmhiykvw.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Jan 2018 14:37:34 -0800
Message-ID: <CABPp-BE0u9x_TtEHmfS11ZV-50rSvCi_y7cmTVV7z=2zT3atvg@mail.gmail.com>
Subject: Re: Git packs friendly to block-level deduplication
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 2:03 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> If you have a bunch of git repositories cloned of the same project on
> the same filesystem, it would be nice of the packs that are produced
> would be friendly to block-level deduplication.
>
> This would save space, and the blocks would be more likely to be in
> cache when you access them, likely speeding up git operations even if
> the packing itself is less efficient.
>
> Here's a hacky one-liner that clones git/git and peff/git (almost the
> same content) and md5sums each 4k packed block, and sort | uniq -c's
> them to see how many are the same:

<snip>

>
> Has anyone here barked up this tree before? Suggestions? Tips on where
> to start hacking the repack code to accomplish this would be most
> welcome.

Does this overlap with the desire to have resumable clones?  I'm
curious what would happen if you did the same experiment with two
separate clones of git/git, cloned one right after the other so that
hopefully the upstream git/git didn't receive any updates between your
two separate clones.  (In other words, how much do packfiles differ in
practice for different packings of the same data?)
