From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 17:01:25 -0400
Message-ID: <20080508210125.GC32762@sigill.intra.peff.net>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Thu May 08 23:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDFm-0002oc-TV
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760454AbYEHVBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbYEHVBZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:01:25 -0400
Received: from peff.net ([208.65.91.99]:4359 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963AbYEHVBY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:01:24 -0400
Received: (qmail 22990 invoked by uid 111); 8 May 2008 21:01:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 17:01:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 17:01:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81564>

On Thu, May 08, 2008 at 10:52:19PM +0200, Guido Ostkamp wrote:

>> And be assured that the objects referenced by a deleted branch will be  
>> removed from the repository eventually as long as 'git gc --prune' is  
>> run periodically.
>
> Ok. I did not know about the 'prune' option yet as it neither mentioned in 
> the "Git Tutorial" nor "Everyday Git", there only 'git gc' is used with no 
> options.

It is deprecated; see 25ee9731.

According to that commit message, prune is now a no-op. However, it
looks like it is still used for trigger a "repack -a" rather than
"repack -A". I don't know if it is worth making that behavior available
through some more sane command line option (I would think people who
really know that they want "repack -a" would just call it).

-Peff
