Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68E22095B
	for <e@80x24.org>; Sun, 19 Mar 2017 10:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdCSKNN (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 06:13:13 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:34921 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdCSKNM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 06:13:12 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so5909448itc.0
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=abOgJTD21nA6JhoCt3i+3pijeSDW+K5BparWDBxwBTU=;
        b=OoOY1HW2Cg8++nsOXvyUviGS/I9vE9axJ9WqI4TnRyPcs6uJkA6rAKA9/474vqFQN+
         4siQgzPHqd5QpdZyvLcNNSBglwVsoaSPtXAjqcIofMaWsr8FeE20qvZLmjyDrten7zjh
         HCEuinhPPMp5fcJeKLtXhda+0SQWMQShAwbdVi/Q1u6+Xk6iLhE/AcCGZCDuKtxt66qq
         cObBWQS0l5iX273G2oWskNTPBVA31/k/fpOHYiC66/Ri1ULi6e3jOAmIVIbIat185qeD
         ZwfuSC69d5baEAkKqEHhUi5JDNegQwVCyPrqVOwMNnlmk2w2SxEB20HSCqg1nrwmYjVJ
         9wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=abOgJTD21nA6JhoCt3i+3pijeSDW+K5BparWDBxwBTU=;
        b=N/s3lcoVBedoAkD9HbPInB5Pg7nRzkm8ZqMr1ybrZgEqQwVt0HLTm08DoonpzYM6sa
         200tRm5XYBWyggUrn5aGGiADufZS7msewSJ0bAVRgq/JDI0S3qYfrPG79/fYQcY7gQWK
         64Y4c+iiKGSlHhGDfozMd++VqeBe2Z/EveQ0BFb7SSo3zTMclU66gwl6t9ziOHVK1iuA
         sf+Kzh97dbOKkn3wFuZl5X2GtqPvx/gXa0Mt6XPAv+ECuxKydc/YTxyccnXGKLu4nMDS
         nO1GN5Qps2o0PAJbLRQfKFu+16uEP9hdt6TLzpTOkmcdkhVeJfN+zgAzfHTu5I8GAx7h
         PJ2w==
X-Gm-Message-State: AFeK/H01HHJHAB3wt75Igju8+s//y0Tbz/LQ6pC5QnoMXW+lXcdG7KIU9gfN0t5SfC+TIrQY1aqJp5e4CvOO0Q==
X-Received: by 10.107.150.201 with SMTP id y192mr26043019iod.33.1489917895647;
 Sun, 19 Mar 2017 03:04:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sun, 19 Mar 2017 03:04:35 -0700 (PDT)
In-Reply-To: <CACsJy8CV=9PoH6QHCeznJ4DFLJN5w1a74X3f4raqrh4zBzCe4Q@mail.gmail.com>
References: <20170318223409.13441-1-avarab@gmail.com> <CACsJy8CV=9PoH6QHCeznJ4DFLJN5w1a74X3f4raqrh4zBzCe4Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 19 Mar 2017 11:04:35 +0100
Message-ID: <CACBZZX6AwBBHPN9-2ADrNXLh82YMVmgj94m-hn_WX_R0yjhcxw@mail.gmail.com>
Subject: Re: [PATCH] rev-parse: match @{u}, @{push} and ^{<type>} case-insensitively
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 10:19 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Mar 19, 2017 at 5:34 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index ba11b9c95e..55bde6ea65 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -96,7 +96,8 @@ some output processing may assume ref names in UTF-8.
>>    refers to the branch that the branch specified by branchname is set t=
o build on
>>    top of (configured with `branch.<name>.remote` and
>>    `branch.<name>.merge`).  A missing branchname defaults to the
>> -  current one.
>> +  current one. Both '@\{upstream\}', '@\{u\}' are case-insensitive, so =
e.g.
>> +  '@\{UPSTREAM\}', '@\{U\}' or '@\{Upstream\}' also work.
>
> Since this change makes @{everything} case-insensitive and there's no
> new one on the horizon, can we just say "everything in @{..} is
> case-insensitive unless otherwise specified" and not updating every
> @{case}? It sets a new common rule for these @{}, which I think is
> good (easier to remember as a user).

I have a slight bias to keeping it the way it is, just because of the
distracted user in a hurry use-case that's looking up only @{u} and
not reading the manpage all the way through.

But yeah, I could do that, i.e. have some blurb at the top noting that
all of the magical syntax is case insensitive unless otherwise noted.
AFAICT the only thing that's case sensitive now is the ^{/regex} form.

Also an advantage of that would be that currently we don't note that
e.g. sha1s like dae86e aren't case sensitive and can be written like
DAE86E, and the @{<date>} syntax doesn't note that it's case
insensitive. A blurb at the top would cover that.
