From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Set proxy override with http_init()
Date: Wed, 27 Feb 2008 21:05:51 +0100
Organization: glandium.org
Message-ID: <20080227200551.GA6954@glandium.org>
References: <20080227072012.GA23423@glandium.org> <1204097780-29581-1-git-send-email-mh@glandium.org> <alpine.LNX.1.00.0802271454390.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 21:04:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSVE-0003Ge-9C
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 21:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402AbYB0UDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 15:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757468AbYB0UDF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 15:03:05 -0500
Received: from vuizook.err.no ([85.19.215.103]:40584 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756540AbYB0UDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 15:03:04 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JUSUQ-0003DL-OL; Wed, 27 Feb 2008 21:03:01 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JUSXH-0001pB-4s; Wed, 27 Feb 2008 21:05:51 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0802271454390.19665@iabervon.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75298>

On Wed, Feb 27, 2008 at 02:59:38PM -0500, Daniel Barkalow wrote:
> On Wed, 27 Feb 2008, Mike Hommey wrote:
> 
> > In transport.c, proxy setting (the one from the remote conf) was set through
> > curl_easy_setopt() call, while http.c already does the same with the
> > http.proxy setting. We now just use this infrastructure instead, and make
> > http_init() now take the proxy url as argument.
> > 
> > At the same time, we make get_http_walker() take a proxy argument too, and
> > pass it to http_init(), which makes remote defined proxy be used for more
> > than get_refs_via_curl().
> 
> It's a good idea, but maybe http_init() (and the call chain leading up to 
> it) should take the struct remote, so that it can get anything else you 
> might also have there in the future? For that matter, is it intentional 
> that http-push ignore the proxy setting, which is equally available in 
> http-push, but not used? If so, it should probably get a comment.

It is intentional, for the moment. I'll rework the patch to take the
struct remote, and add a comment.

Mike
