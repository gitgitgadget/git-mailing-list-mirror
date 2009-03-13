From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Generalised bisection
Date: Fri, 13 Mar 2009 12:49:41 +0000
Message-ID: <efe2b6d70903130549m63ae9bdeg1cd3f24a43b3e66f@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
	 <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Tapsell <johnflux@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Steven Tweed <orthochronous@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 13:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li6r4-0004tv-8y
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 13:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbZCMMtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 08:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbZCMMtp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 08:49:45 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:41348 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbZCMMto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 08:49:44 -0400
Received: by fxm24 with SMTP id 24so2632604fxm.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7b2GnJXwUJGAWzKLH74oEGtvtQNpQTRyGHgZUhmpQEs=;
        b=W1Xmci+pHgc74SPpCUnYlstJiA7DZH3/AUmyjANpu+UAdQSDDrfH1Bnyd1jerYbpFs
         y52GUVql98pW5I6S2DGjAE1NTFtJ7IR3SeoKP6zDU51pufSgpWNkKfMEanhZtr4dN8TU
         FXcvZhGAy3vDmsFUnNdB392cHksiTR1MeHGQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GuLVLv+o5SrUP38REnskFl8XLpv5tOZWxkId5OZNWDBp656X8+5OjRQUUFivLiueL+
         UMYx+XM2ay6otEQyxwELWif0gW3e9d4lp99+6el4+P3K04o83ovk5UDo6MkoyJrXWXea
         6Csg5ozLiTvP9h8obaz+ein7kxFRAfTMySrEU=
Received: by 10.204.52.2 with SMTP id f2mr390228bkg.90.1236948581389; Fri, 13 
	Mar 2009 05:49:41 -0700 (PDT)
In-Reply-To: <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113179>

On Thu, Mar 12, 2009 at 6:02 PM, Steven Tweed <orthochronous@gmail.com> wrote:

> I haven't even looked at the source code so a description of the
> mathematical algorithm would help, but I'll just point out that
> underflow (in the case of working with probabilities) and overflow
> (when working with their negated logarithms) is inherent in most
> multi-step Bayesian algorithms. The only solution is to rescale things
> as you go so that things stay in a "computable" range. (You're almost
> never interested in absolute probabilities anyway but rather relative
> probabilities or, in extreme cases, just the biggest probability, so
> rescaling isn't losing any useful information.)

Are you sure you aren't thinking of when you are using fixed point? I
was under the impression
that Bayesian algorithms usually worked okay in floating point.

One issue in BBChop which should be easy to fix, is that I use a dumb
way of calculating Beta functions. These
are ratios of factorials, so the subexpressions get stupidly big very
quickly. But I don't think that is the only problem.


Ealdwulf
