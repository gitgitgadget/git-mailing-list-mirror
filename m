From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] sequencer: Expose code that handles files in
 .git/sequencer
Date: Thu, 11 Aug 2011 01:22:36 -0500
Message-ID: <20110811062236.GA27394@elie.gateway.2wire.net>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-5-git-send-email-artagnon@gmail.com>
 <20110810152126.GE31315@elie.gateway.2wire.net>
 <CALkWK0nJUTtNgCHF6CE2-w+3ZwdBrscBRw0e0L8wX86Za0G=DA@mail.gmail.com>
 <20110810155332.GB4076@elie.gateway.2wire.net>
 <CALkWK0kxtyPABBUOrXtKDxPCBKt3CynoP4Fm8f_+C1ymkLTo-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 08:22:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrOfL-0004Rp-NB
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 08:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab1HKGWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 02:22:47 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53738 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1HKGWq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 02:22:46 -0400
Received: by iye16 with SMTP id 16so677139iye.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J9yEbYgnRDzu0yc2CFKlMYzeDni/WH6dq3PZ4er3UJI=;
        b=U8NKCPOWwS73NNJVeLPWumNmXWl0n0ZjX0iL2Ipea+Ow4NXW6rXAgERvP2SMezDvIu
         dmn8+vjngSUv6FQ3ZjNJfbjtWAsDPjO9Nv9JGFW3O3lr3ZVtNDzMOOssop452xzOShpq
         MqsC2p/E7jRyvXGdNOz7C+ypoZo31fta/FpR0=
Received: by 10.231.45.129 with SMTP id e1mr11879648ibf.22.1313043766006;
        Wed, 10 Aug 2011 23:22:46 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.ameritech.net [69.209.69.68])
        by mx.google.com with ESMTPS id t14sm1263999ibi.57.2011.08.10.23.22.44
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 23:22:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kxtyPABBUOrXtKDxPCBKt3CynoP4Fm8f_+C1ymkLTo-w@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179083>

Hi Ram,

Ramkumar Ramachandra wrote:

> Are you certain about pick_revisions?  I've copied over the function
> here for your reference.  My issue is that it's too specific
> cherry-pick/ revert:

I'm a very pragmatic person: as long as the code and history are
readable and behave reasonably well, I'm happy.

So in this particular case, why not expose pick_revisions, with some
name like revert_or_cherry_pick?  It would be readable and behave
reasonably well. :)  A theoretical other caller could save a fork
by calling revert_or_cherry_pick instead of forking a subprocess to
do the same.

[...]
> 2. You mentioned multiple entry points earlier, and that's something
> I've been meaning to do: In the long run

Sure, and that still seems like a good idea in the long run.

But as long as we are not closing doors, ideas about the long run
should not get in the way of getting work done today.

Hoping that is clearer.
Jonathan
