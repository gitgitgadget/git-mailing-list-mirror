From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 6/7] pack-objects: allow for early delta deflating
Date: Fri, 02 May 2008 19:03:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805021853410.23581@xanadu.home>
References: <1209755511-7840-1-git-send-email-nico@cam.org>
 <1209755511-7840-2-git-send-email-nico@cam.org>
 <1209755511-7840-3-git-send-email-nico@cam.org>
 <1209755511-7840-4-git-send-email-nico@cam.org>
 <1209755511-7840-5-git-send-email-nico@cam.org>
 <1209755511-7840-6-git-send-email-nico@cam.org>
 <1209755511-7840-7-git-send-email-nico@cam.org> <481B9963.6050605@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 01:04:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js4Iy-0003k3-KA
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 01:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937048AbYEBXDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 19:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935309AbYEBXDd
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 19:03:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33004 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933756AbYEBXDb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 19:03:31 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0900BEWK1UU210@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 May 2008 19:03:30 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <481B9963.6050605@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81043>

On Fri, 2 May 2008, A Large Angry SCM wrote:

> Although I like the idea of changing the behavior if the output is likely to
> be throttled, I do not like the test for that condition being "is it going to
> stdout". This is something better suited to a command line argument.

This is a common assumptions for stdio to go over the network, and other 
behaviors are already adjusted accordingly.  And not only in 
pack-objects but in index-pack too.  So unless you have a really 
compelling reason to override this, I don't think it is worth having 
another command line argument just for the sake of it.


Nicolas
