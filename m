From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] config_set_multivar(): disallow newlines in keys
Date: Tue, 23 Jan 2007 13:47:58 +0100
Message-ID: <81b0412b0701230447sb3cb3e6y125be4d4fa8952f2@mail.gmail.com>
References: <200701150144.56793.jnareb@gmail.com>
	 <200701192344.11972.jnareb@gmail.com>
	 <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701200224180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701220706w65ed0657h1d69819e7879ed40@mail.gmail.com>
	 <Pine.LNX.4.63.0701221619110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701220733j1002bd9dse8db491512c7a500@mail.gmail.com>
	 <Pine.LNX.4.63.0701221643030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701220809w1851cbfp5aa7e027ce79eed3@mail.gmail.com>
	 <Pine.LNX.4.63.0701231225450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 13:48:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9L4K-0005ha-IB
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 13:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXAWMsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 07:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbXAWMsF
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 07:48:05 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:24683 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbXAWMsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 07:48:04 -0500
Received: by wr-out-0506.google.com with SMTP id i22so959972wra
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 04:48:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qOXMITmOYiO1pfj3SaEIO7wKyIbCZXvEZMMByyaX8gAF2SMEVVeZInvVlLDNN0E7Tz0MCEfSI1JyI+iQclFFy0Vfd4nOTJiJQibrUH+Y75RGkxQN5jg3OyQBMvO1wHBP9707+YlETlscebkI5pYkLayFapHUWfVrGpsUfb2UVng=
Received: by 10.78.180.18 with SMTP id c18mr319071huf.1169556478665;
        Tue, 23 Jan 2007 04:47:58 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Tue, 23 Jan 2007 04:47:58 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701231225450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37506>

On 1/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > We probably don't need it libified completely. Just reading and writing of
> > > > the object database and tags/references and very simple revision walking
> > > > will be a very good start [...]
> > >
> > > ... and even these use xmalloc(), which die()s on out-of-memory. Note that
> > > it would be a really horrible work to libify that, since you basically
> > > have to insert gazillions of free() calls at the right point, which we
> > > don't have to, since exit() cleans up after us anyway.
> >
> > Didn't say it'd be simple. Just not impossible.
>
> I thought that was what you meant by "very simple revision walking".
>

that'd be "just a part of revision walking". Dunno what part yet,
because I still have to come up with convincing example of where
only a libgit could be used: just committers and history browsers
should not have any problems just using plumbing (no, stupid
microsoft's createprocess is not a reason enough).
