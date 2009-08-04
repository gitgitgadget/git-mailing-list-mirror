From: Matthieu Stigler <matthieu.stigler@gmail.com>
Subject: Re: How to push properly a la subversion
Date: Tue, 4 Aug 2009 09:17:45 +0200
Message-ID: <111060c20908040017y753a3cb4mbc4d7654192a5d1a@mail.gmail.com>
References: <4A7095CE.8030307@gmail.com>
	 <20090729195044.GA27178@dpotapov.dyndns.org>
	 <111060c20907300111u4345b1f1x784229c066fb3f88@mail.gmail.com>
	 <20090730115448.GB27178@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 09:17:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYEHT-00015G-BP
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 09:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbZHDHRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 03:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbZHDHRr
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 03:17:47 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:59485 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932494AbZHDHRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 03:17:46 -0400
Received: by fxm17 with SMTP id 17so3097697fxm.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3BO4+k1y8fJQ1QecOzixCkRS2VW+/OHMnz8wEhai4EE=;
        b=VRQnBF8JMFkldal1GTFbNGPnFjRR717SsAbCzCppuG45lY0VYK1iLZioNuFvjYVYhf
         4AhzYSyCJkK36SMjrCioz8wmW+UKQGCOMcImUcMz0kWfCeeXJyull3F58/KrF+jNMEfi
         ogSiVfvIgLRnIM3c8HMEIlRE5/zEqGqIg0RnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Hsa6nUogRcIXG0APTWmGRFvGEDxyRsU9uXnY2j55wrlzIg3h5lhR45OEq1nfaQ+tsf
         H8Kg5ZYiKe8hxnVzwY8MV0u8XXkTikIXq8j9/M/kxaO9GVQH/LM4aMsKOzE/gbZl5wV9
         WkRAKRuuoVANLQShPpU5F8VitOwEkj0lvpD+M=
Received: by 10.103.1.5 with SMTP id d5mr333948mui.10.1249370265144; Tue, 04 
	Aug 2009 00:17:45 -0700 (PDT)
In-Reply-To: <20090730115448.GB27178@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124763>

Hi Dmitry and all

Thanks for taking time to explain me in details the philosophy of git
vs svn, it helped me a lot. Two comments/questions:

The first is that as you say,
>'svn commit' does two things: it creates a new commit and propogate this changes to the server

This was a source of confusion for me and I did not get it
immediately. Maybe be help page git-svn crash course could be more
detailed about that? It just mentions the analogy git commit -a /svn
commit (so the first step you mention) but not the second (svn commit
is similar to git push also)? Personaly, I think this could help a lot
newbies like me ;-)

Second, you said
> So, your normally should never push to the branch that is currerently checked out. (New versions of Git will warn you about that).

Is there a way to avoid that? Manually, do I just need on post A
(against which it was pushed from clone B) to use:
git-reset --hard HEAD

And if yes, can I automate that in hooks/post-update in A? Or post-commit in B?

Thanks a lot!

Matthieu

2009/7/30 Dmitry Potapov <dpotapov@gmail.com>:
> On Thu, Jul 30, 2009 at 10:11:43AM +0200, Matthieu Stigler wrote:
>>
>> Furthermore, there are reluctant to install any new softwares
>> and to use command line software,
>
> Actually, gitk and 'git gui' are very nice... Well, I do prefer the
> command line, but I still use gitk to see the history. There are
> some other GUIs out there, but they should be installed separately.
>
>> I used for now portable GIT on windows,
>> which seems to have also ssh.
>
> ssh client works fine on Windows, but I have never installed a shared
> repo on Windows, which would require to install a ssh server. So, I
> don't think I can help here.
>
>> So I understood that I need to set-up a shared repo, thanks for your
>> advices! Now do I really need all those permissions issues? What is the
>> simplest way to deal with that?
>
> If you want to have a shared repo then every developer should have the
> write access to it and every file created by any developer should be
> writable by other developers in the same group. To prevent any developer
> from removing anything on the server, they should not have the normal
> access to it but only through git-shell (i.e. git-shell should be
> specified as the login shell). Now, it is often inconvinient to have
> many special users accounts. So, you can use gitosis, which requires
> only one user account and identified users by their SSH key. I heard
> that some people set up it on Windows, but it was Cygwin version of Git.
>
> As to the simplest way, it is probably to use a distributed workflow:
> each developer has their own repo, which is writable for him/her and
> readable for other developers. (You can easily to do with sharable
> folders by assigning appropriate permissions, and you probably will not
> need to deal with SSH at all). In this workflow, every group has each
> own team leader or co-ordinator, who is responsible for integration
> other people work. Then the repo of the team leader will becomes the
> "official" repo of the project, but it is only social a convention and
> not a technical one. Any developer can fetch from any repository (see
> also git-remote). IMHO, the distributed workflow is far superior to
> having everyone to push to the same repo.
>
> In fact, as closer you emulate SVN workflow, more SVN issues, you will
> pick up. For instance, 'svn commit' does two things: it creates a new
> commit and propogate this changes to the server. In general, it is a
> very bad thing to do, because you end up with a lot of work-in-progress
> commits, which may be steps in the wrong direction, but they interfere
> with other people work. With Git even using a central repo, you can do
> better -- developers can push their work when they have finished.
> Still, you may want to have some code review process. How are you going
> to organize that? And then when someone works on some feature or have
> some other work-in-porgress, you still want that this work will be
> properly backed up (or at least, store more than in one place). So, you
> naturally want to give every developer repo on that server where he/she
> can push their work _before_ it is become part of the official history
> of the project. And, finally, it is always good to have someone who
> co-ordinates everyone's efforts, so intergation will be not randomly but
> based on priorities and quality of one's work...
>
>
> Dmitry
>
