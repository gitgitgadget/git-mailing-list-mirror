Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883B21F461
	for <e@80x24.org>; Tue, 27 Aug 2019 18:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfH0SwT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 14:52:19 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:43874 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfH0SwT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:52:19 -0400
Date:   Tue, 27 Aug 2019 18:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1566931936; bh=WQf5EGpU3sZjYrD5MvQtOlUvMMIzEpal2FYsgHp/jVk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=Eykmbilv0yN8cIWm2GBoEBOCEzNqK/rOFFHrh70pkg8aBpXoaAZ/Ey22GyP415wcr
         gxu+Hy9bcHM6rCEE0hifp94kueYK9TJcxfTgmzNyR4VOQz3BK/scqYtMhU2Yl0rVML
         hwHT7MDtGj/GAzPajzUNFHPjYCoUPlbawQIB0u7wJ9WG8KW1mzFEQjRq8F3gTeQnxx
         RLJN6eKcRZNoc2hpPRhSrrmtKOmmR4CWpxEZLz/O1pnGFOMWKpsqNzUgrNwL61i8JK
         sQXjMqxnqM92+yFYAm3fMQRiJC4vNj6d12qTfPdwv344d/DQFoHrTJoYrqBxGj43WN
         gHWh/roZ7HvYg==
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: Re: [PATCH 1/5] Signing API: Added documentation for the new signing interface
Message-ID: <4buvJvYppITFRis3i5T-P7sOf9Uwdm_dplQvZHfKPGWWy0kTU42vG844ksZBUvsA0rNWosfSyHLGp5pvcx_bNn9wFI9oiTddoke9N7LHNjc=@pm.me>
In-Reply-To: <20190826224646.GA11334@genre.crustytoothpaste.net>
References: <ypmMJFfJKsMOkTyunHZWwCKR1v7qaULVMMH7qlGMGN-l06V37iCnXvQLpzkr0N-1neSgCpZAtd1eKzbed2GAxvgMM15rOe-cGRsHzrglV8k=@pm.me>
 <20190826224646.GA11334@genre.crustytoothpaste.net>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thx for your feedback. I will incorporate the changes and re-submit the pat=
ches.


Ibrahim El

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, August 26, 2019 10:46 PM, brian m. carlson <sandals@crustytoothp=
aste.net> wrote:

> On 2019-08-26 at 19:57:53, Ibrahim El wrote:
>
> > From: Ibrahim El Rhezzali ibrahim.el@pm.me
> > 2f8f82549 Added documentation for the new signing interface
>
> This seems out of place. Also, your commit summary isn't in the
> imperative mood. See Documentation/SubmittingPatches for more details.
>
> > This contains a model document and updated Documentation detailing new =
interface and config aliases and their description
>
> You'll probably want to wrap your commit messages at 72 characters.
>
> > diff --git a/Documentation/config/signing.txt b/Documentation/config/si=
gning.txt
> > new file mode 100644
> > index 000000000..b6b8b8825
> > --- /dev/null
> > +++ b/Documentation/config/signing.txt
> > @@ -0,0 +1,63 @@
> > +signing.default::
> >
> > -   The default signing format to use when signing commits and tags.
> > -   The value must be one of: "openpgp", "x509", or "bettersign".
> > -   The default value is "openpgp".
> >     ++
> >     +The default executable to run for "openpgp" is "`gpg`", for "x509"=
 is
> >     +"`gpgsm`", and for "bettersign" is "`bs`".
> >     ++
> >     +The "bettersign" tool can be found here:
> >     +https://github.com/dhuseby/bs
> >
>
> I don't think we want to introduce the use of this tool. The repository
> contains three commits starting in May of this year. GnuPG's gpg and
> gpgsm tools have been around a long time and implement IETF-standardized
> protocols that are mature and have been well researched. This tool
> doesn't seem to meet that threshold.
>
> It should be fine to set up the API such that one could use it if they
> wanted to with appropriate configuration, but I don't think we want to
> add support for it by default.
>
> > diff --git a/Documentation/technical/signing-interface.png b/Documentat=
ion/technical/signing-interface.png
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1a44a7f665d4a546ac6f18f=
b10208547e6a5fced
> > GIT binary patch
> > literal 76116
>
> This doesn't appear to be used in this patch, and the commit message
> doesn't explain why it's included. I haven't looked at it, but if it's
> a chart of some sort, we usually prefer ASCII art for that purpose.
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------------------------------------
>
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


