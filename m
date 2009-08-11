From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: RFC for 1.7: Do not checkout -b master origin/master on clone
Date: Tue, 11 Aug 2009 23:06:02 +0200
Message-ID: <adf1fd3d0908111406w1ccae22fp3f26ecb89c67fa5e@mail.gmail.com>
References: <4A818B90.9050206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MayXu-00049C-V0
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 23:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbZHKVGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 17:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbZHKVGE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 17:06:04 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:53610 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbZHKVGC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 17:06:02 -0400
Received: by ewy10 with SMTP id 10so4106140ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 14:06:03 -0700 (PDT)
Received: by 10.216.21.65 with SMTP id q43mr1404861weq.43.1250024762693; Tue, 
	11 Aug 2009 14:06:02 -0700 (PDT)
In-Reply-To: <4A818B90.9050206@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125599>

2009/8/11 Michael J Gruber <git@drmicha.warpmail.net>:
> One common source of confusion for newcomers is the fact that master is
> given such a special treatment in git. While it is certainly okay and
> helpful to set up a default branch in a new repository (git init) it is
> not at all clear why it should be treated specially in any other
> situation, such as:
>
> - Why is master the only local branch which git clone sets up (git
> checkout -b master origin/master)?

Because master is the default branch in the remote repository?

[...]

> This behaviour not only is hard to justify; in fact it gives users a
> completely wrong impression: by pretending that master is special,

It is not hard to justify (the git clone behavior). master is not
special, it is just the default branch, but you can change it changing
the HEAD symlink.

> but
> also by hiding core concepts (distinguishing local/remote branches,
> detached heads) from the user at a point where that very hiding leads to
> confusion.
>
> Under the hood, it is of course HEAD which is given special treatment
> (and which in the majority of repos points to master), and git clone
> sets up a local branch according to HEAD (and does some other guess work
> when cloning bare repos), which means that git clone shows the same
> "random" behaviour which git svn clone does: Which local branch is set
> up by default depends on the current value of HEAD/most recent commit at
> the time of the cloning operation.

It's not random. And please don't mix the "git clone" and "git svn" case.

> So, I suggest that starting with git 1.7:
>
> - git clone does not set up any local branches at all

I think you should first think if this is going to really help
newcomers. I think this would be worst.

Instead of "why only 'master'?" the question will be "why I don't get
any files in the workdir?"

"git clone checks out the default branch, and this is 'master' by
default" is not that hard.

HTH,
Santi
