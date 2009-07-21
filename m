From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: What does this mean
Date: Tue, 21 Jul 2009 19:35:55 +0200
Message-ID: <20090721193555.25d2eb4f@gmail.com>
References: <24590563.post@talk.nabble.com>
	<20090721184228.78968f15@gmail.com>
	<19350ccb0907211002p2b56aaabnaca905bef133da71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Bill Cochran <wkcochran@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 19:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTJGa-0007P5-7E
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 19:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918AbZGURgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 13:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755915AbZGURgE
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 13:36:04 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:60144 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913AbZGURgB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 13:36:01 -0400
Received: by ewy26 with SMTP id 26so3244236ewy.37
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=TbcU9V+CpAzEXYrFrbpnm+DwADJwa5R7GrX4QzkrJV0=;
        b=UOH9UHFJVXAaUVpLwBqYH8fVytRCKslaDo1+zMT72eWeAhEiATZJS/LnGw13jOgTlC
         A1rqnXFmKAE+FP0fKOPoX3cuDp+gPtwdAS7lbni1Axo/Y1pskQg+4FVbhHJxZCDkn6fY
         jm9mnulpTXF5qMvUIAGU/vkMZdrvSw44NFDxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=UX89VlKlYZ+Ng3Vf9ouioE4UlGt681f4IJMJ+E+vVQ/3eD6cuibuQlH7vTzcPXn70L
         Mb2MplibxeGJcbip+npeA3fbU9x8Rxr5WsV7sFSPO4KxDQHUYdR6rFKcRTQ6ZYhXac7N
         yYrok5P1wD54s+D/6WMTHCcpUdMRK6fjb8RaQ=
Received: by 10.211.199.11 with SMTP id b11mr7055623ebq.68.1248197759730;
        Tue, 21 Jul 2009 10:35:59 -0700 (PDT)
Received: from localhost (87-205-57-103.adsl.inetia.pl [87.205.57.103])
        by mx.google.com with ESMTPS id 24sm2240747eyx.43.2009.07.21.10.35.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 10:35:59 -0700 (PDT)
In-Reply-To: <19350ccb0907211002p2b56aaabnaca905bef133da71@mail.gmail.com>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123680>

Bill Cochran <wkcochran@gmail.com> wrote:

> Thanks for the quick answer.  I can fix this problem by having a
> clone of the repository on the same machine.  I am just curious if
> the behavior I am seeing is correct.
> 
> > runge:~/repository/papers wkcochra$ git checkout
> > D       medial axis/medial axis.tcp
> 
> 'git checkout' command switches to another branch (actually, because
> > nothing was specified on command line, it doesn't switch at all) and
> > prints a summary of modified files.
> >
> 
> On machine A, I created a directory and file.  This was committed to
> `master.'  The repository was pushed to machine B.  What you are
> looking at is the subsequent checkout on machine B.  Said directory
> and file are medial axis/medial axis.tcp.  The checkout did not
> create the directory nor the file.  Rather, I get the result above.
> 
> git show informs me I am at the correct commit.  git checkout "medial
> axis" fails:
> runge:~/repository/papers wkcochra$ git checkout "medial axis"
> error: pathspec 'medial axis' did not match any file(s) known to git.
> 
> Is this the correct behavior of checkout?
> 
> 
> > For description of 'D', look for '--name-status' option in man
> > git-diff. Maybe this what you are looking for.
> >
> 
> So, this file is deleted, according to the man page of git-diff.
> Interesting that it was never created on machine B.
> 
> 

I think I managed to reproduce your problem. Here is what I did:

> $ git push ../b master
> Counting objects: 4, done.
> Writing objects: 100% (4/4), 283 bytes, done.
> Total 4 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (4/4), done.
> warning: updating the current branch
> warning: Updating the currently checked out branch may cause confusion,
> warning: as the index and work tree do not reflect changes that are in HEAD.
> warning: As a result, you may see the changes you just pushed into it
> warning: reverted when you run 'git diff' over there, and you may want
> warning: to run 'git reset --hard' before starting to work to recover.

This seems to be your case. You see a file as deleted, because in another repo
you have created.

> warning: 
> warning: You can set 'receive.denyCurrentBranch' configuration variable to
> warning: 'refuse' in the remote repository to forbid pushing into its
> warning: current branch.
> warning: To allow pushing into the current branch, you can set it to 'ignore';
> warning: but this is not recommended unless you arranged to update its work
> warning: tree to match what you pushed in some other way.
> warning: 
> warning: To squelch this message, you can set it to 'warn'.
> warning: 
> warning: Note that the default will change in a future version of git
> warning: to refuse updating the current branch unless you have the
> warning: configuration variable set to either 'ignore' or 'warn'.
> To ../b
>  * [new branch]      master -> master
> 
> $ cd ../b/
> $ git checkout 
> D	medial axis/medial axis.tcp
