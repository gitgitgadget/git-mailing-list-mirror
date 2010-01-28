From: David Aguilar <davvid@gmail.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 14:14:41 -0800
Message-ID: <20100128221439.GA6327@gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com> <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com> <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com> <alpine.LFD.2.00.1001281656440.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Linck <mgl@absolute-performance.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 23:17:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nacfc-0000xF-3J
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 23:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab0A1WQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 17:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923Ab0A1WQy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 17:16:54 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:64442 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab0A1WQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 17:16:53 -0500
Received: by fxm7 with SMTP id 7so1465149fxm.28
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 14:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bdQvkpqChXhoMneUEzMr2xWB+S5xNUHtZStfbl3dAEA=;
        b=JgN4+dfX3OMmuBtKTF5opcUOKFqJkKVexzZxJ3250NHpo2sB3/Lc1pE33i18JGUg3Z
         2AZTShsKdLA/YUsizy3zoGyD3i1IAHgDTP4p5nDEvn8VKxNNdErRg8sCI5N1T7haYE0M
         VRvqwlODXBBxOV6VZYjjOmnBuwstNG/MiYJwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LsrZSq7Tbggw3JDT1y+90GPbaQDi7P+ynPUZ+yJ3q34Y19GmRwFMqJmu+fulAZjAN0
         3Q5Y6rrHe533JI9qTBlh3YlCnTOMuli534x0XY9Ba/djuh18MDtTWP/keNUreeht+LXv
         QFVtwQLxfp6ykf0sN3ZQ1ZyZ5M1FxRPgpHluw=
Received: by 10.102.149.4 with SMTP id w4mr5812711mud.34.1264717003629;
        Thu, 28 Jan 2010 14:16:43 -0800 (PST)
Received: from gmail.com (guest-wireless.pixar.com [199.108.77.12])
        by mx.google.com with ESMTPS id w5sm6041521mue.22.2010.01.28.14.16.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 14:16:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001281656440.1681@xanadu.home>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138278>

On Thu, Jan 28, 2010 at 05:04:36PM -0500, Nicolas Pitre wrote:
> On Thu, 28 Jan 2010, Mike Linck wrote:
> 
> > Well, even gitk can't show me the information I'm looking for if the
> > parent branch ended up fast-forwarding to include the changes made in
> > the topic branch.  As far as I can tell there is *no way* to tell what
> > changes were made in a particular branch after a fast-forward has
> > taken place, which seems to make it hard to organize fixes for
> > specific topics/bugs/tickets.
> 
> You should consider using tags in conjunction with your bugs/tickets 
> system.  The fork point for a bug fix may be tagged, as well as the last 
> commit representing the bugfix completion (not the merge point though).  
> This way you can always retrieve the exact set of commits forming up 
> that bugfix, regardless if it was merged back into the main branch with 
> a fast forward or not.
> 
> 
> Nicolas

Tags, combined with --no-ff, should help you out a bit.
If you're worried about devs forgetting to configure the no-ff
then you might be able to help them out if you have any control
over /etc/gitconfig on their systems.  That gives you a
standard, global way to set defaults.

This table gives a great summary of 'git log' commands for
inspecting branches.

http://book.git-scm.com/3_reviewing_history_-_git_log.html


As far as "what's the way to do branches right in git" then
there is no "one single way" because git is a framework upon
which you can build your ideal workflow.  That said, there are
some very good examples to follow.  For example, there is much
that can be learned by studying how git.git's branches are
managed.

http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html

This webcast covers a few more workflows and is a very good
crash course:

http://www.gitcasts.com/posts/railsconf-git-talk

-- 
		David
