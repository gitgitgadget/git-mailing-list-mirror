From: "David Frech" <david@nimblemachines.com>
Subject: Re: test suite fails if sh != bash || tar != GNU tar
Date: Wed, 11 Jul 2007 14:57:00 -0700
Message-ID: <7154c5c60707111457o424cd1a3g192cecc2e00936a8@mail.gmail.com>
References: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com>
	 <Pine.LNX.4.64.0707110347580.4047@racer.site>
	 <alpine.LFD.0.999.0707102020020.3412@woody.linux-foundation.org>
	 <7154c5c60707102108g59280301pa5c3c0dc3911753d@mail.gmail.com>
	 <Pine.LNX.4.64.0707111209160.4516@racer.site>
	 <7v7ip64opa.fsf@assigned-by-dhcp.cox.net>
	 <7154c5c60707111433r64ae5109o314778655cbc017e@mail.gmail.com>
	 <7v7ip639cb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:57:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8kBI-0005q2-UH
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761088AbXGKV5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755906AbXGKV5E
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:57:04 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:48272 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbXGKV5C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:57:02 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1490424nze
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 14:57:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=oKcPFpeJMmOt1SYic8Omp+96hG3ujCsA8hVgm9IEFLIxusI2N36ByD1WfHLiEs7nSu4J5iGBPZDiO+cOeGIrEJ4lPsMvP7PaTlLyP5rBeD0Hu3uWwf6K3O6+Vp2J9zVi6l8W+LPnJXL6leOoLR/gG09U9Z1XtfmbpvKy2EE+Z2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=noXexEWZiBmujZDd89YVfzOXWqZPNSBcC2yLfeqQP53YWIi8UkMo9X2Xhv9Zuw+xTXNt49IxUTDuYzW8UPFH11y8UM5CqhHgUkrktyx09lkLWEjhx5UTQLOpcJBb43CQWpD8VGAmts5kCuQEdU3Igw2KFX9JuSPHkTaIt6pl+y4=
Received: by 10.114.179.1 with SMTP id b1mr5525022waf.1184191020399;
        Wed, 11 Jul 2007 14:57:00 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Wed, 11 Jul 2007 14:57:00 -0700 (PDT)
In-Reply-To: <7v7ip639cb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: be2204bc0a6882c3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52217>

On 7/11/07, Junio C Hamano <gitster@pobox.com> wrote:
> "David Frech" <david@nimblemachines.com> writes:
>
> > One issue is that my server is on dynamic IP, and my lame ISP (the
> > local telco) doesn't give me a proper SMTP relay - they want us to
> > send our mail via HTTP to MSN! Completely lame.
> >
> > So sending mail can be an issue, if the receiver blocks mail from dynamic IPs.
>
> I think I heard gmail has incoming SMTP for its subscribers, and
> I would not be surprised if other free e-mail providers have the
> same.  Perhaps you can use one of them for this purpose?

Yes, I have managed to relay thru gmail. It was a bit hard to set up -
build Postfix with SASL, sniff the traffic to figure out who signed
gmail's SSL cert (Thawte), download CA cert - but I know how to do it.
;-)

The downside is, the gmail relay rewrites the headers in annoying
ways, so I'm not using it in general. If necessary I could relay just
the "build breakage" thru them.

Actually my incoming nimblemachines.com mail gets sent from my dynamic
IP thru normal (non-AUTH, non-SSL) SMTP to gmail, and they accept it
fine. So if I can send the build results to a gmail account, there are
no problems. Hmm - and that account could forward to the git list...

- David

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
