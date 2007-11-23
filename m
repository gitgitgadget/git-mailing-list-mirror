From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Fri, 23 Nov 2007 17:39:06 +0100
Message-ID: <8aa486160711230839o5db5fca1wc09a834ab3d4f053@mail.gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	 <8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com>
	 <7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>
	 <200711231018.49322.jnareb@gmail.com>
	 <7vejehux3y.fsf@gitster.siamese.dyndns.org>
	 <8aa486160711230213q6038037epe2cbd0240db8b612@mail.gmail.com>
	 <7vabp5uhke.fsf@gitster.siamese.dyndns.org>
	 <8aa486160711230734l30a3e907rac5aee11f3518e88@mail.gmail.com>
	 <7v63ztuevk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 17:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvbZG-0007vt-Es
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 17:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbXKWQjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 11:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbXKWQjJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 11:39:09 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:51928 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752352AbXKWQjI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 11:39:08 -0500
Received: by rn-out-0102.google.com with SMTP id s46so4323807rnb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rbZA7RfCGFVcDbM3IxBHjUGnOMAIG5veXw62CqqnQWE=;
        b=BjrH54sIGVqNS1wPWjuF5RtL7StRj6ihlOzoC6W+zYcdcrLKSuAPgvawdTYxKWIkjtGLirPeug6HNyBOVk9L6dJljDGbma2/13FnjL6VIGw7TA63BXu8a/ppnSbJTkzFfnGbL5aesCNLLHTxtcm5u4dOmPuUoUfyBHEEC0NyjNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hwvYLVLoV1KQRiQGr1J4mxza7jlYMayU+35YnkcjDIbBjqP7S4bZ1NpLxUSpz97QMKsiecp2yeuEn5dDGA+l7oRHwjvrWlHLe40D7crntVNPs0rdyNJI/dCHBFO6/Ke/+7iKuITqLrwiOFzBRInIL+E42PUf/R8jPA1kf53ZVOw=
Received: by 10.150.135.2 with SMTP id i2mr1949633ybd.1195835946939;
        Fri, 23 Nov 2007 08:39:06 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Fri, 23 Nov 2007 08:39:06 -0800 (PST)
In-Reply-To: <7v63ztuevk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65905>

On Nov 23, 2007 5:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> >> > OK. So git push will never understand bundles.
> >>
> >> Why not?
> >
> > Sorry, I misunderstood you, because pushing to an existing
> > bundle loses information, and that is also inconsistent with pushin=
g
> > to regular repositories.
>
> Maybe I am missing something from the discussion, but what
> information loss are you referring to?
>

Because you create an incremental bundle, so all the objects in the
old bundle will
not be in the new bundle. But it can be considered the natural
behavior of bundles.

But anyway, pushing to an existing bundle is not very convenient (at
leas for me) because it forces you to keep the bundles. I think the
most convenient way would be to have remote tracking branching to
record the bases for future bundles.

=46or now, I will do an script that behaves like the "git bundle push"
that I described and then I'll report the pro/cons that it has.

Thank you all for the discussion, it was very fruitful.

Santi

P.D.: Am I the only one doing a bundle-only transport mode? If not,
can you comment on the different suggestions that have been said.
Thanks a lot.
