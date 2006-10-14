From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 14 Oct 2006 19:42:31 +0200
Message-ID: <200610141942.32196.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <9e4733910610141018gdfa62a7o9a2bb2819d5c2ecc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 19:42:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYnWi-0001yx-TK
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 19:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWJNRmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 13:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWJNRmV
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 13:42:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:28527 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030344AbWJNRmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 13:42:20 -0400
Received: by ug-out-1314.google.com with SMTP id o38so582638ugd
        for <git@vger.kernel.org>; Sat, 14 Oct 2006 10:42:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FgEQyMlKbczsjceiI4D6/FtAJ2wHBCyTK6cxtGCbXB+vpbfN9oTdahSXuW2MHii/R7Xxf5YZgIyOVi7PXjUn0XdhsJWiw6nP5ZUq5SXTv4UZhJNBiyhPjsb+nG9j/RxQ7HV6ZvqR2q2eOUbgsgySJtld4aPwXqs6553QbVLSWJk=
Received: by 10.67.89.5 with SMTP id r5mr5833021ugl;
        Sat, 14 Oct 2006 10:42:19 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id 13sm1789109ugb.2006.10.14.10.42.18;
        Sat, 14 Oct 2006 10:42:18 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <9e4733910610141018gdfa62a7o9a2bb2819d5c2ecc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28884>

Jon Smirl wrote:
>> About "checkouts", i.e. working directories with repository
>> elsewhere: you can use GIT_DIR environmental variable or "git
>> --git-dir" option, or symlinks, and if Nguyen Thai Ngoc D proposal
>> to have .gitdir/.git "symref"-like file to point to repository
>> passes, we can use that.
>
> I believe they mean checking out only the latest few revisions
> instead of copying the whole repo. This issue is a problem for
> Mozilla. If you want to change a line in the git version you have to
> download the entire 500MB tree with full history.

>From http://bazaar-vcs.org/RcsComparisons
  A "Checkout" is a working tree that points elsewhere for its RCS data.

You can always do like Linux kernel did, splitting repository into 
current and historical part (which would contain also dead branches), 
and creating and publishing current-historical graft file, to join 
history if needed.

>> Partial checkouts are only partially supported as of now; it means
>> you have to do some lowe level stuff to do partial checkout, and be
>> carefull when comitting. BTW it depends what you mean by partial
>> checkout, but they are somewhat incompatibile with atomic commits
>> to snapshot based repository.
> 
> I believe partial checkout means being able to check one directory
> tree out of the repo and work on it while ignoring what is happening
> in the rest of the repo. This is another issue for Mozilla which has
> multiple dependent projects checked into a single repo.

So split different projects into different repositories. There was some 
helper program (git-splitrepo or something like that) for that posted 
on git mailing list. And use "superrepository" to gather all projects 
together (see last discussion about subprojects on git mailing list).
-- 
Jakub Narebski
Poland
