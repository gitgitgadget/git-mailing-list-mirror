Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B41220988
	for <e@80x24.org>; Thu, 20 Oct 2016 16:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755215AbcJTQVK (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:21:10 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:58194 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754883AbcJTQVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:21:09 -0400
Received: (qmail 883 invoked from network); 20 Oct 2016 16:21:07 -0000
Received: (qmail 28016 invoked from network); 20 Oct 2016 16:21:07 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 20 Oct 2016 16:21:02 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1476980461.14459.10.camel@sapo.pt>
Subject: Re: [PATCH v4 01/14] i18n: add--interactive: mark strings for
 translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Thu, 20 Oct 2016 16:21:01 +0000
In-Reply-To: <xmqqy41kkxzd.fsf@gitster.mtv.corp.google.com>
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
         <20161005172110.30801-1-vascomalmeida@sapo.pt>
         <20161010125449.7929-2-vascomalmeida@sapo.pt>
         <xmqqy41kkxzd.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Qua, 19-10-2016 às 11:14 -0700, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
> > 
> >  	} else {
> > -		print "No untracked files.\n";
> > +		print __("No untracked files.\n");
> >  	}
> 
> Not a big deal, but this makes me wonder if we want to do this
> instead
> 
> 		print __("No untracked files.") . "\n";
> 
> so that translators do not have to remember to keep the final LF.

This can be a good idea. On the other hand, I think translators are
cautious to not forget the final LF since there is a lot of them from C
source. Also I think msgfmt checks if English source and translation
both end with newline or not. So if a translator forgets to put a \n
then msgfmt would return an error. If it is not the translator to find
the error herself, someone else will, like the Translation coordinator.

I will leave this patch as is.

https://www.gnu.org/software/gettext/FAQ.html#newline
