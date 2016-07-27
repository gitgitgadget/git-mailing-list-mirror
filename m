Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C377A203E2
	for <e@80x24.org>; Wed, 27 Jul 2016 10:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbcG0Kkq (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 06:40:46 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:55731 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752930AbcG0Kkq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 06:40:46 -0400
Received: (qmail 29662 invoked from network); 27 Jul 2016 10:40:39 -0000
Received: (qmail 31033 invoked from network); 27 Jul 2016 10:40:39 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 27 Jul 2016 10:40:36 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1469616036.1858.21.camel@sapo.pt>
Subject: Re: [PATCH v2] i18n: notes: mark comment for translation
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Date:	Wed, 27 Jul 2016 10:40:36 +0000
In-Reply-To: <xmqqvazs1g9o.fsf@gitster.mtv.corp.google.com>
References: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
	 <xmqqr3ah621l.fsf@gitster.mtv.corp.google.com>
	 <1469535363.1845.8.camel@sapo.pt>
	 <xmqqvazs1g9o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.4 (3.20.4-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A Ter, 26-07-2016 às 10:05 -0700, Junio C Hamano escreveu:
> In any case, I do not understand why you want to exclude the LFs
> from the message.

As Ævar Arnfjörð Bjarmason pointed out [1], it is to assure that a
translator does not break the output by mistake, by removing a LF.
I agree because I have seen a few mistakes about blanks in
translations. I do them myself. I think it is easy to do them if you
are translating a lot of strings, like if you were to start translating
Git to a new language right now. Thus I think it is a good idea to
assure that this kind of mistakes do not occur.

Although msgfmt can catch some mistakes, like source string and
translation must end both with \n, it does not catch all possible
mistakes. For example, I think it does not check a start \n, which is
relevant here. For that translator must use other quality assurance
tools. I know of translate toolkit [2] and msgcheck [3].

> If a translation for a particular language is
> very long and would not fit on a single line, the translator is
> allowed to make the message much longer, i.e. the translated version
> of the <message> part may contain one or more LFs (which is what the
> add-commented-lines function was invented for).  I'd think having
> LFs in the to-be-translated-original will serve as a good hint to
> signal translators that is the case.

When I am translating I always assume that it is fine do add or remove
some lines as needed, unless I'm told otherwise (by a comment for
translators, e.g.).

[1] http://www.mail-archive.com/git@vger.kernel.org/msg98793.html
[2] http://docs.translatehouse.org/projects/translate-toolkit/
[3] https://github.com/flashcode/msgcheck
