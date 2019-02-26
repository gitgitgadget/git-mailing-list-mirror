Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1019F20248
	for <e@80x24.org>; Tue, 26 Feb 2019 20:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfBZUir convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 26 Feb 2019 15:38:47 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:59851 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfBZUiq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 15:38:46 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 2324A2003CC;
        Tue, 26 Feb 2019 21:38:44 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] l10n: fr.po unfuzzy commented entries
Date:   Tue, 26 Feb 2019 21:38:43 +0100
Message-ID: <7020728.IPHcI6cZlJ@cayenne>
In-Reply-To: <871s3vwkvw.fsf@evledraar.gmail.com>
References: <874l8rwrh2.fsf@evledraar.gmail.com> <20190225211453.28300-1-jn.avila@free.fr> <871s3vwkvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, 25 February 2019 23:42:11 CET Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Feb 25 2019, Jean-Noël Avila wrote:
> 
> > The 0.14.4 gettext release was back in 2005, so presumably this is due
> > to some GPLv3 allergy of NetBSD's. The OS version itself is 7.1,
> > released a couple of years ago.
> 
> So this one pargaraph of commit message is just a paragraph from my
> E-Mail upthread, but out of context it's just confusing.
> 

Yes. More explanation.

> > -#, fuzzy
> > +#
> >  #~| msgid "git archive [<options>] <tree-ish> [<path>...]"
> >  #~ msgid "git diff --no-index [<options>] <path> <path>"
> >  #~ msgstr "git archive [<options>] <arbre ou apparenté> [<chemin>...]"
> 
> This still results in the same issue. Sorry, by "unfuzzying" I thought
> you meant change these translations so they'd no longer be commented out
> and would actually have a translation.
> 

The thing is that there isn't two msgid lines, the first one being the previous value.

> The problem is that there's two msgid lines, so e.g. this on top of
> yours "fixes" it:
> 
>      #
>     -#~| msgid "git archive [<options>] <tree-ish> [<path>...]"
>      #~ msgid "git diff --no-index [<options>] <path> <path>"
>      #~ msgstr "git archive [<options>] <arbre ou apparenté> [<chemin>...]"
> 
> But isn't a better fix on top of master just:
> 
>     sed -i '22477,$ d' po/fr.po
> 
> That results in 1500 lines removed from the end. I.e. what's the point
> of keeping those old now-unused translations around?

They can still be used as a translation memory for future approximate translations.

But, I guess it's safer to keep the translation memory out of this repo.

Will do.


