From: Mike Hommey <mh@glandium.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 07:37:14 +0100
Organization: glandium.org
Message-ID: <20080207063714.GB19561@glandium.org>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 07:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN0OC-00043B-NH
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 07:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbYBGGhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 01:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbYBGGhI
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 01:37:08 -0500
Received: from vuizook.err.no ([85.19.215.103]:36689 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbYBGGhH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 01:37:07 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JN0OS-0000AB-I3; Thu, 07 Feb 2008 07:38:02 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JN0Nm-0005QX-Gd; Thu, 07 Feb 2008 07:37:14 +0100
Content-Disposition: inline
In-Reply-To: <20080207042332.GA7632@sigill.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72900>

On Wed, Feb 06, 2008 at 11:23:33PM -0500, Jeff King wrote:
> On Wed, Feb 06, 2008 at 09:56:35PM +0000, Anand Kumria wrote:
> 
> > With GIT_SSL_NO_VERIFY defined, it fails with:
> > 
> > $ GIT_SSL_NO_VERIFY=1 ../git/git-fetch richard
> > error: gnutls_handshake() failed: ASN1 parser: Element was not found. (curl_result = 35, http_code = 0, sha1 = 510567ca41e201253445528ca6eb89ed43e71fce)
> > Getting pack list for https://server.example.com/~richard/newfoo.git
> > error: gnutls_handshake() failed: ASN1 parser: Element was not found.
> > Getting alternates list for https://server.example.com/~richard/newfoo.git
> > error: Unable to find 510567ca41e201253445528ca6eb89ed43e71fce under https://server.example.com/~richard/newfoo.git
> > Cannot obtain needed object 510567ca41e201253445528ca6eb89ed43e71fce
> > fatal: Fetch failed.
> 
> OK, I was finally able to reproduce your bug. It seems that it _only_
> happens when using curl built against gnutls. I built against the
> libcurl4-openssl-dev in Debian unstable, and the problem goes away.
> 
> Can you confirm that building using the openssl version of curl fixes
> the problem?
> 
> Googling for your error message turns up only one other instance: a bug
> in pidgin where the result was "this seems like a bug in gnutls." I hate
> to say "it's not our bug" without knowing exactly what is causing it,
> though. And it does seem odd that it works with 1.5.3.8. I wonder if
> there is some difference in the way we are calling curl that matters.

Nothing significant.

Mike
