From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Mac OS X 10.5 does not require the OLD_ICONV flag set
Date: Fri, 2 Nov 2007 10:30:28 +0100
Organization: glandium.org
Message-ID: <20071102093028.GA29699@glandium.org>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com> <7v4pg55893.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Blake Ramsdell <blaker@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:32:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inst1-0001rM-NX
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbXKBJcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbXKBJcD
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:32:03 -0400
Received: from vawad.err.no ([85.19.200.177]:39222 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbXKBJcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:32:00 -0400
Received: from aputeaux-153-1-66-112.w81-249.abo.wanadoo.fr ([81.249.52.112] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1InssW-0006tu-Eh; Fri, 02 Nov 2007 10:31:51 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1InsrE-0007kQ-GQ; Fri, 02 Nov 2007 10:30:28 +0100
Content-Disposition: inline
In-Reply-To: <7v4pg55893.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63084>

On Fri, Nov 02, 2007 at 02:03:52AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Blake Ramsdell <blaker@gmail.com> writes:
> 
> > Signed-off-by: Blake Ramsdell <blaker@gmail.com>
> > ---
> >  Makefile |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 71479a2..5d83756 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -401,7 +401,9 @@ endif
> >  ifeq ($(uname_S),Darwin)
> >  	NEEDS_SSL_WITH_CRYPTO = YesPlease
> >  	NEEDS_LIBICONV = YesPlease
> > -	OLD_ICONV = UnfortunatelyYes
> > +	ifneq ($(uname_R),9.0.0)
> > +		OLD_ICONV = UnfortunatelyYes
> > +	endif
> >  	NO_STRLCPY = YesPlease
> >  	NO_MEMMEM = YesPlease
> >  endif
> 
> I do not have an access to a Darwin box, but do you mean 10.5
> gives 9.0.0 as uname_R?

Be it that or not, it looks wrong to me to check the Darwin version to
know what to use. Do you rely on the Linux kernel version to know whether
iconv is present ?

Mike
