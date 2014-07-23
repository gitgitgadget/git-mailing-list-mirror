From: Chris Packham <judge.packham@gmail.com>
Subject: Re: confused about remote branch management
Date: Wed, 23 Jul 2014 19:40:04 +1200
Message-ID: <53CF66D4.7060201@gmail.com>
References: <1406083743.29001.139.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Ross Boylan <ross@biostat.ucsf.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 09:40:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9r9t-00059a-7U
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 09:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518AbaGWHkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 03:40:11 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47302 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbaGWHkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 03:40:10 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so1208158pab.20
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=jC08c1uc85AcPYcRFXoyRUwiiNQZy2nF22+THK9sH4M=;
        b=SbuTerg8lYyeQAXs+8+H12rSTI0wW5cuYArXLtC9pOY5T3ekdvsslVzyyxKnduCoJ1
         OfLQMEmPh7CQKqg0PZhAvG0/PMUqCkDDHgbRpvuI7nfx+HvG0zksiUdtc6ylstdwEOhj
         GvtXtb1aMfNHljZJBdPjgOJ0ZWfhr9u1Ime/mKbQb1jN8rbGO2irWBRYI24rR7WTsawW
         wccuEzTkSvaLR+r9RpLmC83beuSD3aE/UgFHsEhCNaukoT9zEL2VTdzqpmy6+c47cEbT
         EB5YrC8uVUPYLewiuzUlLiv2sJWVkA/lDcSCQXcEqrmA7wu2x0qZakDvd7/OqAKIbFVg
         HVWQ==
X-Received: by 10.69.26.68 with SMTP id iw4mr18246618pbd.137.1406101209463;
        Wed, 23 Jul 2014 00:40:09 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id dk1sm1960787pdb.20.2014.07.23.00.40.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 00:40:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1406083743.29001.139.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254060>

On 23/07/14 14:49, Ross Boylan wrote:
> My local master branch is the result of a merge of upstream master and
> some local changes.  I want to merge in more recent upstream work.
> git pull doesn't seem to have updated origin/master, and git checkout
> origin/master also doesn't seem to work.
> 
> Here's some info that may be relevant.
> 
> 
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git remote -v
> origin	https://github.com/emacs-ess/ESS.git (fetch)
> origin	https://github.com/emacs-ess/ESS.git (push)
> personal	https://github.com/RossBoylan/ESS.git (fetch)
> personal	https://github.com/RossBoylan/ESS.git (push)
> # I think I originally cloned from what is now the "personal" remote
> # and switched names later so origin refers to upstream.
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git branch -v
> * master 8fa569c [ahead 340] merge from origin
> # 340 ahead of personal is plausible, but ahead from origin seems odd
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git --version
> git version 1.7.10.4
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git branch -a
> * master
>   remotes/origin/S+eldoc
>   remotes/origin/gretl
>   remotes/origin/linewise_callbacks
>   remotes/origin/litprog
>   remotes/origin/master
>   remotes/origin/transmissions
>   remotes/personal/HEAD -> personal/master
>   remotes/personal/S+eldoc
>   remotes/personal/gretl
>   remotes/personal/linewise_callbacks
>   remotes/personal/litprog
>   remotes/personal/master
>   remotes/personal/transmissions
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git status
> # On branch master
> # Your branch is ahead of 'personal/master' by 340 commits.
> #
> nothing to commit (working directory clean)
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git checkout origin/master
> Note: checking out 'origin/master'.
> 
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in
> this
> state without impacting any branches by performing another checkout.
> 
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -b with the checkout command again.
> Example:
> 
>   git checkout -b new_branch_name
> 
> HEAD is now at a33a2f9... Merge branch 'trunk'
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git checkout master
> Previous HEAD position was a33a2f9... Merge branch 'trunk'
> Switched to branch 'master'
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git pull origin master
> # [messages]
> Not committing merge; use 'git commit' to complete the merge.

I think this is the relevant message. By doing a git pull you are asking
to merge the branch 'master' from the remote 'origin' into the current
branch (which happens to also be called 'master').

What I'm guessing is in "# [messages]" is something about a merge
conflict that needs resolving before the merge can be completed. There
are various ways to resolve the conflict but probably the easiest would be

  git mergetool
  git commit

I personally use have merge.tool set to kdiff3 but there are plenty of
other options.

Another option is to abort this attempt and try again (*warning* here be
dragons).

  git checkout master
  git reset --hard HEAD
  git pull

Note: git uses some heuristics to determine what to merge when you don't
specify what to pull. This should be origin/master unless
branch.master.remote and branch.master.merge are set to something weird.
This probably won't do away with the need to resolve your merge
conflicts but at least you'll be starting from a clean slate.


> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git status
> # On branch master
> # Changes to be committed:
> # [long list]
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git show origin/master
> commit a33a2f9e06185a225af7d72ea3896cfd260e455e
> Merge: 136742f 6b22a88
> Author: Vitalie Spinu <spinuvit@gmail.com>
> Date:   Mon Jan 20 00:43:30 2014 -0800
> 
>     Merge branch 'trunk'
> # this was the head of origin/master BEFORE I did the pull.
> # I think this means it has not been updated.
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git commit -m "merge in
> upstream, probably fe7d609..8fa569c"
> [master 59f6841] merge in upstream, probably fe7d609..8fa569c
> ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git show origin/master -v
> # no change
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
