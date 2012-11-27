From: Aaron Schrab <aaron@schrab.com>
Subject: Re: Possible vulnerability to SHA-1 collisions
Date: Tue, 27 Nov 2012 18:30:17 -0500
Message-ID: <20121127233016.GC3937@pug.qqx.org>
References: <50B0AB9C.2040802@caltech.edu>
 <CAJo=hJsZdduMdSbN+3Ei-7vx3_Q7tO88LywWj5Vw3Ngs0QgsZg@mail.gmail.com>
 <20121127230753.GA22730@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael Hirshleifer <111mth@caltech.edu>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:30:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUc1-0002B0-3I
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092Ab2K0XaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:30:20 -0500
Received: from pug.qqx.org ([50.116.43.67]:37409 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756023Ab2K0XaS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:30:18 -0500
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 880371D329; Tue, 27 Nov 2012 18:30:17 -0500 (EST)
Mail-Followup-To: Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Michael Hirshleifer <111mth@caltech.edu>, git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121127230753.GA22730@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210630>

At 18:07 -0500 27 Nov 2012, Jeff King <peff@peff.net> wrote:
>PS I also think the OP's "sockpuppet creates innocuous bugfix" above is
>   easier said than done. We do not have SHA-1 collisions yet, but if
>   the md5 attacks are any indication, the innocuous file will not be
>   completely clean; it will need to have some embedded binary goo that
>   is mutated randomly during the collision process (which is why the
>   md5 attacks were demonstrated with postscript files which _rendered_
>   to look good, but contained a chunk of random bytes in a spot ignored
>   by the postscript interpreter).

I don't think that really saves us though.  Many formats have parts of 
the file which will be ignored, such as comments in source code.  With 
the suggested type of attack, there isn't a requirement about which 
version of the file is modified.  So the attacker should be able to 
generate a version of a file with an innocuous change, get the SHA-1 for 
that, then add garbage comments to their malicious version of the file 
to try to get the same SHA-1.
