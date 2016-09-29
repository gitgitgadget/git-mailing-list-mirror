Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FEE7207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 14:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933389AbcI2Ob4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 10:31:56 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:39476 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753571AbcI2Obm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 10:31:42 -0400
Received: (qmail 19509 invoked from network); 29 Sep 2016 14:31:36 -0000
Received: (qmail 5837 invoked from network); 29 Sep 2016 14:31:36 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 29 Sep 2016 14:31:34 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1475159493.2435.7.camel@sapo.pt>
Subject: Re: [PATCH v2 02/11] i18n: add--interactive: mark simple here
 documents for translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Thu, 29 Sep 2016 14:31:33 +0000
In-Reply-To: <xmqqmvivy4i9.fsf@gitster.mtv.corp.google.com>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
         <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
         <xmqqmvivy4i9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Dom, 25-09-2016 às 15:54 -0700, Junio C Hamano escreveu:
> >  sub status_cmd {
> > @@ -1573,14 +1573,14 @@ sub quit_cmd {
> >  }
> >  
> >  sub help_cmd {
> > -     print colored $help_color, <<\EOF ;
> > -status        - show paths with changes
> > +     print colored $help_color, __(
> > +"status        - show paths with changes
> >  update        - add working tree state to the staged set of
> changes
> >  revert        - revert staged set of changes back to the HEAD
> version
> >  patch         - pick hunks and update selectively
> >  diff       - view diff between HEAD and index
> > -add untracked - add contents of untracked files to the staged set
> of changes
> > -EOF
> > +add untracked - add contents of untracked files to the staged set
> of changes"),
> > +"\n";
> >  }
> 
> Do we need TRANSLATORS: comment to all of the above not to touch the
> command words that are explained and translate only the explanation?

Yes, it is better to have that comment.

On the other hand, would it make sense to translate these commands? If
so, we would mark for translation the commands name of @cmd in
main_loop().

 sub main_loop {
-       my @cmd = ([ 'status', \&status_cmd, ],
-                  [ 'update', \&update_cmd, ],
-                  [ 'revert', \&revert_cmd, ],
-                  [ 'add untracked', \&add_untracked_cmd, ],
-                  [ 'patch', \&patch_update_cmd, ],
-                  [ 'diff', \&diff_cmd, ],
-                  [ 'quit', \&quit_cmd, ],
-                  [ 'help', \&help_cmd, ],
+       my @cmd = ([ __('status'), \&status_cmd, ],
+                  [ __('update'), \&update_cmd, ],
+                  [ __('revert'), \&revert_cmd, ],
+                  [ __('add untracked'), \&add_untracked_cmd, ],
+                  [ __('patch'), \&patch_update_cmd, ],
+                  [ __('diff'), \&diff_cmd, ],
+                  [ __('quit'), \&quit_cmd, ],
+                  [ __('help'), \&help_cmd, ],
