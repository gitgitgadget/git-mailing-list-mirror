From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Thu, 7 Feb 2013 08:41:06 +0000
Message-ID: <20130207084106.GB1342@serenity.lan>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <7vwqup890o.fsf@alter.siamese.dyndns.org>
 <20130203203150.GU1342@serenity.lan>
 <7v8v7585sr.fsf@alter.siamese.dyndns.org>
 <20130203231549.GV1342@serenity.lan>
 <876224sqwk.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 09:41:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3N3F-0003qv-P4
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 09:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab3BGIlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 03:41:23 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:47069 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab3BGIlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 03:41:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5C0D96064D5;
	Thu,  7 Feb 2013 08:41:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yp53Nhah22CF; Thu,  7 Feb 2013 08:41:15 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 61E056064A7;
	Thu,  7 Feb 2013 08:41:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <876224sqwk.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215678>

On Thu, Feb 07, 2013 at 01:12:59PM +0900, Miles Bader wrote:
> John Keeping <john@keeping.me.uk> writes:
> > I generally like to get rid of the pointless warnings so that the useful
> > ones can't hide in the noise.  Perhaps "CFLAGS += -Wno-string-plus-int"
> > would be better for this particular warning, but when there's only one
> > bit of code that triggers it, tweaking that seemed simpler.
> 
> An even better approach would be to file a bug against clang ... it
> really is a very ill-considered warning -- PTR + OFFS is not just
> valid C, it's _idiomatic_ in C for getting interior pointers into
> arrays -- and such a warning should never be enabled by default, or by
> any standard warning options.

It doesn't warn of PTR + OFFS, only STRING_LITERAL + OFFS.  I agree that
it's not a particularly useful warning but it was clearly introduced
intentionally and appears to find real bugs [1] so I don't intend to
argue about it with the Clang developers.

[1] http://article.gmane.org/gmane.comp.compilers.clang.scm/47203


John
