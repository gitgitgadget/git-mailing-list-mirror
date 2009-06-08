From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 2/6] add a test for git-send-email for threaded mails without chain-reply-to
Date: Mon, 8 Jun 2009 07:47:17 +0200
Message-ID: <200906080747.18233.markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de> <1244410857-920-3-git-send-email-markus.heidelberg@web.de> <7v7hznaaji.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 07:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDXhc-00010k-UM
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 07:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbZFHFrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 01:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbZFHFrP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 01:47:15 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:35592 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZFHFrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 01:47:15 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 37629FF09999;
	Mon,  8 Jun 2009 07:47:17 +0200 (CEST)
Received: from [89.59.71.255] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDXhU-0002OZ-00; Mon, 08 Jun 2009 07:47:17 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7v7hznaaji.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19pbgweAELouMsN7GjKxCqQvMej8zmeEW4vpXic
	xxtPWqq/0xuTSwJ3ITNJj77CuHyMXNwVXsdVS9ue33BCpjDnho
	IDbe2OiL4f2r1Sb6JaxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121034>

Junio C Hamano, 08.06.2009:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > +test_expect_failure 'threading but no chain-reply-to' '
> > +	git send-email \
> > +		--dry-run \
> > +		--from="Example <nobody@example.com>" \
> > +		--to=nobody@example.com \
> > +		--thread \
> > +		--nochain-reply-to \
> > +		$patches $patches |
> > +	grep "In-Reply-To: "
> > +'
> 
> Thanks, but this is not a very good style, as it won't catch if "git
> send-email" dumps core or otherwise fails, exiting with a non-zero status.
> 
> Same comments applies to [PATCH 4/6] as well.

OK, this was my first attempt in writing a test and I just used the last
test 'in-reply-to but no threading' as template.

What can be done to make the test better?
