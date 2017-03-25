Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067A62095E
	for <e@80x24.org>; Sat, 25 Mar 2017 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdCYPkm convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 25 Mar 2017 11:40:42 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:26361 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbdCYPkl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 11:40:41 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 6293C20021B
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 16:40:39 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
Date:   Sat, 25 Mar 2017 16:40:39 +0100
Message-ID: <4046320.m2qk9b67WH@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <xmqqpoh9kx5q.fsf@gitster.mtv.corp.google.com>
References: <20170312200248.3610-1-jn.avila@free.fr> <5036581a-f989-2db6-06ba-621db05c6de1@free.fr> <xmqqpoh9kx5q.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mercredi 22 mars 2017 11:02:09 CET, vous avez écrit :
> Jean-Noël Avila <jn.avila@free.fr> writes:
> >> I am wondering if Documentation/po part should be a separate
> >> repository, with a dedicated i18n/l10n coordinator.  Would it make
> >> it easier for (1) those who write code and doc without knowing other
> >> languages, (2) those who update .pot and coordinate the l10n effort
> >> for the documentation and (3) those who translate them if we keep
> >> them in a single repository?
> > 
> > This is one of the points raised in the first RFC mail. Splitting this
> > part would help a lot manage the translations with their own workflow,
> > would not clutter the main repo with files not really needed for
> > packaging and would simplify dealing with the interaction with crowd
> > translation websites which can directly push translation content to a
> > git repo.
> 
> As I was in favor of splitting it out, I was trying to gauge what
> the downside of doing so would be, especially for those who are
> doing the translation work (it is obvious that it would help
> developers who are not translators, as nothing will change for them
> if we keep this new thing as a separate project).

There's one big downside of  this splitting. The gitman-l10n project would not 
be autonomous without the specific cloning at the particular place in the git 
project. po4a needs the original asciidoc files to perform the transclusion of 
the translated content into the structure of the documents. The setup that you 
are proposing would rule out simple CI checks and would make it complicated 
for the translators to set up their working copy and check the resulting man 
pages.

As I see it, there's the need for the Documentation folder to be contained in 
both project (while remaining the property of the git project). So I would 
think the other way around: for those interested in translated the 
documentation, some script would allow to checkout the git project inside the 
gitman-l10n project (like a kind of library).

This would be mainly transparent for the git developers.

> I'd prefer to start with the "optional gitman-l10n repository is
> checked out at Documentation/po only by convention" approach, before
> committing to bind it as a submodule.  Once we got comfortable with
> cooperating between these two projects, we do want to bind them
> using the submodule mechanism, but not before.

Obviously, my proposition would not allow to evolve towards such a setup, but 
is it really needed anyway ?

