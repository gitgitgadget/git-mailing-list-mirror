From: Maaartin <grajcar1@seznam.cz>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Mon, 11 Oct 2010 23:46:28 +0000 (UTC)
Message-ID: <loom.20101012T013931-754@post.gmane.org>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org> <loom.20101008T234354-493@post.gmane.org> <FD4E6D0A-34E6-4FC4-AA7A-327E07AB58D4@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 01:46:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5S4u-00022H-VW
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 01:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0JKXqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 19:46:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:59157 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561Ab0JKXqm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 19:46:42 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P5S4l-0001y8-DI
	for git@vger.kernel.org; Tue, 12 Oct 2010 01:46:39 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 01:46:39 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 01:46:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.62)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158814>

Kevin Ballard <kevin <at> sb.org> writes:

> On Oct 8, 2010, at 2:58 PM, Maaartin wrote:
> That's not the right layout. I'd have to do
> 
> *.xcodeproj/*
> !*.xcodeproj/project.pbxproj
> */*.xcodeproj/*
> !*/*.xcodeproj/project.pbxproj
> 
> And so on, once for each possible level of nesting.

Sorry, that's was I meant, I was too sloppy/tired/stupid when writing this.

> ... The problem I'm talking about is
> simply that you cannot write a pattern that includes a slash and have that 
pattern match at any nesting level.

I see I wrong again. At least I learned something.

> Upon further reflection, if we stick with platform-provided fnmatch() we 
don't have to special-case a
> prefixed **/. We could simply define patterns as always matching in that way, 
and you can use the
> already-existing prefixed / to root it at the current level. So if my pattern 
looks like
> 
> *.xcodeproj/*
> 
> Then it will attempt to match this pattern against the last 2 path components 
of any path rooted in this
> directory. It can simply count the slashes to determine the number of path 
components. If I really want it
> to just match *.xcodeproj files in the current directory then my pattern 
should look like
> 
> /*.xcodeproj/*

IMHO, this is how it should work, simple and consequent. Sorry for clobbering 
this thread by my mistakes.
