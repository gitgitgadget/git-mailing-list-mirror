From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Demo support for packs via HTTP
Date: Mon, 11 Jul 2005 21:54:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507112147400.30848-100000@iabervon.org>
References: <1121118544.3939.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jul 12 03:56:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsA0d-0003pa-2D
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 03:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVGLB4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 21:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGLB4Q
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 21:56:16 -0400
Received: from iabervon.org ([66.92.72.58]:44294 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261747AbVGLB4L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 21:56:11 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Ds9yC-0007oD-00; Mon, 11 Jul 2005 21:54:00 -0400
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1121118544.3939.6.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Jul 2005, Darrin Thompson wrote:

> On Sun, 2005-07-10 at 15:56 -0400, Daniel Barkalow wrote:
> > +	curl_easy_setopt(curl, CURLOPT_FILE, indexfile);
> > +	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
> > +	curl_easy_setopt(curl, CURLOPT_URL, url);
> 
> I was hoping to send in a patch which would turn on user auth and turn
> off ssl peer verification.
> 
> Your (preliminary obviously) patch puts curl handling in two places. Is
> there a place were I can safely start working on adding the needed
> setopts?

If I understand the curl documentation, you should be able to set options 
on the curl object when it has just been created, if those options aren't
going to change between requests. Note that I make requests from multiple
places, but I use the same curl object for all of them.

	-Daniel
*This .sig left intentionally blank*
