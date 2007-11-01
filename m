From: Nicolas Pitre <nico@cam.org>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 22:27:46 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710312224380.21255@xanadu.home>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
 <20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru>
 <Pine.LNX.4.64.0710312111170.4362@racer.site>
 <7vhck7gdzs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 03:28:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InPmv-0007oT-Hf
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 03:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbXKAC1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 22:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbXKAC1s
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 22:27:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40167 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbXKAC1r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 22:27:47 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQT0088Q2UA9MI0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Oct 2007 22:27:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vhck7gdzs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62907>

On Wed, 31 Oct 2007, Junio C Hamano wrote:

> A rebase conflict resolution that results in emptiness is a
> rather rare event (especially because rebase drops upfront the
> identical changes from the set of commits to be replayed), but
> it does happen.  One could argue that "rebase --continue" can
> notice that the resolved index is identical to the tree of the
> HEAD commit and skip it automatically.
> 
> Given an index that is identical to HEAD, however, it is not
> easy to safely determine if that is because the patch did not
> apply at all, or the patch was applied with conflicts _and_ the
> user decided to make the patch a no-op by resolving.  The
> automatic droppage of the commit needs to happen only on the
> latter and never on the former.

Probably some additional clue could be displayed for the user benefit.  
This might solve the issue nicely.


Nicolas
