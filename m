From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Thu, 12 Mar 2009 11:22:43 +0100
Message-ID: <20090312102243.GA27665@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org> <20090310100400.GC11448@pvv.org> <7v7i2v4x2v.fsf@gitster.siamese.dyndns.org> <20090312120109.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 11:25:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhi5u-0003n1-Em
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 11:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbZCLKWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 06:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbZCLKWy
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 06:22:54 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:40514 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbZCLKWx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 06:22:53 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lhi3n-0000Vt-Q1; Thu, 12 Mar 2009 11:22:44 +0100
Content-Disposition: inline
In-Reply-To: <20090312120109.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113036>

On Thu, Mar 12, 2009 at 12:01:09PM +0900, Nanako Shiraishi wrote:

[...]
> There can be two reasons you may want to give the branch a name other than 'next':
> 
> 1. Because you also have dschos-next that tracks remotes/dscho/next; or
> 
> 2. Because you also have junios-next2 that also tracks remotes/origin/next.

> The first case indicates that the project is using a workflow where
> each developer has his own publishing repository [1], and it is very
> unlikely that Finn Arne has push access to either your or
> Johannes'es public repositories.

No, think more of different repositories with different function, such
as "my-public", "my-group", "beta", "customers", "public" and so on.
You can have multiple repositories with different function. They (can)
have branches with the same name, but have different purposes. To
track more than one you _must_ rename at least one locally (and just
with two remotes "master" is going to give you some issues).

Maybe you want the name in the public repo to be different than the
name in your own repo.

[...]

> I don't understand how the new "--current" makes "sort-of" sense. It
> looks like it is making the command more complex and the only thing
> it does is to encourage a confused workflow.

The naming --current was not good, so I have changed it to --tracking
in my latest suggestion.  Why is it confused?  Why do I need to call
my branch locally the same as it is named remotely?  That does not
scale. Branch names are unique per repository, not globally.

I want to be able to "git pull" and then "git push --tracking" back to
the same branch, not push somewhere else. Curently this requires a
surprisingly complicated shellscript, and is not available from the
guis.

> [1] Your http://gitster.livejournal.com/30645.html showed different
> ways to collaborate very nicely. I think this is the third approach
> in your article.

The main problem with all these examples is that the underlying
assumption is that you can always use the same branch name locally and
remotely.  This just isn't always the case when you have many remotes,
and each remote repository has some implicit function (e.g. "beta",
"john", "graphics-group", "my-public", .....), and they have an active
"master" branch for example.

- Finn Arne
