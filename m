From: "Sean Kelley" <svk.sweng@gmail.com>
Subject: Re: pushing changes to a remote branch
Date: Tue, 10 Jul 2007 22:44:58 -0500
Message-ID: <a2e879e50707102044l864b9dcre5b6fa5893ff4803@mail.gmail.com>
References: <20070710143614.GA29681@piper.oerlikon.madduck.net>
	 <20070710173401.GB5032@sigill.intra.peff.net>
	 <844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 05:45:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8T8g-0002tL-MD
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 05:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbXGKDo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 23:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753779AbXGKDo7
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 23:44:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:22768 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbXGKDo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 23:44:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2142115wah
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 20:44:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T6F3DUMP7AZyhY4ubEVv0OY9HnQ3WpZs+lQ6vnNfd52WgPRp0PDC7iTTPFwQq6y9NjuWSzJjq9Tp+18GwXdCova3zj3zdP2rAt9jKNu9lwE5l8TOs1N4KkMeIzKwZQv4EdEsaSsphu8KDmkjnQXCLkSzvuJnkwemTV7aFwLFUvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E0Jc+gtX0O51dNY3urnegEwaoY3YKdbS7bnp0usdMQ95ZLfwgWARw2xs8AbQwKN7DvS/u2ZfiurbOlzl7iJf4Vm8CLNGBzVsCmmbcNvOOf6POw0CpaG6vj50gVJEHojuufa1O26VLkyU8uTDtUSpWtXui92XWstfPv4YGlvcLI4=
Received: by 10.114.109.1 with SMTP id h1mr4777105wac.1184125498319;
        Tue, 10 Jul 2007 20:44:58 -0700 (PDT)
Received: by 10.115.73.1 with HTTP; Tue, 10 Jul 2007 20:44:58 -0700 (PDT)
In-Reply-To: <844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52132>

Hi,

On 7/10/07, Brian Gernhardt <benji@silverinsanity.com> wrote:
>
> On Jul 10, 2007, at 1:34 PM, Jeff King wrote:
>
> > On Tue, Jul 10, 2007 at 04:36:14PM +0200, martin f krafft wrote:
> >
> >>   git checkout origin/vim
> >>     Note: moving to "origin/vim" which isn't a local branch
> >>   echo change > newfile; git add newfile
> >>   git commit -m'make change'
> >>     Created commit 64b8b2e: make change
> >>      1 files changed, 1 insertions(+), 0 deletions(-)
> >>       create mode 100644 newfile
> >>
> >> If I now checkout master and then return to origin/vim, the commit
> >> is gone.
> >
> > That's because 'origin/vim' is a tracking branch for the remote; it's
> > where you store the information "here's what the remote 'origin'
> > thinks
> > is in the branch 'vim'." That's why you get the "note" warning above.
> >
> > If you want to make changes, you should make a local branch starting
> > from that point:
> >
> >   git-checkout -b vim origin/vim
> >   # hack hack hack
> >   git-commit -m changes
>
> Indeed, in master, git outputs a hint to that when you checkout the
> remote branch.
>
>    $ git checkout origin/master
>    Note: moving to "origin/master" which isn't a local branch
>    If you want to create a new branch from this checkout, you may do so
>    (now or later) by using -b with the checkout command again. Example:
>      git checkout -b <new_branch_name>
>    HEAD is now at f4855d4... 1
>
> Perhaps git-commit should also also output a warning?  "Commit made
> on detached HEAD.  Use "git branch <new_branch_name>" to save your
> commit"?  That's bad wording, but the idea is there.


If you then do a push from that new_branch_name will it create a new
branch on the remote?  I am struggling with just being able to add a
remote.  Create a local branch that maps to the remote.  Then
committing and pushing changes to the remote - all without creating a
new branch on the remote.

Sean

>
> ~~ Brian
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
