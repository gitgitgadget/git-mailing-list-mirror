From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Support for large files on 32bit systems.
Date: Sat, 17 Feb 2007 08:32:06 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702170830280.31945@xanadu.home>
References: <20070217091310.GD21842@admingilde.org>
 <20070217093953.GE21842@admingilde.org> <20070217094959.GH27864@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 17 14:32:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIPfg-00067d-I1
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 14:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946731AbXBQNcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 08:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946728AbXBQNcI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 08:32:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20335 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946731AbXBQNcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 08:32:07 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDM00K7509IV8C0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 17 Feb 2007 08:32:06 -0500 (EST)
In-reply-to: <20070217094959.GH27864@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39986>

On Sat, 17 Feb 2007, Shawn O. Pearce wrote:

> Martin Waitz <tali@admingilde.org> wrote:
> > arg, this patch is completely broken.
> > I tested it by setting the macro via the command line and the
> > = is still left in there.  And __GLIBC__ is not yet defined at this
> > point.
> > 
> > However, we need to set _FILE_OFFSET_BITS for glibc somehow.
> > What is the best way to do so?
> 
> I think the only way to do with this is to have the Makefile detect
> if -D_FILE_OFFSET_BITS=64 is required to be added to CFLAGS based on
> some rule (e.g. uname output?), then add that to CFLAGS when needed.

Why not simply defining _FILE_OFFSET_BITS=64 unconditionally?

It certainly won't cause GIT to explode if compiled against something 
else than glibc.


Nicolas
