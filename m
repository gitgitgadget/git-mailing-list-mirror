From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Wed, 20 Aug 2008 22:04:40 +0200
Message-ID: <20080820200440.GF16626@blimp.local>
References: <20080820185028.GA16626@blimp.local> <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVtwD-0004VH-0o
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbYHTUEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbYHTUEn
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:04:43 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:13646 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbYHTUEn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:04:43 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (klopstock mo29) (RZmta 16.47)
	with ESMTP id u0026ck7KG0gkt ; Wed, 20 Aug 2008 22:04:41 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id DD50C277AE;
	Wed, 20 Aug 2008 22:04:40 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id C6A0136D18; Wed, 20 Aug 2008 22:04:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93027>

Johannes Schindelin, Wed, Aug 20, 2008 21:52:23 +0200:
> On Wed, 20 Aug 2008, Alex Riesen wrote:
> > -		slash = strchr(argv[0], '/');
> > -		if (slash && !prefixcmp(argv[0], "refs/"))
> > -			slash = strchr(slash + 1, '/');
> > -		if (slash && !prefixcmp(argv[0], "remotes/"))
> > -			slash = strchr(slash + 1, '/');
> 
> Why is this not enough?  It strips refs/ if there is one, and remotes/ if 
> there is one (possibly after stripping refs/).  No?
> 

No. It strips refs/ OR remotes/ (because of prefixcmp with argv[0]).
And I still wanted refs/<namespace>/something...
