From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-index-pack really does suck..
Date: Wed, 4 Apr 2007 11:51:50 +0200
Message-ID: <81b0412b0704040251j34b0bc5eh1518eadcfa2ed299@mail.gmail.com>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0704031836350.28181@xanadu.home>
	 <Pine.LNX.4.63.0704031532390.21680@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Chris Lee" <clee@kde.org>, "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "David Lang" <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 11:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ29i-0000mG-Dt
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 11:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992796AbXDDJvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 05:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992797AbXDDJvv
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 05:51:51 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:1858 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992796AbXDDJvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 05:51:50 -0400
Received: by an-out-0708.google.com with SMTP id b33so161446ana
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 02:51:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lxf/fWbFxEJVs4/Mc6n8pY/mm+0nKbWPCVg0CbHCwDcFm/VF042D/IBtGU8JQmFgTDQaniGlttd/XYYslDF2T72qNQoCCL9E/ASG8sZhC1un5Xdy2EyRfMTZP7CDOBi/AtglK/j5HkP2M4DJwt6h500TD/rAGK75Fa6/OFY8rew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZptmuxrwlZajjf/aHTZgeDNZZhZmqNHi6Jvh1T88f8GYzeqzniN+PxxUs6hHCurWbO0V8Av0QAhIyB9e/penKcIybrUVJK39q24VgaHmqyNaVbyMWYE20Ve/Dln+D7ExPm61gSfCcCLwgrso9HcndsEET+DnU6CIRjaC81ubCy4=
Received: by 10.100.168.13 with SMTP id q13mr292293ane.1175680310210;
        Wed, 04 Apr 2007 02:51:50 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Wed, 4 Apr 2007 02:51:50 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0704031532390.21680@qynat.qvtvafvgr.pbz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43725>

On 4/4/07, David Lang <david.lang@digitalinsight.com> wrote:
>
> > The keeping of fetched packs broke that presumption of trust towards
> > local objects and it opened a real path for potential future attacks.
> > Those attacks are still fairly theoretical of course.  But for how
> > _long_?  Do we want GIT to be considered backdoor prone in a couple
> > years from now just because we were obsessed by a 7% CPU overhead?
> >
> > I think we have much more to gain by playing it safe and being more
> > secure and paranoid than trying to squeeze some CPU cycles out of an
> > operation that is likely to ever be bounded by network speed for most
> > people.
>
> this is why -paranoid should be left on for network pulls, but having it on for
> the local uses means that the cost isn't hidden in the network limits isn't
> good.

You never know what pull is networked (or should I say: remote enough
to cause a collision).
