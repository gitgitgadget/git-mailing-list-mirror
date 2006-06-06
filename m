From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: New release?
Date: Tue, 6 Jun 2006 09:46:18 -0700
Message-ID: <20060606164618.GC3938@reactrix.com>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org> <7vodx6zus2.fsf@assigned-by-dhcp.cox.net> <1149610759.27253.9.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 18:46:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnehd-0002jd-QM
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 18:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWFFQqr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 12:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWFFQqr
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 12:46:47 -0400
Received: from 241.37.26.69.virtela.net ([69.26.37.241]:56192 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750819AbWFFQqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 12:46:46 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k56GkIIb009746;
	Tue, 6 Jun 2006 09:46:18 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k56GkI2b009744;
	Tue, 6 Jun 2006 09:46:18 -0700
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1149610759.27253.9.camel@dv>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21388>

On Tue, Jun 06, 2006 at 12:19:19PM -0400, Pavel Roskin wrote:

> On Mon, 2006-06-05 at 23:02 -0700, Junio C Hamano wrote:
> >          - http-fetch fixes from Nick, which looked obviously correct.
> >            I would appreciate test reports from people who saw breakages
> >            on this one.
> 
> I'm still getting a segfault with the current git from the "next" branch:
> 
> $ git-clone http://www.denx.de/git/linux-2.6-denx.git
> ...
> got 4160b8334c53e0881cdc12c1f7d3d54fff883772
> got 5f57f29efee48d84e235a8ff75a35e7e354227a7
> got 681a9c73a2a321850404d4856f4738be47e17d15
> got 29b0ddaa324e417abf153460d7d94fb67823a6ef
> got 23e7a5c7d2c13d98524b69f54378d887e1962fc8
> /home/proski/bin/git-clone: line 29: 27271 Segmentation fault      git-http-fetch -v -a -w "$tname" "$name" "$1/"
> 
> It takes about an hour with my connection from running the command to
> the segfault.  It you have any idea how to speed it up, it would be very
> helpful.

I can't offer any suggestions wrt speeding it up, but I'll do what I can
to reproduce the problem here.

> If I comment out USE_CURL_MULTI, I get compile errors in http.c and
> http-push.c.

I just posted a fix for the compile errors.  As noted there, I've done
very little testing of the fetch/push binaries when built with
USE_CURL_MULTI commented out.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
