Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8DE20984
	for <e@80x24.org>; Tue, 13 Sep 2016 20:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759809AbcIMUXP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 13 Sep 2016 16:23:15 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:49979 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754740AbcIMUXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 16:23:14 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 48B3EB004D9;
        Tue, 13 Sep 2016 22:23:08 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/14] i18n: notes: mark error messages for translation
Date:   Tue, 13 Sep 2016 22:23:07 +0200
Message-ID: <2523910.zLOPm9a3mF@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.6.0-1-amd64; KDE/5.25.0; x86_64; ; )
In-Reply-To: <1473784505.7329.18.camel@sapo.pt>
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt> <83f72924-9a9d-dc1c-109f-341f0cd7ac96@free.fr> <1473784505.7329.18.camel@sapo.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On mardi 13 septembre 2016 16:35:05 CEST Vasco Almeida wrote:
> A Seg, 12-09-2016 às 14:23 +0200, Jean-Noël Avila escreveu:
> > Not sure this one will be easy to localize. The verb is passed as a
> > parameter : see line 366 "list", line 426 "add", line 517 "copy",
> > line
> > 658 "show", line 816 "merge", line 908 "remove" or line 595 with
> > argv[0].
> > 
> > If all the verbs are real subcommands, then the translators should be
> > warned that this is some english twisting, but that they need to
> > refer
> > to the subcommand on the command line.
> 
> Yes, these verbs are git notes subcommands. I will add a Translators
> comment to it explaining so. Or we can unfold that error messages like
> 
> if (!strcmp(subcommand, "add")
> 	die(_("Refusing to add notes in %s (outside of refs/notes/)"),
> ref);
> elseif ...
> 
> else
> 	die(_("Refusing to %s notes in %s (outside of refs/notes/)"),
> subcommand, ref);

This would be counter productive to use the inject strings as keys just to 
test them just after.

> 
> This is more verbose but translations would benefit from it being more
> natural. What do we prefer: (1) concise source and a little unnatural
> translations or (2) verbose code and natural translations?
> 
> Compare, imaging that English is a target translation language, the
> user would read:
> "Refusing to do add of notes in /path [...]" (1)
> "Refusing do add notes in /path [...]" (2)

Having one sentence per action is cumbersome, but avoiding sentence lego is 
mandatory for proper i18n. How about  just adding quotes around the subcommand 
and warn translators ? 




