From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 07:48:24 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807250742120.9968@xanadu.home>
References: <alpine.DEB.1.00.0807241821440.8986@racer>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_lLDMSvLBaoH53VDzayGwfg)"
Cc: spearce@spearce.org, git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 13:50:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMLnz-00031G-UI
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 13:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896AbYGYLsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 07:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbYGYLsb
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 07:48:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30150 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYGYLsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 07:48:30 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4K00HUV8SOXN00@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 Jul 2008 07:48:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0807241821440.8986@racer>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90036>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_lLDMSvLBaoH53VDzayGwfg)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Thu, 24 Jul 2008, Johannes Schindelin wrote:

> 
> From: Björn Steinbrink <B.Steinbrink@gmx.de>
> 
> When index-pack completes a thin pack it appends objects to the pack.  
> Since the commit 92392b4(index-pack: Honor core.deltaBaseCacheLimit when 
> resolving deltas) such an object can be pruned in case of memory
> pressure.
> 
> To be able to re-read the object later, a few more fields have to be set.
> 
> Noticed by Pierre Habouzit.
> 
> Hopefully-signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
> Hopefully-reviewed-and-signed-off-by: Nicolas Pitre <nico@cam.org>, 
> 
> --
> 
> 	This was probably missed in the flurry of patches, scratched 
> 	patches, and new patches.
> 
> 	Nico could you have a quick look?  (I would ask Shawn, but I know 
> 	that he is pretty busy with real world issues.)

sorry, I have intermitant connectivity this week, and I'll be off the 
net for two weeks after that.

Yes, this looks fine, although I'd add a comment mentioning that those 
extra fields are uninitialized in the thin pack case when objects are 
appended to the pack since they're already initialized otherwise.

ACK.


Nicolas

--Boundary_(ID_lLDMSvLBaoH53VDzayGwfg)--
