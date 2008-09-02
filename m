From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 02 Sep 2008 23:39:20 +0200
Message-ID: <200809022339.20123.johan@herland.net>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
 <20080902210524.GB7757@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 23:41:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kadd4-0004gK-7V
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbYIBVkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbYIBVkc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:40:32 -0400
Received: from smtp.getmail.no ([84.208.20.33]:41519 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbYIBVkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:40:31 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K6L0074J8784300@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 02 Sep 2008 23:40:20 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6L0051385KT820@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 02 Sep 2008 23:39:20 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6L00J4885KIZF0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 02 Sep 2008 23:39:20 +0200 (CEST)
In-reply-to: <20080902210524.GB7757@leksak.fem-net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94719>

On Tuesday 02 September 2008, Stephan Beyer wrote:
> Junio C Hamano wrote:
> > Pieter de Bie <pdebie@ai.rug.nl> writes:
> > > Vienna:git pieter$ ./git commit --allow-empty -m"test"
> > > Created commit 6ce62c8b: test
> > > You are on a detached head, so this commit has not been recorded in a
> > > branch. If you don't want to lose this commit, checkout a branch and
> > > then run: git merge 6ce62c8bfcfb341106f3587d1c141c3955c2544c
> > >
> > > Are there any comments to this / strong opinions against such a
> > > change?
> >
> > Unconditionally doing this is too loud for my taste.  You probably can
> > do this in your post-commit hook.
>
> Well, Pieter probably can do this in his post-commit hook. But I think
> this is useful for usability... especially for beginners who might not
> even know what a hook is. ;)

I'm not sure I like this personally, but if we _really_ don't want newbies 
to shoot themselves in the foot, we could make "git commit" fail on a 
detached HEAD unless the user has indicated that s/he knows what's going 
on; i.e. something like this:

Vienna:git pieter$ ./git commit --allow-empty -m"test"
You are on a detached head, so this commit would not be recorded in a
branch. If you don't want to lose this commit, please switch to a (new) 
branch before committing. If you know what you're doing, and want to
proceed on a detached HEAD, please enable commit.detached in your 
configuration (git config --global commit.detached true)

...but I sympathize with those that think this is overkill.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
