Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02327207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 13:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbcJCNV6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 09:21:58 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:53178 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751201AbcJCNV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 09:21:57 -0400
Received: (qmail 27181 invoked from network); 3 Oct 2016 13:21:54 -0000
Received: (qmail 32547 invoked from network); 3 Oct 2016 13:21:53 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <jnareb@gmail.com>; 3 Oct 2016 13:21:48 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1475500908.1776.27.camel@sapo.pt>
Subject: Re: [PATCH v2 02/11] i18n: add--interactive: mark simple here
 documents for translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Mon, 03 Oct 2016 13:21:48 +0000
In-Reply-To: <e71c5040-8fed-887b-bf35-af4ae28d469f@gmail.com>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
         <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
         <e71c5040-8fed-887b-bf35-af4ae28d469f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Sex, 30-09-2016 às 19:26 +0200, Jakub Narębski escreveu:
> W dniu 31.08.2016 o 14:31, Vasco Almeida pisze:
> > Mark messages in here document without interpolation for
> translation.
> > 
> > Marking for translation by removing here documents this way, rather
> than
> > take advantage of "print __ << EOF" way, makes other instances of
> help
> > messages in clean.c match the first two in this file.  Otherwise,
> > reusing here document would add a trailer newline to the message,
> making
> > them not match 100%, hence creating two entries in pot template for
> > translation rather than a single entry.
> 
> This is good catch, but I think it goes backwards with the solution.
> 
> If the text to be translated is multi-line, and it must end with
> newline,
> why is this final newline not included in the msgid?  This would
> involve
> turning printf_ln into printf, and adding trailing newline in final
> entry for builtin/clean.c:295, etc. - I think it is better solution
> than
> uglyifing git-add--interactive.perl
> 
> Though it is not much of uglifying thanks to Perl support for
> embedded
> newlines in double-quoted strings.

I will do this for the next re-roll. Thanks
