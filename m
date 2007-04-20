From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git clone problem through HTTP
Date: Fri, 20 Apr 2007 15:59:01 +0200
Message-ID: <81b0412b0704200659g7c5b4339i3915a592d0b7beac@mail.gmail.com>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
	 <Pine.LNX.4.64.0704201245330.10595@reaper.quantumfyre.co.uk>
	 <6d6a94c50704200638y7cd3c81aj3ff7f78863f4ab8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Aubrey Li" <aubreylee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 15:59:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hetdj-0005eM-DI
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 15:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992796AbXDTN7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 09:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992815AbXDTN7E
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 09:59:04 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:52515 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992796AbXDTN7B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 09:59:01 -0400
Received: by an-out-0708.google.com with SMTP id b33so939028ana
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 06:59:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iQSE6Lv0yaObW5f2VTfdj14gG2CEno7ZFMK1qThWMhYBdaytjDQ8OV9A7fI+JtcApdie+C3WPPpvlh4xYCaQ+71f+tNReBWfkQyQS29Qy70r4fZfmB0Tuo2OlFCquc21mPeRyGTTJGGXDJQRse0BCuonGVBjvBh9d0RyLOy9ZHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aA9NpwOPzxJDkFvMQgm1MnpSuChPK1OkSOu0dDhDJ+fsCnxIUfSmGYq8Ic8LHQrTOVqsvSPTr0NJupl5HzAUPXGe0LkcF6zBlmoNtXOLTp5xi6LH2TriqCjSQPYSmCVeUSeEWUD2k5hImuBaWnbAieR6rshnsRfwofDmKWhNWlA=
Received: by 10.100.5.17 with SMTP id 17mr1698211ane.1177077541107;
        Fri, 20 Apr 2007 06:59:01 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Fri, 20 Apr 2007 06:59:01 -0700 (PDT)
In-Reply-To: <6d6a94c50704200638y7cd3c81aj3ff7f78863f4ab8d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45106>

On 4/20/07, Aubrey Li <aubreylee@gmail.com> wrote:
> On 4/20/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> > On Fri, 20 Apr 2007, Aubrey Li wrote:
> >
> > > I'm behind of a firewall on which the git port is not permitted, so I
> > > can only use http protocol. Unfortunately, I can't clone linus' git
> > > tree at all.
> >
> > Linus packs his refs, which means that currently you can't clone using
> > http, with any version of git.
>
> I really don't understand why packed refs or not depend on the protocol.
> It doesn't make any sense.

It does. And the program you using is currently maintainerless.

> > Try http://repo.or.cz/r/linux-2.6.git/ instead?  This appears to be a
> > straight clone, but without packed refs.
>
> Does git support to update working copy to a different URL? for
> example, I clone the repo through GIT, and switch the working copy to
> HTTP, is it possible?

Yes. Just edit you remote to point somewhere else. Looks for
"remote" in .git/config or .git/remotes/origin.

> Or clone it from http://repo.or.cz/r/linux-2.6.git, and switch it to
> www.kernel.org?

Whatever, works anyway:

$ git clone --reference /home/auli/linux-2.6.git \
http://repo.or.cz/r/linux-2.6.git linux-2.6.or.cz
