From: Chris Mason <mason@suse.com>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sun, 26 Jun 2005 17:03:16 -0400
Message-ID: <200506261703.16862.mason@suse.com>
References: <20050624.212009.92584730.davem@davemloft.net> <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org> <200506261652.59373.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Jun 26 22:57:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmeBU-0003cI-6b
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 22:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVFZVDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 17:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFZVDh
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 17:03:37 -0400
Received: from ns1.suse.de ([195.135.220.2]:3021 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261597AbVFZVDZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 17:03:25 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 2DACCE82F;
	Sun, 26 Jun 2005 23:03:23 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <200506261652.59373.mason@suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sunday 26 June 2005 16:52, Chris Mason wrote:
> >
> > 	git-rev-list --object end ^start > object-list
> >
> >  - Pack that list of objects into an "object pack":
> >
> > 	git-pack-objects out < object-list
>
> Without having read the code, the big thing that hurt performance in my
> early packed file work was compressing the whole packed file instead of
> individual sub-objects.  It takes more room to compress each object, but
> when I compressed the whole thing read performance was quite bad.

Sorry, fat fingered the send key...

The hard links were the biggest problem with my packed file patches, I think 
the dynamic lookup in a separate packed file index is the best way to go.

-chris
