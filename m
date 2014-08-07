From: Nico Williams <nico@cryptonector.com>
Subject: Re: "Branch objects" (was: Re: cherry picking and merge)
Date: Thu, 7 Aug 2014 10:58:29 -0500
Message-ID: <20140807155828.GM23449@localhost>
References: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com>
 <20140806200726.GE23449@localhost>
 <alpine.LSU.2.00.1408071222510.13901@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Aug 07 17:58:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQ5L-0001j9-3s
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 17:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbaHGP6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 11:58:31 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:57012 "EHLO
	homiemail-a104.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757488AbaHGP6a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Aug 2014 11:58:30 -0400
Received: from homiemail-a104.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a104.g.dreamhost.com (Postfix) with ESMTP id 2253320047B8C;
	Thu,  7 Aug 2014 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=cryptonector.com; bh=65QzBw9hoTaiA1
	RGMFM0Luby4m8=; b=rBwzQ6lV2i4ZMTf7BYd9JFNgGnaGqhTeIov3po4lr7mFEN
	vEWpKcN2+4OJpYD4JC7nXVXGeYdCa2FgF8ACptKsHvwVWxu4BxrJGWhe3WjQd+mZ
	G2a+3kR33t7VTgQGVbGotF6I4A9MJ+5KN6YLhDjTorHHiEnnRmrfN89kN8Mac=
Received: from localhost (108-207-244-174.lightspeed.austtx.sbcglobal.net [108.207.244.174])
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a104.g.dreamhost.com (Postfix) with ESMTPA id B290420047B8B;
	Thu,  7 Aug 2014 08:58:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.1408071222510.13901@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254961>

On Thu, Aug 07, 2014 at 12:38:48PM +0100, Tony Finch wrote:
> I have been fiddling around in this area.
> 
> What I want to be able to do is develop fixes for open source code
> that I run, and get those fixes upstream. This means I need a rebasing
> workflow, to keep the patches up-to-date and to deal with code review
> feedback.

Right.

> But this is inconvenient for deploying the patched version to
> production (which is the point of developing the fixes) - I want a

I'm not sure I follow this.  You deploy what you build, and you build
the HEAD of the production branch, whatever that is.  If it gets
rebased, so it it does.

> fast-forwarding branch for that. And it would be nice to be able to
> share the history of the patch series, so others can see what changed
> between revisions more easily.

But yes, it's nice to have a history of all the rebases.  For example:
so you can show the work you've done (rebasing to please an upstream is
work).

The reflog does this, of course, but you can't push it.  Of course, my
conception of branch object wouldn't push rebase history to an upstream
that doesn't want it, but you could push it to repos that do.

> So I have a small tool which maintains a publication branch which
> tracks the head of a rebasing branch. It's reasonably satisfactory so
> far...
> 
> https://git.csx.cam.ac.uk/x/ucs/git/git-repub.git

Yeah, that's useful.

Nico
-- 
