From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/6] sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
Date: Fri, 23 Aug 2013 14:54:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308231451030.14472@syhkavp.arg>
References: <20130822231215.GA16978@sigill.intra.peff.net>
 <20130822231404.GB17060@sigill.intra.peff.net>
 <xmqqob8opdey.fsf@gitster.dls.corp.google.com>
 <20130823182409.GA30130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 23 20:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCwV7-0000cQ-5N
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 20:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab3HWSyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 14:54:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44083 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102Ab3HWSyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 14:54:20 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MRZ007B3Z6JOOC0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 23 Aug 2013 14:54:20 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id BD0722DA0203; Fri, 23 Aug 2013 14:54:19 -0400 (EDT)
In-reply-to: <20130823182409.GA30130@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232823>

On Fri, 23 Aug 2013, Jeff King wrote:

> Making the deltas was considerably less elegant, since we cannot provoke
> pack-objects to pick arbitrary deltas (and it will not even try to delta
> tiny objects, anyway, which would bloat our samples). I ended up with
> the horrible patch below. We _could_ clean it up (error-checking? Who
> needs it?) and make it a debug-and-testing-only option for pack-objects,
> but I just didn't think the grossness was worth it. Still, it's probably
> worth documenting here on the list in case somebody else ever needs to
> add new samples to lib-pack.sh.

Maybe using test-delta (from test-delta.c) would have helped here?

In any case, if something needs to be permanently added into the code to 
help in the creation of test objects, I think test-delta.c is a far 
better place than pack-objects.c.


Nicolas
