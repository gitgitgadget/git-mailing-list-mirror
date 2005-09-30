From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Fix gcc-4 warning in accept() call
Date: Fri, 30 Sep 2005 00:09:17 -0400
Message-ID: <20050930000917.rrwggw4g0gogs8w4@webmail.spamcop.net>
References: <200509292311.j8TNBZDm022135@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 06:10:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELCDM-0004TX-2d
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 06:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVI3EJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 00:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVI3EJT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 00:09:19 -0400
Received: from c62.cesmail.net ([216.154.195.54]:57004 "EHLO c62.cesmail.net")
	by vger.kernel.org with ESMTP id S1751419AbVI3EJS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 00:09:18 -0400
Received: from unknown (HELO gamma.cesmail.net) ([192.168.1.20])
  by c62.cesmail.net with SMTP; 30 Sep 2005 00:09:17 -0400
Received: (qmail 30794 invoked by uid 99); 30 Sep 2005 04:09:17 -0000
Received: from core-philly-4-112.dynamic-dialup.coretel.net
	(core-philly-4-112.dynamic-dialup.coretel.net [69.72.6.112]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Fri, 30 Sep 2005 00:09:17 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509292311.j8TNBZDm022135@inti.inf.utfsm.cl>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9534>

Quoting Horst von Brand <vonbrand@inf.utfsm.cl>:

> > +				unsigned int sslen = sizeof(ss);
>
> Shouldn't this be size_t?

No.  That would actually break things on big-endian 64-bit platforms.

You can see "info libc" for the whole story.  My (limited!) understanding is
that it should be 32-bit for compatibility reasons, so socklen_t was a trick to
fool size_t proponents from the POSIX committee :-)

--
Regards,
Pavel Roskin
