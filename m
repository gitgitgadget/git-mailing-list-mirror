From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 2/2] Run garbage collection with loose object pruning
	after svn dcommit
Date: Fri, 5 Oct 2007 18:49:12 +0200
Message-ID: <20071005164912.GE4797@xp.machine.xx>
References: <20071005001528.GA13029@midwinter.com> <20071005082110.GA4797@xp.machine.xx> <47066255.6080500@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:49:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdqMh-0007DJ-M4
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbXJEQtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbXJEQtQ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:49:16 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:38740 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754215AbXJEQtP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 12:49:15 -0400
Received: (qmail 26249 invoked by uid 0); 5 Oct 2007 16:49:11 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 5 Oct 2007 16:49:11 -0000
Content-Disposition: inline
In-Reply-To: <47066255.6080500@midwinter.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60112>

On Fri, Oct 05, 2007 at 09:12:05AM -0700, Steven Grimm wrote:
> Peter Baumann wrote:
>> I don't like the automatic prune. What if someone has other objects in
>> there which shouldn't be pruned? Making git svn dcommit doing the prune
>> would be at least suprising, because how is one supposed to know that
>> doing a commit into svn will prune all your precious objects?
>>   
>
> "git commit" already does garbage collection, so we've already set a 
> precedent for a commit operation also doing some cleanup at the end. 
> However, you're correct that this cleanup behavior (and the way to turn it 
> off) should be documented so that there's some way to know about it. Doc 
> patch forthcoming.
>

That's new to me. Glancing over git-commit.sh, I could only find a
'git-gc --auto', but no prune. I am not against doing a 'git gc --auto',
but I am against the --prune, because this could make shared
repositories unfunctional.

-Peter
