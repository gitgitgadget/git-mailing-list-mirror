From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer at any
 time
Date: Tue, 1 Dec 2009 19:18:49 +0100 (CET)
Message-ID: <alpine.DEB.2.00.0912011914270.30348@tvnag.unkk.fr>
References: <25718488.post@talk.nabble.com> <20091127234110.7b7e9993.rctay89@gmail.com> <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st> <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st> <20091201161428.GC21299@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Martin Storsj? <martin@martin.st>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 19:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFXSH-00067F-L3
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 19:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbZLAS1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 13:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbZLAS1y
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 13:27:54 -0500
Received: from giant.haxx.se ([83.168.254.42]:58058 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbZLAS1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 13:27:53 -0500
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2009 13:27:53 EST
Received: from giant.haxx.se (giant.haxx.se [83.168.254.42])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9) with ESMTP id nB1IInhZ028582;
	Tue, 1 Dec 2009 19:18:49 +0100
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20091201161428.GC21299@spearce.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134243>

On Tue, 1 Dec 2009, Shawn O. Pearce wrote:

> The #@!*@!* library should be able to generate two requests back-to-back to 
> the same URL without needing to rewind the 2nd request.

If '#@!*@!*' is your pattern for matching libcurl or curl, then sure libcurl 
certainly has no problem at all to send as many requests you like 
back-to-back.

The rewinding business is only really necessary for multipass authentication 
when Expect: 100-continue doesn't work (and thus libcurl has started to send 
data that the server will discard and thus is needed to get sent again). And 
that's not something you can blame "the #@!*@!* library" for, but rather your 
server end and/or how HTTP is defined to work.

-- 

  / daniel.haxx.se
