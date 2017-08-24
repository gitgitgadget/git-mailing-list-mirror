Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4F9208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 09:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdHXJtJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 05:49:09 -0400
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:44688 "EHLO
        zm-mta-out-1.u-ga.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdHXJtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 05:49:07 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Aug 2017 05:49:06 EDT
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.58])
        by zm-mta-out-1.u-ga.fr (Postfix) with ESMTP id 8249AA0482;
        Thu, 24 Aug 2017 11:43:38 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps1.u-ga.fr [152.77.1.30])
        by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 27D7BE0097;
        Thu, 24 Aug 2017 11:43:41 +0200 (CEST)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 76BB1125EB4;
        Thu, 24 Aug 2017 11:43:39 +0200 (CEST)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: sequencer status
References: <8e25c42f-80f2-e0d4-38e4-b4fe9c8074e0@morey-chaisemartin.com>
        <CAP8UFD035niTUQTe73RSTE+3u6WX11UpxoqCSrfVP1Qs-fF0gg@mail.gmail.com>
Date:   Thu, 24 Aug 2017 11:43:39 +0200
In-Reply-To: <CAP8UFD035niTUQTe73RSTE+3u6WX11UpxoqCSrfVP1Qs-fF0gg@mail.gmail.com>
        (Christian Couder's message of "Wed, 23 Aug 2017 18:40:31 +0200")
Message-ID: <vpq4lsxl2r8.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (111)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> It is displaying the steps that have already been performed, right?
> I wonder if people might want more about the current step (but maybe
> that belongs to `git status`) or perhaps the not yet performed states
> (and maybe even a way to edit the todo list?)

Note that 'git status' is already doing this, but shows only 2 items of
each:

$ git status
interactive rebase in progress; onto 3772427
Last commands done (2 commands done):
   pick a48812c some commit title
   exec false
Next commands to do (2 remaining commands):
   pick 9d7835d some other commit
   pick c0e0fa8 one more subject
  (use "git rebase --edit-todo" to view and edit)
You are currently editing a commit while rebasing branch 'master' on '3772427'.
...

The idea was that 2 lines of context is often sufficient, and doesn't
eat too much screen space so it makes sense to show it by default.

I think it makes sense to have another command that shows the whole
sequence, but perhaps it could also be just an option for "git status".

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/
