From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: fatal: Out of memory, malloc failed
Date: Mon, 16 Apr 2007 11:21:15 +0200
Message-ID: <81b0412b0704160221o269fbd6al133a44148c75e38a@mail.gmail.com>
References: <461FBD02.6050105@eircom.net>
	 <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org>
	 <462277CD.5020609@eircom.net> <20070415214050.GA4417@steel.home>
	 <462329D8.4020302@eircom.net>
	 <81b0412b0704160100y35d0f86csd2196fb2864a7037@mail.gmail.com>
	 <46232FAC.4080506@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alan Larkin" <nobrow@eircom.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 11:21:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdNOq-0000tJ-5f
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 11:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbXDPJVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 05:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbXDPJVR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 05:21:17 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:6850 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbXDPJVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 05:21:16 -0400
Received: by an-out-0708.google.com with SMTP id b33so1660494ana
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 02:21:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dmGHJkAVbKh8mqiWkFmzIpsP/Ceu533bYq3IFXVdamsPRcMYkAMYnhykqijNrpjYwqMq4hcfqicwCEMMj/GRWZ9ziyZeFfqMvLFWzGrRidQSTrtxgYPxE1GeGXrbSmWb35Ntuhkc+Xo8OYjO1SvFaAaX0DpYDufdQ0Xe9vLKf/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PB/799eRHRlDoF8Fdm/M+uzH+DAOlVmWmYd27/6MQRYAAwt510X8jKdUPBrGRUPEe3XlZ8BePprV/FVBP0yGCpKltHVnZgFMCqLia8M2INmJvNfGzTpN5LVsbt4vNP4zOvpysgBFAoI3ADBapf1K3tQyAnZHBNEsmQZs3jQ4pKw=
Received: by 10.100.140.6 with SMTP id n6mr4315750and.1176715275795;
        Mon, 16 Apr 2007 02:21:15 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Mon, 16 Apr 2007 02:21:15 -0700 (PDT)
In-Reply-To: <46232FAC.4080506@eircom.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44637>

On 4/16/07, Alan Larkin <nobrow@eircom.net> wrote:
> >> > 72Mb is nothing. Is it Windows/cygwin, by any chance? (I see the
> >> > problem there sometimes. Tried debugging it, got into some ugly
> >> > cygwin-windows interactions, threw up, did the same you did and tried
> >> > to forget it all).
> >>
> >> Thats what I thought, but malloc continued to fail until the 72Mb file
> >> was removed.
> >>
> >> No, my server is running Debian. I had the push problem when logged in
> >> on that.
> >> It worked when I pushed it from a Gentoo box.
> >
> > Ok, now _that_ is interesting... Any limits on that server?
> > What git version?  There were some memory leaks fixed recently...
>
> Ah, perhaps youre on to something there. The version Im running on the server is
> 1.4.4.4 (from apt package manager), but on my own machine (from whence the push
> was successful) its 1.5.0.5. Still, youd expect the problem to have effected more
> people if its a leak or something in the older version.

That's how the leaks were found: people were affected and complained :)
But it also a bit of unusual repo you have: not many have objects more
the 10Mb in their sources. Anyway, give the new version a try. Maybe it
was fixed, or maybe we have a chance to improve the current version.
