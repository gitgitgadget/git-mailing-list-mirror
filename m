From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 17:08:22 -0400
Message-ID: <200504191708.23536.mason@suse.com>
References: <200504191250.10286.mason@suse.com> <200504191412.00227.mason@suse.com> <Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 23:05:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNztV-00042s-1m
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 23:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVDSVIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 17:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVDSVIf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 17:08:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:15300 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261665AbVDSVI1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 17:08:27 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 57F531608B0E;
	Tue, 19 Apr 2005 23:08:26 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 19 April 2005 15:03, Linus Torvalds wrote:
> On Tue, 19 Apr 2005, Chris Mason wrote:
> > Very true, you can't replace quilt with git without ruining both of them.
> >  But it would be nice to take a quilt tree and turn it into a git tree
> > for merging purposes, or to make use of whatever visualization tools
> > might exist someday.
>
> Fair enough. The thing is, going from quilt->git really is a pretty "big
> decision", since it's the decision that says "I will now really commit all
> this quilt changes forever and ever".
>
> Which is also why I think it's actually ok to take a minute to do 100
> quilt patches. This is not something you do on a whim. It's something
> you'd better think about. It's turning a very fluid environment into a
> unchangable, final thing.
>

It's only final when someone pulls from you...for me, all the trees would be 
temporary.

[ ... subtree tree hashes in the index file ... ]

> I'll think about it. I'd love to speed up write-tree, and keeping track of
> it in the index is a nice little trick, but it's not quite high enough up
> on my worries for me to act on it right now.
>
> But if you want to try to see how nasty it would be to add tree index
> entries to the index file at "write-tree" time automatically, hey...
>

Makes sense, I'll let the merge development frenzy die down and give it a try 
one weekend.  I might look into making it a special case of the merging index 
changes, since some of the concepts seem similar.

Regardless, putting it into the index somehow should be fastest, I'll see what 
I can do.

-chris
