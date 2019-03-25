Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A1DE20248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfCYVSK (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:18:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37169 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:18:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so11912625wrm.4
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1eGF9zzqWYVdg35udDCZUvFvuCQ0o/AjUUiuw5OVAeY=;
        b=D/p6V5fksVCpeRyXC/G4APEhJ8gDXR3WuV7j3WeDum4Eb44snxP4OgejrhG6Agudhr
         DGfEeQ+pp+yjyf+rV/1RzBacoP1kOJF5LPcDc5OWcEI4jHQkw4lrn/gcphveJt3KudSP
         m9Y5fekCic8xpKlD99P9RhNq9s1KNQVa5M43cOkvy8lQlheaBbSNaqrIhePqZ3SPCBca
         DVp/o7/dXAR6xwbBr1+uEH0po+Feey92YaDC1I9S8YUISHA01sM4ho5c1IyHC9in/TBc
         9E6cfgoPiHpoC/fchVAd5GD+17jAy9TrMGX7VhgTgJfJNZd1W9tGBVtvoOc/hD8HWvQD
         q4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1eGF9zzqWYVdg35udDCZUvFvuCQ0o/AjUUiuw5OVAeY=;
        b=Kfx7qKM+/tNN4TxmBYm9xoJhsIFB4N53UHUiBUOR6icHfDt9aXTIuIDP202QsVdKKM
         6SQMV3dv2dKyWJWgyMousrCfhDcLBo0whllxVh7svEJJuox2sBcNVdwE0xLPAPgA1Tyi
         SVdQaQW3CaOCD1B2f2Xntou3jS0Kp0b1yK849XBXiZGkLpg4NTjXzjdWDAFQfzrE2MRE
         pI7r0axkIVla75LCshq5uvgcMXrPlI1XF9dSogzveazVmqRZFV8SnyVofEsSraXV4ASB
         2AxXJuds0d6AZmKM9O2H0q8epyn0aP4Jm2r3glnqFLTGwwG3/E3kgLMvHMgMq7U99d93
         ZvWg==
X-Gm-Message-State: APjAAAVlwaxo2SwsWhUzoLVEG2tqBhwuO4j6R1OmiiDzSWPj+0jptukK
        tH+Hevvx9CM6hV/6DlFXgu+J5g5a0mehGB+I0EmHSEyv
X-Google-Smtp-Source: APXvYqz0byzbKi98dLS+uNZAe98yDWSppUX/uZlN8z+UwInhoKTkzRIGSuCDre88CmmlyXZYUKw7aR5vPwigTTOhAvs=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr16737354wru.30.1553548687978;
 Mon, 25 Mar 2019 14:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
In-Reply-To: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Tue, 26 Mar 2019 00:17:56 +0300
Message-ID: <CAL21Bmn0BQirS=vyTRHBx_kfuEp1JY4uw2wkjm5w_pgwgjA5iA@mail.gmail.com>
Subject: Re: [GSoC] Unify ref-filter formats with other --pretty formats
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=BF=D0=BD, 25 =D0=BC=D0=B0=D1=80. 2019 =D0=B3. =D0=B2 22:27, Kapil Jain =
<jkapil.cs@gmail.com>:
>
> Hi,
>
> Below are some two queries concerning
> https://git.github.io/SoC-2019-Ideas/#unify-ref-filter-formats-with-other=
---pretty-formats
>
> Q1)
>
> In pretty.h & pretty.c:
> void get_commit_format(const char *arg, struct rev_info *);
> This function Parses given arguments from "arg", checks it for
> correctness and * fill struct rev_info.
>
> In ref-filter.h & ref-filter.c:
> int verify_ref_format(struct ref_format *format);
> This function is Used to verify if the given format is correct and to
> parse out the used atoms.
>
> Now, the verify_ref_format function can be used inside
> get_commit_format function, hence reusing logic.
> Is this a correct example to work on, for this project ?

Hi! Yes, in my opinion your example looks like good starting point.

> If not, please point out an example so as to understand the problem
> statement better.
>
> Other than this I can't find any other example, for this project in
> pretty.* and ref-filter.*
> Perhaps some examples could be found in command specific files, right ?

Other parts of the project are about reusing other ref-filter logic.
For example, we could try to reuse format_ref_array_item() from
ref-filter.h. I haven't dig into pretty.c logic much, but I guess it
is possible to translate "pretty" formatting commands to ref-filter
ones. That will allow us to remove similar logic from pretty.c. Our
final goal is to minimise code duplication and to have one unified
interface to extract all needed data from object and to print it
properly.

>
> Q2)
> About a recurring term 'atom' in ref-filter and pretty:
> what is atom ? is it a piece of a whole document ? and what is meant
> by used atoms ?

I had the same question in my beginning. Please have a look at [1].
Another good question - what is object. You could ensure that you
understand this by reading [2].

>
> Thanks.

[1] https://git-scm.com/docs/git-for-each-ref#_field_names
[2] https://git-scm.com/book/en/v2/Git-Internals-Git-Objects
