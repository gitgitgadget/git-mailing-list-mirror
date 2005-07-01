From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Tags
Date: Fri, 1 Jul 2005 19:22:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507011907440.30848-100000@iabervon.org>
References: <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 01:17:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoUkp-0005VQ-SK
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 01:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbVGAXYU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 19:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVGAXYT
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 19:24:19 -0400
Received: from iabervon.org ([66.92.72.58]:8198 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261626AbVGAXYE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 19:24:04 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DoUpg-0001VC-00; Fri, 1 Jul 2005 19:22:04 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 1 Jul 2005, Eric W. Biederman wrote:

> Plus if you pull from a spoofed tag somewhere further along
> when you merge your code the merge will fail because what
> you thought was a common ancestor isn't.  And you will
> also likely get an error when you have the same tag
> coming from 2 different sources with different values.

Actually, I think it would be beneficial to support multiple tags with the
same name in any case: if people are going to use local private tags like
"broken", either we need to support having refs/tags/broken being a list
of hashes, or any particular user can only have one broken version.

I don't see any major problems with having refs/ files contain potentially
multiple hashes (limited by what makes sense to be multiple; i.e., heads/*
should have only one value), and this lets the users check the content of
the tag objects to figure out what they care about, and either specify
things in more detail or discard things they don't like (or, when
appropriate, use all values). The main issue I see is that rsync wouldn't
merge them usefully.

(And it would be useful to have a structure to support keeping a simple
piece of information about a set of objects.)

	-Daniel
*This .sig left intentionally blank*
