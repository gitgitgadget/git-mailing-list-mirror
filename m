From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Tags
Date: Tue, 5 Jul 2005 12:21:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507051155580.30848-100000@iabervon.org>
References: <m1vf3p2yks.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 18:40:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpqTD-000104-4v
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 18:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVGEQi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 12:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVGEQi5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 12:38:57 -0400
Received: from iabervon.org ([66.92.72.58]:52998 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261932AbVGEQXR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 12:23:17 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DpqAX-0008AF-00; Tue, 5 Jul 2005 12:21:09 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1vf3p2yks.fsf@ebiederm.dsl.xmission.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 5 Jul 2005, Eric W. Biederman wrote:

> Could you include the person who generated the tag and the time the
> tag was generated in the tag object?
> 
> For a tag like "latest" it would help quite a bit if you could actually
> find out which was the latest version of it :)

Actually, what you really want here is to put in refs/tags/latest the hash
of the tag whose "tag" field is v2.6.13-rc1 (or whatever it is). Having a
tag with the "tag" field of "latest" would be a bit silly, because the
object will probably stay in circulation long after it's no longer
true. And the object itself would tell you that it was the latest version
when it was created (but isn't every version?). That's why you want the
_tag_ to say something useful about the version (maybe "v2.6.12", maybe
just "tested"), and the _ref_ to tell you it's the latest.

The fact that lots of tags get refs named with their contents is just due
to tags only getting used for a small portion of their possible uses. This
only happens when the feature you'd look something up under is a feature
which is persistent.

	-Daniel
*This .sig left intentionally blank*
