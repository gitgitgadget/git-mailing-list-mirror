From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 13:16:44 +0200
Message-ID: <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 15 13:17:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnW23-0002p2-Qz
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 13:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbZIOLQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 07:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZIOLQw
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 07:16:52 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:34384 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbZIOLQn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 07:16:43 -0400
Received: by ewy2 with SMTP id 2so345676ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=DnGGmuFBm7GN/0hxImXjR/P8Cz+rqspxf0kt9rEil08=;
        b=JaomTI/GvS+yGUyG1myEjLd9ad52H80TzDndA2ntIdxtkzXlAr55/CiHN6DLic9Tih
         O0G5LNnzaAHno7SQiqPUiYu2V6/NEXYuz+hTWsTuaPe9EvXTSGZ+outap2fHUrMWEQbf
         8OvFcw5bo48VXL1zzIRw0xiOGlyfxFGYSUzks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XKTcnpx6g73Osor8whlLZpaz+Or3je+zAnpZX7oT/asjwXr+1YgYqqP70JiY6+blZS
         y07EmkcYUneXsZl5gyi9aQzH3ykC0qm6yiRDpBQMRI4k5attid2NXdNVUPFbC4eRtU9t
         2/gZ6XwCHqOhO0Pb9FaKJhNVKSXW2wTU8Y1Vw=
Received: by 10.211.158.8 with SMTP id k8mr680937ebo.98.1253013404336; Tue, 15 
	Sep 2009 04:16:44 -0700 (PDT)
In-Reply-To: <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128528>

On Tue, Sep 15, 2009 at 1:05 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> I'm pretty shocked how difficult this is... still...

No prob. It's only hard at the beginning :-)

> I'm finding git logs and reflogs pretty difficult to read and
> interpret (head melting) - in particular telling what happened on what
> branch -

I found gitk enormously helpful to visualise things. Try

 gitk # will show you the current branch

 gitk X Y # will show you both branches

gitk is a ton easier to visualise. git log is pretty good but won't
show merges, so it's limited.

git reflog is confusing, but it's mostly a tool to help when there's
been a mess and you want to diagnose WTH happened...

>but looking at the reflog (which I assume is showing me the
> actions on the current branch, but I'm not sure)

Don't worry about the reflog...

>  I think I must have
> made two commits on the wrong branch so the reset has only 'popped'
> the top one. Other than that your interpretation is correct.

Ok, so looking at gitk, there would still be one "wrong" commit. Can
you confirm?

> I cannot currently change branches - it only complains about one file.

If you did follow my previous instructions (specially doing 'git reset
--hard'), then this should not happen. Except...

Except when you have a file that git is not tracking, and it exists in
the "other" branch. The commit you undid earlier probably added that
file. So just rm that file, and change branches.

> I'm a bit worried about that - I would like to understand why this is
> a problem but I don't.

About the file? It was "new" in the commit you un-committed. So when
you do git reset --hard, git makes sure all the files it is
_currently_ tracking are "unchanged". If that file was new, it ignores
it. Just rm it and be happy.

> So I am now a little hazy on how to deal with previous TWO commits.

Just review gitk and confirm if there are more commits to unstich --
and we'll  work from there


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
