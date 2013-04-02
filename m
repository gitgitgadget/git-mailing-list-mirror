From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: git https transport and wrong password
Date: Tue, 2 Apr 2013 19:23:08 +0300
Message-ID: <20130402162308.GU30514@lakka.kapsi.fi>
References: <20130402155440.GT30514@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 18:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN3zo-0005fL-N3
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761127Ab3DBQXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:23:11 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:36849 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759587Ab3DBQXK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:23:10 -0400
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UN3zI-0006JF-GY; Tue, 02 Apr 2013 19:23:08 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UN3zI-0003cB-EN; Tue, 02 Apr 2013 19:23:08 +0300
Content-Disposition: inline
In-Reply-To: <20130402155440.GT30514@lakka.kapsi.fi>
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mikko.rapeli@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219789>

On Tue, Apr 02, 2013 at 06:54:40PM +0300, Mikko Rapeli wrote:
> I have client side logs with GIT_CURL_VERBOSE=1 but from intranet so can't
> publish them directly. Here's roughly what the log shows:

Maybe this is simpler summary:

$ grep "HTTP\/1.1" log.txt
> GET ...info/refs?service=git-upload-pack
< HTTP/1.1 401 Authorization required

password prompt here, and ctrl-c does not work in Cygwin, sigh.

> GET ...info/refs?service=git-upload-pack
< HTTP/1.1 401 Authorization required
> GET ...info/refs?service=git-upload-pack
< HTTP/1.1 302 Found

account locked I presume

> GET longredirecturl
> GET ...info/refs
> HTTP/1.1 302 Found
> GET longredirecturl

I was not able reproduce this issue using curl directly to get the info/refs
page.

-Mikko
