From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Verify we know how to read a pack before trying to using
 it.
Date: Mon, 21 Aug 2006 11:51:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608211148120.3851@localhost.localdomain>
References: <20060821071002.GA26029@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 17:53:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFC4r-0002sP-4I
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 17:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWHUPv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 11:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWHUPv7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 11:51:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8668 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932072AbWHUPv7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 11:51:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4C00LSNUQJDR80@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Aug 2006 11:51:55 -0400 (EDT)
In-reply-to: <20060821071002.GA26029@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25800>

On Mon, 21 Aug 2006, Shawn Pearce wrote:

> If the pack format were to ever change or be extended in the future
> there is no assurance that just because the pack file lives in
> objects/pack and doesn't end in .idx that we can read and decompress
> its contents properly.
> 
> If we encounter what we think is a pack file and it isn't or we don't
> recognize its version then die and suggest to the user that they
> upgrade to a newer version of GIT which can handle that pack file.

There are already 3 other places where the pack header and version are 
validated: see git-grep pack_version_ok *.c output.  Maybe it would be 
best to abstract those tests all in one place.


Nicolas
