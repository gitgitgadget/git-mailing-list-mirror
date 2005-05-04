From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Wed, 4 May 2005 18:43:52 -0400
Message-ID: <200505041843.53469.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <200505041344.51637.mason@suse.com> <Pine.LNX.4.58.0505041501220.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "C. Scott Ananian" <cscott@cscott.net>,
	Nicolas Pitre <nico@cam.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 00:38:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTSVM-0000sP-Ul
	for gcvg-git@gmane.org; Thu, 05 May 2005 00:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVEDWoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 18:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEDWoE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 18:44:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16557 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261940AbVEDWn5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 18:43:57 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E59CA9D75;
	Thu,  5 May 2005 00:43:56 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 8499414C829; Thu,  5 May 2005 00:43:56 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0505041501220.2328@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 04 May 2005 18:03, Linus Torvalds wrote:
> On Wed, 4 May 2005, Chris Mason wrote:
> > Yes, if Linus does take the patches, it's really important for people to
> > be able to easily continue without deltas/packing if they want.
>
> I'll happily take the patch and just not use the delta packing myself (at
> least until I trust it). But before I take the patch I want to make sure
> that people agree on it, and that it's been tested well enough that it
> won't cause people to corrupt their repositories.
>
> For example, I do _not_ want to be in the situation SVN is in, where if
> you corrupt your SVN database, you're totally screwed. There's a real
> advantage to not having fancy data structures or complicated consistency
> rules.

Fair enough ;)  I'm pretty flexible about most of the details, so I'm hoping 
it won't be hard to get a consensus.  The current code might be a little too 
simple in format (in the packed and delta headers), but so far it seems 
sufficient for git's needs.

The git-pack utility would probably be the best way to get other people to 
experiment and make suggestions, so I'll start there.

-chris
