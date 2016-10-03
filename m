Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257EB207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 12:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbcJCMn7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 08:43:59 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:60819 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751041AbcJCMn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 08:43:58 -0400
Received: (qmail 9089 invoked from network); 3 Oct 2016 12:43:56 -0000
Received: (qmail 2371 invoked from network); 3 Oct 2016 12:43:55 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <jnareb@gmail.com>; 3 Oct 2016 12:43:50 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1475498630.1776.17.camel@sapo.pt>
Subject: Re: [PATCH v2 02/11] i18n: add--interactive: mark simple here
 documents for translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Mon, 03 Oct 2016 12:43:50 +0000
In-Reply-To: <07371844-7fde-5b7f-b9e1-7db1a54fdbb5@gmail.com>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
         <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
         <xmqqmvivy4i9.fsf@gitster.mtv.corp.google.com>
         <1475159493.2435.7.camel@sapo.pt>
         <xmqqfuoihc1m.fsf@gitster.mtv.corp.google.com>
         <07371844-7fde-5b7f-b9e1-7db1a54fdbb5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Qui, 29-09-2016 às 23:27 +0200, Jakub Narębski escreveu:
> W dniu 29.09.2016 o 19:05, Junio C Hamano pisze:
> > 
> > Vasco Almeida <vascomalmeida@sapo.pt> writes:
> > 
> > > 
> > > On the other hand, would it make sense to translate these
> > > commands? If
> > > so, we would mark for translation the commands name of @cmd in
> > > main_loop().
> > > 
> > >  sub main_loop {
> > > -       my @cmd = ([ 'status', \&status_cmd, ],
> > > -                  [ 'update', \&update_cmd, ],
> > > -                  [ 'revert', \&revert_cmd, ],
> > > -                  [ 'add untracked', \&add_untracked_cmd, ],
> > > -                  [ 'patch', \&patch_update_cmd, ],
> > > -                  [ 'diff', \&diff_cmd, ],
> > > -                  [ 'quit', \&quit_cmd, ],
> > > -                  [ 'help', \&help_cmd, ],
> > > +       my @cmd = ([ __('status'), \&status_cmd, ],
> > > +                  [ __('update'), \&update_cmd, ],
> > > +                  [ __('revert'), \&revert_cmd, ],
> > > +                  [ __('add untracked'), \&add_untracked_cmd, ],
> > > +                  [ __('patch'), \&patch_update_cmd, ],
> > > +                  [ __('diff'), \&diff_cmd, ],
> > > +                  [ __('quit'), \&quit_cmd, ],
> > > +                  [ __('help'), \&help_cmd, ],
> > 
> > I don't know offhand.  If the code to prompt and accept the command
> > given by the user can take the translated word (or a prefix of it),
> > theoretically I would say it could be made to work, but to me it is
> > dubious the benefit outweighs its downsides.  It would make
> > teaching
> > Git and troubleshooting over the phone harder, I would guess.
> > 
> >  A: "Hi, I am in a 'git add -i' session."
> >  B: "Give 's' at the prompt."
> >  A: "My Git does not seem to take 's' as a valid command."
> >  B: "What? I've never seen that problem."
> >  ... back and forth wastes 10 minutes ...
> >  A: "By the way, I am running Git in Portuguese."
> 
> Also, for one-letter commands to work (there is setting where you
> don't even need to press enter, IIRC) all those translations would
> have to be chosen to begin with different letter, isn't it?

I choose not do mark those command names for translation in the next
re-roll since there is no obvious gain from it.
