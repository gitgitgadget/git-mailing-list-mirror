From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Wed, 27 Apr 2005 08:37:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504270833210.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu>
 <Pine.LNX.4.58.0504251339020.18901@ppc970.osdl.org>
 <pan.2005.04.27.03.36.51.65390@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 17:34:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQoWZ-0008RX-EF
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 17:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVD0PhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 11:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVD0PhV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 11:37:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:15814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261787AbVD0Pf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 11:35:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RFZfs4016301
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 08:35:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RFZeK4020425;
	Wed, 27 Apr 2005 08:35:41 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.04.27.03.36.51.65390@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Matthias Urlichs wrote:
>
> Hi, Linus Torvalds wrote:
> 
> > And if two different developers tag exactly the same object with exactly 
> > the same tag-name and exactly the same signature, then they get the same 
> > tag object, and that's fine. They should.
> 
> ... except that they can't. I mean, the signature is done by different
> people at different times, so it can't well be identical.

You'd quite possibly use some shared secret key for some work. For 
example, say you're a company, and any "release person" can sign the 
work..

Also, since you can tag things without signing anything at all, it's even 
more trivial to get the same tag that way.

Signing tags really makes sense when you want somebody _else_ to trust it. 
But unsigned tags are perfectly practical from a _private_ perspective: 
let's say that you just want to remember certain events but you don't need 
to tell anybody else about them - what you'd do is to just create your own 
local tag, and there's no real reason to sign it, since you'll never tell 
anybody else about it anyway.

(One such thing could be to create a tag every time you compile and
install a new kernel: your "tag" is just a way to remember what your
installed kernel was built against, and is meaningless to anybody else.  
In fact, you might well decide to just remove such tags periodically).

		Linus
