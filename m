From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] avoid possible overflow in delta size filtering computation
Date: Tue, 24 Mar 2009 16:52:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903241652080.26337@xanadu.home>
References: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
 <IJd5MMCs9G_oJF_jS9hZAHkoKM0IvDNHuvHhhQ3MnKbPbSQlMYjOAg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Mar 24 21:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmDhc-0005gN-Pt
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 21:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbZCXUz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 16:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbZCXUzY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 16:55:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17301 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbZCXUzX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 16:55:23 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KH100I5C39HAY20@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Mar 2009 16:53:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <IJd5MMCs9G_oJF_jS9hZAHkoKM0IvDNHuvHhhQ3MnKbPbSQlMYjOAg@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114488>

On Tue, 24 Mar 2009, Brandon Casey wrote:

> Nicolas Pitre wrote:
> > On a 32-bit system, the maximum possible size for an object is less than 
> > 4GB, while 64-bit systems may cope with larger objects.  Due to this 
> > limitation, variables holding object sizes are using an unsigned long 
> > type (32 bits on 32-bit systems, or 64 bits on 64-bit systems).
> 
> FYI: except on windows 64-bit where long is still 32 bits AFAIK

Whatever. Same issue.


Nicolas
