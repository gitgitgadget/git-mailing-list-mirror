From: Nicolas Pitre <nico@cam.org>
Subject: Re: .git grows after git-gc?
Date: Tue, 24 Apr 2007 10:56:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704241051330.12375@xanadu.home>
References: <200704241431.33624.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704240939360.12375@xanadu.home>
 <200704241535.32623.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 16:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgMRt-0003lR-Os
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 16:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbXDXO4y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 10:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbXDXO4y
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 10:56:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9612 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbXDXO4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 10:56:54 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH00090XC6T9SW2@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Apr 2007 10:56:53 -0400 (EDT)
In-reply-to: <200704241535.32623.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45456>

On Tue, 24 Apr 2007, Andy Parkins wrote:

> > I think that (2) is the most probable cause of repack growth in your
> > case.  Just try:
> >
> > 	git config --global repack.usedeltabaseoffset true
> > 	git gc
> >
> > and you should get that 2MB back, possibly a bit more.
> 
> Strangely enough - I didn't - stayed at 97MB.  It's probably (1) then.

Well... to be sure, also try:

	git config --global repack.usedeltabaseoffset false
	git gc

and verify that the repository actually grew.  If it stays the same then 
something is not right.


Nicolas
