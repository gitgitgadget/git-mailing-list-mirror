From: "Dana How" <danahow@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 14:02:45 -0800
Message-ID: <56b7f5510711261402s35b77879xdcb2492ea14a1791@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com>
	 <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
	 <alpine.LFD.0.99999.0711261433210.9605@xanadu.home>
	 <56b7f5510711261217h56214321xb7acd9851b677dd6@mail.gmail.com>
	 <alpine.LFD.0.99999.0711261529080.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 23:03:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwm2p-0002GH-8m
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 23:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbXKZWCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 17:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbXKZWCt
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 17:02:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:60858 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbXKZWCs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 17:02:48 -0500
Received: by nf-out-0910.google.com with SMTP id g13so903023nfb
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 14:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4pTbyi+7vQ+gZEU9JnQycba9v9uaur7gY3DQfGgrCQ4=;
        b=vwNdjyujVY9wMMW46ukmOx8DtXH9UxdVk+F6qVNaML5I8NYHy1f+0ioX6FvcdjQfU1hvhqjC+0IoSpSs/2nMD7nrz+kQ4YKgVkw5f28vw6eo9Z4lIomOnSszeKUUpLcapL8GHXWzH+M3sWgw7LUHtcAliDv6vxrTqF0G1FVTPc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R7MJyFopj+IU5w6QJVQeB7VpuCgAl+IcM4pQGcMuH6NpH8DP5UHPbd+OVKttViGkVSJsuI80SR6bIXvX4g+lrW10Z1Gv6z+ChBdL90IKQQDWiHO6nY8w3his4u27Q0vb8Rw9EhWxcjlwL59JaB+NAkA1frRJpcxUVZUtPMdG330=
Received: by 10.78.166.7 with SMTP id o7mr3560564hue.1196114565320;
        Mon, 26 Nov 2007 14:02:45 -0800 (PST)
Received: by 10.78.177.20 with HTTP; Mon, 26 Nov 2007 14:02:45 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0711261529080.9605@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66138>

On Nov 26, 2007 12:55 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 26 Nov 2007, Dana How wrote:
> > On Nov 26, 2007 11:52 AM, Nicolas Pitre <nico@cam.org> wrote:
> > > On Mon, 26 Nov 2007, Dana How wrote:
> > > Then you can do just that for big enough blobs where "big enough" is
> > > configurable: encapsulate them in a pack instead of a loose object.
> > > Problem solved.  Sure you'll end up with a bunch of packs containing
> > > only one blob object, but given that those blobs are so large to be a
> > > problem in your work flow when written out as loose objects, then they
> > > certainly must be few enough not to cause an explosion in the number of
> > > packs.
> > Are you suggesting that "git add" create a new pack containing
> > one blob when the blob is big enough?
> Exactly.
I will think about your suggestion
(and the number of packs that might result),
but I confess I am surprised by it.

When I proposed automatically extracting large blobs from source
packs when creating a new pack under a blob size limit while
pack-objects was running,  you objected on the grounds that
pack-objects only creates packs and should not create blobs
(this proposal had other problems too,  but this is the one you didn't like).

Now it's OK for git-add to sometimes create packs instead of blobs?
I would not have predicted that!

;-)
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
