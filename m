From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] adding support for md5
Date: Fri, 18 Aug 2006 13:37:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608181330210.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
 <44E59BF6.2070909@sinister.cz> <Pine.LNX.4.63.0608181255060.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <44E5A416.9040709@sinister.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 13:38:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE2fv-0008Gy-Uy
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 13:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWHRLiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 07:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWHRLiD
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 07:38:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:40846 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030186AbWHRLiC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 07:38:02 -0400
Received: (qmail invoked by alias); 18 Aug 2006 11:38:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 18 Aug 2006 13:38:01 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Trekie <trekie@sinister.cz>
In-Reply-To: <44E5A416.9040709@sinister.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25652>

Hi,

On Fri, 18 Aug 2006, Trekie wrote:

> Johannes Schindelin wrote:
> > SHA1 has been broken (collisions have been found):
> > 
> > http://www.schneier.com/blog/archives/2005/02/sha1_broken.html
> 
> I don't think you're right. That blog just says, that Wang can find
> 
> "collisions in the the full SHA-1 in 2**69 hash operations, much less
> than the brute-force attack of 2**80 operations based on the hash length."

True. I have not heard of a collision either.

> The point is why use MD5 if anyone can compute a collision?

It does not suffice to generate collisions to make a hash unusable for our 
purposes: you would have to find a way to produce another text for a 
_given_ hash. Plus, this text would not only have to look meaningful, but 
compile. And preferrably introduce a back door.

Granted, once people find out how to generate another text, they can try 
to "optimize" some block between "/*" and "*/", so that the hash stays the 
same. But AFAICT none of the breaks of SHA1 or MD5 point into such a 
direction. Yet.

But _even if_ somebody succeeds in all that, that somebody has to convince 
_you_ to pull. And if you already have that object (the "good" version), 
it will not get overwritten.

Ciao,
Dscho
