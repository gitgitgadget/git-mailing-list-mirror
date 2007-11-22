From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Don't return 'undef' in case called in a vector context.
Date: Thu, 22 Nov 2007 13:17:47 -0800
Message-ID: <7vd4u23rpg.fsf@gitster.siamese.dyndns.org>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180109.34febc3f@paradox.zwell.net>
	<20071122045534.435f01bb@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 22:18:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvJRH-0005ka-Os
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 22:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbXKVVSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 16:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbXKVVSE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 16:18:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54441 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbXKVVSB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 16:18:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C54E22EF;
	Thu, 22 Nov 2007 16:18:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 24C1898A02;
	Thu, 22 Nov 2007 16:18:13 -0500 (EST)
In-Reply-To: <20071122045534.435f01bb@paradox.zwell.net> (Dan Zwell's message
	of "Thu, 22 Nov 2007 04:55:34 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65846>

Dan Zwell <dzwell@zwell.net> writes:

> diff --git a/perl/Git.pm b/perl/Git.pm
> index dca92c8..6603762 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -508,7 +508,7 @@ sub config {
>  		my $E = shift;
>  		if ($E->value() == 1) {
>  			# Key not found.
> -			return undef;
> +			return;
>  		} else {
>  			throw $E;
>  		}

Shouldn't the same fix made to config_bool as well?
