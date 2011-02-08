From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Tue, 08 Feb 2011 09:15:27 +0100
Message-ID: <201102080915.27484.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102070429.05033.johan@herland.net>
 <20110208010648.GA3132@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 09:15:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmijY-0006IM-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 09:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1BHIPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 03:15:31 -0500
Received: from smtp.getmail.no ([84.208.15.66]:64904 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab1BHIPa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 03:15:30 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGA006RTHLT0C50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Feb 2011 09:15:29 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id F05C51EF036F_D50FBA0B	for <git@vger.kernel.org>; Tue,
 08 Feb 2011 08:15:28 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 6DFB61EF035E_D50FBA0F	for <git@vger.kernel.org>; Tue,
 08 Feb 2011 08:15:28 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGA00A70HLSYA10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Feb 2011 09:15:28 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <20110208010648.GA3132@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166337>

On Tuesday 08 February 2011, Dmitry Potapov wrote:
> On Mon, Feb 07, 2011 at 04:29:04AM +0100, Johan Herland wrote:
> > > So, IMHO, the proper solution should be ability to specify the
> > > desired namespace for any remote repository, like this:
> > > 
> > > remote.<name>.tagNameSpace = foo
> > 
> > Interesting. I'm not sure what "foo" means in this context. Would I use
> > it
> > 
> > like this?:
> >     remote.origin.tagNameSpace = refs/tags
> 
> I was not sure about the specific when I wrote this, so I just put "foo",
> but it could be something like you wrote above.
> 
> > (to place origin's tags in refs/tags/*)
> > 
> > If so, what's the difference between this option, and using this?:
> >     remote.origin.fetch = refs/tags/*:refs/tags/*
> 
> I have not tried that, but I suspect that it will cause that all tags
> will be fetched even if they are not belong to tracked branches, i.e.
> "git fetch" will work as "git fetch -t". But maybe I am wrong here.

Ah, yes, I should have been more specific:

    remote.origin.fetch = ~refs/tags/*:refs/tags/*

In my proposal, I suggest using a "~" prefix to signal auto-following 
behavior. This is needed in order to be able to explicitly specify the 
current fetch behavior in the configuration.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
