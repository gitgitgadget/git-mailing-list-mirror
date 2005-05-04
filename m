From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Wed, 4 May 2005 18:34:18 -0400
Message-ID: <200505041834.19053.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <200505041156.19499.mason@suse.com> <DE5D04E8-B182-45B1-AB9A-6AA178005FFD@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 00:28:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTSLj-00089N-EP
	for gcvg-git@gmane.org; Thu, 05 May 2005 00:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVEDWed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 18:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEDWe0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 18:34:26 -0400
Received: from ns.suse.de ([195.135.220.2]:1710 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261917AbVEDWeX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 18:34:23 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 6A87B160F070;
	Thu,  5 May 2005 00:34:22 +0200 (CEST)
To: Geert Bosch <bosch@adacore.com>
User-Agent: KMail/1.8
In-Reply-To: <DE5D04E8-B182-45B1-AB9A-6AA178005FFD@adacore.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 04 May 2005 17:47, Geert Bosch wrote:
>  From your tests it would seem that the zdelta version is the only one
> to provide a uniform improvement over plain git. As it also seems the
> simplest approach, I wonder why the consensus is that using xdiff
> would be better?

zdelta seems to be a research project.  It does compress better than the xdiff 
lib, but the speed improvements against xdiff(1) are probably because the 
resulting tree is smaller.  I favor the xdiff code because it's so much 
smaller, and seems easier for us to maintain.

For performance, there's still quite a bit of tuning that can be done in terms 
of when and how we delta.

-chris
