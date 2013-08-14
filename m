From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: duplicate objects in packfile
Date: Wed, 14 Aug 2013 14:54:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308141451200.14472@syhkavp.arg>
References: <20130814181718.GA7911@sigill.intra.peff.net>
 <7v4nast9bv.fsf@alter.siamese.dyndns.org>
 <7vvc38ruah.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 20:55:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9gDn-0008QX-FD
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 20:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955Ab3HNSyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 14:54:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52143 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944Ab3HNSyv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 14:54:51 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MRJ00KFHB7DUU50@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Aug 2013 14:54:49 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 97F1E2DA0203; Wed, 14 Aug 2013 14:54:49 -0400 (EDT)
In-reply-to: <7vvc38ruah.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232310>

On Wed, 14 Aug 2013, Junio C Hamano wrote:

> Also repacking may have a funny corner case. I do not recall the
> details as the above was a long time ago, but when I was tracking it
> down, a delta was made against one copy of the base object, and
> referred to it using delta-offset, while there was another copy of
> the base object which was found by the bisection search, and from
> there on, the inconsistencies between these two (they represent the
> same payload, but they are at different offsets in the same pack and
> with different in-pack sizes) led to some funky behaviour.

Crap.

Better try to cope with this (with a test case, etc.) rather than 
rejecting them now I'd say.  Strictly speaking, they're still valid pack 
files.


Nicolas
