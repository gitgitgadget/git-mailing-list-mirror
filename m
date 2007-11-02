From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Mac OS X 10.5 does not require the OLD_ICONV flag set
Date: Fri, 2 Nov 2007 21:19:31 +1100
Message-ID: <ee77f5c20711020319l26b4a8c1r99576dc29ea504d8@mail.gmail.com>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com>
	 <7v4pg55893.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Blake Ramsdell" <blaker@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:19:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Intd3-0004Lj-1t
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbXKBKTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbXKBKTd
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:19:33 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:18434 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbXKBKTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:19:32 -0400
Received: by rv-out-0910.google.com with SMTP id k20so764729rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CXIvl+9RFd0B/fDMkBbyWPACv3Lu4qax1EBkKbZ999U=;
        b=MRDSv3htQEfOGYhv5bb8ahdF0lRxEt78MxxmLOsTlTHfMN+PEl8Tq8rIH8AJpFmaMLGh4LJ3ew2CKRRc82rE4Dw3Nlz5BNzZffnhCnCEJxLDmBv87vmORQQQstUNaOfIf6sdKUND76IUcg3U0L3xOmEX4rQw+ZlofE2MHZ5Fy1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N+12i39NIniTbAoPYtR23RkBuSnrBVBVlpSTq9wBz39aygQnh1aVGmEDjBYpHTFHwrNBn7yWw2HiBVsKLN1yE7XImP5CgXC61LQVFfhY/mARXVLPBGZozWFcaVTLqeoKjU1LmnoK70jLLCFalTahgZgy9UJWZikmewVORAe/5RA=
Received: by 10.141.141.3 with SMTP id t3mr782890rvn.1193998771841;
        Fri, 02 Nov 2007 03:19:31 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Fri, 2 Nov 2007 03:19:31 -0700 (PDT)
In-Reply-To: <7v4pg55893.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63096>

On 11/2/07, Junio C Hamano <gitster@pobox.com> wrote:
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
> >       NEEDS_SSL_WITH_CRYPTO = YesPlease
> >       NEEDS_LIBICONV = YesPlease
> > -     OLD_ICONV = UnfortunatelyYes
> > +     ifneq ($(uname_R),9.0.0)
> > +             OLD_ICONV = UnfortunatelyYes
> > +     endif
> >       NO_STRLCPY = YesPlease
> >       NO_MEMMEM = YesPlease
> >  endif
>
> I do not have an access to a Darwin box, but do you mean 10.5
> gives 9.0.0 as uname_R?

Further, that comparison is going to fail as soon as the next revision
of Darwin (9.0.1, etc.) is released.


Dave.
