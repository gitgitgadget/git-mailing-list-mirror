From: Tim Chase <git@tim.thechases.com>
Subject: Re: Using "-" for "previous branch" failing with rebase
Date: Mon, 17 Mar 2014 20:47:44 -0500
Message-ID: <20140317204744.6ac795a0@bigbox.christie.dr>
References: <20140315152924.26c3294e@bigbox.christie.dr>
	<7vppll2uvp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 02:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPj7w-0001XW-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 02:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbaCRBra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 21:47:30 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:57370 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752582AbaCRBr3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 21:47:29 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:60735 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <git@tim.thechases.com>)
	id 1WPj7o-0004PB-ON; Mon, 17 Mar 2014 20:47:28 -0500
In-Reply-To: <7vppll2uvp.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: authenticated_id: tim@thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244318>

On 2014-03-16 23:37, Junio C Hamano wrote:
> Tim Chase <git@tim.thechases.com> writes:
> 
> > Is this just an interface inconsistency or is there a some
> > technical reason this doesn't work (or, has it been
> > addressed/fixed, and just not pulled into Debian Stable's
> > 1.7.10.4 version of git)?
> 
> It is merely that nobody thought "rebase" would benefit from such a
> short-hand, I think.
> 
>     Teach more commands that operate on branch names about "-"
>     shorthand for "the branch we were previously on", like we did
>     for "git merge -" sometime after we introduced "git checkout -"
> 
> has been sitting in my "leftover bits" list at
> 
>     http://git-blame.blogspot.com/p/leftover-bits.html
> 
> for quite some time.  Hint, hint...

Not sure if the "Hint, hint" was intended for me, as I'm not exactly
a git hacker.  I did find another place where I reached for it
instinctively (now that I use it regularly with checkout/merge):
git-diff.

  git checkout some_branch
  #hack
  git commit -m "..."
  git checkout other_branch
  # hmm...what's different between these branches?
  git diff -

which I would have expected to act something like

  git diff some_branch..other_branch

Just for the archives.

-tkc




(or possibly the reverse)
