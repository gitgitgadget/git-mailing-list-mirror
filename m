From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] diff --relative: output paths as relative to the
 current subdirectory
Date: Tue, 12 Feb 2008 16:09:18 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121604310.2920@woody.linux-foundation.org>
References: <7vzlu524n9.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802121531170.2920@woody.linux-foundation.org> <7vfxvx211k.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802121550570.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:12:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP5ET-0004oQ-Mu
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 01:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758232AbYBMALj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 19:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757620AbYBMALi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 19:11:38 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58767 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755260AbYBMALh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 19:11:37 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1D09Jaa018487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 16:09:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1D09IPH030212;
	Tue, 12 Feb 2008 16:09:19 -0800
In-Reply-To: <alpine.LFD.1.00.0802121550570.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.242 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73718>



On Tue, 12 Feb 2008, Linus Torvalds wrote:
> 
> No it isn't. The above doesn't even work for bare repositories, or when 
> you want to look at a branch that has a different directory structure than 
> the currently-checked-out one.

.. and I don't mean that as a theoretical thing. I don't personally use 
bare directories directly very much (I push to them, but I seldom do any 
other remote management than just repacking once in a while), but it _is_ 
a meaningful operation for various services like gitweb or gitk etc.

Obviously gitweb doesn't support that --relative thing right now, and 
maybe it never makes sense in that context, but it's actually really 
pleasant how many things *do* just "automatically work" with bare 
repositories etc.

So I simply don't think that we should assume a working directory for any 
basic git operation, unless that operation fundamentally needs one because 
it's only defined for a system with working directories (which is fairly 
rare, but obviously happens: "git reset --hard", "git pull/merge", "git 
checkout" etc).

			Linus
