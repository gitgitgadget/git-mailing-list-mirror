Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F1C55178
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 21:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C8B20829
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 21:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374673AbgJ0V4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 17:56:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45030 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S374670AbgJ0V4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 17:56:46 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09RLucQV025303
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 17:56:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A90BE420107; Tue, 27 Oct 2020 17:56:38 -0400 (EDT)
Date:   Tue, 27 Oct 2020 17:56:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Filipp Bakanov <filipp@bakanov.su>, git@vger.kernel.org
Subject: Re: Proposal: "unadd" command / alias.
Message-ID: <20201027215638.GI5691@mit.edu>
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
 <xmqqblgnbea5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqblgnbea5.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 01:32:50PM -0700, Junio C Hamano wrote:
> Filipp Bakanov <filipp@bakanov.su> writes:
> 
> > Hi! I suggest to add "unadd" command, that will undo a git add command.
> >
> > git unadd path/to/file
> >
> > It will be an alias to:
> >
> > git reset HEAD -- path/to/file
> >
> > The motivation is that I always forget syntax and have to google each
> > time I want to undo accidentally added files. Unadd is just much
> > easier to remember and quite obvious.
> 
> The alias is for you to do the above, I think.

Filipp,

Indeed, I have a similar alias in my ~/.gitconfig

[alias]
	revert-file = checkout HEAD --

Adding

[alias]
	unadd = reset HEAD --

to your .gitconfig would do what you want.  As a BTW, my favorite
alias is:

   lgt = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit

Sample usage: "git lgt origin.." or "git lgt -10".

Cheers,

					- Ted
