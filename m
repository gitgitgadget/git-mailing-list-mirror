From: "David Frech" <david@nimblemachines.com>
Subject: Re: test suite fails if sh != bash || tar != GNU tar
Date: Wed, 11 Jul 2007 14:33:03 -0700
Message-ID: <7154c5c60707111433r64ae5109o314778655cbc017e@mail.gmail.com>
References: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com>
	 <Pine.LNX.4.64.0707110347580.4047@racer.site>
	 <alpine.LFD.0.999.0707102020020.3412@woody.linux-foundation.org>
	 <7154c5c60707102108g59280301pa5c3c0dc3911753d@mail.gmail.com>
	 <Pine.LNX.4.64.0707111209160.4516@racer.site>
	 <7v7ip64opa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:33:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jo6-0000br-AQ
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbXGKVdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbXGKVdF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:33:05 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:48225 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbXGKVdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:33:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2479112wah
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 14:33:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VLpR76VWryZ3gymVGPVKLz+GOE9Fpj9j1goPrINmY5HZHj3uqLR8GuCVhkto472sSTEp1YF9F/XV05dvfASWVSr4wSRc2gfQjwvyr5s2iN+IpnBlAIPyxiScZECqN1O+dWt59F26UR2sSlMLnPrw1UXaURHNSjyViFLGcNXWSiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=GFlDBnnyI/+N9SwwmoLqP6P43JGORAEx5W1U6OrTQLpykhLBZ7W4guoQiX89t2/xzxV9GymF6k2/j+ijAoa8U9mXbfIZB596f04AL88CcPAJL5hdDCRahIJVDjoyeoBDBJbXI38oY5zkeai4rNURwXQRDcFvWsELCCiM4ul7mZQ=
Received: by 10.115.107.1 with SMTP id j1mr5509576wam.1184189583392;
        Wed, 11 Jul 2007 14:33:03 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Wed, 11 Jul 2007 14:33:03 -0700 (PDT)
In-Reply-To: <7v7ip64opa.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: bd25535e08bfd9fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52212>

On 7/11/07, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> I'll see what I can do. As I'm planning on running git on both FreeBSD
> >> and DragonFly for the forseeable future, and plan to track git's
> >> evolution (running stable releases if not more bleeding-edge code), I
> >> can run the test suite every time I build a new git.
> >
> > If you want to, I can help you setting up a nightly cron job to fetch what
> > is the current "next", run the tests, and report failures by email.
>
> Wow.  Nightly builds of 'next' on various platforms would
> actually be quite useful, especially from non Linux and non bash
> world.

I found and fixed the shell issues. Once I've got a "fix" for tar I'll
send a patch. I think the BSD sh has a bug wrt to negating the return
code from a pipeline.

I'd be happy to do a nightly build on my DragonFly box, and that
should catch anything that also doesn't work for FreeBSD. The failure
modes were exactly the same - though the DFly box has an additional
iconv-related problem (with git-mailinfo) that I still haven't tracked
down...

Is there a canned script to get me started?

One issue is that my server is on dynamic IP, and my lame ISP (the
local telco) doesn't give me a proper SMTP relay - they want us to
send our mail via HTTP to MSN! Completely lame.

So sending mail can be an issue, if the receiver blocks mail from dynamic IPs.

- David

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
