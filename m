From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write
 failures
Date: Wed, 06 Feb 2008 15:07:48 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802061505390.2732@xanadu.home>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
 <47A9E4F9.8050100@nrlssc.navy.mil>
 <e1dab3980802061059m5bf9c291s892da586248e229c@mail.gmail.com>
 <47AA0D60.60504@nrlssc.navy.mil>
 <e1dab3980802061157r36dfa8b9uab49af013cb8e963@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	David Steven Tweed <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqZI-00024b-5o
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbYBFUH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbYBFUHz
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:07:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53687 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbYBFUHz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:07:55 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVU000UD2L0L4A1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Feb 2008 15:07:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e1dab3980802061157r36dfa8b9uab49af013cb8e963@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72839>

On Wed, 6 Feb 2008, David Tweed wrote:

> Given I'm the only person (AFAICS from the list archives) who's ever
> talked about failed temporary packs, I assume that almost everyone
> using git is using filesystems with sufficient space that they don't
> get write errors,

Note that doing ^C during a fetch will also leave a temporary pack file 
there.  So your patch is good even for people with plenty of disk space.

> so the path building will generally be done 0 times
> per --prune. (Using a USB disk that's almost full, along with
> occasionally filling up my /home with experiment output, is the
> occasions I get them.) So I don't think efficiency is an issue.

Clearly not a hot path indeed.


Nicolas
