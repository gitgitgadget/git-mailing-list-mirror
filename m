From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] config_set_multivar(): disallow newlines in keys
Date: Mon, 22 Jan 2007 17:09:13 +0100
Message-ID: <81b0412b0701220809w1851cbfp5aa7e027ce79eed3@mail.gmail.com>
References: <200701150144.56793.jnareb@gmail.com>
	 <200701191310.32417.jnareb@gmail.com>
	 <Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <200701192344.11972.jnareb@gmail.com>
	 <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701200224180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701220706w65ed0657h1d69819e7879ed40@mail.gmail.com>
	 <Pine.LNX.4.63.0701221619110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701220733j1002bd9dse8db491512c7a500@mail.gmail.com>
	 <Pine.LNX.4.63.0701221643030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 17:10:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H91k2-00019Q-4g
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 17:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbXAVQJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 11:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbXAVQJQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 11:09:16 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:27380 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbXAVQJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 11:09:15 -0500
Received: by wr-out-0506.google.com with SMTP id i22so696409wra
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 08:09:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qt1HgfSYIGOpc2GyRMo4wsP+Zy6wBgz+WdMIUHb9B7otWN6jCrPmO/RI6UZL9zIiiLnKVHL9bxWF4x/iiNxdG3go2tugKBFQwKImYOVmvzxxUZGMUYpHKw3FsWaY0SZIvmiwxpyFM3lddU8sSnRLOUG2sN9Mkn2wZ/ZIq+71HUI=
Received: by 10.82.120.14 with SMTP id s14mr6964214buc.1169482153764;
        Mon, 22 Jan 2007 08:09:13 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 08:09:13 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701221643030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37422>

On 1/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > BTW IMHO we will probably never libify git; too many too complicated cases
> > > exist already.
> >
> > We probably don't need it libified completely. Just reading and writing of
> > the object database and tags/references and very simple revision walking
> > will be a very good start [...]
>
> ... and even these use xmalloc(), which die()s on out-of-memory. Note that
> it would be a really horrible work to libify that, since you basically
> have to insert gazillions of free() calls at the right point, which we
> don't have to, since exit() cleans up after us anyway.

Didn't say it'd be simple. Just not impossible.
