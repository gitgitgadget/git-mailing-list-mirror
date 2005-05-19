From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [preview] diff-helper rename detection.
Date: Wed, 18 May 2005 20:01:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505181952260.2322@ppc970.osdl.org>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org> <7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org> <7vr7g4m0lz.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 04:59:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYbG4-00035j-0C
	for gcvg-git@gmane.org; Thu, 19 May 2005 04:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVESC7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 22:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVESC7S
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 22:59:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:4324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262457AbVESC7O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 22:59:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4J2wxU3003011
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 May 2005 19:59:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4J2wwPh000385;
	Wed, 18 May 2005 19:58:58 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7g4m0lz.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 18 May 2005, Junio C Hamano wrote:
> 
> This is not yet a request for inclusion but is a preview
> requesting for testing and comments, especially from Linus (for
> general usability comments and suggestions for cut-off-points in
> heuristics) and Nico (in case I had blatantly misused the
> diff-delta interface).

I think this is great, although I also bet that we'll tweak the heuristics
later.

I suspect that one tweak may be to try to find the "best" rename first,
rather than look at files in the order they were discovered (ie you'd
create a _matrix_ of the delta scores, rather than walk through the newly
created files in order). That would then potentially allow for a more
relaxed definitions of "rename", without any possibility of losing sight
of a better rename due to finding a bad one first.

But I think the simple heurstic is probably fine as a first cut.

So my only nit so far is that you declare "patch_delta()", even though you
don't actually have it. Just remove it.

		Linus
