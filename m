From: Junio C Hamano <junkio@cox.net>
Subject: Re: [preview] diff-helper rename detection.
Date: Wed, 18 May 2005 20:08:39 -0700
Message-ID: <7vk6lvnc94.fsf@assigned-by-dhcp.cox.net>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org>
	<7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org>
	<7vr7g4m0lz.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505181952260.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 05:09:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYbOG-0003jY-AI
	for gcvg-git@gmane.org; Thu, 19 May 2005 05:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVESDIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 23:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVESDIq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 23:08:46 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:15859 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262453AbVESDIm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 23:08:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519030839.LDJM23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 23:08:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505181952260.2322@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 18 May 2005 20:01:03 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I suspect that one tweak may be to try to find the "best" rename first,
LT> rather than look at files in the order they were discovered (ie you'd
LT> create a _matrix_ of the delta scores, rather than walk through the newly
LT> created files in order). That would then potentially allow for a more
LT> relaxed definitions of "rename", without any possibility of losing sight
LT> of a better rename due to finding a bad one first.

I thought about that but I opted for simplicity of first picking
the exact matches.  I was unsure about the usefulness of relaxed
matching to begin with.  But I now realize that to see how useful
that would be we need to experiment it and a matrix approach
would become necessity for that.

LT> So my only nit so far is that you declare "patch_delta()",
LT> even though you don't actually have it. Just remove it.

I'd rather keep that file as is for later merge with Nico.  It
came from the delitification patch and I tried to keep the new
files as they are.

