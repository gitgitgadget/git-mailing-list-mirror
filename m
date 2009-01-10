From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Main branch being maintained with 'git am', how do mere mortals interact without too much conflicts?
Date: Sat, 10 Jan 2009 15:47:48 +0100
Message-ID: <adf1fd3d0901100647wd66a57bufb42d3d7d415e76d@mail.gmail.com>
References: <87vdsntnyd.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junichi Uekawa" <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:56:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLfGe-0000LI-Jk
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 15:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbZAJOzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 09:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbZAJOzQ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 09:55:16 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:43250 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbZAJOzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 09:55:15 -0500
Received: by bwz14 with SMTP id 14so30234071bwz.13
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 06:55:13 -0800 (PST)
Received: by 10.102.247.4 with SMTP id u4mr9606966muh.104.1231598868909;
        Sat, 10 Jan 2009 06:47:48 -0800 (PST)
Received: by 10.103.189.7 with HTTP; Sat, 10 Jan 2009 06:47:48 -0800 (PST)
In-Reply-To: <87vdsntnyd.dancerj%dancer@netfort.gr.jp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105119>

2009/1/10 Junichi Uekawa <dancer@netfort.gr.jp>:
> Hi,
>
> I've been maintaining my Git repository (monthlyreport.git) where most
> people do not have push access, and I'm taking patches through e-mail
> with 'git am'.
>
> It often happens that I'm receiving patches which won't apply without
> a merge ('git am -3') and happen to be conflict-resolving often,
> because people work off a branch a few days before, and try to send
> patches nearer the deadline (This is a monthly meeting resume, which
> people are expected to submit their material, so this is kind of
> normal).
>
>
> One thing I'm worried is that users apparently have to throw away
> their own change or do some conflict resolution.
>
>
> User does
>  git pull xxxx
>  edit ...
>  git add
>  git commit
>  git format-patch -o ... HEAD^
>
>
> I do bunch of
>    git am -3 (which usually has a conflict of some way or other)
>    git add XXXX
>    git am -3 --resolve
>    git push
>
>
> User then find that when doing
>
>  git pull
>
> again, a conflict will occur.
>
>
>
> I am thinking of recommending the users to create a branch
>
>  git checkout -b my-work-for-2009-01 origin
>  edit ...
>  git add
>  git commit
>  git format-patch -o ... HEAD^
>  send the email
>
> and do
>
>  git checkout master
>  git pull
>
> and throw away their branches when they are included upstream.
>
>
>
> Something tells me the problem is that I'm probably using a workflow
> that resembles SVN too much, and users aren't used to branches yet.
> Has anybody found this to be a problem, or better yet, is there a
> better workflow?

I think your workflow is fine. When someone sends a patch s/he has to
know that their branch is a throw away branch to create the patch.
Another thing is if you send it as a public repository or as a bundle,
and even then the maintainer can decide to apply it merging or
cherry-picking.

There is a doc explaining " An overview of recommended workflows with
git" in git:

http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html

HTH,
Santi
