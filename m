From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Set proxy override with http_init()
Date: Wed, 27 Feb 2008 14:59:38 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802271454390.19665@iabervon.org>
References: <20080227072012.GA23423@glandium.org> <1204097780-29581-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 21:01:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSSb-00024v-Ak
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 21:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759319AbYB0T7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759308AbYB0T7o
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:59:44 -0500
Received: from iabervon.org ([66.92.72.58]:43940 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759225AbYB0T7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:59:43 -0500
Received: (qmail 31120 invoked by uid 1000); 27 Feb 2008 19:59:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2008 19:59:38 -0000
In-Reply-To: <1204097780-29581-1-git-send-email-mh@glandium.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75297>

On Wed, 27 Feb 2008, Mike Hommey wrote:

> In transport.c, proxy setting (the one from the remote conf) was set through
> curl_easy_setopt() call, while http.c already does the same with the
> http.proxy setting. We now just use this infrastructure instead, and make
> http_init() now take the proxy url as argument.
> 
> At the same time, we make get_http_walker() take a proxy argument too, and
> pass it to http_init(), which makes remote defined proxy be used for more
> than get_refs_via_curl().

It's a good idea, but maybe http_init() (and the call chain leading up to 
it) should take the struct remote, so that it can get anything else you 
might also have there in the future? For that matter, is it intentional 
that http-push ignore the proxy setting, which is equally available in 
http-push, but not used? If so, it should probably get a comment.

	-Daniel
*This .sig left intentionally blank*
