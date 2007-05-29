From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] builtin-pack-objects: don't fail,
 if delta is not possible
Date: Mon, 28 May 2007 22:45:16 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705282243280.11491@xanadu.home>
References: <11803872591522-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue May 29 04:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsriL-0000lb-Kz
	for gcvg-git@gmane.org; Tue, 29 May 2007 04:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbXE2Cp2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 22:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXE2Cp1
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 22:45:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54527 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbXE2Cp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 22:45:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIS00DIR7NG4R41@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 28 May 2007 22:45:18 -0400 (EDT)
In-reply-to: <11803872591522-git-send-email-mkoegler@auto.tuwien.ac.at>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48659>

On Mon, 28 May 2007, Martin Koegler wrote:

> If builtin-pack-objects runs out of memory while finding
> the best deltas, it bails out with an error.
> 
> If the delta index creation fails (because there is not enough memory),
> we can downgrade the error message to a warning and continue with the
> next object.

In the same vain, there is one realloc() that was turned into a 
xrealloc() in diff-delta.c.  I think this was a mistake and should 
probably be a non fatal realloc again to let the caller go on.


Nicolas
