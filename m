From: Greg KH <greg@kroah.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 08:20:04 -0700
Message-ID: <20120312152004.GB9380@kroah.com>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye>
 <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu>
 <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Willy Tarreau <w@1wt.eu>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 16:20:24 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S772o-0008Le-SO
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 16:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab2CLPUK (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 11:20:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45739 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755906Ab2CLPUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 11:20:07 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 621712140F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Mar 2012 11:20:06 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 12 Mar 2012 11:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=ZP3/JqMWvN8Y/jK8VlI5xyTFVMI=; b=iXDEq5s1ud8N1Q/yKEB/KxPBd85i
	+Pni7w11bp6Wm8xJtKfHfR2Z0c1Z8saFJ1a6HuL0QRjLG+4SOUk6tD+Ad9vt6eee
	KiqDbOa2etfOXNJCfoPSCzoVMVtePscdQ351zagH4QA+SYX5nqaAOa+fkhiCGZ0L
	KoJwnaI4anZnl7s=
X-Sasl-enc: Y6jXSRQXU2Kyh+mhu1WjL8barKj8mt4URWeewBuzDTLq 1331565605
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E79BA8E00CC;
	Mon, 12 Mar 2012 11:20:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120312085820.GA11569@1wt.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192886>

On Mon, Mar 12, 2012 at 09:58:20AM +0100, Willy Tarreau wrote:
> Hi Jonathan,
> 
> On Mon, Mar 12, 2012 at 01:48:55AM -0500, Jonathan Nieder wrote:
> > > Indeed, and I've even changed my patch formats in haproxy to avoid brackets
> > > due to this issue. The cause is that many patches are sent with a [PATCH]
> > > prefix and that with Git, either you keep the subject line intact or you
> > > remove everything that is between brackets. There's the -b option to only
> > > remove remove tags looking like [PATCH], but my general experience with it
> > > was not satisfying (I don't remind why).
> > 
> > Maybe the problem was as simple as "git am" not knowing about "-b".
> 
> I think you're quite right.
> 
> > Two relevant patches:
> > 
> >   f7e5ea17 (am: learn passing -b to mailinfo, 2012-01-16)
> >   ee2d1cb4 (mailinfo: with -b, keep space after [foo], 2012-01-16)
> > 
> > are in "master" and 1.7.10-rc0 and were not part of any earlier release.
> >
> > Kudos to Thomas for writing them.
> 
> Ah, thank you very much for this useful info, I'll update my version !

I don't see a -b option to 'git am' in the manpage, am I missing
something here?

greg k-h
