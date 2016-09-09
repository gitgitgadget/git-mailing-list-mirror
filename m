Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A151F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753966AbcIIUVM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:21:12 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35565 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbcIIUVK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:21:10 -0400
Received: by mail-oi0-f53.google.com with SMTP id c192so2831139oih.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gzbkd9m6H2CuEeQf01RQ3SmrpbXby8ZaQuIGtPhjDI0=;
        b=x0QNvMMVGVuIDwNoQwCf44SVZUyuxjEF/5xJcfv6pXCdGCfR5UZAnz+xYsJbN3dQ+K
         Mwzz0+8yjP4UFEraWYEI2QcfzGoa/Y+b2cVbTwrsUNYzUSG9V3NDzcueR5mzvDnF0R3R
         9cVhtBpfgiDCkBTy+SEzw2xckY5FoA8msBPwlw6WZ8uSpUr58F33dCBArPuiAg4oy7eR
         vPbNSiRyVC/qeDVX94KLmF0usxBf+GSHb7MolqVuyG5gWklHLw9jYIcHyEN66/ld1uch
         Xdm9H1Z3f3QXvEKGmvqiW3Fehr7EiJ+v/9yPTAK+shYvFPdnSd4k5kZBeNszlNhPXkFA
         EGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gzbkd9m6H2CuEeQf01RQ3SmrpbXby8ZaQuIGtPhjDI0=;
        b=EpcozwszrpBWlsS3bJnGTE9U5Bm85bwgHGnCBeJm8RVljOTJXeG1U95yJYYq1BCKnb
         FPm+l2LJvqvPwsIYa0s/ktfD8Ig3xZrbXazWJWkOCQ+Kx6QnyrmFA2hy9Qp4nt6gpcZ1
         qv9EPyeqFOH0/7psrUAP5z584aIHn5OviAtgy9RjtmvE07uFtZKZN/tVfKOoPShsL2F1
         6WQG6uu081t6FUTLEX6bQ5u/8OaTSySk2dobS4NWqrQh/kGgwwWeBVq2AlPBHpoLMBp5
         GO5o+z1TyQxOjjFCXr2h1jcsPtMAqZS5hQHfcN8afWSHikrsZ8XHxRTbehYQME5LLovs
         oPEw==
X-Gm-Message-State: AE9vXwOpFRgZAUc1iEbSKYAFFG0em3xxenorMvZrMA4+nDSXNmzEZgg1k3JJp/cCXMt5OtmwrnFvDO/aVaWNcQ==
X-Received: by 10.157.5.169 with SMTP id 38mr6962332otd.104.1473452469926;
 Fri, 09 Sep 2016 13:21:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.226 with HTTP; Fri, 9 Sep 2016 13:20:29 -0700 (PDT)
In-Reply-To: <CAFO0PHdGppfgSSYW4YB-0LEsuohyzSCkrk48fovppNfDYZx78w@mail.gmail.com>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <ae804c55-d145-fc90-e1a9-6ebd6c60453a@gmail.com> <ccb678e4-d91a-1ef0-90e3-0a507ea0ee25@gmail.com>
 <CAFO0PHc48OmWNcRrh2Wu30L6Oarqyw+co+zNPpsPEWerCiqanw@mail.gmail.com> <CAFO0PHdGppfgSSYW4YB-0LEsuohyzSCkrk48fovppNfDYZx78w@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Fri, 9 Sep 2016 22:20:29 +0200
Message-ID: <CANQwDwem4HdiRiFY5a3M5_teRiPmf68ZsjPhXTiddh9MQ9i-0Q@mail.gmail.com>
Subject: Re: [RFCv3] Proposed questions for "Git User's Survey 2016", take three
To:     David Bainbridge <david.bainbridge@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello David,

On 7 September 2016 at 20:49, David Bainbridge
<david.bainbridge@gmail.com> wrote:
> Hi Jakub,
>
> I guess we could keep polishing this forever!
>
> Anyway, a couple of last comments from me:
> 1. Could you use the new Git logo instead of the +++/---- ? It would show
> some clear relationship with the Git community. The new logo has been in =
use
> for a few years now so I guess many people will recognise this.

Good idea. Done.

Though I say I like old logo one better...

> 2. If survs have dropdowns for countries and ages (integers) it might be
> worth using those instead of free text fields. Countries in particular
> should have a drop-down if available. It could probably avoid some
> post-survey correction.

Unfortunately Survs.com do not offer pre-made dropdowns for countries.
It offers a way to provide answers for a question by copy'n'paste of a plai=
n
text file, for example with list of countries.

Coming up with correct list of countries is not easy, as I wrote:

JN> Survs.com do not offer list of countries as a pre-defined drop-down
JN> list (select, with search), and it looks like it is not as easy as
JN> I thought (though I could push responsibility to Locale::Country ;-):
JN>
JN>   https://en.wikipedia.org/wiki/List_of_sovereign_states
JN>
JN> This question originally read "What country are you from?"
JN> which might be thought as country of birth... which may not
JN> exist any longer.

Though perhaps I make it harder that it really is:
$ perl -MLocale::Country -e 'print join "\n", all_country_names();'

> 3. The comment: Both question "3. Have you found Git easy to learn?" and =
"4.
> Have you found Git easy to use?" are about being it easy or hard in gener=
al;
> for mathematically inclined you can think about it as a weighted average.=
"
> Not sure that this adds anything useful to the survey and could be remove=
d,
> or at least needs correcting to mention the correct questions.

Fixed question numbers, removed unnecessary and not useful note about
"weighted average".

> OK, that's it from me!

Thanks!

Regards,
--=20
Jakub Nar=C4=99bski
