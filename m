From: Jared Hance <jaredhance@gmail.com>
Subject: Re: Git feature request: --amend older commit
Date: Fri, 17 Aug 2012 21:41:39 -0400
Message-ID: <20120818014139.GA11100@gentoo.cinci.rr.com>
References: <20120817154749.11762.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 18 03:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Y3g-00045U-Rq
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 03:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756318Ab2HRBlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 21:41:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34741 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab2HRBlr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 21:41:47 -0400
Received: by yhmm54 with SMTP id m54so4480107yhm.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 18:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=P/3X3ntbKETvHXuEJt59xUM063mdqz+UxG0eFUZpVtM=;
        b=ew5/S0UWcDh6wBq/T9R10KvsPelZwCkbKi+lEhv8gCotUKfdw6oapogsp0V1JYolu+
         CTZQ329sginoKf3CwSK9F2UFMfexNL3+3R5mKu14ULMo59lTUUYgpZ7gRVKEGHT0OyZb
         KUWP8Ls+Hkbw6IahD36utV6eE7RJsvs1cI3duKay+Fzd2NRWbrNqYpGNIqYOEpWOzNrY
         LGz2L0RMQsd1DoaunXgVjyuJTg5Ck/Ct6BVcP+bewtQ0P6+Hs1r0aNKGXQBKqQDq7fDp
         YviME9khfkyt2NrWJzQGorLKx56RzViyH5EWvK5UcYQjYSBc2SvqEbAUKeEdwUXdJ+5Y
         F+8A==
Received: by 10.50.135.70 with SMTP id pq6mr3717573igb.29.1345254106495;
        Fri, 17 Aug 2012 18:41:46 -0700 (PDT)
Received: from gentoo.cinci.rr.com (cpe-75-186-11-240.cinci.res.rr.com. [75.186.11.240])
        by mx.google.com with ESMTPS id dk6sm6301704igb.0.2012.08.17.18.41.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 18:41:45 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20120817154749.11762.qmail@science.horizon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203668>

On Fri, Aug 17, 2012 at 11:47:49AM -0400, George Spelvin wrote:
> Something like "git commit --fixup HEAD~3", where "git commit --fixup HEAD"
> would be equivalent to "git commit --amend".

Aside from the ways others mentioned on how to do this, I think that a
better interface if this were to be added would be to make the commit an
optional parameter of --amend. Adding another parameter which
effectively does a superset of --amend sounds unnecessary.

I often want to amend a commit, but its simply too much work, so I
usually commit it marking the message as something like
"fixup! ...". Then, before I push, I make sure to rebase all of
the commits marked as fixups. Clearly autosquash does this, but to have
to override the editor as "true" is just a hassle.

I feel like this is a common enough need that it deserves more first
class support than relying on the rebase command and then using true as
an editor. Either it should be supported natively or it should be
possible to autosquash a rebase without --interactive, since at present
--autosquash requires --interactive, which isn't nice for when the user
does not want the rebase to be interactive. Such a simple task shouldn't
require an interactive command.
