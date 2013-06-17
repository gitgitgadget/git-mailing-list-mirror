From: LCD 47 <lcd047@gmail.com>
Subject: Re: DNS issue when cloning over HTTP and HTTPS
Date: Tue, 18 Jun 2013 02:11:05 +0300
Message-ID: <20130617231105.GA24069@admin.romednet.com>
References: <20130617222356.GA22255@admin.romednet.com>
 <alpine.DEB.2.00.1306180038490.19414@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Jun 18 01:11:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoiZu-0002Ml-2S
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 01:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab3FQXLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 19:11:09 -0400
Received: from ns1.romednet.com ([86.120.198.50]:8019 "EHLO ns1.romednet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab3FQXLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 19:11:07 -0400
Received: from admin.romednet.com (unknown [95.76.45.66])
	by ns1.romednet.com (Postfix) with ESMTPS id 3bZ7T54yycz3hq2;
	Tue, 18 Jun 2013 02:11:05 +0300 (EEST)
Received: by admin.romednet.com (Postfix, from userid 1034)
	id 3bZ7T5701Hz3SfGD; Tue, 18 Jun 2013 02:11:05 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1306180038490.19414@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228122>

On 18 June 2013, Daniel Stenberg <daniel@haxx.se> wrote:
> On Tue, 18 Jun 2013, LCD 47 wrote:
> 
> >   Cloning with the git protocol works as expected.
> >
> >A search on the net shows people having the same problem more than an
> >year ago, and the solution there seems to imply that Git can't cope
> >with async DNS in curl:
> >
> >http://osdir.com/ml/freebsd-ports-bugs/2012-05/msg00095.html
> >
> >   Any idea?
> 
> It's not a git problem really. When you build libcurl to use c-ares
> for asynch name resolving you unfortunately don't get a really feature
> complete replacement for all stuff the stock synch resolver can do and
> I believe you (and person from that link from last year) experience
> that.
>
> The solution for you is to:
>
> a) rebuild libcurl with another resolving backend (there's a synch and
> threaded asynch one to choose from)
>
>  or
>
> b) fix c-ares to work "properly" in this scenario as well

    Thank you for the quick and very helpful response.  I rebuilt curl
with the threaded resolver, then I rebuilt Git, and now cloning over
HTTP works fine.  I'll send a bug report to the maintainers of curl and
Git for my Linux distribution then.

    /lcd
