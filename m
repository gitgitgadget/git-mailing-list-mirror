From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFC: adding xdelta compression to git
Date: Tue, 03 May 2005 00:12:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505030008070.14033@localhost.localdomain>
References: <200505030657.38309.alonz@nolaviz.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 06:06:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSog5-0003HE-P5
	for gcvg-git@gmane.org; Tue, 03 May 2005 06:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVECEM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVECEM3
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:12:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:4472 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261363AbVECEMY
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 00:12:24 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFW00MLOBONVK@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 May 2005 00:12:24 -0400 (EDT)
In-reply-to: <200505030657.38309.alonz@nolaviz.org>
X-X-Sender: nico@localhost.localdomain
To: Alon Ziv <alonz@nolaviz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2005, Alon Ziv wrote:

> Looking for novel methods of wasting my time :), I am considering adding 
> xdelta to git.
> 
> I have two concrete proposals, both of which (IMO) are consistent with the git 
> philosophy:
> 
> 1. Add a git-deltify command, which will take two trees and replace the second 
> tree's blobs with delta-blobs referring to the first tree. Each delta-blob is 
> self-contained; from the outside it looks like any other blob, but internally 
> it contains another blob reference + an xdelta. The only function which would 
> need to understand the new format would be unpack_sha1_file.
[....]

Guess what?

That's exactly what I did, except that I used libxdiff, stripped it to 
the bare minimum and even optimized it to be as efficient (i.e. fast) as 
possible given the git environment.

I'm finalizing the code right now.


Nicolas
