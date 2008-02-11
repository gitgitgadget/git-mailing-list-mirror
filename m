From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Sun, 10 Feb 2008 19:33:34 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802101929310.2732@xanadu.home>
References: <20080210175812.GB12162@auto.tuwien.ac.at>
 <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 01:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOMcr-000700-Ub
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 01:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbYBKAdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 19:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbYBKAdg
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 19:33:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24850 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbYBKAdf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 19:33:35 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW1004PRTJYIGF0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Feb 2008 19:33:34 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73442>

On Sun, 10 Feb 2008, Junio C Hamano wrote:

> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> 
> > This patch adds a cache to keep the object data in memory. The delta
> > resolving code must also search in the cache.
> 
> I have to wonder what the memory pressure in real-life usage
> will be like.

FWIW, I don't like this idea.

I'm struggling to find ways to improve performances of 
pack-objects/index-pack with those large repositories that are becoming 
more common (i.e. GCC, OOO, Mozilla, etc.)  Anything that increase 
memory usage isn't very welcome IMHO.


Nicolas
