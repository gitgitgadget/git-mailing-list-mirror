Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 153441F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 15:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeKTBto (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 20:49:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33039 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbeKTBto (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 20:49:44 -0500
Received: by mail-io1-f66.google.com with SMTP id f12-v6so22515207iog.0
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8B3Gj8Xdn0qz8rsCep1bT/DwMMPQdaInJ2eBs2oUDis=;
        b=Ha8nYftOsVtx76AVZBgaqMIQkyQqE+GD548eT3lkku6PyZ0ZcezpfrTUe6A0opBbep
         4KS3gH8Qj4FM/6f6sEM/6zUUkvzdpklQBzq/ow0i8WVISFJm4pNwayCMshGbLrpGu0qM
         Sf3VXuBZmAAh11t7XAtTjXGREUTHqjgloH6fsW1iA96/4c/csOz+wpEWcbxSB5peARPO
         qEjxgfHOOUt4KAoYLPL8sN+Ap5LlkCMjyJMdKFJYTXpuoqj4ZzFOQQOB/hlEDdh6pjJq
         smLNl9wcl36WNYHfXDjrb1QfndjreAC3EQ9Z8mVAhhs0LtK6MohaxqTpi317yhaqusSD
         O2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8B3Gj8Xdn0qz8rsCep1bT/DwMMPQdaInJ2eBs2oUDis=;
        b=j5snHCsl+apSxOFrxlpQLa9OR9jXsclNufmQ/EJQdEp8nghi0dtPVt8wZSBra4/oOw
         N0bbjkEybpZgjaFPxyDq0GgRoNSbEfivR+KRKXkLZk/Rg6a30dgXaaJo45nWcbJQq8rA
         OC2dlMeMyrINrQdLakz97BUascAeuW8qGrWWr2tqAqTJNGFXAEnO9J6+R/zhgu9k4h+G
         VB5MpnRfrUiSHlm3yLUUDpb/dtdcuRcyayFM/w8CDoi/gXHObwDOO2Zi2f2yTE+4LSaY
         LELiheeBdBgRbMXRzAT5jLhrB6WKxAnfTNwCMPZkURY8RUkJPJtRKeFwNTsNOIVtqnOx
         huxw==
X-Gm-Message-State: AA+aEWZFqHxvQy/wq+hgR+aVr1rk6rjIaNJedvFwjZJnk0utmxPHBe50
        qtzoCLlm7HVwZtZKXEPB+li9YXJ3ciJ3W+X/PH0=
X-Google-Smtp-Source: AFSGD/Ubw4Ka6cC+auE7eGkoJznu1ALrHyBve+t+PvHC0DaUB1OaXMMFOQTiudzMmgC2I5da7TF5Y+mMqmgWxhisgzE=
X-Received: by 2002:a6b:6f18:: with SMTP id k24mr12640954ioc.236.1542641148948;
 Mon, 19 Nov 2018 07:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20181118164800.32759-1-pclouds@gmail.com> <87d0r217vr.fsf@evledraar.gmail.com>
 <878t1p1fnr.fsf@evledraar.gmail.com>
In-Reply-To: <878t1p1fnr.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Nov 2018 16:25:22 +0100
Message-ID: <CACsJy8Aq8kjtwv8ZtPOUHOp=59KL9dRiTQkFfbr5oPh9Swytwg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Make :(attr) pathspec work with "git log"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 12:16 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> As an aside, how do you do the inverse of matching for an attribute by
> value? I.e.:
>
>     $ git ls-files | wc -l; git ls-files ':(attr:diff=3Dperl)' | wc -l
>     3522
>     65
>
> I'd like something gives me all files that don't match diff=3Dperl,
> i.e. 3522-65 =3D 3457 files, or what I'd get if I constructed such a matc=
h
> manually with excludes:
>
>     $ git ls-files $(grep diff=3Dperl .gitattributes | cut -d ' ' -f1 | s=
ed 's!^!:(exclude)!') | wc -l
>     3457
>
> From my reading of parse_pathspec_attr_match() and match_attrs() this
> isn't possible and I'd need to support ':(attr:diff!=3Dperl)' via a new
> MATCH_NOT_VALUE mode. But I wanted to make sure I wasn't missing some
> subtlety, i.e. that this was implemented already via some other feature.
>
> I thought I could do:
>
>     git ls-files ':(exclude):(attr:diff=3Dperl)'
>
> But we don't support chaining like that, and this would only exclude a
> file that's actually called ":(attr:diff=3Dperl)". I.e. created via
> something like "touch ':(attr:diff=3Dperl)'".

I think we allow :(exclude,attr:diff=3Dperl) which should "exclude all
paths that have diff=3Dperl attribute". It's actually tested in t6135
for ls-files (but I didn't add the same test for 'git grep' because I
was so confident it would work; I'll work on that).
--=20
Duy
