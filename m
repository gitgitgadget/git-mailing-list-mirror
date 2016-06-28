Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500F31FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 08:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbcF1I1U (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 04:27:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50633 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077AbcF1I1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 04:27:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5S8QvJg012645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 10:26:57 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5S8QwZV015056;
	Tue, 28 Jun 2016 10:26:58 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Jeff King <peff@peff.net>
Cc:	gitster@pobox.com, git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 3/6] doc: typeset -- as litteral
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
	<20160627174623.11084-3-Matthieu.Moy@imag.fr>
	<20160627191005.GD9594@sigill.intra.peff.net>
Date:	Tue, 28 Jun 2016 10:26:58 +0200
In-Reply-To: <20160627191005.GD9594@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 27 Jun 2016 15:10:05 -0400")
Message-ID: <vpqa8i5zpkd.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 28 Jun 2016 10:26:57 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5S8QvJg012645
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467707221.8257@XAhv2urA5GNb7u5C8DI55g
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 27, 2016 at 07:46:20PM +0200, Matthieu Moy wrote:
>
>> Subject: Re: [PATCH 3/6] doc: typeset -- as litteral
>
> s/litteral/literal/
>
> I can hardly blame you, though. I think English stole the word from
> French and then switched its spelling. :)

I never remember about double consonent, and indeed the fact that French
and English have different spelling for the same words doesn't help
(addition Vs adition, traffic Vs trafic, ...) ;-).

Fixed in v2.

> You may also want put quotes around "--" to make it clear that you are
> talking about it as punctuation, not using it as such in your
> sentence.

Done.

> I read all the way through patch 6, and they all look good to me (though
> the "litteral" typo appears again later). I won't bother responding to
> each separately.

Should all be fixed now.

> I do notice that your patterns are finding existing items marked with
> single-quotes. We may have other cases lurking that are not quoted at
> all (but should be).

Yes, this series (and tr/doc-tt) clearly catch just the low-hanging
fruits. Having forward quotes in the existing text makes it clear that
the author wanted some kind of formatting, and hence make regex-based
replacement rather reliable (very few false positive).

Unquoted stuff are more problematic since you can have for example

  You should run `git foo --bar boz`

or multi-lines formatted code blocks, and a naive regex would match
--bar.

> I think those could be a separate series, but if anybody wants to look
> for them, I think searching for "\--" will help (a literal double-dash
> needs that to avoid becoming an emdash).

The rule seems to be more complex than this, for example "Implies
--porcelain" in https://git-scm.com/docs/git-blame is properly typeset,
although the source code has no escaping or quoting.

I'll keep these out of the series for now, I've added more ideas to

  https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#Fix_asciidoc_formatting_in_documentation

I may come back to this later.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
