From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 4 Feb 2016 13:01:11 +0000
Message-ID: <20160204130111.GG29880@serenity.lan>
References: <cover.1454587284.git.johannes.schindelin@gmx.de>
 <20160204121437.GF29880@serenity.lan>
 <alpine.DEB.2.20.1602041334450.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elia Pinto <gitter.spiros@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 14:01:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRJXS-0006qK-D8
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 14:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbcBDNBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 08:01:30 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:41184 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965015AbcBDNB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 08:01:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6B5B7CDA5A8;
	Thu,  4 Feb 2016 13:01:29 +0000 (GMT)
X-Quarantine-ID: <AUgPPtGHFpGd>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AUgPPtGHFpGd; Thu,  4 Feb 2016 13:01:26 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 75B51CDA5A9;
	Thu,  4 Feb 2016 13:01:13 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1602041334450.2964@virtualbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285461>

On Thu, Feb 04, 2016 at 01:38:51PM +0100, Johannes Schindelin wrote:
> On Thu, 4 Feb 2016, John Keeping wrote:
> 
> > Using spaces around operators also matches our C coding style.
> 
> Well, by that reasoning you should go the whole nine yards and write
> 
> 	lineno = $(( $lineno + 1 ))
> 
> Except you can't. Because shell code is inherently not like C code.

That isn't my main argument, although I do think the (presumed)
rationale for using spaces in C to improve usability applies here as
well, even if the confines of the language don't let us go as far as in
C.

I'm not actually sure whether spaces inside the enclosing $(( and )) are
helpful, we're much less consistent about that than about spaces around
binary operators.  Having looked at t/ as well now, we really do seem to
favour using spaces around the binary operators so I'm further convinced
this series is switching the wrong cases.

> What I found particularly interesting about 180bad3 (rebase -i: respect
> core.commentchar, 2013-02-11) was that it *snuck in* that coding style: it
> *changed* the existing one (without rationale in the commit message, too).

The last version of that patch I can find in the archive [1] doesn't add
the spaces, so I think they must have been part of Junio's fixup
discusses in the following messages.  Although I don't think the
historic context is useful in deciding which direction to go in the
future.

[1] http://article.gmane.org/gmane.comp.version-control.git/216103
